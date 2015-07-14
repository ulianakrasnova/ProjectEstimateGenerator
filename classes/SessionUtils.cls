public with sharing class SessionUtils {
	//create Session string
	public static String createSession(String login, String password) {
		Time t = DateTime.now().time();
		String strSession = login + password + String.valueOf(t);

		return EncodingUtil.convertToHex(Crypto.generateDigest('MD5', Blob.valueOf(strSession)));
	}

	public static String createPassword(String password) {
		return EncodingUtil.convertToHex(Crypto.generateDigest('MD5', Blob.valueOf(password)));
	}
}