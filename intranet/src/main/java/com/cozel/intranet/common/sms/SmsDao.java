package com.cozel.intranet.common.sms;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.cozel.intranet.common.abstractDao.SmsAbstractDao;

@Repository("smsDao")
public class SmsDao extends SmsAbstractDao{
    
    public int smsSend(Map<String, Object> paramMap) {
       return (Integer) insert("sms.smsSend", paramMap);
    }
    
    public int mmsSend(Map<String, Object> paramMap) {
        return (Integer) insert("sms.mmsSend", paramMap);
     }
    
    @SuppressWarnings("unchecked")
    public List<Map<String, Object>> getSmsHistory(Map<String, Object> paramMap) {
        return (List<Map<String, Object>>) selectList("sms.getSmsHistory", paramMap);
     }
}
