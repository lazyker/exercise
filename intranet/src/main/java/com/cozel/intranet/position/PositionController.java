package com.cozel.intranet.position;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
import com.cozel.intranet.common.comment.CommentService;
import com.cozel.intranet.common.paging.PagingDTO;
import com.cozel.intranet.common.security.AES128Util;
import com.cozel.intranet.common.utils.StringUtil;
import com.cozel.intranet.position.service.PositionService;

@Controller
public class PositionController {
	
	@Autowired
	private PositionService positionService;
	
	@Autowired
    private ConsultantService consultantService;
	
	@Autowired
    private CodeService codeService;
	
	@Autowired
    private CommentService commentService;
	
	private static final Logger logger = LoggerFactory.getLogger(PositionController.class);
	
	@RequestMapping(value = "/position/positionList", method = {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView positionList(@RequestParam Map<String, Object> param,
													HttpSession session,
	        										@ModelAttribute("pagingDTO") PagingDTO pagingDTO,
	        										ModelAndView mv) {
		@SuppressWarnings("unchecked")
		Map<String, String> userInfo =  (Map<String, String>) session.getAttribute("userInfo");
		String adminYn = userInfo.get("ADMIN_YN");
		String authPosition = userInfo.get("AUTH_POSITION");
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
        param.put("authPosition", authPosition);
        param.put("conId", conId);
        param.put("sconId", conId);
        param.put("startRowNum", pagingDTO.getStartRowNum());
        param.put("pageSize", pagingDTO.getPageSize());
        pagingDTO.setTotalCount(positionService.getPositionTotalCount(param));
	    List<Map<String, Object>> positionList = positionService.getPositionList(param);
	    
	    mv.addObject("codeMap", codeMap);
	    mv.addObject("search", param);
	    mv.addObject("paging", pagingDTO);
	    mv.addObject("positionList", positionList);
		mv.setViewName("position/positionList");
		return mv;
	}
	
	@RequestMapping(value = "/position/positionDetail", method = RequestMethod.GET)
	public ModelAndView positionDetail(@RequestParam Map<String, Object> param, HttpSession session, ModelAndView mv) throws Exception {
		@SuppressWarnings("unchecked")
		Map<String, String> userInfo =  (Map<String, String>) session.getAttribute("userInfo");
	    String posId = StringUtil.NVL(param.get("posId"));
	    Map<String, Object> getPosition = null;
	    List<Map<String, Object>> getCommentList = null;
	    
	    if (StringUtils.isNotEmpty(posId)) {
	    	getPosition =  positionService.getPosition(param);
	        
	        param.put("itemId", posId);
	        getCommentList = commentService.getCommentList(param);
	        
	        param.put("parentId", getPosition.get("JOB1"));
	        List<Map<String, Object>> childCodeList = codeService.getCodeList2(param);
	        mv.addObject("childCodeList", childCodeList);
	    } else {
	    	getPosition = new HashMap<String, Object>();
	    	getPosition.put("PUBLIC_YN", userInfo.get("AUTH_PUBLIC"));
	    	getPosition.put("CON_ID", userInfo.get("CON_ID"));
	    }
	    
	    //진행현황, 진행상태 리스트
	    String authUserType = userInfo.get("AUTH_USER_TYPE");
	    List<Map<String, Object>> progressList = new ArrayList<Map<String, Object>>();
	    List<Map<String, Object>> posRecPresentList = positionService.getUsrRecPresentList(param); //진행현황
	    for (Map<String, Object>presentMap : posRecPresentList) {
	    	String mobile = AES128Util.decrypt(String.valueOf(presentMap.get("MOBILE")));
	    	
	    	if (StringUtils.equals(authUserType, "2") && !StringUtils.equals(String.valueOf(presentMap.get("CON_ID")), userInfo.get("CON_ID"))) {
	    		mobile = "***********";
	    	}
	    	presentMap.put("MOBILE", mobile);
	    	
	    	Map<String, Object> m = new HashMap<String, Object>();
	    	m.put("recId", presentMap.get("REC_ID"));
	    	List<Map<String, Object>> posProStatusList = positionService.getUsrProStatusList(m); //진행상태
	    	
	    	if (posProStatusList.size() != 0) {
	    		presentMap.put("posProStatusList", posProStatusList);
	    	}
	    	
	    	progressList.add(presentMap);
	    }
	    
	    mv.addObject("getPosition", getPosition);
	    mv.addObject("getCommentList", getCommentList);
	    mv.addObject("progressList", progressList);
	    mv.addObject("userInfo", userInfo);
	    mv.setViewName("position/positionDetail");    
	    
		return mv;
	}
	
	@RequestMapping(value = "/position/position", method = RequestMethod.GET)
	public ModelAndView position(@RequestParam Map<String, Object> param, HttpSession session, ModelAndView mv) throws Exception {
		@SuppressWarnings("unchecked")
		Map<String, String> userInfo =  (Map<String, String>) session.getAttribute("userInfo");
	    String posId = StringUtil.NVL(param.get("posId"));
	    Map<String, Object> getPosition = null;
	    List<Map<String, Object>> getCommentList = null;
	    
	    param.put("cdType", "1");
	    List<Map<String, Object>> jobCodeList = codeService.getCodeList(param);
	    List<Map<String, Object>> consultantList = consultantService.getConsultantList(param);
	    
	    if (StringUtils.isNotEmpty(posId)) {
	    	getPosition =  positionService.getPosition(param);
	        
	        param.put("itemId", posId);
	        getCommentList = commentService.getCommentList(param);
	        
	        param.put("parentId", getPosition.get("JOB1"));
	        List<Map<String, Object>> childCodeList = codeService.getCodeList2(param);
	        mv.addObject("childCodeList", childCodeList);
	    } else {
	    	getPosition = new HashMap<String, Object>();
	    	getPosition.put("PUBLIC_YN", userInfo.get("AUTH_PUBLIC"));
	    	getPosition.put("CON_ID", userInfo.get("CON_ID"));
	    }
	    
	    //진행현황, 진행상태 리스트
	    String authUserType = userInfo.get("AUTH_USER_TYPE");
	    List<Map<String, Object>> progressList = new ArrayList<Map<String, Object>>();
	    List<Map<String, Object>> posRecPresentList = positionService.getUsrRecPresentList(param); //진행현황
	    for (Map<String, Object>presentMap : posRecPresentList) {
	    	String mobile = AES128Util.decrypt(String.valueOf(presentMap.get("MOBILE")));
	    	
	    	if (StringUtils.equals(authUserType, "2") && !StringUtils.equals(String.valueOf(presentMap.get("CON_ID")), userInfo.get("CON_ID"))) {
	    		mobile = "***********";
	    	}
	    	presentMap.put("MOBILE", mobile);
	    	
	    	Map<String, Object> m = new HashMap<String, Object>();
	    	m.put("recId", presentMap.get("REC_ID"));
	    	List<Map<String, Object>> posProStatusList = positionService.getUsrProStatusList(m); //진행상태
	    	
	    	if (posProStatusList.size() != 0) {
	    		presentMap.put("posProStatusList", posProStatusList);
	    	}
	    	
	    	progressList.add(presentMap);
	    }
	    
	    mv.addObject("consultantList", consultantList);
	    mv.addObject("jobCodeList", jobCodeList);
	    mv.addObject("getPosition", getPosition);
	    mv.addObject("getCommentList", getCommentList);
	    mv.addObject("progressList", progressList);
	    mv.addObject("userInfo", userInfo);
	    mv.setViewName("position/position");    
	    
		return mv;
	}
	
	@ResponseBody
	@RequestMapping(value = "/position/setPosition", method = RequestMethod.POST)
	public Map<String, Object> setPosition(@RequestParam Map<String, Object> param) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		positionService.setPosition(param);
		resultMap.put("result", "success");
		return resultMap;
	}
	
	/** 회사 등록 팝업 **/
	@RequestMapping(value = "/position/companyPop", method = RequestMethod.GET)
	public ModelAndView companyPop(@RequestParam Map<String, Object> param, 
    		HttpSession session, @ModelAttribute("pagingDTO") PagingDTO pagingDTO, ModelAndView mv) {
		@SuppressWarnings("unchecked")
		Map<String, String> userInfo =  (Map<String, String>) session.getAttribute("userInfo");
		String adminYn = userInfo.get("ADMIN_YN");
		String authCompany = userInfo.get("AUTH_COMPANY");
		String conId = userInfo.get("CON_ID");
        String comNm = StringUtil.NVL(param.get("comNm"));
        String pageNo = StringUtil.NVL(param.get("pageNo"));
        
        if(StringUtils.isNotEmpty(pageNo)){
            pagingDTO.setStartRowNum((Integer.parseInt(pageNo)-1) * 5);
        }
        
        pagingDTO.setPageSize(5);
        pagingDTO.setBlockSize(5);
        param.put("startRowNum", pagingDTO.getStartRowNum());
        param.put("pageSize", pagingDTO.getPageSize());
        param.put("adminYn", adminYn);
        param.put("authCompany", authCompany);
        param.put("usrId", conId);
        param.put("conId", conId);
        pagingDTO.setTotalCount(positionService.getCompanyPopTotalCount(param));
        List<Map<String, Object>> companyList = positionService.getCompanyPopList(param);
        
        mv.addObject("comNm", comNm);
        mv.addObject("paging", pagingDTO);
        mv.addObject("companyList", companyList);
        mv.setViewName("pop/position/companyPop");    
        return mv;
    }
   
    @ResponseBody
	@RequestMapping(value = "/position/modPosition", method = RequestMethod.POST)
	public Map<String, Object> modPosition(@RequestParam Map<String, Object> param) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		positionService.modPosition(param);
		resultMap.put("result", "success");
		return resultMap;
	}
	
