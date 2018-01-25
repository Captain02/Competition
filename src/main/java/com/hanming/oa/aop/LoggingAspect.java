package com.hanming.oa.aop;

import org.apache.shiro.SecurityUtils;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.After;
import org.aspectj.lang.annotation.Aspect;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

@Aspect
@Component
public class LoggingAspect {
	private static final Logger logger = LoggerFactory.getLogger(LoggingAspect.class);

	@After("execution(* com.hanming.oa.controller..*.*(..))")
	public void afterMethod(JoinPoint joinPoint) {
		String methodName = joinPoint.getSignature().getName();
		String username = (String) SecurityUtils.getSubject().getSession().getAttribute("username");
		logger.info("=============" + username + " 执行 " + methodName + "=============");
	}
}
