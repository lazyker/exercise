package com.cozel.intranet.support.service;

import java.util.List;
import java.util.Map;

public interface BoardService {

    List<Map<String, Object>> getBoardList(Map<String, Object> param);
    
    int getBoardTotalCount(Map<String, Object> param);
    
    Map<String, Object> getBoard(Map<String, Object> param);
    
    void setBoard(Map<String, Object> param);
    
    void modBoard(Map<String, Object> param);
    
    void delBoard(Map<String, Object> param);
    
}
