package com.hanming.oa.filter;

import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.subject.Subject;
import org.apache.shiro.web.filter.AccessControlFilter;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class ResourceCheckFilter extends AccessControlFilter {
	private static final Logger logger = LoggerFactory.getLogger(ResourceCheckFilter.class);

	private String errorUrl;

	public String getErrorUrl() {
		return errorUrl;
	}

	public void setErrorUrl(String errorUrl) {
		this.errorUrl = errorUrl;
	}

	@Override
	protected boolean isAccessAllowed(ServletRequest servletRequest, ServletResponse servletResponse, Object object)
			throws Exception {

		Subject subject = getSubject(servletRequest, servletResponse);
		String url = getPathWithinApplication(servletRequest);
		logger.info("正在访问的Url" + url);
		System.out.println("=================================" + url);
		return subject.isPermitted(url);
	}

	//出现错误跳转页面
	@Override
	protected boolean onAccessDenied(ServletRequest servletRequest, ServletResponse servletResponse) throws Exception {
		HttpServletRequest request = (HttpServletRequest) servletRequest;
		HttpServletResponse response = (HttpServletResponse) servletResponse;
		response.sendRedirect(request.getContextPath() + this.errorUrl);

		return false;
	}

}
