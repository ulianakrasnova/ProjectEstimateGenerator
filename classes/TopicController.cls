public with sharing class TopicController {

	private List<TopicToPointMap> allTopicToPointMaps;

	public TopicController() {
		
	}

	public List<TopicToPointMap> getAllTopicToPointMaps() {
 		allTopicToPointMaps = TopicToPointMap.getAllTopicToPointMaps();

 		return allTopicToPointMaps;
	}

	public Integer getHardnessLevelsNumber() {
		return [
			SELECT COUNT()
			FROM Hardness_Level__c
		];
	}

}