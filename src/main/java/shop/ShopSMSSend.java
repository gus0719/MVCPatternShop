package shop;

import java.util.HashMap;
import java.util.Random;

import org.json.simple.JSONObject;

import net.nurigo.java_sdk.api.Message;
import net.nurigo.java_sdk.exceptions.CoolsmsException;

public class ShopSMSSend {
	String api_key;
	String api_key_secret;
	String responsePhoneNo = "";
	//Message message = new Message();
	
	public String smsSend(String phone_user) {
		 api_key = "NCS2IEVVSZRB5POG";
		 api_key_secret = "4NOXNXYZNWF1EJVXNBLNFIMRBJWKUB77";
		Message coolsms = new Message(api_key, api_key_secret);
		Random rd = new Random();
		int randomNo = rd.nextInt(999999)+1;
		System.out.println("Random Chk>>"+randomNo);
		HashMap<String, String> params = new HashMap<String, String>();
	    params.put("to", phone_user); // 수신번호
	    params.put("from", "01097061935"); // 발신번호 등록번호와 일치
	    params.put("type", "SMS"); // Message type ( SMS, LMS, MMS, ATA )
	    String text = "[DREAM] 입력하실 인증번호는 "+Integer.toString(randomNo)+" 입니다";
	    params.put("text", text); // 문자내용
	    try {
		      JSONObject obj = (JSONObject) coolsms.send(params);
		      System.out.println(obj.toString());
		    } catch (CoolsmsException e) {
		      e.getMessage();
		      e.getCode();
		    }
		return Integer.toString(randomNo);
	}
	public static void main(String[] args) {
		ShopSMSSend sms = new ShopSMSSend();
		sms.smsSend("01097061935");
	}
}