public with sharing class CookieController {
	public CookieController() {
		Map<String, Cookie> m = ApexPages.currentPage().getCookies();

		for (String key : m.keySet()) {
			System.debug('------key=' + key + '----value=' + m.get(key).getValue());
		}
	}
}