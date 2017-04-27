package com.cozel.intranet.admin.service;

import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cozel.intranet.admin.dao.ConsultantDao;

@Service(value = "ConsultantService")
public class ConsultantServiceImpl implements ConsultantService {

	@Autowired
	private ConsultantDao consultantDao;
	
	@Override
	public List<Map<String, Object>> getConsultantList(Map<String, Object> param) {
	    return consultantDao.getConsultantList(param); 
	}
	
	@Override
	public Map<String, Object> getConsultant(Map<String, Object> param) {
	    return consultantDao.getConsultant(param);
	}
	
	@Override
	public void addConsultant(Map<String, Object> param) {
	    consultantDao.addConsultant(param);
	}
	
	@Override
    public void modConsultant(Map<String, Object> param) {
        consultantDao.modConsultant(param);
    }
   
	@Override
    public void delConsultant(Map<String, Object> param) {
        consultantDao.delConsultant(param);
    }

    @Override
    public boolean emailCheck(Map<String, Object> param) {
        int cnt = 0;
        boolean result = true;
        
        if(StringUtils.equals((String)param.get("state"), "new")) {
            result = (cnt == consultantDao.emailCheck(param)) ? true : false;
        }
        
        return result; 
    }
    
    @Override
    public boolean loginCheck(Map<String, Object> param) {
        int cnt = 1;
        boolean result = true;
        
        result = (cnt == consultantDao.loginCheck(param)) ? true : false;
        return result; 
    }
	
	@Override
	public void setLoginInfo(Map<String, Object> param) {
	    consultantDao.setLoginInfo(param);
	}
    
}
