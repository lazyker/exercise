package com.cozel.intranet.admin;

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

import com.cozel.intranet.admin.service.StatsService;
import com.cozel.intranet.candidate.service.CandidateService;
import com.cozel.intranet.common.paging.PagingDTO;
import com.cozel.intranet.common.utils.StringUtil;
import com.cozel.intranet.position.service.PositionService;

@Controller
public class ClosedDataController {
	
	@Autowired
	PositionService positionService;
	
	@Autowired
	CandidateService candidateService;
	
	private static final Logger logger = LoggerFactory.getLogger(ClosedDataController.class);
	
	@RequestMapping(value = "/admin/closedData", method = {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView closedData(@RequestParam Map<String, Object> param,
												HttpSession session,
	        									@ModelAttribute("pagingDTO") PagingDTO pagingDTO) {
		ModelAndView mv = new ModelAndView();
	    String pageNo = StringUtil.NVL(param.get("pageNo"));
	    String type = StringUtil.NVL(param.get("type"), "P");
	    param.put("closedDataType", "N");
	    
	    //포지션
	    if (StringUtils.equals(type, "P")) 
	    { 
	    	if(StringUtils.isNotEmpty(pageNo)){
	    		pagingDTO.setPageNo(Integer.parseInt(pageNo));
	    	}
	    	
	    	param.put("startRowNum", pagingDTO.getStartRowNum());
	    	param.put("pageSize", pagingDTO.getPageSize());
	    	pagingDTO.setTotalCount(positionService.getPositionTotalCount(param));
	    	List<Map<String, Object>> positionList = positionService.getPositionList(param);
	    	
	    	mv.addObject("paging", pagingDTO);
	    	mv.addObject("positionList", positionList);
	    	mv.setViewName("admin/closed/closedPosition");
	    }
	    else 
	    {  //후보자
	    	if(StringUtils.isNotEmpty(pageNo)){
	    		pagingDTO.setPageNo(Integer.parseInt(pageNo));
	    	}
	    	
	    	param.put("startRowNum", pagingDTO.getStartRowNum());
	    	param.put("pageSize", pagingDTO.getPageSize());
	    	pagingDTO.setTotalCount(candidateService.getCandidateTotalCount(param));
		    List<Map<String, Object>> candidateList = candidateService.getCandidateList(param);
	    	
	    	mv.addObject("paging", pagingDTO);
	    	mv.addObject("candidateList", candidateList);
	    	mv.setViewName("admin/closed/closedCandidate");
	    }
	    
	    mv.addObject("base", param);
		return mv;
	}
	
	@ResponseBody
	@RequestMapping(value = "/admin/changePublicYn", method = RequestMethod.POST)
	public Map<String, Object> changePublicYn(@RequestParam Map<String, Object> param) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		String closedDataType = StringUtil.NVL(param.get("closedDataType"));
		int result = 0;
		
		if (StringUtils.equals(closedDataType, "P")) {
			result = positionService.changePublicYn(param);
		} else {
			result = candidateService.changePublicYn(param);
		}
		
		if (result == 1) {
			resultMap.put("result", "success");
		} 
		
		return resultMap;
	}
	
}
