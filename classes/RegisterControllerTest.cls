@isTest
private class RegisterControllerTest {

	private static Employee__c employee;

	private static void init() {
		employee = new Employee__c(
			Name = 'Test User',
			Login__c = 'test',
			Password__c = '098f6bcd4621d373cade4e832627b4f6',
			Email__c = 'test@test.com'
		);
		insert employee;
	}

	@isTest static void testRegistration_validInfo() {
		Test.startTest();

		RegisterController controller = new RegisterController();

		controller.firstName = 'Test';
		controller.lastName = 'User';
		controller.username = 'test';
		controller.password = 'test';
		controller.user.Email__c = 'test@test.com';
		controller.user.Question__c = 'test question';
		controller.user.Hint__c = 'test hint';
		controller.user.Answer__c = 'test answer';

		PageReference prRegister = controller.doRegister();
		PageReference prCancel = controller.doCancel();

		Test.stopTest();

		System.assertEquals(Page.HomePage.getUrl(), prRegister.getUrl());
		System.assertEquals(Page.LoginPage.getUrl(), prCancel.getUrl());
	}

	@isTest static void testRegistration_invalidInfo() {
		init();

		Test.startTest();

		RegisterController controller = new RegisterController();

		ApexPages.currentPage().getParameters().put('username', 'test');
		ApexPages.currentPage().getParameters().put('email', 'test@test.com');
		controller.doCheck();
		System.assert(ApexPages.hasMessages());
		System.assertEquals(2, ApexPages.getMessages().size(), ApexPages.getMessages());

		ApexPages.currentPage().getParameters().put('username', 'test');
		ApexPages.currentPage().getParameters().put('email', 'test1@test.com');
		controller.doCheck();
		System.assert(ApexPages.hasMessages());

		ApexPages.currentPage().getParameters().put('username', 'test1');
		ApexPages.currentPage().getParameters().put('email', 'test1@test.com');
		controller.doCheck();
		System.assert(ApexPages.hasMessages(), ApexPages.getMessages());

		Test.stopTest();
	}

}