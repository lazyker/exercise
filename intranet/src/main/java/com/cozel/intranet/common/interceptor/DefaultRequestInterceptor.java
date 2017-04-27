package com.cozel.intranet.common.interceptor;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import com.cozel.intranet.common.utils.RequestUtil;

public class DefaultRequestInterceptor implements HandlerInterceptor {
	protected Log log = LogFactory.getLog(DefaultRequestInterceptor.class);
	
    @Autowired
    private RequestUtil requestUtil;
	
	@Override
	public boolean preHandle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o) throws Exception {
		String url = httpServletRequest.getRequestURI();
		log.debug("Request URI \t: " + url);
		requestUtil.setValue(httpServletRequest);
		
		HttpSession session = httpServletRequest.getSession(false);
		
		if (session == null && url.indexOf("/login") == -1) {
			log.debug("session ->>>>>>>>> " + session);
			httpServletResponse.sendRedirect(httpServletRequest.getContextPath() + "/login");
			return false;
		}
		
		if (session != null) {
			@SuppressWarnings("unchecked")
			Map<String, Object> userInfo =  (Map<String, Object>) session.getAttribute("userInfo");
			log.debug("userInfo ->>>>>>>>> " + userInfo);
			if (userInfo == null && url.indexOf("/login") == -1) {
				httpServletResponse.sendRedirect(httpServletRequest.getContextPath() + "/login");
				return false;
			}
		}
		
		return true;
	}
	
	@Override
	public void postHandle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, ModelAndView modelAndView)
			throws Exception {
		
	}
	
	@Override
	public void afterCompletion(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, Exception e)
			throws Exception {
		
	}

}
