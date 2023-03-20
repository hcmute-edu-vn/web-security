package com.shoplane.services;

import java.io.IOException;
import java.io.UnsupportedEncodingException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class SuperService {
  protected HttpServletRequest request = null;
  protected HttpServletResponse response = null;

  public SuperService(HttpServletRequest request, HttpServletResponse response) {
    this.request = request;
    this.response = response;
  }

  public void setEncoding(String env) throws UnsupportedEncodingException {
    this.request.setCharacterEncoding(env);
    this.response.setCharacterEncoding(env);
  }

  public void forwardToPage(String url) throws ServletException, IOException {
    this.request.getRequestDispatcher(url).forward(request, response);

  }

//  Redirect to url Pattern
  public void redirectToPage(String urlPattern) throws IOException {
    this.response.sendRedirect(urlPattern);
  }

//  Log info or error
  public void log(String msg) {
    System.out.println(msg);
  }

  // set Attribute
  public void setAttribute(String key, Object value) {
    this.request.setAttribute(key, value);
  }

  // Get Param
  public String getParameter(String key) {
    return this.request.getParameter(key);
  }

  // Get Param
  public String[] getParameterValues(String key) {
    return this.request.getParameterValues(key);
  }

  // Get context

  public String getContextPath() {
    return this.request.getContextPath();
  }

  // Get Session
  public HttpSession getSession() {
    return this.request.getSession();
  }
}