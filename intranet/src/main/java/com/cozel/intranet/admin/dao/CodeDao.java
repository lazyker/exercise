package com.cozel.intranet.admin.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.cozel.intranet.common.abstractDao.AbstractDao;

@Repository
public class CodeDao extends AbstractDao{
    
    @SuppressWarnings("unchecked")
    public List<Map<String,Object>> getCodeList(Map<String, Object> param) {
        return (List<Map<String, Object>>)selectList("code.getCodeList", param);
    }
    
    @SuppressWarnings("unchecked")
    public List<Map<String,Object>> getCodeList2(Map<String, Object> param) {
        return (List<Map<String, Object>>)selectList("code.getCodeList2", param);
    }
    
    public void setCode(Map<String, Object> param) {
        update("code.setCode", param);
    }
    
    public void dragCode(Map<String, Object> param) {
        update("code.dragCode", param);
    }
    
    public void delCode(Map<String, Object> param) {
        delete("code.delCode", param);
    }
    
}
