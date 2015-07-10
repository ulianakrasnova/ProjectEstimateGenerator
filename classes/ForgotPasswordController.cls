public with sharing class ForgotPasswordController {

	public Employee__c employee {get; set;}
	public Boolean isExist {get; set;}
	public Boolean isSend {get; set;}
	public String Answer {get; set;}

	public ForgotPasswordController() {
		this.employee = new Employee__c();
		this.Answer = '';
		this.isSend = true;
		this.isExist = false;
	}

	public PageReference getSecurityAsk() {
		//select from database by email
		List<Employee__c> users = [
			SELECT Name, Question__c, Hint__c, Email__c, Session__c, Answer__c, Login__c, Password__c
			FROM Employee__c
			WHERE Email__c = :this.employee.Email__c
			LIMIT 1];

		isExist = ! users.isEmpty();

		//if isExist show Question and Hint
		if (isExist) {
			this.employee = users.get(0);
			return null;
		} else {
			//else display error message
			ApexPages.addMessage(
				new ApexPages.Message(
					ApexPages.Severity.ERROR,
					'This user isn\'t exist.'));
		}
		return null;
	}

	public PageReference getPassword() {
		if (Answer == this.employee.Answer__c) {
			this.employee.Session__c = SessionUtils.createSession(this.employee.Login__c, this.employee.Password__c);
			update this.employee;

			Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();

			email.setSubject( 'Request for new password on the SalesForce' );
			email.setToAddresses( new List<String>{this.employee.Email__c} );
			email.setHtmlBody( 'Dear '+ this.employee.Name +
				',</br><p>You requested a password recovery for your account on the SalesForce </br>Your login:'+
				 this.employee.Login__c +'</p>To recover your password, go to ' + '<a href="' +
				 URL.getSalesforceBaseUrl().toExternalForm() + '/apex/CreateNewPasswordPage?s=' +
				 this.employee.Session__c + '">this link</a>' );

			List<Messaging.SendEmailResult> r =
				Messaging.sendEmail( new Messaging.SingleEmailMessage[] {email} );
				isSend = false;
				ApexPages.addMessage(
					new ApexPages.Message(
						ApexPages.Severity.INFO,
						'Please, check your e-mail'));
				} else {
					//else display error message
					ApexPages.addMessage(
						new ApexPages.Message(
							ApexPages.Severity.ERROR,
							'This is wrong answer.'));
				}
		return null;
	}
}