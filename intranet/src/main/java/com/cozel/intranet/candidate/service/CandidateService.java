package com.cozel.intranet.candidate.service;

import java.util.List;
import java.util.Map;

public interface CandidateService {

    List<Map<String, Object>> getCandidateList(Map<String, Object> param);
    
    int getCandidateTotalCount(Map<String, Object> param);
    
    Map<String, Object> getCandidate(Map<String, Object> param);
    
    void setCandidate(Map<String, Object> param);
    
    void modCandidate(Map<String, Object> param);
    
    void delCandidate(Map<String, Object> param);
    
    List<Map<String, Object>> getCandidatePopList(Map<String, Object> param);
    
    List<Map<String, Object>> getPositionPopList(Map<String, Object> param);
    
    int getPositionPopTotalCount(Map<String, Object> param);
    
    List<Map<String, Object>> getPosRecPresentList(Map<String, Object> param);
    
    int addPosRecPresent(Map<String, Object> param);
    
    int delPosRecPresent(Map<String, Object> param);
    
    List<Map<String, Object>> getPosProStatusList(Map<String, Object> param);
    
    int addPosProStatus(Map<String, Object> param);
    
    int delPosProStatus(Map<String, Object> param);
    
    String getMarkId(Map<String, Object> param);
    
    int changePublicYn(Map<String, Object> param);
    
}
