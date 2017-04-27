package com.cozel.intranet.admin.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cozel.intranet.admin.dao.CodeDao;

@Service(value = "CodeService")
public class CodeServiceImpl implements CodeService {

	@Autowired
	private CodeDao codeDao;

    @Override
    public List<Map<String, Object>> getCodeList(Map<String, Object> param) {
        return codeDao.getCodeList(param);
    }
    
    @Override
    public List<Map<String, Object>> getCodeList2(Map<String, Object> param) {
        return codeDao.getCodeList2(param);
    }

    @Override
    public void setCode(Map<String, Object> param) {
        codeDao.setCode(param);
    }

    @Override
    public void dragCode(List<Map<String, Object>> paramList) {
        Map<String, Object> param = new HashMap<String, Object>();
        
        for (Map<String, Object> m : paramList) {
            for (String key : m.keySet()) {
                param.put(key, m.get(key));
                
                if (StringUtils.equals(key, "parentId")) {
                    param.put("cdId", m.get(key));
                }
            }
            codeDao.dragCode(param);
        }
    }

    @Override
    public void delCode(Map<String, Object> param) {
        codeDao.delCode(param);
        
    }
	
}
