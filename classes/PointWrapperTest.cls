@isTest
private class PointWrapperTest {

	private static Point__c point;

	private static void init() {
		Topic__c testTopic = new Topic__c(
			Name = 'Test Topic Name',
			Description__c = 'Test Topic Description'
		);

		insert testTopic;

		Point__c testPoint = new Point__c(
			Name = 'Test Point Name',
			Description__c = 'Test Point Description',
			Topic__c = testTopic.Id
		);

		insert testPoint;
		point = testPoint;

		Hardness_Level__c testHardnessLevel = new Hardness_Level__c(
			Name = 'Test Hardness Level'
		);

		insert testHardnessLevel;

		Estimate_Time__c testEstimateTime = new Estimate_Time__c(
			Point__c = testPoint.Id,
			Hardness_Level__c = testHardnessLevel.Id,
			Time__c = 1
		);

		insert testEstimateTime;
	}
	
	@isTest static void estimateTimeWrappersList_isNotEmpty() {
		init();

		Test.startTest();

		PointWrapper testPointWrapper = new PointWrapper(point);
		System.assert(!testPointWrapper.estimateTimeWrappersList.isEmpty());

		Test.stopTest();
	}

}