package com.shoplane.controllers.client.authenication;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.shoplane.services.client.CustomerService;

@WebServlet(urlPatterns = { "/forgot-password", "/forgot-password/" })
public class CustomerForgotPasswordServlet extends HttpServlet {
  private static final long serialVersionUID = 1L;

  public CustomerForgotPasswordServlet() {
    super();
  }

  @Override
  protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    CustomerService customerService = new CustomerService(request, response);
    customerService.getForgotPasswordForm();
  }

  @Override
  protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    CustomerService customerService = new CustomerService(request, response);
    customerService.submitForgotPasswordForm();
  }

}
