public with sharing class TopicToPointMap {

	public TopicWrapper topicWrapper { get; set; }
	public List<PointWrapper> pointWrappersList { get; set; }
	
	public TopicToPointMap(TopicWrapper topicWrapper, List<PointWrapper> pointWrappersList) {
		this.topicWrapper = topicWrapper;
		this.pointWrappersList = pointWrappersList;
	}

	public static List<TopicToPointMap> getAllTopicToPointMaps() {
		List<TopicWrapper> allTopics = TopicWrapper.getAllTopics();
		List<PointWrapper> allPoints = PointWrapper.getAllPoints();

		List<TopicToPointMap> allTopicToPointMaps = new List<TopicToPointMap>();

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

}