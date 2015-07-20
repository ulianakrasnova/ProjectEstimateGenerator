public with sharing class EstimateTimeWrapper {

	public String id { get; set; }
	public Decimal estimateTime { get; set; }
	public String hardnessLevelName { get; set; }
	public String hardnessLevelId { get; set; }
	public String pointId { get; set; }
	public String userId { get; set; }
	
	public EstimateTimeWrapper(Estimate_Time__c estimateTime, Hardness_Level__c hardnessLevel, Point__c point, Employee__c user) {
		this.id = estimateTime.Id;
		this.estimateTime = estimateTime.Time__c;
		this.hardnessLevelName = hardnessLevel.Name;
		this.hardnessLevelId = hardnessLevel.Id;
		this.pointId = point.Id;				
		this.userId = user.Id;
	}

}