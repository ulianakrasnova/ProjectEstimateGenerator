public with sharing class PointWrapper {

	public String name { get; set; }
	public String description { get; set; }
	public String topicName { get; set; }
	public List<EstimateTimeWrapper> estimateTimeWrappersList { get; set; }
	private static List<PointWrapper> allPoints = new List<PointWrapper>();

	public PointWrapper(Point__c point) {
		this.name = point.Name;
		this.description = point.Description__c;
		this.topicName = point.Topic__r.Name;

		estimateTimeWrappersList = new List<EstimateTimeWrapper>();
		for (Estimate_Time__c estimateTime: [
			SELECT Time__c, Hardness_Level__r.Name
			FROM Estimate_Time__c
			LIMIT 10000
		]) {
			estimateTimeWrappersList.add(new EstimateTimeWrapper(estimateTime.Time__c, estimateTime.Hardness_Level__r));
		}		
	}

	public static List<PointWrapper> getAllPoints() {
		allPoints.clear();

		String currentSessionId = ApexPages.currentPage().getCookies().get('userSession').getValue();
		for (Point__c point: [
			SELECT Name, Description__c, Topic__r.Name, (
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