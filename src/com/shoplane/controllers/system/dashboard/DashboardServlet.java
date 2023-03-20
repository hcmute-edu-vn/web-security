package com.shoplane.controllers.system.dashboard;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.shoplane.services.system.DashBoardService;

@WebServlet(urlPatterns = { "/system", "/system/" })
public class DashboardServlet extends HttpServlet {
  private static final long serialVersionUID = 1L;

  public DashboardServlet() {
    super();
  }

  @Override
  protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    DashBoardService dashBoardService = new DashBoardService(request, response);
    dashBoardService.getDashboard();
  }

  @Override
  protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    doGet(request, response);
  }

}
