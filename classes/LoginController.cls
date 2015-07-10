public with sharing class LoginController extends AbstractController {
	public String username { get; set; }
	public String password { get; set; }

	public LoginController() {
		super();

		this.username = '';
		this.password = '';
	}

	public PageReference init() {
		if (this.user.Id != null) {
			return Page.HomePage;
		}
		else {
			ApexPages.currentPage().getCookies().remove('userSession');
			return null;
		}
	}

	public PageReference doLogin() {
		//select from database by login and password
		List <Employee__c> users = [
			SELECT Login__c, Password__c
			FROM Employee__c
			WHERE Login__c = :this.username
			  AND Password__c = :SessionUtils.createPassword(this.password)
			LIMIT 1
		];

		//if exist do login(go to home page)
		if ( ! users.isEmpty()) {
			this.user = users.get(0);

			//add new Session
			String sessionId = SessionUtils.createSession(this.username, this.password);
			Cookie userSession = new Cookie('userSession', sessionId, null, 7200, false);
			ApexPages.currentPage().setCookies(new Cookie[] {userSession});

			this.user.Session__c = sessionId;
			this.user.Login__c = this.username;
			this.user.Password__c = SessionUtils.createPassword(this.password);
			update user;

			return Page.HomePage;
		}
		else { //else display error message
			ApexPages.addMessage(
				new ApexPages.Message(
					ApexPages.Severity.ERROR,
					'There is no such username or password.'));
		}

		return null;
	}

	public PageReference doRegister() {
		return Page.RegisterPage;
	}

	public PageReference doForgotPassword() {
		return Page.ForgotPassword;
	}
}