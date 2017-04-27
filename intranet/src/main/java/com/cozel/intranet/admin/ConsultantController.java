package com.cozel.intranet.admin;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.cozel.intranet.admin.service.ConsultantService;
import com.cozel.intranet.common.file.FileService;
import com.cozel.intranet.common.file.FileType;
import com.cozel.intranet.common.security.AES128Util;
import com.cozel.intranet.common.security.Sha256;
import com.cozel.intranet.common.utils.StringUtil;

@Controller
public class ConsultantController {
	
	@Autowired
	private ConsultantService consultantService;
	
	@Autowired
	private FileService fileService;
	
	private static final Logger logger = LoggerFactory.getLogger(ConsultantController.class);
	
	@RequestMapping(value = "/admin/consultantList", method = RequestMethod.GET)
	public ModelAndView consultantList(@RequestParam Map<String, Object> param, ModelAndView mv) throws Exception {
	    List<Map<String, Object>> tmpList = consultantService.getConsultantList(param);
	    List<Map<String, Object>> consultantList = new ArrayList<Map<String, Object>>();
	    
	    for (Map<String, Object> hm : tmpList) {
	    	hm.put("MOBILE", AES128Util.decrypt(String.valueOf(hm.get("MOBILE"))));
	    	hm.put("PHONE", AES128Util.decrypt(String.valueOf(hm.get("PHONE"))));
	    	
	    	consultantList.add(hm);
	    }
	    
	    mv.addObject("consultantList", consultantList);
		mv.setViewName("admin/consultant/consultantList");
		return mv;
	}
	
	@RequestMapping(value = "/admin/consultant", method = RequestMethod.GET)
	public ModelAndView consultant(@RequestParam Map<String, Object> param, ModelAndView mv) throws Exception {
	    String conId = StringUtil.NVL(param.get("conId"));
	    Map<String, Object> consultant = new HashMap<String, Object>();
	    
	    if (StringUtils.isNotEmpty(conId)) {
	        consultant = consultantService.getConsultant(param);
	        consultant.put("MOBILE", AES128Util.decrypt(consultant.get("MOBILE").toString()));
	        consultant.put("PHONE", AES128Util.decrypt(consultant.get("PHONE").toString()));
	        consultant.put("EMAIL", AES128Util.decrypt(consultant.get("EMAIL").toString()));
	    } else {
	    	//기본 체크 라디오 버튼
	    	consultant.put("AUTH_PUBLIC", "1");
	    	consultant.put("AUTH_COMPANY", "1");
	    	consultant.put("AUTH_POSITION", "1");
	    	consultant.put("AUTH_USER", "1");
	    	consultant.put("AUTH_USER_TYPE", "1");
	    }
		
	    mv.addObject("consultant", consultant);
		mv.setViewName("admin/consultant/consultant");
		return mv;
	}
	
	@ResponseBody
	@RequestMapping(value = "/admin/addConsultant", method = RequestMethod.POST)
	public Map<String, Object> addConsultant(@RequestParam Map<String, Object> param, HttpServletRequest request) throws Exception {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		String email = StringUtil.NVL(param.get("email"));
	    String adminYn = StringUtil.NVL(param.get("adminYn"), "N");
	    String conId = email.split("@")[0]; //컨설턴트 아이디
	    String pwd = Sha256.encrypt(StringUtil.NVL(param.get("password"))); //sha256 암호화
	    
	    //관리자 지정시
	    if (StringUtils.equals(adminYn, "Y")) {
	    	param.put("authPublic", "1");
	    	param.put("authCompany", "1");
	    	param.put("authPosition", "1");
	    	param.put("authUser", "1");
	    	param.put("authPublic", "1");
	    	param.put("authUserType", "1");
	    }

	    param.put("mobile", AES128Util.encrypt(StringUtil.NVL(param.get("mobile"))));
		param.put("phone", AES128Util.encrypt(StringUtil.NVL(param.get("phone"))));
		param.put("email", AES128Util.encrypt(StringUtil.NVL(param.get("email"))));
	    param.put("password", pwd);
	    param.put("adminYn", adminYn);
	    param.put("conId", conId);
	    consultantService.addConsultant(param);
	    
	    try {
	        param.put("fileType", FileType.CONSULTANT.getCode());
	        param.put("orgId", conId);
	        
	        fileService.uploadFile(param, request);	    
        } catch (Exception e) {
            e.printStackTrace();
        }
	    
	    resultMap.put("result", "success");
		return resultMap;
	}
	
	@ResponseBody
	@RequestMapping(value = "/admin/modConsultant", method = RequestMethod.POST)
    public Map<String, Object> modConsultant(@RequestParam Map<String, Object> param, HttpServletRequest request) throws Exception {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		String conId = StringUtil.NVL(param.get("conId"));
	    String adminYn = StringUtil.NVL(param.get("adminYn"), "N");
	    String pwd = Sha256.encrypt(StringUtil.NVL(param.get("password"))); //sha256 암호화
	    
	  //관리자 지정시
	    if (StringUtils.equals(adminYn, "Y")) {
	    	param.put("authPublic", "1");
	    	param.put("authCompany", "1");
	    	param.put("authPosition", "1");
	    	param.put("authUser", "1");
	    	param.put("authPublic", "1");
	    	param.put("authUserType", "1");
	    }

	    
//	    MultipartHttpServletRequest multipartHttpServletRequest =(MultipartHttpServletRequest) request;
	    
//	    int a = multipartHttpServletRequest.getContentLength();
//	    String attId = StringUtil.NVL(param.get("attId")); //파일을 삭제할 경우 빈값
//	    String email = StringUtil.NVL(param.get("email"));
//        String emailSplit[] = email.split("@"); //컨설턴트 아이디
//        String emailId = emailSplit[0];

//        conId = StringUtils.equals(conId, emailId) ? conId : emailId;
        
	    param.put("mobile", AES128Util.encrypt(StringUtil.NVL(param.get("mobile"))));
		param.put("phone", AES128Util.encrypt(StringUtil.NVL(param.get("phone"))));
		param.put("email", AES128Util.encrypt(StringUtil.NVL(param.get("email"))));
		param.put("password", pwd);
	    param.put("adminYn", adminYn);
        consultantService.modConsultant(param);
        
        try {
            param.put("fileType", FileType.CONSULTANT.getCode());
            param.put("orgId", conId);
            
            fileService.modFile(param, request);
            
//            if (StringUtils.equals(attId, "")) {
//                fileService.delFile(param);    
//            }else{
//                fileService.uploadFile(param, request);     
//            }
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        resultMap.put("result", "success");
		return resultMap;
    }
	
	/** 컨설턴트 삭제 **/
	@RequestMapping(value = "/admin/delConsultant", method = RequestMethod.POST) 
	public ModelAndView delConsultant(@RequestParam Map<String, Object> param, ModelAndView mv) throws Exception {
	    consultantService.delConsultant(param);
	    fileService.delFile(param);
	    
	    mv.setViewName("redirect:/admin/consultantList");
	    return mv;
	}
	
   @RequestMapping(value = "/admin/emailCheck", method = RequestMethod.POST) 
    public @ResponseBody boolean emailCheck(@RequestParam Map<String, Object> param, ModelAndView mv) {
       String email = StringUtil.NVL(param.get("email"));
       String emailId = email.split("@")[0];
       
       param.put("conId", emailId);
       return consultantService.emailCheck(param);
    }
}
