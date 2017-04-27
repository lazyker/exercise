package com.cozel.intranet.support.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.cozel.intranet.common.abstractDao.AbstractDao;

@Repository
public class MarkDao extends AbstractDao{

    @SuppressWarnings("unchecked")
    public List<Map<String,Object>> getMarkList(Map<String, Object> param) {
        return (List<Map<String, Object>>)selectList("mark.getMarkList", param);
    }
    
    public int getMarkTotalCount(Map<String, Object> param) {
        return (Integer) selectOne("mark.getMarkTotalCount", param);
    }
    
    public int setMark(Map<String, Object> param) {
        return (Integer) insert("mark.setMark", param);
    }
    
    public int delMark(Map<String, Object> param) {
    	return (Integer) delete("mark.delMark", param);
    }
    
}
