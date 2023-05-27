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
public class XContentTypeOptionsFilter implements Filter {

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		 HttpServletResponse httpResponse = (HttpServletResponse) response;
		 // Không thực hiện bất kỳ kiểm tra tự động tài nguyên được trả về từ máy chủ.
		 httpResponse.setHeader("X-Content-Type-Options", "nosniff");
		 chain.doFilter(request, response);
	}

}
