package com.cozel.intranet.support.service;

import java.util.List;
import java.util.Map;

public interface ScheduleService {

    List<Map<String, Object>> getScheduleList(Map<String, Object> param);
    
    Map<String, Object> getSchedule(Map<String, Object> param);
    
    int setSchedule(Map<String, Object> param);
    
    int modSchedule(Map<String, Object> param);
    
    int delSchedule(Map<String, Object> param);
    
}
