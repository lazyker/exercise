package com.cozel.intranet.support.service;

import java.util.List;
import java.util.Map;

public interface KpiService {

    List<Map<String, Object>> getKpiList(Map<String, Object> param);
    
}
