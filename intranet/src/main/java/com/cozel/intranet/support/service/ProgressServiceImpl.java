package com.cozel.intranet.support.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cozel.intranet.support.dao.ProgressDao;

@Service(value = "ProgressService")
public class ProgressServiceImpl implements ProgressService {

	@Autowired
	private ProgressDao progressDao;
	
	@Override
	public List<Map<String, Object>> getProgressList(Map<String, Object> param) {
	    return progressDao.getProgressList(param); 
	}
	
	@Override
	public int getProgressTotalCount(Map<String, Object> param) {
	    return progressDao.getProgressTotalCount(param);
	}
	
}
