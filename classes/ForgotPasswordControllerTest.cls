@isTest
private class ForgotPasswordControllerTest {

	private static Employee__c employee;

	private static void init() {
		employee = new Employee__c(
			Name = 'Test User',
			Login__c = 'test',
			Password__c = '098f6bcd4621d373cade4e832627b4f6',
			Email__c = 'test@test.com',
			Hint__c = 'test',
			Answer__c = 'test',
			Question__c = 'test'
		);
		insert employee;
	}

	@isTest static void testForgotPassword_submit() {
		init();

		Test.startTest();

		ForgotPasswordController controller = new ForgotPasswordController();
		controller.employee.Email__c = employee.Email__c;

		controller.getSecurityAsk();
		System.assert( ! ApexPages.hasMessages(ApexPages.Severity.ERROR));

		controller.employee.Email__c = 'test1@test.com';

		controller.getSecurityAsk();
		System.assert(ApexPages.hasMessages(ApexPages.Severity.ERROR));

		controller.Answer = employee.Answer__c;
		controller.getPassword();

		System.assert(ApexPages.hasMessages(ApexPages.Severity.INFO));

		Test.stopTest();
	}

}