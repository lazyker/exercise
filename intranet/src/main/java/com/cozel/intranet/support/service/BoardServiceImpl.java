package com.cozel.intranet.support.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cozel.intranet.support.dao.BoardDao;

@Service(value = "BoardService")
public class BoardServiceImpl implements BoardService {

	@Autowired
	private BoardDao boardDao;
	
	@Override
	public List<Map<String, Object>> getBoardList(Map<String, Object> param) {
	    return boardDao.getBoardList(param); 
	}
	
	@Override
	public int getBoardTotalCount(Map<String, Object> param) {
	    return boardDao.getBoardTotalCount(param);
	}
	
	@Override
	public Map<String, Object> getBoard(Map<String, Object> param) {
	    return boardDao.getBoard(param);
	}
	
	@Override
	public void setBoard(Map<String, Object> param) {
	    boardDao.setBoard(param);
	}
	
    @Override
    public void modBoard(Map<String, Object> param) {
        boardDao.modBoard(param);
    }
	
    @Override
    public void delBoard(Map<String, Object> param) {
        boardDao.delBoard(param);
    }
    
}
