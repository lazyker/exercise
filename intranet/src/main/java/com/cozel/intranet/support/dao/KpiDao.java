package com.cozel.intranet.support.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.cozel.intranet.common.abstractDao.AbstractDao;

@Repository
public class KpiDao extends AbstractDao{

    @SuppressWarnings("unchecked")
    public List<Map<String,Object>> getKpiList(Map<String, Object> param) {
        return (List<Map<String, Object>>)selectList("kpi.getKpiList", param);
    }
    
}
