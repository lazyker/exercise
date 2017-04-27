package com.cozel.intranet;

import java.util.Locale;

import javax.validation.Valid;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.cozel.intranet.admin.vo.ConsultantVo;

@Controller
public class ValidationTestController {
	
	private static final Logger logger = LoggerFactory.getLogger(ValidationTestController.class);
	
	@RequestMapping(value = "/validationTest", method = RequestMethod.GET)
	public ModelAndView validationTest(Locale locale, Model model) {
		ModelAndView mav = new ModelAndView();
		
		mav.addObject("consultantVo", new ConsultantVo());
		mav.setViewName("test");
		
		return mav;
	}
	
	@RequestMapping(value = "/validationSave", method = RequestMethod.POST)
	public String validationSave(Locale locale, @Valid ConsultantVo consultantVo, BindingResult bindingResult, Model model) {
		
		if (bindingResult.hasErrors()) {
			logger.debug("AAA");
		}else
			logger.debug("BBB");
		
		return "test";
	}
	
}
