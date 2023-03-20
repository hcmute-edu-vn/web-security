package com.shoplane.controllers.system.option;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.shoplane.services.system.OptionService;

@WebServlet(urlPatterns = { "/system/products/options", "/system/products/options/" })
public class ListOptionServlet extends HttpServlet {
  private static final long serialVersionUID = 1L;

  public ListOptionServlet() {
    super();
  }

  @Override
  protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    OptionService optionService = new OptionService(request, response);
    optionService.handleGetListOption();
  }
}
