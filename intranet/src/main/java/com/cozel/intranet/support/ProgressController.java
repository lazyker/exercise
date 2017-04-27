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
import com.cozel.intranet.support.service.ProgressService;

@Controller
public class ProgressController {
	
	@Autowired
	ProgressService progressService;
	
	@RequestMapping(value = "/support/progress", method = {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView progress(@RequestParam Map<String, Object> param,
												HttpSession session,
	        									@ModelAttribute("pagingDTO") PagingDTO pagingDTO) {
		ModelAndView mv = new ModelAndView();
		@SuppressWarnings("unchecked")
		Map<String, String> userInfo =  (Map<String, String>) session.getAttribute("userInfo");
		String adminYn = userInfo.get("ADMIN_YN");
		String authPosition = userInfo.get("AUTH_POSITION");
		String conId = userInfo.get("CON_ID");
	    String pageNo = StringUtil.NVL(param.get("pageNo"));
	    String state = StringUtil.NVL(param.get("state"), "A"); //default 추천
	    
        if(StringUtils.isNotEmpty(pageNo)){
            pagingDTO.setPageNo(Integer.parseInt(pageNo));
        }
        
        param.put("state", state);
        param.put("adminYn", adminYn);
        param.put("authPosition", authPosition);
        param.put("conId", conId);
        param.put("sconId", conId);
        param.put("startRowNum", pagingDTO.getStartRowNum());
        param.put("pageSize", pagingDTO.getPageSize());
        pagingDTO.setTotalCount(progressService.getProgressTotalCount(param));
	    List<Map<String, Object>> progressList = progressService.getProgressList(param);
	    
	    mv.addObject("search", param);
	    mv.addObject("paging", pagingDTO);
	    mv.addObject("progressList", progressList);
		mv.setViewName("support/progress");
		return mv;
	}
	
}
