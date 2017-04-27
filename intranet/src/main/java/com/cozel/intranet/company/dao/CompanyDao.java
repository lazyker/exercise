package com.cozel.intranet.company.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.cozel.intranet.common.abstractDao.AbstractDao;

@Repository
public class CompanyDao extends AbstractDao{

    @SuppressWarnings("unchecked")
    public List<Map<String,Object>> getCompanyList(Map<String, Object> param) {
        return (List<Map<String, Object>>)selectList("company.getCompanyList", param);
    }
    
    public int getTotalCount(Map<String, Object> param) {
        return (Integer) selectOne("company.getTotalCount", param);
    }
    
    @SuppressWarnings("unchecked")
    public Map<String,Object> getCompany(Map<String, Object> param) {
        return (Map<String, Object>)selectOne("company.getCompany", param);
    }
    
    public void setCompany(Map<String, Object> param) {
        insert("company.setCompany", param);
    }
    
    public void setPerson(Map<String, Object> param) {
        insert("company.setPerson", param);
    }
    
    public void modCompany(Map<String, Object> param) {
        update("company.modCompany", param);
    }
    
    public void delCompany(Map<String, Object> param) {
    	update("company.delCompany", param);
    }
    
    @SuppressWarnings("unchecked")
    public List<Map<String,Object>> getPersonList(Map<String, Object> param) {
        return (List<Map<String, Object>>)selectList("company.getPersonList", param);
    }
    
    public void modPerson(Map<String, Object> param) {
        update("company.modPerson", param);
    }
    
    public void delPerson(Map<String, Object> param) {
    	update("company.delPerson", param);
    }

}