	@RequestMapping(value = "/position/delPosition", method = RequestMethod.POST)
	public ModelAndView delPosition(@RequestParam Map<String, Object> param, ModelAndView mv) {
		positionService.delPosition(param);
	    mv.setViewName("redirect:/position/positionList");
		return mv;
	}
	
	/** 진행현황 후보자 등록 팝업 **/
	@RequestMapping(value = "/position/candidateAddPop", method = RequestMethod.GET)
    public ModelAndView candidateAddPop(@RequestParam Map<String, Object> param, 
    		HttpSession session, ModelAndView mv, @ModelAttribute("pagingDTO") PagingDTO pagingDTO) throws Exception {
		@SuppressWarnings("unchecked")
		Map<String, String> userInfo =  (Map<String, String>) session.getAttribute("userInfo");
		String adminYn = userInfo.get("ADMIN_YN");
		String authUser = userInfo.get("AUTH_USER");
		String conId = userInfo.get("CON_ID");
        String comNm = StringUtil.NVL(param.get("usrNm"));
        String pageNo = StringUtil.NVL(param.get("pageNo"));
        
        if(StringUtils.isNotEmpty(pageNo)){
            pagingDTO.setStartRowNum((Integer.parseInt(pageNo)-1) * 5);
        }
        
        param.put("adminYn", adminYn);
        param.put("authUser", authUser);
        param.put("usrId", conId);
        param.put("conId", conId);
        pagingDTO.setPageSize(5);
        pagingDTO.setBlockSize(5);
        param.put("startRowNum", pagingDTO.getStartRowNum());
        param.put("pageSize", pagingDTO.getPageSize());
        pagingDTO.setTotalCount(positionService.getCandidatePopTotalCount(param));
        
        List<Map<String, Object>> tmpList = positionService.getCandidatePopList(param);
        List<Map<String, Object>> candidateList = new ArrayList<Map<String, Object>>();
        for (Map<String, Object> hm : tmpList) {
        	hm.put("MOBILE", AES128Util.decrypt(String.valueOf(hm.get("MOBILE"))));
	    	
	    	candidateList.add(hm);
        }
        
        mv.addObject("comNm", comNm);
        mv.addObject("paging", pagingDTO);
        mv.addObject("candidateList", candidateList);
        mv.setViewName("pop/position/candidatePop");    
        return mv;
    }
   
