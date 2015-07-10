@isTest
private class LoginControllerTest {
	private static Employee__c employee;

	private static void init() {
		employee = new Employee__c(
			Name = 'Test User',
			Login__c = 'test',
			Password__c = '098f6bcd4621d373cade4e832627b4f6'
		);
		insert employee;
	}

	@isTest static void testLogin_validCredentials() {
		init();

		Test.startTest();

		LoginController controller = new LoginController();
		controller.init();

		controller.username = 'test';
		controller.password = 'test';

		PageReference pr = controller.doLogin();

		Test.stopTest();

		System.assertEquals(Page.HomePage.getUrl(), pr.getUrl());
	}

	@isTest static void testLogin_invalidCredentials() {
		init();

		Test.startTest();

		LoginController controller = new LoginController();
		controller.init();

		controller.username = 'test';
		controller.password = 'test1';

		PageReference pr = controller.doLogin();

		Test.stopTest();

		System.assertEquals(null, pr);
	}

	@isTest static void testLogin_Registration() {
		Test.startTest();

		LoginController controller = new LoginController();
		controller.init();

		PageReference pr = controller.doRegister();

		Test.stopTest();

		System.assertEquals(Page.RegisterPage.getUrl(), pr.getUrl());
	}

	@isTest static void testLogin_forgotPassword() {
		Test.startTest();

		LoginController controller = new LoginController();
		controller.init();

		PageReference pr = controller.doForgotPassword();

		Test.stopTest();

		System.assertEquals(Page.ForgotPassword.getUrl(), pr.getUrl());
	}
}