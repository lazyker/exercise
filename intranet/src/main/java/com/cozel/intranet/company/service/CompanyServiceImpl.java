package com.cozel.intranet.company.service;

import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cozel.intranet.company.dao.CompanyDao;

@Service(value = "CompanyService")
public class CompanyServiceImpl implements CompanyService {

	@Autowired
	private CompanyDao companyDao;
	
	@Override
	public List<Map<String, Object>> getCompanyList(Map<String, Object> param) {
	    return companyDao.getCompanyList(param); 
	}
	
	@Override
	public int getTotalCount(Map<String, Object> param) {
	    return companyDao.getTotalCount(param);
	}
	
	@Override
	public Map<String, Object> getCompany(Map<String, Object> param) {
	    return companyDao.getCompany(param);
	}
	
	@Override
	public void setCompany(Map<String, Object> param) {
	    companyDao.setCompany(param);
	}
	
	@Override
    public void setPerson(Map<String, Object> param) {
        companyDao.setPerson(param);
    }
	
    @Override
    public void modCompany(Map<String, Object> param) {
        companyDao.modCompany(param);
    }
	
    @Override
    public void delCompany(Map<String, Object> param) {
        companyDao.delCompany(param);
    }
    
	@Override
	public List<Map<String, Object>> getPersonList(Map<String, Object> param) {
	    return companyDao.getPersonList(param); 
	}
	
	@Override
    public void modPerson(Map<String, Object> param) {
        companyDao.modPerson(param);
    }
	
	@Override
    public void delPerson(Map<String, Object> param) {
        companyDao.delPerson(param);
    }
	
}
