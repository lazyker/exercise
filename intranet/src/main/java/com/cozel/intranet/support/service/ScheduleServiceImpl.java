package com.cozel.intranet.support.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cozel.intranet.support.dao.ScheduleDao;

@Service(value = "ScheduleService")
public class ScheduleServiceImpl implements ScheduleService {

	@Autowired
	private ScheduleDao scheduleDao;
	
	@Override
	public List<Map<String, Object>> getScheduleList(Map<String, Object> param) {
	    return scheduleDao.getScheduleList(param); 
	}
	
	@Override
	public Map<String, Object> getSchedule(Map<String, Object> param) {
	    return scheduleDao.getSchedule(param); 
	}

	@Override
	public int setSchedule(Map<String, Object> param) {
		return scheduleDao.setSchedule(param);
	}

	@Override
	public int modSchedule(Map<String, Object> param) {
		return scheduleDao.modSchedule(param);
	}

	@Override
	public int delSchedule(Map<String, Object> param) {
		return scheduleDao.delSchedule(param);
	}
	
}
