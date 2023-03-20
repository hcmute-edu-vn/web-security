package com.shoplane.services;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.shoplane.utils.Constants;

public class ErrorService extends SuperService {

  public ErrorService(HttpServletRequest request, HttpServletResponse response) {
    super(request, response);
  }

  public void forwardPageError() throws ServletException, IOException {
    super.setEncoding(Constants.UTF8);
    String pageInternalError = "/pages/500.jsp";
    // Get requestURI
    String requestURI = request.getRequestURI();
    String homeUrl = super.getContextPath();
    if (requestURI.contains("system")) {
      homeUrl += "/system";
    }
    super.setAttribute("homeUrl", homeUrl);
    super.forwardToPage(pageInternalError);
  }

}
