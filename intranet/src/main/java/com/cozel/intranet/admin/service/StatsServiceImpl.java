package com.cozel.intranet.admin.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cozel.intranet.admin.dao.StatsDao;

@Service(value = "StatsService")
public class StatsServiceImpl implements StatsService {

	@Autowired
	private StatsDao statsDao;

    @Override
    public List<Map<String, Object>> getLoginStatsList(Map<String, Object> param) {
        return statsDao.getLoginStatsList(param);
    }
    
    @Override
    public int getLoginStatsTotalCount(Map<String, Object> param) {
        return statsDao.getLoginStatsTotalCount(param);
    }
    
}
