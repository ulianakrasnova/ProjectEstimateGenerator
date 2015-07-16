public with sharing class PointWrapper {

	public String id { get; set; }
	public String name { get; set; }
	public String description { get; set; }
	public String topicName { get; set; }
	public String topicId { get; set; }
	public List<EstimateTimeWrapper> estimateTimeWrappersList { get; set; }
	private static List<PointWrapper> allPoints = new List<PointWrapper>();

	public PointWrapper(Point__c point) {
		this.id = point.Id;
		this.name = point.Name;
		this.description = point.Description__c;
		this.topicName = point.Topic__r.Name;
		this.topicId = point.Topic__r.Id;

		estimateTimeWrappersList = new List<EstimateTimeWrapper>();
		for (Estimate_Time__c estimateTime: [
			SELECT Time__c, Hardness_Level__r.Name, Hardness_Level__r.Id, Point__r.Id
			FROM Estimate_Time__c
			WHERE Point__r.Id = :point.Id
			LIMIT 10000
		]) {
			estimateTimeWrappersList.add(new EstimateTimeWrapper(
				estimateTime, 
				estimateTime.Hardness_Level__r,
				estimateTime.Point__r
			));
		}		
	}

	public static List<PointWrapper> getAllPoints() {
		allPoints.clear();

		String currentSessionId = ApexPages.currentPage().getCookies().get('userSession').getValue();
		for (Point__c point: [
			SELECT Name, Description__c, Topic__r.Name, Topic__r.Id, (
				SELECT Time__c, Hardness_Level__r.Name
				FROM Estimated_Times__r
				WHERE Employee__r.Session__c = :currentSessionId
				LIMIT 2000
			) 
			FROM Point__c
			LIMIT 10000
		]) {
			allPoints.add(new PointWrapper(point));
		}

		return allPoints;
	}
}