package com.cozel.intranet.position.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cozel.intranet.position.dao.PositionDao;

@Service(value = "PositionService")
public class PositionServiceImpl implements PositionService {

	@Autowired
	private PositionDao positionDao;
	
	@Override
	public List<Map<String, Object>> getPositionList(Map<String, Object> param) {
	    return positionDao.getPositionList(param); 
	}
	
	@Override
	public int getPositionTotalCount(Map<String, Object> param) {
	    return positionDao.getPositionTotalCount(param);
	}
	
	@Override
	public Map<String, Object> getPosition(Map<String, Object> param) {
	    return positionDao.getPosition(param);
	}
	
	@Override
	public void setPosition(Map<String, Object> param) {
	    positionDao.setPosition(param);
	}
	
    @Override
    public void modPosition(Map<String, Object> param) {
        positionDao.modPosition(param);
    }
	
    @Override
    public void delPosition(Map<String, Object> param) {
        positionDao.delPosition(param);
    }
    
	@Override
	public List<Map<String, Object>> getCompanyPopList(Map<String, Object> param) {
	    return positionDao.getCompanyPopList(param); 
	}
	
	@Override
	public int getCompanyPopTotalCount(Map<String, Object> param) {
	    return positionDao.getCompanyPopTotalCount(param);
	}
    

	@Override
	public List<Map<String, Object>> getCandidatePopList(Map<String, Object> param) {
	    return positionDao.getCandidatePopList(param);
	}
	
	@Override
	public int getCandidatePopTotalCount(Map<String, Object> param) {
		return positionDao.getCandidatePopTotalCount(param);
	}	
	
	@Override
	public List<Map<String, Object>> getUsrRecPresentList(Map<String, Object> param) {
		return positionDao.getUsrRecPresentList(param);
	}

	@Override
	public int addUsrRecPresent(Map<String, Object> param) {
		return positionDao.addUsrRecPresent(param);
	}

	@Override
	public int delUsrRecPresent(Map<String, Object> param) {
		return positionDao.delUsrRecPresent(param);
	}

	@Override
	public List<Map<String, Object>> getUsrProStatusList(Map<String, Object> param) {
		return positionDao.getUsrProStatusList(param);
	}

	@Override
	public int addUsrProStatus(Map<String, Object> param) {
		return positionDao.addUsrProStatus(param);
	}

	@Override
	public int delUsrProStatus(Map<String, Object> param) {
		return positionDao.delUsrProStatus(param);
	}
	
	@Override
	public int changePublicYn(Map<String, Object> param) {
		return positionDao.changePublicYn(param);
	}
	
}
