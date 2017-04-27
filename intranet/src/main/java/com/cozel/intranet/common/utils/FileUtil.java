package com.cozel.intranet.common.utils;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

@Component("fileUtil")
public class FileUtil {
    
    @Value("#{config['file.upload.path']}")
    String filePath;
    
    //파일 추가
    public List<Map<String, Object>> parseInsertFileInfo(Map<String, Object> paramMap, HttpServletRequest request)  throws Exception {
        MultipartHttpServletRequest multipartHttpServletRequest = (MultipartHttpServletRequest) request;
        Iterator<String> iterator = multipartHttpServletRequest.getFileNames();
        
        MultipartFile multipartFile = null;
        String originalFileName = null;
        String originalFileExtension = null;
        
        List<Map<String,Object>> list = new ArrayList<Map<String,Object>>();
        Map<String, Object> listMap = null;
        String fileType   = (String) paramMap.get("fileType");
        
        File file = new File(filePath, fileType);
        
        if (!file.exists()) {
            file.mkdirs();
        }
        
        while(iterator.hasNext()) {
            multipartFile = multipartHttpServletRequest.getFile(iterator.next());
            if (multipartFile.isEmpty() == false) {
                originalFileName = multipartFile.getOriginalFilename();
                originalFileExtension = originalFileName.substring(originalFileName.lastIndexOf("."));
                String storedFileName = CommonUtil.UNIQUEKEY() + originalFileExtension;
                
                file = new File(filePath + fileType + "/" + storedFileName);
                multipartFile.transferTo(file);
                
//                if (StringUtils.equals(fileType, "4")) { //홈페이지 이미지로 인한 예외처리
//                	file = new File("/home/cozelh/apache/htdocs/images/consultant/" + storedFileName);
//                	multipartFile.transferTo(file);
//                }
                
                listMap = new HashMap<String,Object>();
                listMap.put("attId", paramMap.get("attId")); //첨부파일 아이디
                listMap.put("orgId", paramMap.get("orgId")); //게시물 아이디
                listMap.put("fileType", fileType); //파일구분
                listMap.put("originalFileNm", originalFileName); //원본 파일명
                listMap.put("storedFileNm", storedFileName); //저장된 파일명
                listMap.put("fileSize", multipartFile.getSize()); //파일 크기
                listMap.put("filePath", filePath + fileType); //파일 경로
                
                //후보자 등록일 경우 (국문이력서1:1, 영문이력서1:2, 국문이력서2:3, 영문이력서2:4, 추천서:5, 기타:6)
                if (StringUtils.equals(fileType, "1")) {
                	String fileName = multipartFile.getName().substring(4, 5);
                	listMap.put("fileOrder", fileName);                	
                }
                
                list.add(listMap);
                
            }
        }
        
        return list;
    }
    
    //파일 삭제
    public boolean parseDeleteFileInfo (Map<String, Object> paramMap)  throws Exception {
        String path = (String) paramMap.get("FILE_PATH");
        String storedFileName = (String) paramMap.get("STORED_FILE_NM");
        boolean result = false;
        
        File file = new File(path + "/" + storedFileName );
        
        if (file.exists()) {
            file.delete();
            result = true;
        }
        return result;
    }
}
