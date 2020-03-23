package global.sesoc.wareware.model;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Random;

public class SHA256Util {
	
	
	//sha-256 암호화
	
	public static String getEncrypt(String source,String salt) {
		
		return getEncrypt(source,salt.getBytes());
	}

	public static String getEncrypt(String source,byte[] salt) {
		
		String result = "";
		
		byte[] a = source.getBytes();
		byte[] bytes = new byte[a.length + salt.length];
		
		System.arraycopy(a, 0, bytes, 0, a.length);
        System.arraycopy(salt, 0, bytes, a.length, salt.length);
		
		try {
			MessageDigest md = MessageDigest.getInstance("SHA-256");
			md.update(bytes);
			
			byte[] byteData = md.digest();
			
			StringBuffer sb = new StringBuffer();
			for(int i=0;i<byteData.length; i++) {
				sb.append(Integer.toString((byteData[i] & 0xFF) + 256, 16).substring(1));
			}
			result = sb.toString();
		}catch(NoSuchAlgorithmException e) {
			e.printStackTrace();
		}
		return result;
	}
	
	
	//helper 생성
	public static String generateHelper() {
		Random random = new Random();
		
		byte[] helper = new byte[8];
		random.nextBytes(helper);
		
		StringBuffer sb = new StringBuffer();
		for(int i = 0 ; i< helper.length; i++) {  //byte값을 hex값으로 전환
			sb.append(String.format("%02x", helper[i]));
		}
		
		return sb.toString();
	}
	
	
	
	
	
	
}