	/** 포지션별 후보자 진행현황 등록 **/
	@RequestMapping(value = "/position/addCandidatePresent", method = RequestMethod.POST) 
	public @ResponseBody Map<String, Object> addCandidatePresent(@RequestParam Map<String, Object> param, ModelAndView mv) throws Exception {
	   Map<String, Object> resultMap = new HashMap<String, Object>();
	   
	   int result = positionService.addUsrRecPresent(param);
	   
	   if (result == 1) {
		   List<Map<String, Object>> tmpList = positionService.getUsrRecPresentList(param);
	        List<Map<String, Object>> posRecPresent = new ArrayList<Map<String, Object>>();
	        for (Map<String, Object> hm : tmpList) {
	        	hm.put("MOBILE", AES128Util.decrypt(String.valueOf(hm.get("MOBILE"))));
	        	hm.put("USR_SCHOOL", StringUtil.NVL(hm.get("USR_SCHOOL"), ""));
	        	hm.put("USR_MAJOR", StringUtil.NVL(hm.get("USR_MAJOR"), ""));
		    	
	        	posRecPresent.add(hm);
	        }
		   
		   resultMap.put("result", posRecPresent.get(0));
		   resultMap.put("success", result);
	   }
     
	   return resultMap;
	}
	
	/** 포지션별 후보자 진행현황 삭제 **/
	@RequestMapping(value = "/position/delUsrRecPresent", method = RequestMethod.POST) 
	public @ResponseBody Map<String, Object> delUsrRecPresent(@RequestParam Map<String, Object> param,
				@RequestParam(value="arrayChk",required=true) List<String> arrayChk, ModelAndView mv) {
	   Map<String, Object> resultMap = new HashMap<String, Object>();
	   String result = "";
	   
	   for (String value : arrayChk) {
		   param.put("recId", value);
		   result += positionService.delUsrRecPresent(param);   
	   }
	   
	   if (!result.contains("0")) {
		   resultMap.put("result", "success");
	   }
      
	   return resultMap;
	}
	
