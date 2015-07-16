@isTest
private class TopicWrapperTest {

	private static TopicWrapper testTopicWrapper;

	private static void init() {
		Topic__c topic = new Topic__c(
			Name = 'Test topic',
			Description__c = 'Test topic description'
		);

		testTopicWrapper = new TopicWrapper(topic);

		insert topic;
	}
	
	@isTest static void getAllTopics_isNotEmpty() {
		init();
		
		Test.startTest();

		List<TopicWrapper> allTopics = TopicWrapper.getAllTopics();

		System.assert(!allTopics.isEmpty());

		Test.stopTest();
	}
	
	@isTest static void getAllTopics_containsElement() {
		init();

		Test.startTest();

		List<TopicWrapper> allTopics = TopicWrapper.getAllTopics();
		System.assertEquals(allTopics[0].name, testTopicWrapper.name);

		Test.stopTest();
	}
	
}