package com.shoplane.controllers.system.product;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.shoplane.services.system.ProductService;

@WebServlet(urlPatterns = { "/system/products/trash/", "/system/products/trash" })
public class ListProductDeletedServlet extends HttpServlet {
  private static final long serialVersionUID = 1L;

  public ListProductDeletedServlet() {
    super();
  }

  @Override
  protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    ProductService productService = new ProductService(request, response);
    productService.getListProductDeleted();

  }

  @Override
  protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
  }

}
