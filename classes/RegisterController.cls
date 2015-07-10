public with sharing class RegisterController extends AbstractController {

	public String firstName { get; set; }
	public String lastName { get; set; }
	public String username { get; set; }
	public String password { get; set; }

	public RegisterController() {
		super();

		this.username = '';
		this.password = '';
	}

	public PageReference doCheck() {
		String login = ApexPages.currentPage().getParameters().get('username');
		String email = ApexPages.currentPage().getParameters().get('email');
		email = ( ! String.isEmpty(email)) ? email.replace('\'', '\\\'') : '';

		List<Employee__c> users = [
			SELECT Login__c, Email__c
			FROM Employee__c
			WHERE Login__c = :login
			   OR Email__c = :email
			LIMIT 1
		];

		ApexPages.getMessages().clear();

		if ( ! users.isEmpty() && users.get(0).Login__c == login) {
			ApexPages.addMessage(
				new ApexPages.Message(
					ApexPages.Severity.ERROR,
					'This login is exist already.')
			);
		}

		if ( ! users.isEmpty() && users.get(0).Email__c == email) {
				ApexPages.addMessage(
					new ApexPages.Message(
						ApexPages.Severity.ERROR,
						'This email is exist already.')
				);
		}

		return null;
	}

	public PageReference doRegister() {
		try {
			String sessionId = SessionUtils.createSession(this.username, this.password);
			Cookie userSession = new Cookie('userSession', sessionId, null, 7200, false);
			ApexPages.currentPage().setCookies(new Cookie[]{userSession});

			this.user.Session__c = sessionId;
			this.user.Login__c = this.username;
			this.user.Password__c = SessionUtils.createPassword(this.password);
			this.user.Name = firstName + ' ' + lastname;
			this.user.Hint__c = this.user.Hint__c.trim();
			insert user;
		}
		catch(Exception e) {
			String message = e.getMessage();
			if (message.contains('Login__c') || message.contains('Email__c')) {
				if (message.contains('Login__c')) {
					ApexPages.addMessage(
						new ApexPages.Message(
							ApexPages.Severity.ERROR,
							'This login is exist already.'));
				}

				if (message.contains('Email__c')) {
					ApexPages.addMessage(
						new ApexPages.Message(
							ApexPages.Severity.ERROR,
							'This email is exist already.'));
				}
			}
			else {
				ApexPages.addMessage(
						new ApexPages.Message(
							ApexPages.Severity.ERROR,
							message));
			}

			return null;
		}

		//send confirm e-mail
		Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
		email.setSubject('Regisration on the SalesForce');
		email.setToAddresses(new List<String>{this.user.Email__c});
		email.setHtmlBody('Dear ' + user.Name + ',</br><p>Welcome to the SalesForce. </br>Your login:' +
			user.Login__c + '</p>Please follow the link below to log in for your account:</br>' +
			'<a href="' + URL.getSalesforceBaseUrl().toExternalForm() +
			'/apex/LoginPage">Welcome to Home Page!</a>');

		List<Messaging.SendEmailResult> emails = Messaging.sendEmail(new Messaging.SingleEmailMessage[] {email});

		return Page.HomePage;
	}

	public PageReference doCancel() {
		return Page.LoginPage;
	}
}