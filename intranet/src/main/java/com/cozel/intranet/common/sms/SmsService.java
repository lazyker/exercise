package com.cozel.intranet.common.sms;

import java.util.List;
import java.util.Map;

public interface SmsService {

	//sms 발송
    int smsSend(Map<String, Object> param);

    //mms 발송 정보 입력
    int mmsSend(Map<String, Object> param);
    
    //sms history
    List<Map<String, Object>> getSmsHistory(Map<String, Object> param);
    
}
