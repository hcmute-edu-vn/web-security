package com.shoplane.controllers.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletResponse;

//@WebFilter("/*")
public class ContentSecurityPolicyFilter implements Filter {

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		 HttpServletResponse httpResponse = (HttpServletResponse) response;
		 // Cho phép tất cả các nguồn và tài nguyên 
		 httpResponse.setHeader(
				 "Content-Security-Policy", 
				 "default-src 'self' *; script-src 'self' *; style-src 'self' *; "
				 + "img-src 'self' *; font-src 'self' *; connect-src 'self' *; "
				 + "frame-src 'self' *; media-src 'self' *; object-src 'self' *; child-src 'self' *;");
		 chain.doFilter(request, response);
	}

}
