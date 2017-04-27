package com.cozel.intranet.common.comment;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.cozel.intranet.common.utils.DateUtil;

@Controller
public class CommentController {

	@Autowired
	private CommentService commentService;
	
	@RequestMapping(value = "/comment/setComment", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> setCompany(@RequestParam Map<String, Object> param, HttpSession session) {
		Map<String, Object> hm = new HashMap<String, Object>();
		@SuppressWarnings("unchecked")
		Map<String, String> userInfo =  (Map<String, String>) session.getAttribute("userInfo");
		String conId = userInfo.get("CON_ID");
		
		try {
			Date date = new Date();
			String currentTime = DateUtil.getCurrentTime(date, "yyyy-MM-dd HH:mm:ss");
			
			param.put("regDate", currentTime);
			param.put("conId", conId);
			commentService.setComment(param);
			
			hm.put("regDate", DateUtil.getCurrentTime(date, "yyyy-MM-dd"));
			hm.put("conNm", userInfo.get("CON_NM"));
			hm.put("contents", String.valueOf(param.get("contents")).replaceAll("\n", "<br>"));
			hm.put("cmtId", param.get("cmtId"));
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return hm;
	}
	
	@RequestMapping(value = "/comment/modComment", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> modComment(@RequestParam Map<String, Object> param, HttpSession session) {
		Map<String, Object> hm = new HashMap<String, Object>();
		@SuppressWarnings("unchecked")
		Map<String, String> userInfo =  (Map<String, String>) session.getAttribute("userInfo");
		
		try {
			Date date = new Date();
			String currentTime = DateUtil.getCurrentTime(date, "yyyy-MM-dd HH:mm:ss");
			
			param.put("regDate", currentTime);
			commentService.modComment(param);
			
			hm.put("regDate", DateUtil.getCurrentTime(date, "yyyy-MM-dd"));
			hm.put("conNm", userInfo.get("CON_NM"));
			hm.put("contents", String.valueOf(param.get("contents")).replaceAll("\n", "<br>"));
			hm.put("cmtId", param.get("cmtId"));
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return hm;
	}
	
	@RequestMapping(value = "/comment/delComment", method = RequestMethod.POST)
	public @ResponseBody void delCompany(@RequestParam Map<String, Object> param) {
		commentService.delComment(param);
	}
}
