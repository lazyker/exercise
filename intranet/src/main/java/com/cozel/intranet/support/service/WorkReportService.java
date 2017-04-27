package com.cozel.intranet.support.service;

import java.util.List;
import java.util.Map;

public interface WorkReportService {

    List<Map<String, Object>> getWorkReportList(Map<String, Object> param);
    
    int getWorkReportTotalCount(Map<String, Object> param);
    
}
