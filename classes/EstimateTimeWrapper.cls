public with sharing class EstimateTimeWrapper {

	public Decimal estimateTime;
	private String hardnessLevelName;
	
	public EstimateTimeWrapper(Decimal estimateTime, Hardness_Level__c hardnessLevel) {
		this.estimateTime = estimateTime;
		this.hardnessLevelName = hardnessLevel.Name;		
	}

	public Decimal getEstimateTime() {
		return this.estimateTime;
	}

	public void setEstimateTime(Decimal estimateTime) {
		this.estimateTime = estimateTime;
	}

	public String getHardnessLevelName() {
		return this.hardnessLevelName;
	}

}