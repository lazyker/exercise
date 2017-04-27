package com.cozel.intranet.support;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.cozel.intranet.common.paging.PagingDTO;
import com.cozel.intranet.common.utils.StringUtil;
import com.cozel.intranet.support.service.WorkReportService;

@Controller
public class WorkReportController {
	
	@Autowired
	WorkReportService workReportService;
	
	@RequestMapping(value = "/support/workReport", method = {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView workReport(@RequestParam Map<String, Object> param,
												HttpSession session,
	        									@ModelAttribute("pagingDTO") PagingDTO pagingDTO) {
		ModelAndView mv = new ModelAndView();
		@SuppressWarnings("unchecked")
		Map<String, String> userInfo =  (Map<String, String>) session.getAttribute("userInfo");
	    String pageNo = StringUtil.NVL(param.get("pageNo"));
	    
        if(StringUtils.isNotEmpty(pageNo)){
            pagingDTO.setPageNo(Integer.parseInt(pageNo));
        }
        
        param.put("conId", userInfo.get("CON_ID"));
        param.put("startRowNum", pagingDTO.getStartRowNum());
        param.put("pageSize", pagingDTO.getPageSize());
        pagingDTO.setTotalCount(workReportService.getWorkReportTotalCount(param));
	    List<Map<String, Object>> workReportList = workReportService.getWorkReportList(param);
	    
	    mv.addObject("paging", pagingDTO);
	    mv.addObject("workReportList", workReportList);
		mv.setViewName("support/workReport");
		return mv;
	}
	
}
