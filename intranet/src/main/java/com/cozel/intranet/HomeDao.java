package com.cozel.intranet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.cozel.intranet.common.abstractDao.AbstractDao;

@Repository
public class HomeDao extends AbstractDao {
	
	public String getToday() {
		return (String) selectOne("test.getToday");
	}
	
	public int tx1Save(Map<String, Object> param) throws Exception {  
        return (int) insert("transactionTest.tx1Save", param);  
    }  
      
    public int tx2Save(Map<String, Object> param) throws Exception {  
        return (int) insert("transactionTest.tx2Save", param);  
    }  
}