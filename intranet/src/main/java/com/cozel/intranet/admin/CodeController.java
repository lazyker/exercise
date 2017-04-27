package com.cozel.intranet.admin;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.support.RequestContextUtils;

import com.cozel.intranet.admin.service.CodeService;
import com.cozel.intranet.common.utils.StringUtil;

@Controller
public class CodeController {
	
	private static final Logger logger = LoggerFactory.getLogger(CodeController.class);
	
	@Autowired
	private CodeService codeService;
	
	@RequestMapping(value = "/admin/codeList")
	public ModelAndView consultantList(@RequestParam Map<String, Object> param, HttpServletRequest request, ModelAndView mv) {
	    String cdType = StringUtil.NVL(param.get("cdType"), "1");
	    
	    Map<String, ?> fm = RequestContextUtils.getInputFlashMap(request);
	    if (fm != null) {
	        cdType = (String) fm.get("cdType");
	    }
	    
	    param.put("cdType", cdType);
	    List<Map<String, Object>> codeParentList = codeService.getCodeList(param);
	    
	    mv.addObject("codeParentList", codeParentList);
	    mv.addObject("cdType", cdType);
		mv.setViewName("admin/code/codeList");
		
		return mv;
	}
	
	@RequestMapping(value = "/admin/childList")
    public @ResponseBody List<Map<String, Object>> childList(@RequestParam Map<String, Object> param, ModelAndView mv) {
        List<Map<String, Object>> codeChildList = codeService.getCodeList2(param);
        return codeChildList;
    }
	
	@RequestMapping(value="/admin/setParentCode", method = RequestMethod.POST) 
	public ModelAndView setCode(@RequestParam Map<String, Object> param, HttpServletRequest request, ModelAndView mv) {
	    String parentCdNm = StringUtil.NVL(param.get("parentCdNm"));
	    String cdType = StringUtil.NVL(param.get("cdType"));
	    
	    if (!StringUtils.equals(parentCdNm, "")) {
	        param.put("cdNm",parentCdNm);
	    }
	    
	    codeService.setCode(param);
	    
	    Map<String, Object> fm = RequestContextUtils.getOutputFlashMap(request);
	    fm.put("cdType", cdType);
	    
	    mv.setViewName("redirect:/admin/codeList");
	    return mv;
	}
	
   @RequestMapping(value = "/admin/setChildCode")
    public @ResponseBody Map<String, Object> setChildCode(@RequestParam Map<String, Object> param, ModelAndView mv) {
       String childCdNm = StringUtil.NVL(param.get("childCdNm"));
       
       if (!StringUtils.equals(childCdNm, "")) {
           param.put("cdNm",childCdNm);
       }
       
       codeService.setCode(param);
       
       Map<String, Object> hm = new HashMap<String, Object>();
       hm.put("result", param);
       
       return hm;
    }
	
	@RequestMapping(value="/admin/dragCode", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> dragCode(@RequestBody List<Map<String, Object>> list){
	    Map<String, Object> jsonObject = new HashMap<String, Object>();
	    
	    codeService.dragCode(list);
	    
	    return jsonObject;
	}
	
	@RequestMapping(value="/admin/delCode", method = RequestMethod.POST) 
    public @ResponseBody Map<String, Object> delCode(@RequestParam Map<String, Object> param, ModelAndView mv) {
	    Map<String, Object> hm = new HashMap<String, Object>();
	    
        codeService.delCode(param);
        
        hm.put("result", "success");
        return hm;
    }
}
