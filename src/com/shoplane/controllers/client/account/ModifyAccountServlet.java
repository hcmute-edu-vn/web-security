package com.shoplane.controllers.client.account;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.shoplane.services.client.AccountService;

@WebServlet(urlPatterns = { "/account/modify", "/account/modify/" })
public class ModifyAccountServlet extends HttpServlet {
  private static final long serialVersionUID = 1L;

  public ModifyAccountServlet() {
    super();
  }

  @Override
  protected void doGet(HttpServletRequest request, HttpServletResponse response)
      throws ServletException, IOException {
    AccountService accountService = new AccountService(request, response);
    accountService.getModifyAccountForm();
  }

  @Override
  protected void doPost(HttpServletRequest request, HttpServletResponse response)
      throws ServletException, IOException {
    AccountService accountService = new AccountService(request, response);
    accountService.submitModifyAccountForm();
  }

}
