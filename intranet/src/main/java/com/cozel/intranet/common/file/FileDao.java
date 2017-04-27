package com.cozel.intranet.common.file;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.cozel.intranet.common.abstractDao.AbstractDao;

@Repository("fileDao")
public class FileDao extends AbstractDao{
    
    @SuppressWarnings("unchecked")
    public List<Map<String,Object>> getFileList(Map<String, Object> paramMap) {
        return (List<Map<String, Object>>)selectList("file.getFileList", paramMap);
    }
    
    @SuppressWarnings("unchecked")
    public Map<String,Object> getFileInfo(Map<String, Object> paramMap) {
        return (Map<String, Object>) selectOne("file.getFileInfo", paramMap);
    }
    
    public void uploadFile(Map<String, Object> paramMap) throws Exception {
        insert("file.uploadFile", paramMap);
    }
    
    public void delFile(Map<String, Object> paramMap) throws Exception {
        update("file.delFile", paramMap);
    }
}
