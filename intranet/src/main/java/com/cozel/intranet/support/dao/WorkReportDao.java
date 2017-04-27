package com.cozel.intranet.support.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.cozel.intranet.common.abstractDao.AbstractDao;

@Repository
public class WorkReportDao extends AbstractDao{

    @SuppressWarnings("unchecked")
    public List<Map<String,Object>> getWorkReportList(Map<String, Object> param) {
        return (List<Map<String, Object>>)selectList("workReport.getWorkReportList", param);
    }
    
    public int getWorkReportTotalCount(Map<String, Object> param) {
        return (Integer) selectOne("workReport.getWorkReportTotalCount", param);
    }
    
}
