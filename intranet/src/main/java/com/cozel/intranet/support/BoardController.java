package com.cozel.intranet.support;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.cozel.intranet.common.file.FileService;
import com.cozel.intranet.common.file.FileType;
import com.cozel.intranet.common.paging.PagingDTO;
import com.cozel.intranet.common.utils.StringUtil;
import com.cozel.intranet.support.service.BoardService;

@Controller
public class BoardController {
	
	@Autowired
	BoardService boardService;
	
	@Autowired
	private FileService fileService;
	
	@RequestMapping(value = "/support/noticeList", method = {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView noticeList(@RequestParam Map<String, Object> param, 
													@ModelAttribute("pagingDTO") PagingDTO pagingDTO,
	        										ModelAndView mv) {
	    String pageNo = StringUtil.NVL(param.get("pageNo"));
	    
        if(StringUtils.isNotEmpty(pageNo)){
            pagingDTO.setPageNo(Integer.parseInt(pageNo));
        }
        
        param.put("bodType", "1"); //공지사항
        param.put("startRowNum", pagingDTO.getStartRowNum());
        param.put("pageSize", pagingDTO.getPageSize());
        pagingDTO.setTotalCount(boardService.getBoardTotalCount(param));
	    List<Map<String, Object>> boardList = boardService.getBoardList(param);
	    
	    mv.addObject("search", param);
	    mv.addObject("paging", pagingDTO);
	    mv.addObject("boardList", boardList);
		mv.setViewName("support/noticeList");
		return mv;
	}
	
	@RequestMapping(value = {"/support/noticeDetail", "/support/notice"}, method = RequestMethod.GET)
	public ModelAndView notice(@RequestParam Map<String, Object> param, HttpSession session, HttpServletRequest request) {
		ModelAndView mv = new ModelAndView();
		@SuppressWarnings("unchecked")
		Map<String, String> userInfo =  (Map<String, String>) session.getAttribute("userInfo");
		
		Map<String, Object> getNotice = boardService.getBoard(param);
		String url = request.getRequestURI();
		String[] targetUrl = url.split("/");
		String viewNm = null;
		
		if (StringUtils.equals(targetUrl[2], "noticeDetail")) {
			viewNm = "noticeDetail";
		} else {
			viewNm = "notice";
		}

		mv.addObject("userInfo", userInfo);
		mv.addObject("getNotice", getNotice);
	    mv.setViewName("support/" + viewNm);    
		return mv;
	}
	
	@RequestMapping(value = "/support/setNotice", method = RequestMethod.POST)
	public ModelAndView setNotice(@RequestParam Map<String, Object> param, HttpServletRequest request, HttpSession session, ModelAndView mv) {
		@SuppressWarnings("unchecked")
		Map<String, String> userInfo =  (Map<String, String>) session.getAttribute("userInfo");
		param.put("conId", userInfo.get("CON_ID"));
		
		boardService.setBoard(param);
		
		try {
	        param.put("fileType", FileType.BOARD.getCode());
	        param.put("orgId", param.get("bodId"));
	        
	        fileService.uploadFile(param, request);	    
        } catch (Exception e) {
            e.printStackTrace();
        }
		
		mv.setViewName("redirect:/support/noticeList");    
		return mv;
	}
	
	@RequestMapping(value = "/support/modNotice", method = RequestMethod.POST)
	public ModelAndView modNotice(@RequestParam Map<String, Object> param, HttpServletRequest request, ModelAndView mv) {
		String bodId = StringUtil.NVL(param.get("bodId"));
		
		boardService.modBoard(param);
		
		try {
	        param.put("fileType", FileType.BOARD.getCode());
	        param.put("orgId", bodId);
	        
	        fileService.modFile(param, request);	    
        } catch (Exception e) {
            e.printStackTrace();
        }
		
		mv.setViewName("redirect:/support/noticeList");    
		return mv;
	}
	
	@RequestMapping(value = "/support/delNotice", method = RequestMethod.POST)
	public ModelAndView delNotice(@RequestParam Map<String, Object> param, ModelAndView mv) throws Exception {
		boardService.delBoard(param);
		fileService.delFile(param);
		
		mv.setViewName("redirect:/support/noticeList");
		return mv;
	}
	
	@RequestMapping(value = "/support/workDataList", method = {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView workDataList(@RequestParam Map<String, Object> param, 
	        										@ModelAttribute("pagingDTO") PagingDTO pagingDTO,
	        										ModelAndView mv) {
	    String pageNo = StringUtil.NVL(param.get("pageNo"));
	    
        if(StringUtils.isNotEmpty(pageNo)){
            pagingDTO.setPageNo(Integer.parseInt(pageNo));
        }
        
        param.put("bodType", "2"); //업무자료
        param.put("startRowNum", pagingDTO.getStartRowNum());
        param.put("pageSize", pagingDTO.getPageSize());
        pagingDTO.setTotalCount(boardService.getBoardTotalCount(param));
	    List<Map<String, Object>> workDataList = boardService.getBoardList(param);
	    
	    mv.addObject("search", param);
	    mv.addObject("paging", pagingDTO);
	    mv.addObject("workDataList", workDataList);
		mv.setViewName("support/workDataList");
		return mv;
	}
	
	@RequestMapping(value = {"/support/workDataDetail", "/support/workData"}, method = RequestMethod.GET)
	public ModelAndView workData(@RequestParam Map<String, Object> param, HttpSession session, HttpServletRequest request) {
		ModelAndView mv = new ModelAndView();
		@SuppressWarnings("unchecked")
		Map<String, String> userInfo =  (Map<String, String>) session.getAttribute("userInfo");
		
		Map<String, Object> getWorkData = boardService.getBoard(param);
		String url = request.getRequestURI();
		String[] targetUrl = url.split("/");
		String viewNm = null;
		
		if (StringUtils.equals(targetUrl[2], "workDataDetail")) {
			viewNm = "workDataDetail";
		} else {
			viewNm = "workData";
		}

		mv.addObject("userInfo", userInfo);
		mv.addObject("getWorkData", getWorkData);
	    mv.setViewName("support/" + viewNm);    
		return mv;
	}
	
	@RequestMapping(value = "/support/setWorkData", method = RequestMethod.POST)
	public ModelAndView setWorkData(@RequestParam Map<String, Object> param, HttpServletRequest request, HttpSession session, ModelAndView mv) {
		@SuppressWarnings("unchecked")
		Map<String, String> userInfo =  (Map<String, String>) session.getAttribute("userInfo");
		param.put("conId", userInfo.get("CON_ID"));
		
		
		boardService.setBoard(param);
		
		try {
	        param.put("fileType", FileType.BOARD.getCode());
	        param.put("orgId", param.get("bodId"));
	        
	        fileService.uploadFile(param, request);	    
        } catch (Exception e) {
            e.printStackTrace();
        }
		
		mv.setViewName("redirect:/support/workDataList");    
		return mv;
	}
	
	@RequestMapping(value = "/support/modWorkData", method = RequestMethod.POST)
	public ModelAndView modWorkData(@RequestParam Map<String, Object> param, HttpServletRequest request, ModelAndView mv) {
		String bodId = StringUtil.NVL(param.get("bodId"));
		
		boardService.modBoard(param);
		
		try {
	        param.put("fileType", FileType.BOARD.getCode());
	        param.put("orgId", bodId);
	        
	        fileService.modFile(param, request);	    
        } catch (Exception e) {
            e.printStackTrace();
        }
		
		mv.setViewName("redirect:/support/workDataList");    
		return mv;
	}
	
	@RequestMapping(value = "/support/delWorkData", method = RequestMethod.POST)
	public ModelAndView delWorkData(@RequestParam Map<String, Object> param, ModelAndView mv) {
		boardService.delBoard(param);
		
		try {
            fileService.delFile(param);
        } catch (Exception e) {
            e.printStackTrace();
        }
		
		mv.setViewName("redirect:/support/workDataList");
		return mv;
	}
	
}
