@isTest
private class TopicToPointMapTest {

	private static void init() {
		// counter for further loops
		Integer i;

		List<Topic__c> testTopicsList = new List<Topic__c>();

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
		
		for (i = 0; i < 2; i++) {
			Topic__c testTopic = new Topic__c(
				Name = 'Topic ' + String.valueOf(i),
				Description__c = 'Topic ' + String.valueOf(i) + ' Description'
			);
			testTopicsList.add(testTopic);
		}

		insert testTopicsList;

		List<Point__c> testPointsList = new List<Point__c>();

		for (i = 0; i < 2; i++) {
			Point__c testPoint = new Point__c(
				Name = 'Point ' + String.valueOf(i),
				Description__c = 'Point ' + String.valueOf(i) + ' Description',
				Topic__c = testTopicsList[i].Id
			);
			testPointsList.add(testPoint);
		}

		insert testPointsList;

		Hardness_Level__c testHardnessLevel = new Hardness_Level__c(
			Name = 'test'
		);

		insert testHardnessLevel;

		List<Estimate_Time__c> testEstimateTimesList = new List<Estimate_Time__c>();

		for (i = 0; i < 2; i++) {
			Estimate_Time__c testEstimateTime = new Estimate_Time__c(
				Point__c = testPointsList[i].Id,
				Hardness_Level__c = testHardnessLevel.Id,
				Time__c = i,
				Employee__c = testEmployee.Id
			);
		}

		insert testEstimateTimesList;
	}
	

	@isTest static void getAllTopicToPointMaps_isNotEmpty() {
		init();

		Test.startTest();

		List<TopicToPointMap> testAllTopicToPointMaps = TopicToPointMap.getAllTopicToPointMaps();

		System.assert(!testAllTopicToPointMaps.isEmpty());

		Test.stopTest();
	}
	
	@isTest static void getAllTopicToPointMaps_mappedProperly() {
		init();

		Test.startTest();

		List<TopicToPointMap> testAllTopicToPointMaps = TopicToPointMap.getAllTopicToPointMaps();

		System.assertEquals(testAllTopicToPointMaps[0].topicWrapper.name, testAllTopicToPointMaps[0].pointWrappersList[0].topicName);

		Test.stopTest();
	}
	
}