public with sharing class TopicToPointMap {

	public TopicWrapper topicWrapper { get; set; }
	public List<PointWrapper> pointWrappersList { get; set; }
	private static List<TopicToPointMap> allTopicToPointMaps = new List<TopicToPointMap>();
	
	public TopicToPointMap(TopicWrapper topicWrapper, List<PointWrapper> pointWrappersList) {
		this.topicWrapper = topicWrapper;
		this.pointWrappersList = pointWrappersList;
	}

	public static List<TopicToPointMap> getAllTopicToPointMaps() {
		List<TopicWrapper> allTopics = TopicWrapper.getAllTopics();
		List<PointWrapper> allPoints = PointWrapper.getAllPoints();

		allTopicToPointMaps.clear();

		for (TopicWrapper topic: allTopics) {
			List<PointWrapper> points = new List<PointWrapper>();
			for (PointWrapper point: allPoints) {
				if (topic.name == point.topicName) {
					points.add(point);
				}
			}
			allTopicToPointMaps.add(new TopicToPointMap(topic, points));
		}

		return allTopicToPointMaps;
	}

}