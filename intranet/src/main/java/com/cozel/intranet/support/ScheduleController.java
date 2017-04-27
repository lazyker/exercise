package com.cozel.intranet.support;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.cozel.intranet.common.file.FileService;
import com.cozel.intranet.common.file.FileType;
import com.cozel.intranet.common.utils.DateUtil;
import com.cozel.intranet.common.utils.StringUtil;
import com.cozel.intranet.support.service.ScheduleService;

@Controller
public class ScheduleController {
	
	@Autowired
	ScheduleService scheduleService;
	
	@Autowired
	private FileService fileService;
	
	@RequestMapping(value = "/support/schedule", method = {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView schedule(@RequestParam Map<String, Object> param) throws Exception {
		ModelAndView mv = new ModelAndView();
        Date date = new Date();
	    int defaultYear = Integer.parseInt(DateUtil.getYear(date));
	    String defaultMonth = DateUtil.getMonth(DateUtil.addMonth(date, -1));
	    String year = StringUtil.NVL(param.get("year"), String.valueOf(defaultYear));
	    String month = StringUtil.NVL(param.get("month"), defaultMonth); 
	    
	    param.put("year", year);
	    param.put("month", month);
//	    List<Map<String, Object>> scheduleList = scheduleService.getScheduleList(param);
	    
	    mv.addObject("search", param);
//	    mv.addObject("scheduleList", scheduleList);
		mv.setViewName("support/schedule");
		return mv;
	}
	
//	@ResponseBody
//	@RequestMapping(value = "/support/scheduleList", method = RequestMethod.GET)
//	public List<Map<String, Object>> scheduleList(@RequestParam Map<String, Object> param, HttpSession session) {
//		List<Map<String, Object>> scheduleList = scheduleService.getScheduleList(param);
//		return scheduleList;
//	}
	
	@RequestMapping(value = "/support/scheduleList", method = RequestMethod.GET)
    public ModelAndView scheduleList(@RequestParam Map<String, Object> param) {
        ModelAndView mav = new ModelAndView();
        List<Map<String, Object>> scheduleList = scheduleService.getScheduleList(param);
        mav.addObject("scheduleList", scheduleList);
        mav.setViewName("jsonView");
        return mav;
    }
	
	@RequestMapping(value = "/support/scheduleWritePop", method = RequestMethod.GET) 
	public ModelAndView scheduleWritePop(@RequestParam Map<String, Object> param, HttpSession session) {
		ModelAndView mv = new ModelAndView();
		@SuppressWarnings("unchecked")
		Map<String, String> userInfo =  (Map<String, String>) session.getAttribute("userInfo");
		String schId = StringUtil.NVL(param.get("schId"));
		Map<String, Object> scheduleData = null;
		
		if (StringUtils.isNotEmpty(schId)) {
			scheduleData = scheduleService.getSchedule(param);
		} else { 
			scheduleData = new HashMap<String, Object>();
			scheduleData.put("START_YMD", param.get("startYmd"));
			scheduleData.put("END_YMD", param.get("endYmd"));
			scheduleData.put("START_TM", DateUtil.addMinuteStep("startTm", 30));
			scheduleData.put("END_TM", DateUtil.addMinuteStep("endTm", 30));
		}
		
		mv.addObject("scheduleData", scheduleData);
		mv.addObject("userInfo", userInfo);
		mv.setViewName("pop/support/scheduleWritePop");
		return mv;
	}
	
	@ResponseBody
	@RequestMapping(value = "/support/setSchedule", method = RequestMethod.POST)
	public Map<String, Object> setSchedule(@RequestParam Map<String, Object> param, HttpServletRequest request, HttpSession session) {
		@SuppressWarnings("unchecked")
		Map<String, String> userInfo =  (Map<String, String>) session.getAttribute("userInfo");
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		param.put("conId", userInfo.get("CON_ID"));
		param.put("publicYn", "Y");
		int result = scheduleService.setSchedule(param);
		
		try {
	        param.put("fileType", FileType.SCHEDULE.getCode());
	        param.put("orgId", param.get("schId"));
	        
	        fileService.uploadFile(param, request);	    
        } catch (Exception e) {
            e.printStackTrace();
        }
		
		if (result == 1) {
			resultMap.put("result", "success");
		}
		
		return resultMap;
	}
	
	@ResponseBody
	@RequestMapping(value = "/support/modSchedule", method = RequestMethod.POST)
	public Map<String, Object> modSchedule(@RequestParam Map<String, Object> param, HttpServletRequest request) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		int result = scheduleService.modSchedule(param);
		
		try {
	        param.put("fileType", FileType.BOARD.getCode());
	        param.put("orgId", param.get("schId"));
	        
	        fileService.modFile(param, request);
        } catch (Exception e) {
            e.printStackTrace();
        }
		
		if (result == 1) {
			resultMap.put("result", "success");
		}
		
		return resultMap;
	}
	
	@ResponseBody
	@RequestMapping(value = "/support/delSchedule", method = RequestMethod.POST)
	public Map<String, Object> delSchedule(@RequestParam Map<String, Object> param) throws Exception {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		int result = scheduleService.delSchedule(param);
		
		if (result == 1) {
			fileService.delFile(param);
			resultMap.put("result", "success");
		}
		
		return resultMap;
	}
	
}
