package com.shoplane.controllers.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletResponse;

@WebFilter("/*")
public class XFrameOptionsFilter implements Filter {

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		 HttpServletResponse httpResponse = (HttpServletResponse) response;
		 // Không cho phép trang web được nhúng trong một frame hoặc iframe.
		 httpResponse.setHeader("X-Frame-Options", "DENY");
		 chain.doFilter(request, response);
	}

}
