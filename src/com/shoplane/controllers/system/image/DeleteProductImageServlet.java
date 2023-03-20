package com.shoplane.controllers.system.image;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.shoplane.services.system.ProductImageService;

@WebServlet(urlPatterns = { "/system/products/images/delete", "/system/products/images/delete/" })
public class DeleteProductImageServlet extends HttpServlet {
  private static final long serialVersionUID = 1L;

  public DeleteProductImageServlet() {
    super();
  }

  @Override
  protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    ProductImageService productImageService = new ProductImageService(request, response);
    productImageService.deleteProductImage();
  }

  @Override
  protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

  }

}
