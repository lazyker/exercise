package com.cozel.intranet.company.service;

import java.util.List;
import java.util.Map;

public interface CompanyService {

    List<Map<String, Object>> getCompanyList(Map<String, Object> param);
    
    int getTotalCount(Map<String, Object> param);
    
    Map<String, Object> getCompany(Map<String, Object> param);
    
    void setCompany(Map<String, Object> param);
    
    void setPerson(Map<String, Object> param);
    
    void modCompany(Map<String, Object> param);
    
    void delCompany(Map<String, Object> param);
    
    List<Map<String, Object>> getPersonList(Map<String, Object> param);
    
    void modPerson(Map<String, Object> param);
    
    void delPerson(Map<String, Object> param);
    
}
