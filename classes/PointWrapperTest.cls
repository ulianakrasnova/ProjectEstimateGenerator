@isTest
private class PointWrapperTest {

	private static Point__c testPoint;

	private static void init() {
		String testSessionId = 'test';
		ApexPages.currentPage().setCookies(
			new Cookie[]{
				new Cookie('userSession', testSessionId, null, 7200, false)
			}
		);

		Employee__c testEmployee = new Employee__c(
			Session__c = testSessionId
		);

		insert testEmployee;

		Topic__c testTopic = new Topic__c(
			Name = 'Test Topic Name',
			Description__c = 'Test Topic Description'
		);

		insert testTopic;

		testPoint = new Point__c(
			Name = 'Test Point Name',
			Description__c = 'Test Point Description',
			Topic__c = testTopic.Id
		);

		insert testPoint;

		Hardness_Level__c testHardnessLevel = new Hardness_Level__c(
			Name = 'Test Hardness Level'
		);

		insert testHardnessLevel;

		Estimate_Time__c testEstimateTime = new Estimate_Time__c(
			Point__c = testPoint.Id,
			Hardness_Level__c = testHardnessLevel.Id,
			Time__c = 1,
			Employee__c = testEmployee.Id
		);

		insert testEstimateTime;

		System.debug('testEstimateTime consists of: ' + testEstimateTime);
	}
	
	@isTest static void estimateTimeWrappersList_isNotEmpty() {
		init();

		Test.startTest();

		PointWrapper testPointWrapper = new PointWrapper(testPoint);
		System.assert(!testPointWrapper.estimateTimeWrappersList.isEmpty());

		Test.stopTest();
	}

}