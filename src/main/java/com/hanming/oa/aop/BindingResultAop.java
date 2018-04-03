package com.hanming.oa.aop;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.stereotype.Component;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;

import com.hanming.oa.Tool.Msg;

/*
 * 用于字段校验
 * */

@Aspect
@Component
public class BindingResultAop {

	@Around("execution(* com.hanming.oa.controller..*.*(..))")
	public Object around(ProceedingJoinPoint joinPoint) throws Throwable {
		BindingResult result = null;
		for (Object arg : joinPoint.getArgs()) {
			if (arg instanceof BindingResult) {
				result = (BindingResult) arg;
			}
		}
		if (result != null) {
			if (result.hasErrors()) {
				Map<String, Object> map = new HashMap<>();
				List<FieldError> errors = result.getFieldErrors();
				if (errors.size() > 0) {
					for (FieldError fieldError : errors) {
						map.put(fieldError.getField(), fieldError.getDefaultMessage());
					}
					return Msg.fail().add("errorFields", map);
				}
			}
		}
		return joinPoint.proceed();
	}
}
