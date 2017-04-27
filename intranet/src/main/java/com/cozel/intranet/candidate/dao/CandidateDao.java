package com.cozel.intranet.candidate.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.cozel.intranet.common.abstractDao.AbstractDao;

@Repository
public class CandidateDao extends AbstractDao{

    @SuppressWarnings("unchecked")
    public List<Map<String,Object>> getCandidateList(Map<String, Object> param) {
        return (List<Map<String, Object>>)selectList("candidate.getCandidateList", param);
    }
    
    public int getCandidateTotalCount(Map<String, Object> param) {
        return (Integer) selectOne("candidate.getCandidateTotalCount", param);
    }
    
    @SuppressWarnings("unchecked")
    public Map<String,Object> getCandidate(Map<String, Object> param) {
        return (Map<String, Object>)selectOne("candidate.getCandidate", param);
    }
    
    public void setCandidate(Map<String, Object> param) {
        insert("candidate.setCandidate", param);
    }
    
    public void modCandidate(Map<String, Object> param) {
        update("candidate.modCandidate", param);
    }
    
    public void delCandidate(Map<String, Object> param) {
    	update("candidate.delCandidate", param);
    }
    
    @SuppressWarnings("unchecked")
    public List<Map<String,Object>> getCandidatePopList(Map<String, Object> param) {
        return (List<Map<String, Object>>)selectList("candidate.getCandidatePopList", param);
    }
    
    @SuppressWarnings("unchecked")
    public List<Map<String,Object>> getPositionPopList(Map<String, Object> param) {
    	return (List<Map<String, Object>>)selectList("candidate.getPositionPopList", param);
    }

    public int getPositionPopTotalCount(Map<String, Object> param) {
        return (Integer) selectOne("candidate.getPositionPopTotalCount", param);
    }
    
    @SuppressWarnings("unchecked")
    public List<Map<String,Object>> getPosRecPresentList(Map<String, Object> param) {
        return (List<Map<String, Object>>)selectList("candidate.getPosRecPresentList", param);
    }
    
    public int addPosRecPresent(Map<String, Object> param) {
    	return (Integer) insert("candidate.addPosRecPresent", param);
    }
    
    public int delPosRecPresent(Map<String, Object> param) {
        return (Integer) update("candidate.delPosRecPresent", param);
    }
    
    @SuppressWarnings("unchecked")
    public List<Map<String,Object>> getPosProStatusList(Map<String, Object> param) {
        return (List<Map<String, Object>>)selectList("candidate.getPosProStatusList", param);
    }
    
    public int addPosProStatus(Map<String, Object> param) {
        return (Integer) insert("candidate.addPosProStatus", param);
    }
    
    public int delPosProStatus(Map<String, Object> param) {
        return (Integer) update("candidate.delPosProStatus", param);
    }
    
    public String getMarkId(Map<String, Object> param) {
        return (String )selectOne("candidate.getMarkId", param);
    }
    
    public int changePublicYn(Map<String, Object> param) {
    	return (Integer) update("candidate.changePublicYn", param);
    }
    
}
