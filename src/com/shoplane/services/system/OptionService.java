package com.shoplane.services.system;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.owasp.encoder.Encode;

import com.shoplane.dao.ColorDAO;
import com.shoplane.dao.OptionDAO;
import com.shoplane.dao.ProductDAO;
import com.shoplane.dao.SizeDAO;
import com.shoplane.models.Color;
import com.shoplane.models.Option;
import com.shoplane.models.Product;
import com.shoplane.models.Size;
import com.shoplane.services.SuperService;
import com.shoplane.utils.Constants;
import com.shoplane.utils.Helper;

public class OptionService extends SuperService {
  private OptionDAO optionDAO = null;
  private ProductDAO productDAO = null;
  private SizeDAO sizeDAO = null;
  private ColorDAO colorDAO = null;

  public OptionService(HttpServletRequest request, HttpServletResponse response) {
    super(request, response);
    this.optionDAO = new OptionDAO();
    this.productDAO = new ProductDAO();
    this.sizeDAO = new SizeDAO();
    this.colorDAO = new ColorDAO();
  }

  // [GET] ListOptionServlet
  public void handleGetListOption() throws ServletException, IOException {
    try {
      super.setEncoding(Constants.UTF8);
      String url = "/pages/system/options/index.jsp";
      String productId = Encode.forHtml(super.getParameter("product_id").trim());
      Product product = this.productDAO.find(productId);

      List<Option> options = null;
      if (product != null) {
        options = this.optionDAO.findByProduct(product);
      }

      // Set att and forward to page
      super.setAttribute("options", options);
      super.setAttribute("productId", productId);
      super.forwardToPage(url);

      // Set session
      super.getSession().setAttribute("createOptionStatus", null);
      super.getSession().setAttribute("editOptionStatus", null);
    } catch (Exception e) {
      super.log(e.getMessage());
      String error = super.getContextPath() + "/system/500";
      this.redirectToPage(error);
    }
  }

  // [GET] CreateOptionServlet
  public void handleGetCreateOption() throws ServletException, IOException {
    try {
      super.setEncoding(Constants.UTF8);
      // define url
      String url = "/pages/system/options/createOption.jsp";
      // Get param
      String productId = Encode.forHtml(super.getParameter("product_id").trim());
      Product product = this.productDAO.find(productId);
      List<Size> sizes = this.sizeDAO.findAll();
      List<Color> colors = this.colorDAO.findAll();

      super.setAttribute("productId", productId);
      super.setAttribute("product", product);
      super.setAttribute("sizes", sizes);
      super.setAttribute("colors", colors);

      // Forward to page
      super.forwardToPage(url);
    } catch (Exception e) {
      super.log(e.getMessage());
      String error = super.getContextPath() + "/system/500";
      this.redirectToPage(error);
    }
  }

  // [POST] CreateOptionServlet
  public void handlePostCreateOption() throws IOException {
    try {
      super.setEncoding(Constants.UTF8);
      // get params
      String productId = super.getParameter("productId");
      String optionId = super.getParameter("optionId");
      String sizeId = super.getParameter("sizeId");
      String colorId = super.getParameter("colorId");
      String quantity = super.getParameter("availableQuantity");
      // next url
      String url = super.getContextPath() + "/system/products/options/?product_id=" + productId;
      // Get data from db
      Product product = this.productDAO.find(productId);
      Size size = this.sizeDAO.find(sizeId);
      Color color = this.colorDAO.find(colorId);
      String createOptionStatus = "";

      // Create option
      Option option = new Option();
      option.setOptionId(optionId);
      if (Helper.isNumeric(quantity)) {
        option.setAvailableQuantity(Integer.parseInt(quantity));
      } else {
        option.setAvailableQuantity(0);
      }
      option.setColor(color);
      option.setSize(size);
      option.setProduct(product);

      this.optionDAO.create(option);
      createOptionStatus = Constants.SUCCESS_STATUS;

      super.getSession().setAttribute("createOptionStatus", createOptionStatus);
      // Redirect
      super.redirectToPage(url);

    } catch (Exception e) {
      super.log(e.getMessage());
      String error = super.getContextPath() + "/system/500";
      this.redirectToPage(error);
    }
  }

  // [GET] detail option
  public void handleGetDetailOption() throws ServletException, IOException {
    try {
      super.setEncoding(Constants.UTF8);
      // define Url
      String url = "/pages/system/options/editOption.jsp";
      // Get Params
      String optionId = Encode.forHtml(super.getParameter("option_id"));
      String productId = Encode.forHtml(super.getParameter("product_id"));

      // Get data from db
      Product product = this.productDAO.find(productId);
      Option option = this.optionDAO.find(optionId);
      List<Size> sizes = this.sizeDAO.findAll();
      List<Color> colors = this.colorDAO.findAll();

      // Set att
      super.setAttribute("productId", productId);
      super.setAttribute("optionId", optionId);
      super.setAttribute("product", product);
      super.setAttribute("sizes", sizes);
      super.setAttribute("colors", colors);
      super.setAttribute("option", option);

      super.forwardToPage(url);
    } catch (Exception e) {
      super.log(e.getMessage());
      String error = super.getContextPath() + "/system/500";
      this.redirectToPage(error);
    }
  }

  // [POST] DetailOptionServlet
  public void updateOption() throws IOException {
    try {
      super.setEncoding(Constants.UTF8);
      // Get Params
      String optionId = Encode.forHtml(super.getParameter("option_id"));
      String productId = Encode.forHtml(super.getParameter("product_id"));
      String sizeId = Encode.forHtml(super.getParameter("sizeId"));
      String colorId = Encode.forHtml(super.getParameter("colorId"));
      String quantity = Encode.forHtml(super.getParameter("availableQuantity"));
      String editOptionStatus = "";

      // Url

      String url = super.getContextPath() + "/system/products/options/?product_id=" + productId;

      // Get data
      Product product = this.productDAO.find(productId);
      Option option = this.optionDAO.find(optionId);
      Size size = this.sizeDAO.find(sizeId);
      Color color = this.colorDAO.find(colorId);

      // Update option
      if (Helper.isNumeric(quantity)) {
        option.setAvailableQuantity(Integer.parseInt(quantity));
      }
      option.setColor(color);
      option.setSize(size);
      option.setProduct(product);

      this.optionDAO.update(option);
      editOptionStatus = Constants.SUCCESS_STATUS;
      super.getSession().setAttribute("editOptionStatus", editOptionStatus);

      // redirect
      super.redirectToPage(url);

    } catch (Exception e) {
      super.log(e.getMessage());
      String error = super.getContextPath() + "/system/500";
      this.redirectToPage(error);
    }

  }

}
