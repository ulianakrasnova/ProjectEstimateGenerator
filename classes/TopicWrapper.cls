public with sharing class TopicWrapper {

	private String name;
	private String description;
	private static List<TopicWrapper> allTopics = new List<TopicWrapper>();

	public TopicWrapper(Topic__c topic) {
		this.name = topic.Name;
		this.description = topic.Description__c;
	}

	public String getName() {
		return this.name;
	}

	public String getDescription() {
		return this.description;
	}

	public static List<TopicWrapper> getAllTopics() {
		allTopics.clear();
		
		for (Topic__c topic: [
			SELECT Name, Description__c
			FROM Topic__c
			LIMIT 10000
		]) {
			allTopics.add(new TopicWrapper(topic));
		}
		
		return allTopics;
	}

}