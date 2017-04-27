package com.cozel.intranet.support;

import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.cozel.intranet.common.paging.PagingDTO;
import com.cozel.intranet.common.utils.StringUtil;

@Controller
public class SupportController {
	
	
	private static final Logger logger = LoggerFactory.getLogger(SupportController.class);
	
	@RequestMapping(value = "/support/support", method = {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView candidateList(@RequestParam Map<String, Object> param, 
	        										@ModelAttribute("pagingDTO") PagingDTO pagingDTO,
	        										ModelAndView mv) {
	    String pageNo = StringUtil.NVL(param.get("pageNo"));
	    
        if(StringUtils.isNotEmpty(pageNo)){
            pagingDTO.setPageNo(Integer.parseInt(pageNo));
        }
        
        param.put("startRowNum", pagingDTO.getStartRowNum());
        param.put("pageSize", pagingDTO.getPageSize());
//        pagingDTO.setTotalCount(candidateService.getCandidateTotalCount(param));
//	    List<Map<String, Object>> candidateList = candidateService.getCandidateList(param);
	    
//	    mv.addObject("codeMap", codeMap);
	    mv.addObject("search", param);
	    mv.addObject("paging", pagingDTO);
//	    mv.addObject("candidateList", candidateList);
		mv.setViewName("support/noticeList");
		return mv;
	}
	
}
