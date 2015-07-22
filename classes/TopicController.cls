public with sharing class TopicController {

	private List<TopicToPointMap> allTopicToPointMaps;
	private Employee__c currentUser;

	public transient String newTopicName { get; set; }
	public transient String newTopicDescription { get; set; }

	public TopicController() {
		String sessionId = ApexPages.currentPage().getCookies().get('userSession').getValue();
		this.currentUser = [
			SELECT Name
			FROM Employee__c
			WHERE Session__c = :sessionId
			LIMIT 1
		][0];

	}

	public List<TopicToPointMap> getAllTopicToPointMaps() {
 		allTopicToPointMaps = TopicToPointMap.getAllTopicToPointMaps();
 		return allTopicToPointMaps;
	}

	public Integer getHardnessLevelsNumber() {
		return [
			SELECT COUNT()
			FROM Hardness_Level__c
		];
	}

	public PageReference saveAll() {
		List<Topic__c> topicsToUpdate = new List<Topic__c>();
		List<Point__c> pointsToUpdate = new List<Point__c>();
		List<Estimate_Time__c> estimateTimesToUpdate = new List<Estimate_Time__c>();

		for (TopicToPointMap currentTopicToPointMap: allTopicToPointMaps) {
			Topic__c currentTopic = new Topic__c(
				Id = currentTopicToPointMap.topicWrapper.id,
				Name = currentTopicToPointMap.topicWrapper.name,
				Description__c = currentTopicToPointMap.topicWrapper.description
			);
			
			topicsToUpdate.add(currentTopic);

			for (PointWrapper currentPointWrapper: currentTopicToPointMap.pointWrappersList) {
				Point__c currentPoint = new Point__c(
					Id = currentPointWrapper.id,
					Name = currentPointWrapper.name,
					Description__c = currentPointWrapper.description,
					Topic__c = currentPointWrapper.topicId
				);

				pointsToUpdate.add(currentPoint);

				for (EstimateTimeWrapper currentEstimateTimeWrapper: 
						currentPointWrapper.estimateTimeWrappersList) {

					Estimate_Time__c currentEstimateTime = new Estimate_Time__c(
						Id = currentEstimateTimeWrapper.id,
						Time__c = currentEstimateTimeWrapper.estimateTime,
						Point__c = currentEstimateTimeWrapper.pointId,
						Hardness_Level__c = currentEstimateTimeWrapper.hardnessLevelId,
						Employee__c = this.currentUser.Id
					);

					estimateTimesToUpdate.add(currentEstimateTime);
				}
			}
		}

		update topicsToUpdate;
		update pointsToUpdate;
		update estimateTimesToUpdate;

		return ApexPages.currentPage();
	}

	public PageReference discardChanges() {
		return ApexPages.currentPage();
	}

	public PageReference createNewTopic() {
		Topic__c newTopic = new Topic__c(
			Name = newTopicName,
			Description__c = newTopicDescription
		);
		insert newTopic;

		return ApexPages.currentPage();
	}

	public PageReference createNewPoint() {
		String topicId = ApexPages.currentPage().getParameters().get('topicId');

		TopicToPointMap currentTopicToPointMap = TopicToPointMap.searchByTopicId(topicId);

		Point__c point = new Point__c(
			Name = currentTopicToPointMap.topicWrapper.newPointName,
			Description__c = currentTopicToPointMap.topicWrapper.newPointDescription,
			Topic__c = topicId
		);

		insert point;

		List<Estimate_Time__c> estimateTimesToInsert = new List<Estimate_Time__c>();

		for (Hardness_Level__c hardnessLevel: [
			SELECT Name
			FROM Hardness_Level__c
			LIMIT 10000
		]) {
			Estimate_Time__c estimateTimeToInsert = new Estimate_Time__c(
				Point__c = point.Id,
				Hardness_Level__c = hardnessLevel.Id,
				Employee__c = currentUser.Id,
				Time__c = 0
			);
			estimateTimesToInsert.add(estimateTimeToInsert);
		}

		insert estimateTimesToInsert;

		return null;
	}
}