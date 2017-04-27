package com.cozel.intranet.common.sms;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.cozel.intranet.common.utils.DateUtil;
import com.cozel.intranet.common.utils.StringUtil;

@Controller
public class SmsController {
    
    @Autowired
    private SmsService smsService;
    
	@RequestMapping(value = "/common/smsSend", method = RequestMethod.POST)
	public ModelAndView smsSend(@RequestParam Map<String, Object> param, HttpSession session) { 
		ModelAndView mv = new ModelAndView();
		@SuppressWarnings("unchecked")
		Map<String, String> userInfo =  (Map<String, String>) session.getAttribute("userInfo");
		String tranType = StringUtil.NVL(param.get("tranType"));
		String toMessage	= "";

		if (StringUtils.equals(tranType, "4")) {
			toMessage = StringUtil.NVL(param.get("toMessage1"));
			param.put("toMessage", toMessage);
		} else {
			toMessage = StringUtil.NVL(param.get("toMessage2"));
			param.put("toMessage", toMessage);
			smsService.mmsSend(param);
		}
		
		param.put("conId", userInfo.get("CON_ID"));
		
		int result = smsService.smsSend(param);
		mv.addObject("result", result);
        mv.setViewName("jsonView");
        
        return mv;
    }
	
	@RequestMapping(value = "/support/smsHistory", method = {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView smsHistory(@RequestParam Map<String, Object> param, HttpSession session) throws Exception {
		ModelAndView mv = new ModelAndView();
		@SuppressWarnings("unchecked")
		Map<String, String> userInfo =  (Map<String, String>) session.getAttribute("userInfo");
		Date date = new Date();
	    int defaultYear = Integer.parseInt(DateUtil.getYear(date));
	    String defaultMonth = DateUtil.getMonth(date);
	    String year = StringUtil.NVL(param.get("year"), String.valueOf(defaultYear));
	    String month = StringUtil.NVL(param.get("month"), defaultMonth);
	    String adminYn = StringUtil.NVL(userInfo.get("ADMIN_YN"));
	    
	    List<Map<String, Object>> yearList = new ArrayList<Map<String, Object>>();
	    for (int i = defaultYear; i >= 2017; i--) {
	    	Map<String, Object> yearMap = new HashMap<String, Object>();
	    	yearMap.put("YEAR", String.valueOf(i));
	    	yearList.add(yearMap);
	    }
	    
		String sDate = StringUtil.NVL(year +"-" + month + "-" + "01");
		String eDate = StringUtil.NVL(year +"-" + month + "-" + "31");
		
		param.put("adminYn", adminYn);
		param.put("year", year);
		param.put("month", month);
		param.put("sDate", sDate);
		param.put("eDate", eDate);
		param.put("s_key", "em_log_" + year + month);
        param.put("conId", userInfo.get("CON_ID"));
	    List<Map<String, Object>> smsHistory = smsService.getSmsHistory(param);
        
	    mv.addObject("yearList", yearList);
        mv.addObject("search", param);
	    mv.addObject("smsHistory", smsHistory);
		mv.setViewName("support/smsHistory");
		return mv;
	}
}
