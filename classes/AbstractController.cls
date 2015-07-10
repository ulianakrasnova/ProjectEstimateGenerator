public abstract class AbstractController {

	public Employee__c user {get; set;}

	public AbstractController() {
		this.user = new Employee__c();
	}

	public Boolean initPage() {
		//get cookie value
		if (ApexPages.currentPage().getCookies().containsKey('userSession')) {
			Cookie userSession = ApexPages.currentPage().getCookies().get('userSession');
			String sessionId = userSession.getValue();

			//select user by cookie value
			List<Employee__c> users = [
				SELECT Name, Session__c, Role__c
				FROM Employee__c
				WHERE Session__c = :sessionId
				LIMIT 1
			];

			if ( ! users.isEmpty()) {
				this.user = users.get(0);

				return true;
			}
		}

		return false;
	}

}