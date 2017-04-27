package com.cozel.intranet.admin.service;

import java.util.List;
import java.util.Map;

public interface ConsultantService {

    List<Map<String, Object>> getConsultantList(Map<String, Object> param);
    
    Map<String, Object> getConsultant(Map<String, Object> param);
    
    void addConsultant(Map<String, Object> param);
    
    void modConsultant(Map<String, Object> param);
    
    void delConsultant(Map<String, Object> param);
    
    boolean emailCheck(Map<String, Object> param);
    
    boolean loginCheck(Map<String, Object> param);
    
    void setLoginInfo(Map<String, Object> param);
}
