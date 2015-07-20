public with sharing class PointWrapper {

	public String id { get; set; }
	public String name { get; set; }
	public String description { get; set; }
	public String topicName { get; set; }
	public String topicId { get; set; }
	public List<EstimateTimeWrapper> estimateTimeWrappersList { get; set; }
	private static List<PointWrapper> allPoints = new List<PointWrapper>();
	private static String currentSessionId = ApexPages.currentPage().getCookies().get('userSession').getValue();

	public PointWrapper(Point__c point) {
		this.id = point.Id;
		this.name = point.Name;
		this.description = point.Description__c;
		this.topicName = point.Topic__r.Name;
		this.topicId = point.Topic__r.Id;

		estimateTimeWrappersList = new List<EstimateTimeWrapper>();

		for (Estimate_Time__c estimateTime: [
				SELECT Time__c, Hardness_Level__r.Name, Hardness_Level__r.Id, Point__r.Id, Employee__r.Id
				FROM Estimate_Time__c
				WHERE Point__r.Id = :point.Id
					AND Employee__r.Session__c = :currentSessionId
				LIMIT 10000
			]) { 
				estimateTimeWrappersList.add(new EstimateTimeWrapper(
					estimateTime, 
					estimateTime.Hardness_Level__r,
					estimateTime.Point__r,
					estimateTime.Employee__r
			));
		}		
	}

	public PointWrapper(Point__c point, List<Estimate_Time__c> estimateTimes) {
		this.id = point.Id;
		this.name = point.Name;
		this.description = point.Description__c;
		this.topicName = point.Topic__r.Name;
		this.topicId = point.Topic__r.Id;

		estimateTimeWrappersList = new List<EstimateTimeWrapper>();

		for (Estimate_Time__c estimateTime: estimateTimes) {
			estimateTimeWrappersList.add(new EstimateTimeWrapper(
				estimateTime, 
				estimateTime.Hardness_Level__r,
				estimateTime.Point__r,
				estimateTime.Employee__r
			));
		}	
	}

	public static List<PointWrapper> getAllPoints() {
		allPoints.clear();

		for (Point__c point: [
			SELECT Name, Description__c, Topic__r.Name, Topic__r.Id, (
				SELECT Time__c, Hardness_Level__r.Name, Point__r.Name, Employee__r.Name
				FROM Estimate_Times__r
				WHERE Employee__r.Session__c = :currentSessionId
				LIMIT 2000
			) 
			FROM Point__c
			LIMIT 10000
		]) {
			if ( ! point.Estimate_Times__r.isEmpty()) {
				allPoints.add(new PointWrapper(point, point.Estimate_Times__r));
			}
		}

		return allPoints;
	}
}