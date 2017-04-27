package com.cozel.intranet.support.service;

import java.util.List;
import java.util.Map;

public interface ProgressService {

    List<Map<String, Object>> getProgressList(Map<String, Object> param);
    
    int getProgressTotalCount(Map<String, Object> param);
    
}
