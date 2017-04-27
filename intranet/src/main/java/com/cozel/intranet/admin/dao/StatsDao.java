package com.cozel.intranet.admin.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.cozel.intranet.common.abstractDao.AbstractDao;

@Repository
public class StatsDao extends AbstractDao{
    
    @SuppressWarnings("unchecked")
    public List<Map<String,Object>> getLoginStatsList(Map<String, Object> param) {
        return (List<Map<String, Object>>)selectList("stats.getLoginStatsList", param);
    }
    
    public int getLoginStatsTotalCount(Map<String, Object> param) {
        return (Integer) selectOne("stats.getLoginStatsTotalCount", param);
    }
}
