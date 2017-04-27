package com.cozel.intranet.support.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cozel.intranet.support.dao.MarkDao;

@Service(value = "MarkService")
public class MarkServiceImpl implements MarkService {

	@Autowired
	private MarkDao markDao;
	
	@Override
	public List<Map<String, Object>> getMarkList(Map<String, Object> param) {
	    return markDao.getMarkList(param); 
	}
	
	@Override
	public int getMarkTotalCount(Map<String, Object> param) {
	    return markDao.getMarkTotalCount(param);
	}
	
	@Override
	public int setMark(Map<String, Object> param) {
		return markDao.setMark(param);
	}
	
    @Override
    public int delMark(Map<String, Object> param) {
    	return markDao.delMark(param);
    }
    
}
