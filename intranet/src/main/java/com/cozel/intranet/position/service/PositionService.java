package com.cozel.intranet.position.service;

import java.util.List;
import java.util.Map;

public interface PositionService {

    List<Map<String, Object>> getPositionList(Map<String, Object> param);
    
    int getPositionTotalCount(Map<String, Object> param);
    
    Map<String, Object> getPosition(Map<String, Object> param);
    
    void setPosition(Map<String, Object> param);
    
    void modPosition(Map<String, Object> param);
    
    void delPosition(Map<String, Object> param);
    
    List<Map<String, Object>> getCompanyPopList(Map<String, Object> param);
    
    int getCompanyPopTotalCount(Map<String, Object> param);
    
    
    List<Map<String, Object>> getCandidatePopList (Map<String, Object> param);
    
    int getCandidatePopTotalCount(Map<String, Object> param);
    
    List<Map<String, Object>> getUsrRecPresentList(Map<String, Object> param);
    
    int addUsrRecPresent(Map<String, Object> param);
    
    int delUsrRecPresent(Map<String, Object> param);
    
    List<Map<String, Object>> getUsrProStatusList(Map<String, Object> param);
    
    int addUsrProStatus(Map<String, Object> param);
    
    int delUsrProStatus(Map<String, Object> param);
    
    int changePublicYn(Map<String, Object> param);
    
}
