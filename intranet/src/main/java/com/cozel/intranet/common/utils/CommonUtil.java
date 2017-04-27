package com.cozel.intranet.common.utils;

import javax.servlet.http.HttpServletRequest;

public class CommonUtil {
	
    //10자리
	public static synchronized String UNIQUEKEY() {
		int iLen = 2;
		int dateTimeSeq= 0;
		int MAXSEQ= 500;
		
		String s = getConvert36(System.nanoTime()) + StringUtil.setPrefixLen(getConvert36(dateTimeSeq++),iLen,"0");
		// 1343783860986+123456는 long됨
		//DateTimeSeq는 123456 (6자리)정도까지 됨.
		if(dateTimeSeq>MAXSEQ)
			dateTimeSeq=0;
		return s;
	}
	
	/**
	 * 접속한 IP 구하기
	 */
	public static String getRealIP(HttpServletRequest request) {
		String clientIP = request.getHeader("HTTP_X_FORWARDED_FOR");
		if(null == clientIP || clientIP.length() == 0 
		   || clientIP.toLowerCase().equals("unknown")){
			clientIP = request.getHeader("REMOTE_ADDR");
		}
		 
		if(null == clientIP || clientIP.length() == 0 
		   || clientIP.toLowerCase().equals("unknown")){
			clientIP = request.getRemoteAddr();
		}
		return clientIP;
	}
	
	private static String getConvert36(long nDec){
		long t;
		char c;
		int nLog =36;
		String strRet = "";
		while(nDec > 0) {
			t = nDec % nLog;
			if (t<10) c = (char)(t + '0'); // int를 char로 변환
			else c = (char)(t - 10 + 'A');  // 10 이상의 수는 알파벳으로 표기
	
			strRet = c + strRet;
			nDec /= nLog;
		}
		return strRet;
		
	}
	
}
