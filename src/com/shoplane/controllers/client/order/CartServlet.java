package com.shoplane.controllers.client.order;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.shoplane.services.client.CartService;

@WebServlet(urlPatterns = { "/cart", "/cart/" })
public class CartServlet extends HttpServlet {
  private static final long serialVersionUID = 1L;

  public CartServlet() {
    super();
  }

  @Override
  protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    CartService cartService = new CartService(request, response);
    cartService.getOrderList();
  }

  @Override
  protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    CartService cartService = new CartService(request, response);
    cartService.deleteItemOrder();
  }

}
