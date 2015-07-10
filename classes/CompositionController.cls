public with sharing class CompositionController extends AbstractController {

	public CompositionController() {
		super();
	}

	public PageReference init() {
		if (super.initPage()) {
			return null;
		}
		return doLogOut();
	}

	public PageReference doLogOut() {
		if (this.user.Id != null) {
			ApexPages.currentPage().getCookies().remove('userSession');
			this.user.Session__c = null;
			update this.user;
		}

		if (ApexPages.currentPage().getUrl().contains('Login')) {
			return null;
		}
		else {
			return Page.LoginPage;
		}
 	}

}