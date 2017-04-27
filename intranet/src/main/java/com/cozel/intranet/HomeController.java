package com.cozel.intranet;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	@Autowired
	private HomeDao homedao;
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/getToday", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		logger.info("db test {}.", model);
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		String today = homedao.getToday();
		
		
		model.addAttribute("today", today );
		model.addAttribute("serverTime", formattedDate );
		
		return "home";
	}
	
    @RequestMapping(value = "/ip", method = RequestMethod.GET)
    public String home(Model model) {  
        HttpServletRequest req = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
        String ip = req.getHeader("X-FORWARDED-FOR"); 
        
        if (ip == null || ip.length() == 0) {
            ip = req.getHeader("Proxy-Client-IP");
        }

        if (ip == null || ip.length() == 0) {
            ip = req.getHeader("WL-Proxy-Client-IP");  // 웹로직
        }

        if (ip == null || ip.length() == 0) {
            ip = req.getRemoteAddr() ;
        }
         
        model.addAttribute("clientIP", ip);
        return "home";
    }
	
	
}
