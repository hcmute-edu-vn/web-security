package com.shoplane.controllers.system.user;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.shoplane.services.system.UserService;

@WebServlet(urlPatterns = { "/system/users/edit", "/system/users/edit/" })
public class EditUserSevlet extends HttpServlet {
  private static final long serialVersionUID = 1L;

  public EditUserSevlet() {
    super();
  }

  @Override
  protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    UserService userService = new UserService(request, response);
    userService.getEditUserForm();
  }

  @Override
  protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    UserService userService = new UserService(request, response);
    userService.submitEditUserForm();
  }

}
