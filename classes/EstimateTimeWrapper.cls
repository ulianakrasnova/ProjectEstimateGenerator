public with sharing class EstimateTimeWrapper {

	public Decimal estimateTime { get; set; }
	public String hardnessLevelName { get; set; }
	
	public EstimateTimeWrapper(Decimal estimateTime, Hardness_Level__c hardnessLevel) {
		this.estimateTime = estimateTime;
		this.hardnessLevelName = hardnessLevel.Name;		
	}

}