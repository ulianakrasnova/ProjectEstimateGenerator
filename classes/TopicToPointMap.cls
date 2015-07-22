public with sharing class TopicToPointMap {

	public TopicWrapper topicWrapper { get; set; }
	public List<PointWrapper> pointWrappersList { get; set; }
	public static List<TopicToPointMap> allTopicToPointMaps;
	
	public TopicToPointMap(TopicWrapper topicWrapper, List<PointWrapper> pointWrappersList) {
		this.topicWrapper = topicWrapper;
		this.pointWrappersList = pointWrappersList;
	}

	public static List<TopicToPointMap> getAllTopicToPointMaps() {
		List<TopicWrapper> allTopics = TopicWrapper.getAllTopics();
		List<PointWrapper> allPoints = PointWrapper.getAllPoints();

		allTopicToPointMaps = new List<TopicToPointMap>();

		for (TopicWrapper topic: allTopics) {
			List<PointWrapper> points = new List<PointWrapper>();
			for (PointWrapper point: allPoints) {
				if (topic.id == point.topicId) {
					points.add(point);
				}
			}
			allTopicToPointMaps.add(new TopicToPointMap(topic, points));
		}	

		return allTopicToPointMaps;
	}

	public static TopicToPointMap searchByTopicId(String topicId) {
		if (allTopicToPointMaps == null) {
			allTopicToPointMaps = TopicToPointMap.getAllTopicToPointMaps();
		}

		for (TopicToPointMap currentTopicToPointMap: allTopicToPointMaps) {
			if (currentTopicToPointMap.topicWrapper.id == topicId) {
				return currentTopicToPointMap;
			}
		}

		return null;
	}
}