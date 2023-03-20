package com.shoplane.controllers.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.shoplane.models.User;
import com.shoplane.utils.Constants;

public class AuthorizationFilterServlet implements Filter {
  private ServletContext servletContext = null;

  @Override
  public void init(FilterConfig filterConfig) throws ServletException {
    // TODO Auto-generated method stub
    Filter.super.init(filterConfig);
    this.servletContext = filterConfig.getServletContext();
  }

  @Override
  public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain chain)
      throws IOException, ServletException {

    // Convert to Http
    HttpServletRequest request = (HttpServletRequest) servletRequest;
    HttpServletResponse response = (HttpServletResponse) servletResponse;

    // Get uri
    String url = request.getRequestURI();
    String filterMsg = "";

    // Check
    if (url.contains("/system")) {
      User user = (User) request.getSession().getAttribute(Constants.USER_SESSION);
      if (user != null) {
        System.out.println("Hello world 2");
        // If admin
        if (user.getRole().getRoleId().equals(Constants.ADMIN_ROLE)) {
          chain.doFilter(request, response);
        } else {
          // Normal user => Return home
          filterMsg = "Đường dẫn không hợp lệ";
          request.getSession().setAttribute("filterMsg", filterMsg);
          response.sendRedirect(servletContext.getContextPath() + "/");
        }
      } else {
        // user isn't exits
        filterMsg = "Đăng nhập trước khi truy cập đường dẫn này!";
        request.getSession().setAttribute("filterMsg", filterMsg);
        response.sendRedirect(servletContext.getContextPath() + "/login");
      }
    } else {
      chain.doFilter(request, response);
    }
  }

}
