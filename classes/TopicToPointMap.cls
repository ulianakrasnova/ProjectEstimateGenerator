public with sharing class TopicToPointMap {

	private TopicWrapper topicWrapper;
	private List<PointWrapper> pointWrappersList;
	private static List<TopicToPointMap> allTopicToPointMaps = new List<TopicToPointMap>();
	
	public TopicToPointMap(TopicWrapper topicWrapper, List<PointWrapper> pointWrappersList) {
		this.topicWrapper = topicWrapper;
		this.pointWrappersList = pointWrappersList;
	}

	public TopicWrapper getTopicWrapper() {
		return this.topicWrapper;
	}

	public List<PointWrapper> getPointWrappersList() {
		return this.pointWrappersList;
	}

	public static List<TopicToPointMap> getAllTopicToPointMaps() {
		List<TopicWrapper> allTopics = TopicWrapper.getAllTopics();
		List<PointWrapper> allPoints = PointWrapper.getAllPoints();

		allTopicToPointMaps.clear();

		for (TopicWrapper topic: allTopics) {
			List<PointWrapper> points = new List<PointWrapper>();
			for (PointWrapper point: allPoints) {
				if (topic.getName() == point.getTopicName()) {
					points.add(point);
				}
			}
			allTopicToPointMaps.add(new TopicToPointMap(topic, points));
		}

		return allTopicToPointMaps;
	}

}