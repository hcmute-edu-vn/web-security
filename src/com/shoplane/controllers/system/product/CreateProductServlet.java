package com.shoplane.controllers.system.product;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.shoplane.services.system.ProductService;

@WebServlet(urlPatterns = { "/system/products/create", "/system/products/create/" })
public class CreateProductServlet extends HttpServlet {
  private static final long serialVersionUID = 1L;

  public CreateProductServlet() {
    super();
  }

  @Override
  protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    ProductService productService = new ProductService(request, response);
    productService.handleGetCreateProduct();
  }

  @Override
  protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    ProductService productService = new ProductService(request, response);
    productService.handlePostCreateProduct();
  }

}
