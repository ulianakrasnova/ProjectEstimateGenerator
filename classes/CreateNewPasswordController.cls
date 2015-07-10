public with sharing class CreateNewPasswordController {
	public String newPassword {get; set;}
	public String confirmPassword {get; set;}
	public Employee__c user {get; set;}

	public CreateNewPasswordController() {
		this.user = new Employee__c();
	}

	public PageReference setNewPassword() {
		//get sparam from request
		String sparam = ApexPages.currentPage().getParameters().get('s');

		//select from database by sparam
		List<Employee__c> users = [
			SELECT Name, Session__c, Login__c, Password__c
			FROM Employee__c
			WHERE Session__c = :sparam
			LIMIT 1
		];

		if ( ! users.isEmpty()) {
			user = users.get(0);

			if (newpassword == confirmpassword) {
				user.Password__c = newpassword;
				this.user.Session__c = SessionUtils.createSession(user.Login__c, user.Password__c);
				update user;
				Cookie userSession = new Cookie('userSession', this.user.Session__c, null, 700, false);
				ApexPages.currentPage().setCookies(new Cookie[]{userSession});
				return Page.HomePage;
			} else {
				//else display error message
				ApexPages.addMessage(
					new ApexPages.Message(
						ApexPages.Severity.ERROR,
						'Passwords aren\'t the same.'));
				return null;
			}
		} else {
			//else display error message
			ApexPages.addMessage(
				new ApexPages.Message(
					ApexPages.Severity.ERROR,
					'This user isn\'t exist.'));
			return null;
		}
	}
}