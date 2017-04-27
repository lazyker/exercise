package com.cozel.intranet.admin.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.cozel.intranet.common.abstractDao.AbstractDao;

@Repository
public class ConsultantDao extends AbstractDao{

    @SuppressWarnings("unchecked")
    public List<Map<String,Object>> getConsultantList(Map<String, Object> param) {
        return (List<Map<String, Object>>)selectList("consultant.getConsultantList", param);
    }
    
    @SuppressWarnings("unchecked")
    public Map<String,Object> getConsultant(Map<String, Object> param) {
        return (Map<String, Object>)selectOne("consultant.getConsultant", param);
    }
    
    public void addConsultant(Map<String, Object> param) {
        insert("consultant.addConsultant", param);
    }
    
    public void modConsultant(Map<String, Object> param) {
        update("consultant.modConsultant", param);
    }
    
    public void delConsultant(Map<String, Object> param) {
        update("consultant.delConsultant", param);
    }
    
    public int emailCheck(Map<String, Object> param) {
        return (Integer) selectOne("consultant.emailCheck", param);
    }
    
    public int loginCheck(Map<String, Object> param) {
        return (Integer) selectOne("consultant.loginCheck", param);
    }

    public void setLoginInfo(Map<String, Object> param) {
        insert("consultant.setLoginInfo", param);
    }
    
}
