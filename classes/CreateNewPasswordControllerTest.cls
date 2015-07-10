@isTest
private class CreateNewPasswordControllerTest {

	private static Employee__c employee;

	private static void init() {
		employee = new Employee__c(
			Name = 'Test User',
			Login__c = 'test',
			Password__c = '098f6bcd4621d373cade4e832627b4f6',
			Email__c = 'test@test.com',
			Hint__c = 'test',
			Answer__c = 'test',
			Question__c = 'test',
			Session__c = '098f6bcd4621d373cade4e832627b4f6'
		);
		insert employee;
	}

	@isTest static void testCreateNewPassword_validPassword() {
		init();

		ApexPages.currentPage().getParameters().put('s', '098f6bcd4621d373cade4e832627b4f6');

		Test.startTest();

		CreateNewPasswordController controller = new CreateNewPasswordController();
		controller.newPassword = 'test';
		controller.confirmPassword = 'test';

		PageReference prHome = controller.setNewPassword();

		System.assertEquals(Page.HomePage.getUrl(), prHome.getUrl());

		Test.stopTest();
	}

	@isTest static void testCreateNewPassword_WithoutUser() {
		Test.startTest();

		CreateNewPasswordController controller = new CreateNewPasswordController();
		PageReference prHome = controller.setNewPassword();

		System.assert(ApexPages.hasMessages(ApexPages.Severity.ERROR));

		Test.stopTest();
	}

	@isTest static void testCreateNewPassword_invalidPassword() {
		init();

		Test.startTest();

		CreateNewPasswordController controller = new CreateNewPasswordController();
		PageReference prHome = controller.setNewPassword();

		System.assert(ApexPages.hasMessages(ApexPages.Severity.ERROR));

		Test.stopTest();
	}

}