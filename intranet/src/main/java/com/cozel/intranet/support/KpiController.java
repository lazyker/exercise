package com.cozel.intranet.support;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.time.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.cozel.intranet.common.utils.DateUtil;
import com.cozel.intranet.common.utils.StringUtil;
import com.cozel.intranet.support.service.KpiService;

@Controller
public class KpiController {
	
	@Autowired
	KpiService kpiService;
	
	@RequestMapping(value = "/support/kpi", method = {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView kpi(@RequestParam Map<String, Object> param) throws Exception {
		ModelAndView mv = new ModelAndView();
        Date date = new Date();
	    int defaultYear = Integer.parseInt(DateUtil.getYear(date));
	    String defaultMonth = DateUtil.getMonth(date);
	    String year = StringUtil.NVL(param.get("year"), String.valueOf(defaultYear));
	    String month = StringUtil.NVL(param.get("month"), defaultMonth); 
	    
	    List<Map<String, Object>> yearList = new ArrayList<Map<String, Object>>();
	    for (int i = defaultYear; i >= 2017; i--) {
	    	Map<String, Object> yearMap = new HashMap<String, Object>();
	    	yearMap.put("YEAR", String.valueOf(i));
	    	yearList.add(yearMap);
	    }
	    
	    param.put("year", year);
	    param.put("month", month);
	    param.put("dt", year+month);
	    List<Map<String, Object>> kpiList = kpiService.getKpiList(param);
	    
	    mv.addObject("search", param);
	    mv.addObject("kpiList", kpiList);
	    mv.addObject("yearList", yearList);
		mv.setViewName("support/kpi");
		return mv;
	}
	
}
