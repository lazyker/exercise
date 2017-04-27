package com.cozel.intranet.company;

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
import com.cozel.intranet.common.utils.StringUtil;
import com.cozel.intranet.company.service.CompanyService;

@Controller
public class CompanyController {
	
	@Autowired
	private CompanyService companyService;
	
	@Autowired
    private ConsultantService consultantService;
	
	@Autowired
    private CodeService codeService;
	
	@Autowired
    private CommentService commentService;
	
	private static final Logger logger = LoggerFactory.getLogger(CompanyController.class);
	
	@RequestMapping(value = "/company/companyList", method = {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView companyList(@RequestParam Map<String, Object> param, 
											        @ModelAttribute("pagingDTO") PagingDTO pagingDTO,
											        HttpSession session,
											        ModelAndView mv) {
		@SuppressWarnings("unchecked")
		Map<String, String> userInfo =  (Map<String, String>) session.getAttribute("userInfo");
		String adminYn = userInfo.get("ADMIN_YN");
		String authCompany = userInfo.get("AUTH_COMPANY");
		String conId = userInfo.get("CON_ID");
	    String pageNo = StringUtil.NVL(param.get("pageNo"));
	    List<Map<String, Object>> codeList = null;
	    
        if(StringUtils.isNotEmpty(pageNo)){
            pagingDTO.setPageNo(Integer.parseInt(pageNo));
        }
        
        {
            param.put("cdType", "1");
            codeList = codeService.getCodeList(param);
            
            if (!StringUtils.equals((String)param.get("industry1"), "")) {
                param.put("parentId", param.get("industry1"));
                List<Map<String, Object>> codeChildList = codeService.getCodeList2(param);
                mv.addObject("codeChildList", codeChildList);    
            }
        }

        param.put("adminYn", adminYn);
        param.put("authCompany", authCompany);
        param.put("usrId", conId);
        param.put("conId", conId);
        param.put("startRowNum", pagingDTO.getStartRowNum());
        param.put("pageSize", pagingDTO.getPageSize());
        pagingDTO.setTotalCount(companyService.getTotalCount(param)); // 총 개수
	    List<Map<String, Object>> companyList = companyService.getCompanyList(param);
	    
	    mv.addObject("codeList", codeList);
	    mv.addObject("search", param);
	    mv.addObject("paging", pagingDTO);
	    mv.addObject("companyList", companyList);
		mv.setViewName("company/companyList");
		return mv;
	}
	
	@RequestMapping(value = "/company/companyDetail", method = RequestMethod.GET)
	public ModelAndView companyDetail(@RequestParam Map<String, Object> param, HttpSession session, ModelAndView mv) {
		@SuppressWarnings("unchecked")
		Map<String, String> userInfo =  (Map<String, String>) session.getAttribute("userInfo");
	    String comId = StringUtil.NVL(param.get("comId"));
	    Map<String, Object> getCompany = null;
	    List<Map<String, Object>> getPersonList = null;
	    List<Map<String, Object>> getCommentList = null;
	    
	    if (StringUtils.isNotEmpty(comId)) {
	        getCompany =  companyService.getCompany(param);
	        getPersonList = companyService.getPersonList(param);
	        
	        param.put("itemId", comId);
	        getCommentList = commentService.getCommentList(param);
	    }
	    
	    mv.addObject("getPersonList", getPersonList);
	    mv.addObject("getCompany", getCompany);
	    mv.addObject("getCommentList", getCommentList);
	    mv.addObject("userInfo", userInfo);
	    mv.setViewName("company/companyDetail");    
	    
		return mv;
	}
	
	@RequestMapping(value = "/company/company", method = RequestMethod.GET)
	public ModelAndView company(@RequestParam Map<String, Object> param, HttpSession session, ModelAndView mv) {
		@SuppressWarnings("unchecked")
		Map<String, String> userInfo =  (Map<String, String>) session.getAttribute("userInfo");
	    String comId = StringUtil.NVL(param.get("comId"));
	    Map<String, Object> getCompany = null;
	    List<Map<String, Object>> getPersonList = null;
	    List<Map<String, Object>> getCommentList = null;
	    
	    param.put("cdType", "1");
	    List<Map<String, Object>> codeList = codeService.getCodeList(param);
	    List<Map<String, Object>> consultantList = consultantService.getConsultantList(param);
	    
	    if (StringUtils.isNotEmpty(comId)) {
	        getCompany =  companyService.getCompany(param);
	        getPersonList = companyService.getPersonList(param);
	        
	        param.put("itemId", comId);
	        getCommentList = commentService.getCommentList(param);
	        
	        param.put("parentId", getCompany.get("INDUSTRY1"));
	        List<Map<String, Object>> childCodeList = codeService.getCodeList2(param);
	        mv.addObject("childCodeList", childCodeList);
	    } else {
	    	getCompany = new HashMap<String, Object>();
	    	getCompany.put("CON_ID", userInfo.get("CON_ID"));
	    	getCompany.put("USR_NM", userInfo.get("CON_NM"));
	    }
	    
	    mv.addObject("consultantList", consultantList);
	    mv.addObject("getPersonList", getPersonList);
	    mv.addObject("codeList", codeList);
	    mv.addObject("getCompany", getCompany);
	    mv.addObject("getCommentList", getCommentList);
	    mv.addObject("userInfo", userInfo);
	    mv.setViewName("company/company");    
	    
		return mv;
	}
	
	@ResponseBody
	@RequestMapping(value = "/company/setCompany", method = RequestMethod.POST)
	public Map<String, Object> setCompany(@RequestParam Map<String, Object> param) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
	    companyService.setCompany(param);
	    
	    for (int i = 0; i < 3; i++) {
	    	param.put("personNm", param.get("list["+i+"].personNm"));
	    	param.put("deptNm", param.get("list["+i+"].deptNm"));
	    	param.put("posNm", param.get("list["+i+"].posNm"));
	    	param.put("phone1", param.get("list["+i+"].phone1"));
	    	param.put("phone2", param.get("list["+i+"].phone2"));
	    	param.put("email", param.get("list["+i+"].email"));
	    	param.put("etc", param.get("list["+i+"].etc"));
	    	param.put("sort", i+1);
	    	
	    	companyService.setPerson(param);
	    }
	    	    
	    resultMap.put("result", "success");
		return resultMap;
	}
	
   @RequestMapping(value = "/company/companyOverlapPop", method = RequestMethod.GET)
    public ModelAndView companyOverlapPop(@RequestParam Map<String, Object> param, ModelAndView mv) {
        String comNm = StringUtil.NVL(param.get("comNm"));
        int companySize = 0;
            
        param.put("startRowNum", 0);
        param.put("comNm", comNm);
        List<Map<String, Object>> companyList = companyService.getCompanyList(param);
        
        companySize = companyList.size();
        if (StringUtils.equals(comNm, "")) {
            companySize = -1;
        }
        
        mv.addObject("comNm", param.get("comNm"));
        mv.addObject("companyLen", companySize);
        mv.setViewName("pop/company/companyOverlapPop");    
        return mv;
    }

	@ResponseBody
    @RequestMapping(value = "/company/modCompany", method = RequestMethod.POST)
	public Map<String, Object> modCompany(@RequestParam Map<String, Object> param) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
	    companyService.modCompany(param);
	    
	    for (int i = 0; i < 3; i++) {
	    	param.put("personId", param.get("list["+i+"].personId"));
	    	param.put("personNm", param.get("list["+i+"].personNm"));
	    	param.put("deptNm", param.get("list["+i+"].deptNm"));
	    	param.put("posNm", param.get("list["+i+"].posNm"));
	    	param.put("phone1", param.get("list["+i+"].phone1"));
	    	param.put("phone2", param.get("list["+i+"].phone2"));
	    	param.put("email", param.get("list["+i+"].email"));
	    	param.put("etc", param.get("list["+i+"].etc"));
	    	param.put("sort", i+1);
	    	
	    	companyService.modPerson(param);
	    }
	    
	    resultMap.put("result", "success");
		return resultMap;
	}
	
	@RequestMapping(value = "/company/delCompany", method = RequestMethod.POST)
	public ModelAndView delCompany(@RequestParam Map<String, Object> param, ModelAndView mv) {
	    companyService.delCompany(param);
	    
	    mv.setViewName("redirect:/company/companyList");
		return mv;
	}

}