	/** 포지션별 후보자 진행상태 저장 **/
	@RequestMapping(value = "/position/addUsrProStatus", method = RequestMethod.POST) 
	public @ResponseBody Map<String, Object> addUsrProStatus(@RequestParam Map<String, Object> param, ModelAndView mv) {
	   Map<String, Object> resultMap = new HashMap<String, Object>();
	   
	   int result = positionService.addUsrProStatus(param);
	   
	   if (result == 1) {
		   resultMap.put("staId", param.get("staId"));
		   resultMap.put("result", "success");
	   }
      
	   return resultMap;
	}
	
	/** 포지션별 후보자 진행상태 삭제 **/
	@RequestMapping(value = "/position/delUsrProStatus", method = RequestMethod.POST) 
	public @ResponseBody Map<String, Object> delUsrProStatus(@RequestParam Map<String, Object> param, ModelAndView mv) {
	   Map<String, Object> resultMap = new HashMap<String, Object>();
	   
	   int result = positionService.delUsrProStatus(param);
	   
	   if (result == 1) {
		   resultMap.put("result", "success");
	   }
      
	   return resultMap;
	}
	
	/** 복사 **/
	@RequestMapping(value = "/position/copyPosition", method = RequestMethod.POST)
	public ModelAndView copyPosition(@RequestParam Map<String, Object> param, HttpSession session) {
		ModelAndView mv = new ModelAndView();
		@SuppressWarnings("unchecked")
		Map<String, String> userInfo =  (Map<String, String>) session.getAttribute("userInfo");
		
		Map<String, Object> positionData = positionService.getPosition(param);
		param.put("conId", userInfo.get("CON_ID"));
		
		param.put("posId", positionData.get("POS_ID"));
		param.put("posNm", positionData.get("POS_NM"));
		param.put("comId", positionData.get("COM_ID"));
		param.put("comNm", positionData.get("COM_NM"));
		param.put("rule", positionData.get("RULE"));
		param.put("hPublicYn", positionData.get("H_PUBLIC_YN"));
		param.put("sConId", positionData.get("S_CON_ID"));
		param.put("posStatus", positionData.get("POS_STATUS"));
		param.put("job1", positionData.get("JOB1"));
		param.put("job2", positionData.get("JOB2"));
		param.put("edu", positionData.get("EDU"));
		param.put("fromRank", positionData.get("FROM_RANK"));
		param.put("toRank", positionData.get("TO_RANK"));
		param.put("career", positionData.get("CAREER"));
		param.put("lang", positionData.get("LANG"));
		param.put("place", positionData.get("PLACE"));
		param.put("publicYn", positionData.get("PUBLIC_YN"));
		param.put("task", positionData.get("TASK"));
		param.put("posCondition", positionData.get("POS_CONDITION"));
		param.put("fromTarget", positionData.get("FROM_TARGET"));
		param.put("toTarget", positionData.get("TO_TARGET"));
		param.put("tCompany", positionData.get("T_COMPANY"));
		param.put("gender", positionData.get("GENDER"));
		param.put("license", positionData.get("LICENSE"));
		param.put("base", positionData.get("BASE"));
		param.put("bonus", positionData.get("BONUS"));
		param.put("etc", positionData.get("ETC"));
		
		positionService.setPosition(param);
		
	    mv.addObject("posId", param.get("posId"));
	    mv.setViewName("redirect:/position/position");
	    return mv;
	}
	
}
