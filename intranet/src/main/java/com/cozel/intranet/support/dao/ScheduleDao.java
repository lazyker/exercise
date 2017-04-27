package com.cozel.intranet.support.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.cozel.intranet.common.abstractDao.AbstractDao;

@Repository
public class ScheduleDao extends AbstractDao{

    @SuppressWarnings("unchecked")
    public List<Map<String,Object>> getScheduleList(Map<String, Object> param) {
        return (List<Map<String, Object>>)selectList("schedule.getScheduleList", param);
    }
    
    @SuppressWarnings("unchecked")
    public Map<String, Object> getSchedule(Map<String, Object> param) {
    	return (Map<String, Object>) selectOne("schedule.getSchedule", param);
    }
    
    public int setSchedule(Map<String, Object> param) {
    	return (Integer) insert("schedule.setSchedule", param);
    }
    
    public int modSchedule(Map<String, Object> param) {
    	return (Integer) update("schedule.modSchedule", param);
    }
    
    public int delSchedule(Map<String, Object> param) {
    	return (Integer) update("schedule.delSchedule", param);
    }
    
}
