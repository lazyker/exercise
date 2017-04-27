package com.cozel.intranet.candidate.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cozel.intranet.candidate.dao.CandidateDao;

@Service(value = "CandidateService")
public class CandidateServiceImpl implements CandidateService {

	@Autowired
	private CandidateDao candidateDao;
	
	@Override
	public List<Map<String, Object>> getCandidateList(Map<String, Object> param) {
	    return candidateDao.getCandidateList(param); 
	}
	
	@Override
	public int getCandidateTotalCount(Map<String, Object> param) {
	    return candidateDao.getCandidateTotalCount(param);
	}
	
	@Override
	public Map<String, Object> getCandidate(Map<String, Object> param) {
	    return candidateDao.getCandidate(param);
	}
	
	@Override
	public void setCandidate(Map<String, Object> param) {
	    candidateDao.setCandidate(param);
	}
	
    @Override
    public void modCandidate(Map<String, Object> param) {
        candidateDao.modCandidate(param);
    }
	
    @Override
    public void delCandidate(Map<String, Object> param) {
    	List<Map<String, Object>> posRecPresentList = candidateDao.getPosRecPresentList(param); //진행현황 리스트
    	
        candidateDao.delCandidate(param);
        candidateDao.delPosRecPresent(param); //진행현황 삭제
        
        if (posRecPresentList.size() != 0) {
        	for (Map<String, Object> hm : posRecPresentList) {
        		param.put("recId", hm.get("REC_ID"));
        		candidateDao.delPosProStatus(param); //진행상태 삭제
        	}
        }
    }
    
	@Override
	public List<Map<String, Object>> getCandidatePopList(Map<String, Object> param) {
	    return candidateDao.getCandidatePopList(param); 
	}
	
	@Override
	public List<Map<String, Object>> getPositionPopList(Map<String, Object> param) {
	    return candidateDao.getPositionPopList(param);
	}
	
	@Override
	public int getPositionPopTotalCount(Map<String, Object> param) {
		return candidateDao.getPositionPopTotalCount(param);
	}	
	
	@Override
	public List<Map<String, Object>> getPosRecPresentList(Map<String, Object> param) {
		return candidateDao.getPosRecPresentList(param);
	}

	@Override
	public int addPosRecPresent(Map<String, Object> param) {
		return candidateDao.addPosRecPresent(param);
	}

	@Override
	public int delPosRecPresent(Map<String, Object> param) {
		return candidateDao.delPosRecPresent(param);
	}

	@Override
	public List<Map<String, Object>> getPosProStatusList(Map<String, Object> param) {
		return candidateDao.getPosProStatusList(param);
	}

	@Override
	public int addPosProStatus(Map<String, Object> param) {
		return candidateDao.addPosProStatus(param);
	}

	@Override
	public int delPosProStatus(Map<String, Object> param) {
		return candidateDao.delPosProStatus(param);
	}
	
	@Override
	public String getMarkId(Map<String, Object> param) {
	    return candidateDao.getMarkId(param);
	}
	
	@Override
	public int changePublicYn(Map<String, Object> param) {
		return candidateDao.changePublicYn(param);
	}

}
