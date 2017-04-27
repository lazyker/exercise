package com.cozel.intranet.support.service;

import java.util.List;
import java.util.Map;

public interface MarkService {

    List<Map<String, Object>> getMarkList(Map<String, Object> param);
    
    int getMarkTotalCount(Map<String, Object> param);
    
    int setMark(Map<String, Object> param);
    
    int delMark(Map<String, Object> param);
    
}
