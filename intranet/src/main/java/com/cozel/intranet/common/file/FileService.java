package com.cozel.intranet.common.file;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.transaction.annotation.Transactional;

public interface FileService {

    //파일 리스트
    public List<Map<String,Object>> getFileList(Map<String, Object> param);
    
    //파일 상세
    public Map<String, Object> getFileInfo(Map<String, Object> param);
    
    //파일 업로드
    @Transactional(rollbackFor={Exception.class})
    public void uploadFile(Map<String, Object>param, HttpServletRequest request) throws Exception;
    
    //파일 수정
    void modFile(Map<String, Object> param, HttpServletRequest request) throws Exception;
    
    //파일 삭제
    public void delFile(Map<String, Object>param) throws Exception;

}
