public with sharing class TopicWrapper {

	public String id { get; set; }
	public String name { get; set; }
	public String description { get; set; }
	private static List<TopicWrapper> allTopics = new List<TopicWrapper>();

	public String newPointName { get; set; }
	public String newPointDescription { get; set; }

	public TopicWrapper(Topic__c topic) {
		this.id = topic.Id;
		this.name = topic.Name;
		this.description = topic.Description__c;
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