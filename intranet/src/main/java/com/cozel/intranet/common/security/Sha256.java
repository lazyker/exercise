package com.cozel.intranet.common.security;

import java.security.MessageDigest;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class Sha256 {
	
	private static final Logger logger = LoggerFactory.getLogger(Sha256.class);
	
	public static String encrypt(String planText) {
		logger.debug("암호화 전 패스워드 : {}", planText);
        try{
        	if (StringUtils.isNotEmpty(planText)) {
        		MessageDigest md = MessageDigest.getInstance("SHA-256");
        		md.update(planText.getBytes());
        		byte byteData[] = md.digest();
        		
        		StringBuffer sb = new StringBuffer();
        		for (int i = 0; i < byteData.length; i++) {
        			sb.append(Integer.toString((byteData[i] & 0xff) + 0x100, 16).substring(1));
        		}
        		
        		return sb.toString();
        	} else {
        		return planText;
        	}
            
        }catch(Exception e){
            e.printStackTrace();
            throw new RuntimeException();
        }
    }
	
}
