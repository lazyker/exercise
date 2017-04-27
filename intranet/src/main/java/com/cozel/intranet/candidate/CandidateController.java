package com.cozel.intranet.candidate;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.cozel.intranet.admin.service.CodeService;
import com.cozel.intranet.admin.service.ConsultantService;
import com.cozel.intranet.candidate.service.CandidateService;
import com.cozel.intranet.common.comment.CommentService;
import com.cozel.intranet.common.file.FileService;
import com.cozel.intranet.common.file.FileType;
import com.cozel.intranet.common.paging.PagingDTO;
import com.cozel.intranet.common.security.AES128Util;
import com.cozel.intranet.common.utils.StringUtil;

@Controller
public class CandidateController {
	
	@Autowired
	private CandidateService candidateService;
	
	@Autowired
    private ConsultantService consultantService;
	
	@Autowired
    private CodeService codeService;
	
	@Autowired
    private CommentService commentService;
	
	@Autowired
	private FileService fileService;
	
	private static final Logger logger = LoggerFactory.getLogger(CandidateController.class);
	
	@RequestMapping(value = "/candidate/candidateList", method = {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView candidateList(@RequestParam Map<String, Object> param,
													HttpSession session ,
	        										@ModelAttribute("pagingDTO") PagingDTO pagingDTO) {
		ModelAndView mv = new ModelAndView();
		@SuppressWarnings("unchecked")
		Map<String, String> userInfo =  (Map<String, String>) session.getAttribute("userInfo");
		String adminYn = userInfo.get("ADMIN_YN");
		String authUser = userInfo.get("AUTH_USER");
		String conId = userInfo.get("CON_ID");
	    String pageNo = StringUtil.NVL(param.get("pageNo"));
	    List<Map<String, Object>> codeList1 = null;
	    List<Map<String, Object>> codeList2 = null;
	    Map<String, Object> codeMap = new HashMap<String, Object>();
	    
        if(StringUtils.isNotEmpty(pageNo)){
            pagingDTO.setPageNo(Integer.parseInt(pageNo));
        }
        
        {
            param.put("cdType", "1");
            codeList1 = codeService.getCodeList(param);
            param.put("cdType", "2");
            codeList2 = codeService.getCodeList(param);
            
            codeMap.put("codeList1", codeList1);
            codeMap.put("codeList2", codeList2);
            
            if (StringUtils.isNotEmpty((String)param.get("industry1"))) {
                param.put("parentId", param.get("industry1"));
                List<Map<String, Object>> codeChildList1 = codeService.getCodeList2(param);
                mv.addObject("codeChildList1", codeChildList1);    
            }
            
            if (StringUtils.isNotEmpty((String)param.get("job1"))) {
                param.put("parentId", param.get("job1"));
                List<Map<String, Object>> codeChildList2 = codeService.getCodeList2(param);
                mv.addObject("codeChildList2", codeChildList2);    
            }
        }

        param.put("adminYn", adminYn);
        param.put("authUser", authUser);
        param.put("conId", conId);
        param.put("sconId", conId);
        param.put("startRowNum", pagingDTO.getStartRowNum());
        param.put("pageSize", pagingDTO.getPageSize());
        pagingDTO.setTotalCount(candidateService.getCandidateTotalCount(param));
	    List<Map<String, Object>> candidateList = candidateService.getCandidateList(param);
	    
	    mv.addObject("codeMap", codeMap);
	    mv.addObject("search", param);
	    mv.addObject("paging", pagingDTO);
	    mv.addObject("candidateList", candidateList);
		mv.setViewName("candidate/candidateList");
		return mv;
	}
	
	@RequestMapping(value = "/candidate/candidateDetail", method = RequestMethod.GET)
	public ModelAndView candidateDetail(@RequestParam Map<String, Object> param, HttpSession session) throws Exception {
		ModelAndView mv = new ModelAndView();
		@SuppressWarnings("unchecked")
		Map<String, String> userInfo =  (Map<String, String>) session.getAttribute("userInfo");
	    String usrId = StringUtil.NVL(param.get("usrId"));
	    Map<String, Object> getCandidate = null;
	    List<Map<String, Object>> getUsrAcademicList = new ArrayList<Map<String, Object>>();
	    List<Map<String, Object>> getCommentList = null;
	    Map<String, Object> fileMap = null;
	    
	    List<Map<String, Object>> codeList1 = null;
	    List<Map<String, Object>> codeList2 = null;
	    Map<String, Object> codeMap = new HashMap<String, Object>();
	    String getMarkId = null;
	    
	    param.put("conId", userInfo.get("CON_ID"));
        param.put("cdType", "1");
        codeList1 = codeService.getCodeList(param);
        param.put("cdType", "2");
        codeList2 = codeService.getCodeList(param);
        
        codeMap.put("codeList1", codeList1);
        codeMap.put("codeList2", codeList2);
	    
	    List<Map<String, Object>> consultantList = consultantService.getConsultantList(param);
	    
	    if (StringUtils.isNotEmpty(usrId)) {
	    	getCandidate =  candidateService.getCandidate(param);
	    	getMarkId =  candidateService.getMarkId(param);
	    	String authUserType = userInfo.get("AUTH_USER_TYPE");
	    	String mobile = AES128Util.decrypt(String.valueOf(getCandidate.get("MOBILE")));
	    	String phone = AES128Util.decrypt(String.valueOf(getCandidate.get("PHONE")));
	    	String email = AES128Util.decrypt(String.valueOf(getCandidate.get("EMAIL")));
	    	String sources = String.valueOf(getCandidate.get("SOURCES"));
	    	
	    	if (StringUtils.equals(authUserType, "2") && !StringUtils.equals(String.valueOf(getCandidate.get("CON_ID")), userInfo.get("CON_ID"))) {
	    		mobile = "***********";
	    		phone = "***********";
	    		email = "***********";
	    		sources = "*********";
	    	}
	    	getCandidate.put("MOBILE", mobile);
	    	getCandidate.put("PHONE", phone);
	    	getCandidate.put("EMAIL", email);
	    	getCandidate.put("SOURCES", sources);
	    	
	    	//학력사항 리스트
	    	Map<String, Object> academicMap = null;
	    	String[] academic1 = StringUtil.NVL(getCandidate.get("ACADEMIC_1")).split(":");
	    	String[] academic2 = StringUtil.NVL(getCandidate.get("ACADEMIC_2")).split(":");
	    	String[] academic3 = StringUtil.NVL(getCandidate.get("ACADEMIC_3")).split(":");
	    	String[] academic4 = StringUtil.NVL(getCandidate.get("ACADEMIC_4")).split(":");
	    	
	    	if (academic1.length > 1) {
	    		academicMap = new HashMap<String, Object>();
	    		academicMap.put("USR_LEVEL", academic1[0]);
	    		academicMap.put("USR_SCHOOL", academic1[1]);
	    		academicMap.put("USR_MAJOR", academic1[2]);
	    		academicMap.put("USR_TYPE", academic1[3]);
	    		getUsrAcademicList.add(academicMap);
	    	} 
	    	if (academic2.length > 1) {
	    		academicMap = new HashMap<String, Object>();
	    		academicMap.put("USR_LEVEL", academic2[0]);
	    		academicMap.put("USR_SCHOOL", academic2[1]);
	    		academicMap.put("USR_MAJOR", academic2[2]);
	    		academicMap.put("USR_TYPE", academic2[3]);
	    		getUsrAcademicList.add(academicMap);
	    	} 
	    	if (academic3.length > 1) {
	    		academicMap = new HashMap<String, Object>();
	    		academicMap.put("USR_LEVEL", academic3[0]);
	    		academicMap.put("USR_SCHOOL", academic3[1]);
	    		academicMap.put("USR_MAJOR", academic3[2]);
	    		academicMap.put("USR_TYPE", academic3[3]);
	    		getUsrAcademicList.add(academicMap);
	    	} 
	    	if (academic4.length > 1) {
	    		academicMap = new HashMap<String, Object>();
	    		academicMap.put("USR_LEVEL", academic4[0]);
	    		academicMap.put("USR_SCHOOL", academic4[1]);
	    		academicMap.put("USR_MAJOR", academic4[2]);
	    		academicMap.put("USR_TYPE", academic4[3]);
	    		getUsrAcademicList.add(academicMap);
	    	}

	    	//파일 리스트
	    	param.put("orgId", usrId);
	    	List<Map<String, Object>> fileList = fileService.getFileList(param);
	    	
	    	fileMap = new HashMap<String, Object>();
	    	for(Map<String, Object> hm : fileList) {
	    		int index = Integer.parseInt(hm.get("FILE_ORDER").toString());
	    		
	    		fileMap.put("attId_" + index, hm.get("ATT_ID"));
	    		fileMap.put("originalFileNm_" + index, hm.get("ORIGINAL_FILE_NM"));
	    		fileMap.put("fileSize_" + index, hm.get("FILE_SIZE"));
	    	}
	        
	    	//코멘트 리스트
	        param.put("itemId", usrId);
	        getCommentList = commentService.getCommentList(param);
	        
            param.put("parentId", getCandidate.get("INDUSTRY1"));
            List<Map<String, Object>> codeChildList1 = codeService.getCodeList2(param);
            mv.addObject("codeChildList1", codeChildList1);    
            
            param.put("parentId", getCandidate.get("JOB1"));
            List<Map<String, Object>> codeChildList2 = codeService.getCodeList2(param);
            mv.addObject("codeChildList2", codeChildList2);    
	    } else {
	    	getCandidate = new HashMap<String, Object>();
	    	getCandidate.put("PUBLIC_YN", userInfo.get("AUTH_PUBLIC"));
	    	getCandidate.put("CON_ID", userInfo.get("CON_ID"));
	    }
	   
	    //진행현황, 진행상태 리스트
	    List<Map<String, Object>> progressList = new ArrayList<Map<String, Object>>();
	    List<Map<String, Object>> posRecPresentList = candidateService.getPosRecPresentList(param); //진행현황
	    for (Map<String, Object>presentMap : posRecPresentList) {
	    	Map<String, Object> m = new HashMap<String, Object>();
	    	String recId = (String) presentMap.get("REC_ID");
	    	m.put("recId", recId);
	    	
	    	List<Map<String, Object>> posProStatusList = candidateService.getPosProStatusList(m); //진행상태
	    	
	    	if (posProStatusList.size() != 0) {
	    		presentMap.put("posProStatusList", posProStatusList);
	    	}
	    	
	    	progressList.add(presentMap);
	    }
	    
	    mv.addObject("codeMap", codeMap);
	    mv.addObject("consultantList", consultantList);
	    mv.addObject("getCandidate", getCandidate);
	    mv.addObject("getMarkId", getMarkId);
	    mv.addObject("getUsrAcademicList", getUsrAcademicList);
	    mv.addObject("fileMap", fileMap);
	    mv.addObject("getCommentList", getCommentList);
	    mv.addObject("progressList", progressList);
	    mv.addObject("userInfo", userInfo);
	    mv.setViewName("candidate/candidateDetail");    
	    
		return mv;
	}
	
	@RequestMapping(value = "/candidate/candidate", method = RequestMethod.GET)
	public ModelAndView candidate(@RequestParam Map<String, Object> param, HttpSession session) throws Exception {
		ModelAndView mv = new ModelAndView();
		@SuppressWarnings("unchecked")
		Map<String, String> userInfo =  (Map<String, String>) session.getAttribute("userInfo");
	    String usrId = StringUtil.NVL(param.get("usrId"));
	    Map<String, Object> getCandidate = null;
	    List<Map<String, Object>> getUsrAcademicList = new ArrayList<Map<String, Object>>();
	    List<Map<String, Object>> getCommentList = null;
	    Map<String, Object> fileMap = null;
	    
	    List<Map<String, Object>> codeList1 = null;
	    List<Map<String, Object>> codeList2 = null;
	    Map<String, Object> codeMap = new HashMap<String, Object>();
	    String getMarkId = null;
	    
	    param.put("conId", userInfo.get("CON_ID"));
        param.put("cdType", "1");
        codeList1 = codeService.getCodeList(param);
        param.put("cdType", "2");
        codeList2 = codeService.getCodeList(param);
        
        codeMap.put("codeList1", codeList1);
        codeMap.put("codeList2", codeList2);
	    
	    List<Map<String, Object>> consultantList = consultantService.getConsultantList(param);
	    
	    if (StringUtils.isNotEmpty(usrId)) {
	    	getCandidate =  candidateService.getCandidate(param);
	    	getMarkId =  candidateService.getMarkId(param);
	    	String authUserType = userInfo.get("AUTH_USER_TYPE");
	    	String mobile = AES128Util.decrypt(String.valueOf(getCandidate.get("MOBILE")));
	    	String phone = AES128Util.decrypt(String.valueOf(getCandidate.get("PHONE")));
	    	String email = AES128Util.decrypt(String.valueOf(getCandidate.get("EMAIL")));
	    	
	    	if (StringUtils.equals(authUserType, "2") && !StringUtils.equals(String.valueOf(getCandidate.get("CON_ID")), userInfo.get("CON_ID"))) {
	    		mobile = "***********";
	    		phone = "***********";
	    		email = "***********";
	    	}
	    	getCandidate.put("MOBILE", mobile);
	    	getCandidate.put("PHONE", phone);
	    	getCandidate.put("EMAIL", email);
	    	
	    	//학력사항 리스트
	    	Map<String, Object> academicMap = null;
	    	String[] academic1 = StringUtil.NVL(getCandidate.get("ACADEMIC_1")).split(":");
	    	String[] academic2 = StringUtil.NVL(getCandidate.get("ACADEMIC_2")).split(":");
	    	String[] academic3 = StringUtil.NVL(getCandidate.get("ACADEMIC_3")).split(":");
	    	String[] academic4 = StringUtil.NVL(getCandidate.get("ACADEMIC_4")).split(":");

	    	if (academic1.length > 1) {
	    		academicMap = new HashMap<String, Object>();
	    		academicMap.put("USR_LEVEL", academic1[0]);
	    		academicMap.put("USR_SCHOOL", academic1[1]);
	    		academicMap.put("USR_MAJOR", academic1[2]);
	    		academicMap.put("USR_TYPE", academic1[3]);
	    		getUsrAcademicList.add(academicMap);
	    	} else {	academicMap = new HashMap<String, Object>(); getUsrAcademicList.add(academicMap); }
	    	if (academic2.length > 1) {
	    		academicMap = new HashMap<String, Object>();
	    		academicMap.put("USR_LEVEL", academic2[0]);
	    		academicMap.put("USR_SCHOOL", academic2[1]);
	    		academicMap.put("USR_MAJOR", academic2[2]);
	    		academicMap.put("USR_TYPE", academic2[3]);
	    		getUsrAcademicList.add(academicMap);
	    	} else {	academicMap = new HashMap<String, Object>(); getUsrAcademicList.add(academicMap); }
	    	if (academic3.length > 1) {
	    		academicMap = new HashMap<String, Object>();
	    		academicMap.put("USR_LEVEL", academic3[0]);
	    		academicMap.put("USR_SCHOOL", academic3[1]);
	    		academicMap.put("USR_MAJOR", academic3[2]);
	    		academicMap.put("USR_TYPE", academic3[3]);
	    		getUsrAcademicList.add(academicMap);
	    	} else {	academicMap = new HashMap<String, Object>(); getUsrAcademicList.add(academicMap); }
	    	if (academic4.length > 1) {
	    		academicMap = new HashMap<String, Object>();
	    		academicMap.put("USR_LEVEL", academic4[0]);
	    		academicMap.put("USR_SCHOOL", academic4[1]);
	    		academicMap.put("USR_MAJOR", academic4[2]);
	    		academicMap.put("USR_TYPE", academic4[3]);
	    		getUsrAcademicList.add(academicMap);
	    	} else {	academicMap = new HashMap<String, Object>(); getUsrAcademicList.add(academicMap); }

	    	//파일 리스트
	    	param.put("orgId", usrId);
	    	List<Map<String, Object>> fileList = fileService.getFileList(param);
	    	
	    	fileMap = new HashMap<String, Object>();
	    	for(Map<String, Object> hm : fileList) {
	    		int index = Integer.parseInt(hm.get("FILE_ORDER").toString());
	    		
	    		fileMap.put("attId_" + index, hm.get("ATT_ID"));
	    		fileMap.put("originalFileNm_" + index, hm.get("ORIGINAL_FILE_NM"));
	    		fileMap.put("fileSize_" + index, hm.get("FILE_SIZE"));
	    	}
	        
	    	//코멘트 리스트
	        param.put("itemId", usrId);
	        getCommentList = commentService.getCommentList(param);
	        
            param.put("parentId", getCandidate.get("INDUSTRY1"));
            List<Map<String, Object>> codeChildList1 = codeService.getCodeList2(param);
            mv.addObject("codeChildList1", codeChildList1);    
            
            param.put("parentId", getCandidate.get("JOB1"));
            List<Map<String, Object>> codeChildList2 = codeService.getCodeList2(param);
            mv.addObject("codeChildList2", codeChildList2);    
	    } else {
	    	getCandidate = new HashMap<String, Object>();
	    	getCandidate.put("PUBLIC_YN", userInfo.get("AUTH_PUBLIC"));
	    	getCandidate.put("CON_ID", userInfo.get("CON_ID"));
	    }
	   
	    //진행현황, 진행상태 리스트
	    List<Map<String, Object>> progressList = new ArrayList<Map<String, Object>>();
	    List<Map<String, Object>> posRecPresentList = candidateService.getPosRecPresentList(param); //진행현황
	    for (Map<String, Object>presentMap : posRecPresentList) {
	    	Map<String, Object> m = new HashMap<String, Object>();
	    	String recId = (String) presentMap.get("REC_ID");
	    	m.put("recId", recId);
	    	
	    	List<Map<String, Object>> posProStatusList = candidateService.getPosProStatusList(m); //진행상태
	    	
	    	if (posProStatusList.size() != 0) {
	    		presentMap.put("posProStatusList", posProStatusList);
	    	}
	    	
	    	progressList.add(presentMap);
	    }
	    
	    mv.addObject("codeMap", codeMap);
	    mv.addObject("consultantList", consultantList);
	    mv.addObject("getCandidate", getCandidate);
	    mv.addObject("getMarkId", getMarkId);
	    mv.addObject("getUsrAcademicList", getUsrAcademicList);
	    mv.addObject("fileMap", fileMap);
	    mv.addObject("getCommentList", getCommentList);
	    mv.addObject("progressList", progressList);
	    mv.addObject("userInfo", userInfo);
	    mv.setViewName("candidate/candidate");    
	    
		return mv;
	}
	
	@ResponseBody
	@RequestMapping(value = "/candidate/setCandidate", method = RequestMethod.POST)
	public Map<String, Object> setCandidate(@RequestParam Map<String, Object> param, HttpServletRequest request) throws Exception {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		param.put("mobile", AES128Util.encrypt(StringUtil.NVL(param.get("mobile"))));
		param.put("phone", AES128Util.encrypt(StringUtil.NVL(param.get("phone"))));
		param.put("email", AES128Util.encrypt(StringUtil.NVL(param.get("email"))));
		
	    for (int i = 0; i < 4; i++) {
	    	String level = StringUtil.NVL(param.get("list["+i+"].usrLevel"));
	    	String school = StringUtil.NVL(param.get("list["+i+"].usrSchool"));
	    	String major = StringUtil.NVL(param.get("list["+i+"].usrMajor"));
	    	String type = StringUtil.NVL(param.get("list["+i+"].usrType"));
	    	
	    	String academic = level + ":" + school + ":" + major + ":" + type;
	    	param.put("academic_" + (i+1), academic);
	    }
	    
	    candidateService.setCandidate(param);
	    
	    try {
	        param.put("fileType", FileType.USR.getCode());
	        param.put("orgId", param.get("usrId"));
	        
	        fileService.uploadFile(param, request);	    
        } catch (Exception e) {
            e.printStackTrace();
        }
		
	    resultMap.put("result", "success");
		return resultMap;
	}
	
	//후보자 중복 검색 팝업
   @RequestMapping(value = "/candidate/candidateOverlapPop", method = RequestMethod.GET)
    public ModelAndView candidateOverlapPop(@RequestParam Map<String, Object> param, 
    												HttpSession session,
    												ModelAndView mv) throws Exception {
	   @SuppressWarnings("unchecked")
		Map<String, String> userInfo =  (Map<String, String>) session.getAttribute("userInfo");
		String adminYn = userInfo.get("ADMIN_YN");
		String authUser = userInfo.get("AUTH_USER");
		String conId = userInfo.get("CON_ID");
        String usrNm = StringUtil.NVL(param.get("usrNm"));
        List<Map<String, Object>> usrList = new ArrayList<Map<String, Object>>();
        
        if (StringUtils.isNotEmpty(usrNm)) {
            param.put("adminYn", adminYn);
            param.put("authUser", authUser);
            param.put("conId", conId);
            param.put("sconId", conId);
        	
            List<Map<String, Object>> tmpList = candidateService.getCandidatePopList(param);
            
            for (Map<String, Object> hm : tmpList) {
            	hm.put("MOBILE", AES128Util.decrypt(String.valueOf(hm.get("MOBILE"))));
    	    	
            	usrList.add(hm);
            }
        }
        
        mv.addObject("usrNm", usrNm);
        mv.addObject("usrList", usrList);
        mv.setViewName("pop/candidate/candidateOverlapPop");    
        return mv;
    }
   
   //SMS 팝업
   @RequestMapping(value = "/candidate/smsPop", method = RequestMethod.GET)
    public ModelAndView smsPop(@RequestParam Map<String, Object> param, 
    												HttpSession session) throws Exception {
	   ModelAndView mv = new ModelAndView();
	   @SuppressWarnings("unchecked")
		Map<String, String> userInfo =  (Map<String, String>) session.getAttribute("userInfo");
	    String toTarget = StringUtil.NVL(param.get("toTarget")).replaceAll("-", "");
	   	String mobile = AES128Util.decrypt(userInfo.get("MOBILE")).replaceAll("-", "");
	   
	   	mv.addObject("toTarget", toTarget);
		mv.addObject("fromTarget", mobile);
        mv.setViewName("pop/candidate/smsPop");
        return mv;
    }
	
	@ResponseBody
	@RequestMapping(value = "/candidate/modCandidate", method = RequestMethod.POST)
	public  Map<String, Object> modCandidate(@RequestParam Map<String, Object> param, HttpServletRequest request) throws Exception {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		String usrId = StringUtil.NVL(param.get("usrId"));
		
        try {
            param.put("fileType", FileType.USR.getCode());
            param.put("orgId", usrId);
            
            fileService.modFile(param, request);
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        param.put("mobile", AES128Util.encrypt(StringUtil.NVL(param.get("mobile"))));
		param.put("phone", AES128Util.encrypt(StringUtil.NVL(param.get("phone"))));
		param.put("email", AES128Util.encrypt(StringUtil.NVL(param.get("email"))));
		
	    for (int i = 0; i < 4; i++) {
	    	String level = StringUtil.NVL(param.get("list["+i+"].usrLevel"));
	    	String school = StringUtil.NVL(param.get("list["+i+"].usrSchool"));
	    	String major = StringUtil.NVL(param.get("list["+i+"].usrMajor"));
	    	String type = StringUtil.NVL(param.get("list["+i+"].usrType"));
	    	
	    	String academic = level + ":" + school + ":" + major + ":" + type;
	    	param.put("academic_" + (i+1), academic);
	    	
	    }
	    
	    candidateService.modCandidate(param);
		
	    resultMap.put("result", "success");
		return resultMap;
	}
	
	/** 후보자 삭제 **/
	@RequestMapping(value = "/candidate/delCandidate", method = RequestMethod.POST)
	public ModelAndView delCandidate(@RequestParam Map<String, Object> param, ModelAndView mv) {
		try {
			//트랜잭션 처리 해야 함
			candidateService.delCandidate(param);
			
			param.put("fileType", FileType.USR.getCode());
			param.put("orgId", param.get("usrId"));
			fileService.delFile(param);
			commentService.delComment(param);
			
			//학력사항도 삭제 처리 해야 하나
		} catch (Exception e) {
            e.printStackTrace();
        }
		
	    mv.setViewName("redirect:/candidate/candidateList");
		return mv;
	}
	
	/** 포지션 검색 팝업창 **/
	@RequestMapping(value = "/candidate/positionAddPop", method = RequestMethod.GET)
	public ModelAndView positionAddPop(@RequestParam Map<String, Object> param, 
    		ModelAndView mv, @ModelAttribute("pagingDTO") PagingDTO pagingDTO) {
        String posNm = StringUtil.NVL(param.get("posNm"));
        String pageNo = StringUtil.NVL(param.get("pageNo"));
        
        if(StringUtils.isNotEmpty(pageNo)){
            pagingDTO.setStartRowNum((Integer.parseInt(pageNo)-1) * 5);
        }
        
        pagingDTO.setPageSize(5);
        pagingDTO.setBlockSize(5);
        param.put("startRowNum", pagingDTO.getStartRowNum());
        param.put("pageSize", pagingDTO.getPageSize());
        pagingDTO.setTotalCount(candidateService.getPositionPopTotalCount(param));
        List<Map<String, Object>> positionList = candidateService.getPositionPopList(param);
        
        mv.addObject("posNm", posNm);
        mv.addObject("paging", pagingDTO);
        mv.addObject("positionList", positionList);
        mv.setViewName("pop/candidate/positionPop");    
        return mv;
	}
   
	/** 후보자별 포지션 진행현황 등록 **/
	@RequestMapping(value = "/candidate/addPositionPresent", method = RequestMethod.POST) 
	public @ResponseBody Map<String, Object> addPositionPresent(@RequestParam Map<String, Object> param, ModelAndView mv) {
	   Map<String, Object> resultMap = new HashMap<String, Object>();
	   
	   int result = candidateService.addPosRecPresent(param);
	   
	   if (result == 1) {
		   List<Map<String, Object>> posRecPresent = candidateService.getPosRecPresentList(param);
		   resultMap.put("result", posRecPresent.get(0));
		   resultMap.put("success", result);
	   }
      
	   return resultMap;
	}
	
	/** 후보자별 포지션 진행현황 삭제 **/
	@RequestMapping(value = "/candidate/delPosRecPresent", method = RequestMethod.POST) 
	public @ResponseBody Map<String, Object> delPosRecPresent(@RequestParam Map<String, Object> param,
				@RequestParam(value="arrayChk",required=true) List<String> arrayChk, ModelAndView mv) {
	   Map<String, Object> resultMap = new HashMap<String, Object>();
	   String result = "";
	   
	   for (String value : arrayChk) {
		   param.put("recId", value);
		   result += candidateService.delPosRecPresent(param);   
	   }
	   
	   if (!result.contains("0")) {
		   resultMap.put("result", "success");
	   }
      
	   return resultMap;
	}
	
	/** 후보자별 포지션 진행상태 저장 **/
	@RequestMapping(value = "/candidate/addPosProStatus", method = RequestMethod.POST) 
	public @ResponseBody Map<String, Object> addPosProStatus(@RequestParam Map<String, Object> param, ModelAndView mv) {
	   Map<String, Object> resultMap = new HashMap<String, Object>();
	   
	   int result = candidateService.addPosProStatus(param);
	   
	   if (result == 1) {
		   resultMap.put("staId", param.get("staId"));
		   resultMap.put("result", "success");
	   }
      
	   return resultMap;
	}
	
	/** 후보자별 포지션 진행상태 삭제 **/
	@RequestMapping(value = "/candidate/delPosProStatus", method = RequestMethod.POST) 
	public @ResponseBody Map<String, Object> delPosProStatus(@RequestParam Map<String, Object> param, ModelAndView mv) {
	   Map<String, Object> resultMap = new HashMap<String, Object>();
	   
	   int result = candidateService.delPosProStatus(param);
	   
	   if (result == 1) {
		   resultMap.put("result", "success");
	   }
      
	   return resultMap;
	}
	
	/** 복사 **/
//	@RequestMapping(value = "/candidate/copyCandidate", method = RequestMethod.POST)
//	public ModelAndView copyCandidate(@RequestParam Map<String, Object> param, HttpServletRequest request) throws Exception {
//		ModelAndView mv = new ModelAndView();
//		Map<String, Object> candidateData = candidateService.getCandidate(param); 
//		
//		param.put("mobile", AES128Util.encrypt(StringUtil.NVL(param.get("mobile"))));
//		param.put("phone", AES128Util.encrypt(StringUtil.NVL(param.get("phone"))));
//		param.put("email", AES128Util.encrypt(StringUtil.NVL(param.get("email"))));
//		candidateService.setCandidate(param);
//		
//	    for (int i = 0; i < 4; i++) {
//	    	param.put("usrId", param.get("usrId"));
//	    	param.put("usrLevel", param.get("list["+i+"].usrLevel"));
//	    	param.put("usrSchool", param.get("list["+i+"].usrSchool"));
//	    	param.put("usrMajor", param.get("list["+i+"].usrMajor"));
//	    	param.put("usrType", param.get("list["+i+"].usrType"));
//	    	param.put("usrOrder", i+1);
//	    	
//	    	candidateService.setUsrAcademic(param);
//	    }
//	    
//	    try {
//	        param.put("fileType", FileType.USR.getCode());
//	        param.put("orgId", param.get("usrId"));
//	        
//	        fileService.uploadFile(param, request);	    
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//	    
//	    mv.addObject("usrId", param.get("usrId"));
//	    mv.setViewName("redirect:/candidate/candidate");
//	    return mv;
//	}
	
}
