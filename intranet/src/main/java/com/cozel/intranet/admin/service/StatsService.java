package com.cozel.intranet.admin.service;

import java.util.List;
import java.util.Map;

public interface StatsService {

    List<Map<String, Object>> getLoginStatsList(Map<String, Object> param);
    
    int getLoginStatsTotalCount(Map<String, Object> param);
    
}
