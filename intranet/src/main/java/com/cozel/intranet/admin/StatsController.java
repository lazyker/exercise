package com.cozel.intranet.admin;

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

import com.cozel.intranet.admin.service.ConsultantService;
import com.cozel.intranet.admin.service.StatsService;
import com.cozel.intranet.common.paging.PagingDTO;
import com.cozel.intranet.common.utils.StringUtil;

@Controller
public class StatsController {
	
	@Autowired
	StatsService statsService;
	
	@Autowired
	ConsultantService consultantService;
	
	@RequestMapping(value = "/admin/loginStats", method = {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView loginStats(@RequestParam Map<String, Object> param,
												HttpSession session,
	        									@ModelAttribute("pagingDTO") PagingDTO pagingDTO) {
		ModelAndView mv = new ModelAndView();
	    String pageNo = StringUtil.NVL(param.get("pageNo"));
	    
        if(StringUtils.isNotEmpty(pageNo)){
            pagingDTO.setPageNo(Integer.parseInt(pageNo));
        }
        
        List<Map<String, Object>> consultantList = consultantService.getConsultantList(param);
        
        param.put("startRowNum", pagingDTO.getStartRowNum());
        param.put("pageSize", pagingDTO.getPageSize());
        pagingDTO.setTotalCount(statsService.getLoginStatsTotalCount(param));
	    List<Map<String, Object>> loginStatsList = statsService.getLoginStatsList(param);
	    
	    mv.addObject("search", param);
	    mv.addObject("paging", pagingDTO);
	    mv.addObject("loginStatsList", loginStatsList);
	    mv.addObject("consultantList", consultantList);
		mv.setViewName("admin/stats/loginStatsList");
		return mv;
	}
	
//	@RequestMapping(value = "/support/markPop", method = RequestMethod.GET)
//    public ModelAndView markPop(@RequestParam Map<String, Object> param, 
//    											HttpSession session, 
//    											@ModelAttribute("pagingDTO") PagingDTO pagingDTO) throws Exception {
//		ModelAndView mv = new ModelAndView();
//		@SuppressWarnings("unchecked")
//		Map<String, String> userInfo =  (Map<String, String>) session.getAttribute("userInfo");
//		String adminYn = userInfo.get("ADMIN_YN");
//		String authUser = userInfo.get("AUTH_USER");
//		String conId = userInfo.get("CON_ID");
//        String comNm = StringUtil.NVL(param.get("usrNm"));
//        String pageNo = StringUtil.NVL(param.get("pageNo"));
//        
//        if(StringUtils.isNotEmpty(pageNo)){
//            pagingDTO.setStartRowNum((Integer.parseInt(pageNo)-1) * 5);
//        }
//        
//        param.put("adminYn", adminYn);
//        param.put("authUser", authUser);
//        param.put("usrId", conId);
//        param.put("conId", conId);
//        pagingDTO.setPageSize(5);
//        pagingDTO.setBlockSize(5);
//        param.put("startRowNum", pagingDTO.getStartRowNum());
//        param.put("pageSize", pagingDTO.getPageSize());
//        pagingDTO.setTotalCount(positionService.getCandidatePopTotalCount(param));
//        
//        List<Map<String, Object>> tmpList = positionService.getCandidatePopList(param);
//        List<Map<String, Object>> candidateList = new ArrayList<Map<String, Object>>();
//        for (Map<String, Object> hm : tmpList) {
//        	hm.put("MOBILE", AES128Util.decrypt(String.valueOf(hm.get("MOBILE"))));
//	    	
//	    	candidateList.add(hm);
//        }
//        
//        mv.addObject("comNm", comNm);
//        mv.addObject("paging", pagingDTO);
//        mv.addObject("candidateList", candidateList);
//        mv.setViewName("pop/support/markPop");    
//        return mv;
//    }
//	
//	@ResponseBody
//	@RequestMapping(value = "/support/setMark", method = RequestMethod.POST)
//	public Map<String, Object> setMark(@RequestParam Map<String, Object> param, HttpSession session) {
//		@SuppressWarnings("unchecked")
//		Map<String, String> userInfo =  (Map<String, String>) session.getAttribute("userInfo");
//		Map<String, Object> resultMap = new HashMap<String, Object>();
//		
//		param.put("conId", userInfo.get("CON_ID"));
//		int cnt = markService.getMarkTotalCount(param);
//		if (cnt == 0) { 
//			int result = markService.setMark(param);
//			if (result == 1) {
//				resultMap.put("result", "success");
//				resultMap.put("markId", param.get("markId"));
//			} 
//		} else {
//			resultMap.put("result", "fail");
//		}
//		
//		return resultMap;
//	}
//	
//	@ResponseBody
//	@RequestMapping(value = "/support/delMark", method = RequestMethod.POST)
//	public Map<String, Object> delMark(@RequestParam(value="markIdArr[]", required=false) List<String> markIdArr,
//														HttpSession session,
//														@RequestParam Map<String, Object> param) {
//		@SuppressWarnings("unchecked")
//		Map<String, String> userInfo =  (Map<String, String>) session.getAttribute("userInfo");
//		Map<String, Object> resultMap = new HashMap<String, Object>();
//		
//		param.put("conId", userInfo.get("CON_ID"));
//		int result = 0;
//		if (markIdArr !=  null) 
//		{
//			for (String value : markIdArr) {
//				param.put("markId", value);
//				
//				result = markService.delMark(param);
//				if (result != 1) { resultMap.put("result", "fail"); }
//			}
//		}
//		else 
//		{
//			result = markService.delMark(param);
//		}
//		
//		if (result == 1) {
//			resultMap.put("result", "success");
//		}
//		
//		return resultMap;
//	}	
//	@RequestMapping(value = "/support/modNotice", method = RequestMethod.POST)
//	public ModelAndView modNotice(@RequestParam Map<String, Object> param, HttpServletRequest request, ModelAndView mv) {
//		String bodId = StringUtil.NVL(param.get("bodId"));
//		
//		boardService.modBoard(param);
//		
//		try {
//	        param.put("fileType", FileType.BOARD.getCode());
//	        param.put("orgId", bodId);
//	        
//	        fileService.modFile(param, request);	    
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//		
//		mv.setViewName("redirect:/support/noticeList");    
//		return mv;
//	}
//	
//	@RequestMapping(value = "/support/delNotice", method = RequestMethod.POST)
//	public ModelAndView delNotice(@RequestParam Map<String, Object> param, ModelAndView mv) {
//		boardService.delBoard(param);
//		
//		try {
//            fileService.delFile(param);
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//		
//		mv.setViewName("redirect:/support/noticeList");
//		return mv;
//	}
	
}
