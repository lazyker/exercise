package com.cozel.intranet.support.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.cozel.intranet.common.abstractDao.AbstractDao;

@Repository
public class BoardDao extends AbstractDao{

    @SuppressWarnings("unchecked")
    public List<Map<String,Object>> getBoardList(Map<String, Object> param) {
        return (List<Map<String, Object>>)selectList("board.getBoardList", param);
    }
    
    public int getBoardTotalCount(Map<String, Object> param) {
        return (Integer) selectOne("board.getBoardTotalCount", param);
    }
    
    @SuppressWarnings("unchecked")
    public Map<String,Object> getBoard(Map<String, Object> param) {
        return (Map<String, Object>)selectOne("board.getBoard", param);
    }
    
    public void setBoard(Map<String, Object> param) {
        insert("board.setBoard", param);
    }
    
    public void modBoard(Map<String, Object> param) {
        update("board.modBoard", param);
    }
    
    public void delBoard(Map<String, Object> param) {
    	update("board.delBoard", param);
    }
    
}
