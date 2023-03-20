package com.shoplane.controllers.client.account;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.shoplane.services.client.AccountService;
import com.shoplane.utils.Constants;

@WebServlet(urlPatterns = { "/account", "/account/" })
public class AccountServlet extends HttpServlet {
  private static final long serialVersionUID = 1L;

  public AccountServlet() {
    super();
  }

  @Override
  protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    AccountService accountService = new AccountService(request, response);
    accountService.getAccount();
  }

  @Override
  protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    request.setCharacterEncoding(Constants.UTF8);
    response.setCharacterEncoding(Constants.UTF8);
    doGet(request, response);
  }

}
