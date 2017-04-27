package com.cozel.intranet.common.file;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FileUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class FileController {
    
    @Value("#{config['file.upload.path']}")
    String filePath;
    
    @Value("#{config['env']}")
    String env;
    
    @Autowired
    private FileService fileService;
    
    @RequestMapping(value="/downloadFile")
    public void downloadFile(@RequestParam Map<String, Object> param, HttpServletResponse response) throws IOException {
        Map<String,Object> map = fileService.getFileInfo(param);
        if (map != null) {
        	String storedFileName   = (String) map.get("STORED_FILE_NM");
        	String originalFileName  = (String) map.get("ORIGINAL_FILE_NM");
        	String filePath             = (String) map.get("FILE_PATH");
        	
        	try 
        	{
        		
System.out.println("env ::: " + env);
System.out.println("filePath ::: " + filePath);
        		byte fileByte[] = new byte[1024*1024];
        		
//        		if (StringUtils.equals(env, "development")) { //linux path
//        			fileByte = FileUtils.readFileToByteArray(new File(filePath + "/"+ storedFileName));
//        		} else {
//        		}
        		fileByte = FileUtils.readFileToByteArray(new File(filePath + "\\"+ storedFileName));        			
        		
        		response.setContentType("application/octet-stream");
        		response.setContentLength(fileByte.length);
        		response.setHeader("Content-Disposition", "attachment; fileName=\"" + URLEncoder.encode(originalFileName,"UTF-8")+"\";");
        		response.setHeader("Content-Transfer-Encoding", "binary");
        		response.getOutputStream().write(fileByte);
        		
        		response.getOutputStream().flush();
        		response.getOutputStream().close();
        	}
        	catch(Exception e) 
        	{
        		response.setContentType("text/html;charset=UTF-8");
        		response.setHeader("Cache-Control", "no-cache");
        		response.getWriter().print("<script>alert('파일을 찾을 수 없습니다');</script>");
        	}
        }
    }
    
    /**
     * 이미지 파일 읽기 
     */
    @RequestMapping("/images/{imgNm}/{imgType}")
    private void getImage(@PathVariable String imgNm, @PathVariable String imgType, HttpServletResponse response) throws Exception {
        String path = filePath +"/"+ imgType  +"/"+ imgNm;
        
        byte[] bytes = readFile(path);
        write(response, bytes);
    }
    
    /**
     * 파일로부터 byte 배열 읽어오기 
     */
    private byte[] readFile(String path) throws IOException {
    	BufferedInputStream bis = null;
    	byte[] bytes = null;
    	
    	try {
    		bis = new BufferedInputStream(new FileInputStream(path));
    		int length = bis.available();
    		bytes = new byte[length];
    		bis.read(bytes);
    	}catch(Exception e) {
    		bytes = new byte[0];
    	}
    	finally {
    		if(bis != null) try{bis.close();}catch(IOException e){}
    	}
		
		return bytes;
    }
    
    /**
     * 응답 OutputStream에 파일 내용 쓰기
     */
    private void write(HttpServletResponse response, byte[] bytes) throws IOException {
        response.setContentType("image/jpeg");
        OutputStream output = response.getOutputStream();
        output.write(bytes);
        output.flush();
        output.close();
    }
}
