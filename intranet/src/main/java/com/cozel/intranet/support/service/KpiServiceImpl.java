package com.cozel.intranet.support.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cozel.intranet.support.dao.KpiDao;

@Service(value = "KpiService")
public class KpiServiceImpl implements KpiService {

	@Autowired
	private KpiDao kpiDao;
	
	@Override
	public List<Map<String, Object>> getKpiList(Map<String, Object> param) {
	    return kpiDao.getKpiList(param); 
	}
	
}
