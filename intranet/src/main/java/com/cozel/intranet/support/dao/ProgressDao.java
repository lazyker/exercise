package com.cozel.intranet.support.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.cozel.intranet.common.abstractDao.AbstractDao;

@Repository
public class ProgressDao extends AbstractDao{

    @SuppressWarnings("unchecked")
    public List<Map<String,Object>> getProgressList(Map<String, Object> param) {
        return (List<Map<String, Object>>)selectList("progress.getProgressList", param);
    }
    
    public int getProgressTotalCount(Map<String, Object> param) {
        return (Integer) selectOne("progress.getProgressTotalCount", param);
    }
    
}
