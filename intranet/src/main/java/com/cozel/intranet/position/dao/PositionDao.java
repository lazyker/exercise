package com.cozel.intranet.position.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.cozel.intranet.common.abstractDao.AbstractDao;

@Repository
public class PositionDao extends AbstractDao{

    @SuppressWarnings("unchecked")
    public List<Map<String,Object>> getPositionList(Map<String, Object> param) {
        return (List<Map<String, Object>>)selectList("position.getPositionList", param);
    }
    
    public int getPositionTotalCount(Map<String, Object> param) {
        return (Integer) selectOne("position.getPositionTotalCount", param);
    }
    
    @SuppressWarnings("unchecked")
    public Map<String,Object> getPosition(Map<String, Object> param) {
        return (Map<String, Object>)selectOne("position.getPosition", param);
    }
    
    public void setPosition(Map<String, Object> param) {
        insert("position.setPosition", param);
    }
    
    public void modPosition(Map<String, Object> param) {
        update("position.modPosition", param);
    }
    
    public void delPosition(Map<String, Object> param) {
    	update("position.delPosition", param);
    }
    
    @SuppressWarnings("unchecked")
    public List<Map<String,Object>> getCompanyPopList(Map<String, Object> param) {
        return (List<Map<String, Object>>)selectList("position.getCompanyPopList", param);
    }
    
    public int getCompanyPopTotalCount(Map<String, Object> param) {
        return (Integer) selectOne("position.getCompanyPopTotalCount", param);
    }
    

    
    @SuppressWarnings("unchecked")
    public List<Map<String,Object>> getCandidatePopList(Map<String, Object> param) {
    	return (List<Map<String, Object>>)selectList("position.getCandidatePopList", param);
    }

    public int getCandidatePopTotalCount(Map<String, Object> param) {
        return (Integer) selectOne("position.getCandidatePopTotalCount", param);
    }
    
    @SuppressWarnings("unchecked")
    public List<Map<String,Object>> getUsrRecPresentList(Map<String, Object> param) {
        return (List<Map<String, Object>>)selectList("position.getUsrRecPresentList", param);
    }
    
    public int addUsrRecPresent(Map<String, Object> param) {
    	return (Integer) insert("position.addUsrRecPresent", param);
    }
    
    public int delUsrRecPresent(Map<String, Object> param) {
        return (Integer) update("position.delUsrRecPresent", param);
    }
    
    @SuppressWarnings("unchecked")
    public List<Map<String,Object>> getUsrProStatusList(Map<String, Object> param) {
        return (List<Map<String, Object>>)selectList("position.getUsrProStatusList", param);
    }
    
    public int addUsrProStatus(Map<String, Object> param) {
        return (Integer) insert("position.addUsrProStatus", param);
    }
    
    public int delUsrProStatus(Map<String, Object> param) {
        return (Integer) update("position.delUsrProStatus", param);
    }
    
    public int changePublicYn(Map<String, Object> param) {
        return (Integer) update("position.changePublicYn", param);
    }
    
}
