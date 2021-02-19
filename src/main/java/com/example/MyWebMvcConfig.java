package com.example;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.example.interceptor.AjaxLoginCheckInterceptor;
import com.example.interceptor.MemberLoginCheckInterceptor;
import com.example.interceptor.MemberStayLoggedInInterceptor;

@Configuration
public class MyWebMvcConfig implements WebMvcConfigurer {

	@Autowired
	private  MemberLoginCheckInterceptor memberLoginCheckInterceptor;
	@Autowired
	private MemberStayLoggedInInterceptor memberStayLoggedInInterceptor;
	@Autowired
	private AjaxLoginCheckInterceptor ajaxLoginCheckInterceptor;

	@Override
	public void addInterceptors(InterceptorRegistry registry) {
		// 회원 로그인 확인 인터셉터 등록하기
		InterceptorRegistration registration = registry.addInterceptor(memberLoginCheckInterceptor);
		// 인터셉터가 수행될 URL 주소 경로 추가
//		registration.addPathPatterns("/notice/write");
		registration.addPathPatterns("/fileNotice/*");
		// 인터셉터 수행에서 제외할 URL 주소 경로 추가
		registration.excludePathPatterns("/fileNotice/list", "/fileNotice/content");


		registry.addInterceptor(ajaxLoginCheckInterceptor)
		.addPathPatterns("/comment/*")
		.excludePathPatterns("/comment/one/*", "/comment/pages/*")
		.excludePathPatterns("/mcomment/one/*", "/mcomment/pages/*");


		// 회원 로그인 상태유지 인터셉터 등록하기
		registry.addInterceptor(memberStayLoggedInInterceptor)
		.addPathPatterns("/*");
	} // addInterceptors

}
