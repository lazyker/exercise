package com.cozel.intranet.common.file;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cozel.intranet.common.utils.FileUtil;
import com.cozel.intranet.common.utils.StringUtil;

@Service("fileService")
public class FileServiceImpl implements FileService {
    
    @Autowired
    private FileUtil fileUtil;
    
    @Autowired
    private FileDao fileDao;

    @Override
    public List<Map<String, Object>> getFileList(Map<String, Object> param) {
        return fileDao.getFileList(param);
    }
    
    @Override
    public Map<String, Object> getFileInfo(Map<String, Object> param) {
        return (Map<String, Object>) fileDao.getFileInfo(param);
    }

    @Override
    public void uploadFile(Map<String, Object> param, HttpServletRequest request) throws Exception {
        List<Map<String,Object>> list = fileUtil.parseInsertFileInfo(param, request);
        for (Map<String, Object> map : list) {
            fileDao.uploadFile(map);
        }
    }
    
    @Override
    public void modFile(Map<String, Object> param, HttpServletRequest request) throws Exception {
    	if (StringUtils.equals((String) param.get("fileType"), "1")) {
    		List<Map<String,Object>> list = fileUtil.parseInsertFileInfo(param, request);
    		
    		//삭제만 했을 경우
    		String[] delFiles = param.get("delFiles").toString().split("@");
    		if (delFiles.length > 1) {
    			for (int i =1; i < delFiles.length; i++) {
    				Map<String, Object> paramMap = new HashMap<String, Object>();
    				paramMap.put("attId", delFiles[i]);
    				delFile(paramMap);
    			}
    		}
    		
    		if (list.size() > 0) {
    			for (Map<String, Object> map : list) {
    				fileDao.uploadFile(map);
    			}
    		}
    	}
    	else
    	{
    		String attId = StringUtil.NVL(param.get("attId"));
            
            List<Map<String,Object>> list = fileUtil.parseInsertFileInfo(param, request);
            
            if (list.size() > 0) {
                delFile(param);
                
                for (Map<String, Object> map : list) {
                    fileDao.uploadFile(map);
                }
            }
            else{
                //삭제만 할 경우
                if (StringUtils.isEmpty(attId)) {
                	delFile(param);    
                }
            }    		
    	}
    }

    @Override
    public void delFile(Map<String, Object> param) throws Exception {
    	String fileType = StringUtil.NVL(param.get("fileType"));
    	
    	if (StringUtils.equals(fileType, "1")) { //후보자인 경우
    		fileDao.delFile(param);
    	}
    	else {
    		Map<String, Object> fileInfo = fileDao.getFileInfo(param);
    		
    		if (fileInfo != null) {
    			//2017-01-20  물리 파일 지우지 않는걸로 변경되어 주석
//            fileUtil.parseDeleteFileInfo(fileInfo); //물리 파일을 지운다.
    			fileDao.delFile(param);
    		}
    	}
    }
}
