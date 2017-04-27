package com.cozel.intranet.admin.service;

import java.util.List;
import java.util.Map;

public interface CodeService {

    List<Map<String, Object>> getCodeList(Map<String, Object> param);
    
    List<Map<String, Object>> getCodeList2(Map<String, Object> param);
    
    void setCode(Map<String, Object> param);
    
    void dragCode(List<Map<String, Object>> paramList);
    
    void delCode(Map<String, Object> param);
    
}
