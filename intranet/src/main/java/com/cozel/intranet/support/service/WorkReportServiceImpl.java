package com.cozel.intranet.support.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cozel.intranet.support.dao.WorkReportDao;

@Service(value = "WorkReportService")
public class WorkReportServiceImpl implements WorkReportService {

	@Autowired
	private WorkReportDao workReportDao;
	
	@Override
	public List<Map<String, Object>> getWorkReportList(Map<String, Object> param) {
	    return workReportDao.getWorkReportList(param); 
	}
	
	@Override
	public int getWorkReportTotalCount(Map<String, Object> param) {
	    return workReportDao.getWorkReportTotalCount(param);
	}
	
}
