package com.cozel.intranet.common.sms;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("smsService")
public class SmsServiceImpl implements SmsService {
    
    @Autowired
    private SmsDao smsDao;
    
	@Override
	public int smsSend(Map<String, Object> param) {
		return smsDao.smsSend(param);
	}
	
	@Override
	public int mmsSend(Map<String, Object> param) {
		return smsDao.mmsSend(param);
	}
	
	@Override
	public List<Map<String, Object>> getSmsHistory(Map<String, Object> param) {
		return smsDao.getSmsHistory(param);
	}
	
}
