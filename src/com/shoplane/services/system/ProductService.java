package com.shoplane.services.system;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.shoplane.dao.CategoryDAO;
import com.shoplane.dao.ProductDAO;
import com.shoplane.dao.ProductTypeDAO;
import com.shoplane.models.Category;
import com.shoplane.models.Product;
import com.shoplane.models.ProductType;
import com.shoplane.services.SuperService;
import com.shoplane.utils.Constants;
import com.shoplane.utils.Helper;

public class ProductService extends SuperService {

  private ProductDAO productDAO = null;
  private CategoryDAO categoryDAO = null;
  private ProductTypeDAO productTypeDAO = null;

  public ProductService(HttpServletRequest request, HttpServletResponse response) {
    super(request, response);
    this.productDAO = new ProductDAO();
    this.categoryDAO = new CategoryDAO();
    this.productTypeDAO = new ProductTypeDAO();
  }

  // [GET] ListProductServlet
  public void getProductList() throws ServletException, IOException {
    try {
      String url = "/pages/system/products/index.jsp";
      // Set url patten active sidebar item
      super.getSession().setAttribute("urlPatten", Constants.PRODUCTS);
      // Set encoding
      super.setEncoding(Constants.UTF8);

      // get list
      String productTypeId = super.getParameter("product_type");
      String categoryId = super.getParameter("category");
      String currentPageStr = super.getParameter("current_page");
      String pageSizeStr = super.getParameter("page_size");

      int currentPage = 1;
      int pageSize = 10;
      byte isDelete = 0;

      if (currentPageStr != null && pageSizeStr != null) {
        if (Helper.isNumeric(currentPageStr)) {
          currentPage = Integer.parseInt(currentPageStr);
        }

        if (Helper.isNumeric(pageSizeStr)) {
          pageSize = Integer.parseInt(pageSizeStr);
        }
      }

      // Get data
      List<ProductType> productTypes = this.productTypeDAO.findAll();
      List<Category> categories = this.categoryDAO.findAll();
      ProductType productType = this.productTypeDAO.find(productTypeId);
      Category category = this.categoryDAO.find(categoryId);
      Map<String, Object> params = new HashMap<>();
      params.put("isDelete", isDelete);
      List<Product> products = new ArrayList<>();
      int totalItem = this.productDAO.count();

      if (productTypeId.equals(Constants.ALL)) {
        products = this.productDAO.paginationByIsDeleted(params, currentPage, pageSize);
        totalItem = this.productDAO.countByIsDeleted(params);
      } else {
        params.put("productType", productType);
        totalItem = 0;
        if (categoryId.equals(Constants.SHIRT_ALL) && productTypeId.equals(Constants.SHIRT)) {
          products = this.productDAO.paginationByProductTypeAndIsDeleted(params, currentPage, pageSize, Constants.DESC);
          totalItem = this.productDAO.countByProductTypeAndIsDeleted(params);
        }
        if (categoryId.equals(Constants.SHORT_ALL) && productTypeId.equals(Constants.SHORT)) {
          products = this.productDAO.paginationByProductType(params, currentPage, pageSize);
          totalItem = this.productDAO.countByProductType(params);
        }
        if (!categoryId.equals(Constants.SHIRT_ALL) && !categoryId.equals(Constants.SHORT_ALL)) {
          params.put("category", category);
          products = this.productDAO.paginationByCategoryAndProductTypeAndIsDeleted(params, currentPage, pageSize,
              Constants.DESC);
          totalItem = this.productDAO.countByProductTypeAndCategoryAndIsDeleted(params);
        }
      }

      // Chưa ổn lắm => Cần phải fix chỉnh lại chỗ này
      int totalPage = (int) Math.ceil((double) totalItem / pageSize);

      super.setAttribute("products", products);
      super.setAttribute("productTypes", productTypes);
      super.setAttribute("categories", categories);
      // Set value of param url
      super.setAttribute("totalPage", totalPage);
      super.setAttribute("currentPage", currentPage);
      super.setAttribute("pageSize", pageSize);
      super.setAttribute("productType", productTypeId);
      super.setAttribute("category", categoryId);

      // Forward
      super.forwardToPage(url);
      super.getSession().setAttribute("createProductStatus", null);
      super.getSession().setAttribute("editProductStatus", null);

    } catch (Exception e) {
      super.log(e.getMessage());
      String error = super.getContextPath() + "/system/500";
      super.redirectToPage(error);
    }
  }

  // [GET] CreateProductServlet
  public void handleGetCreateProduct() throws ServletException, IOException {
    try {
      super.setEncoding(Constants.UTF8);
      String url = "/pages/system/products/createProduct.jsp";
      List<Category> categories = this.categoryDAO.findAll();
      List<ProductType> productTypes = this.productTypeDAO.findAll();

      // Set Att
      super.setAttribute("categories", categories);
      super.setAttribute("productTypes", productTypes);

      // Forward
      super.forwardToPage(url);

    } catch (Exception e) {
      super.log(e.getMessage());
      String error = super.getContextPath() + "/system/500";
      super.redirectToPage(error);
    }
  }

  // [POST] CreateProductServlet
  public void handlePostCreateProduct() throws ServletException, IOException {
    try {
      super.setEncoding(Constants.UTF8);
      // Get props
      String productId = super.getParameter("productId").trim();
      String productTypeId = super.getParameter("categoryTypeId").trim();
      String categoryId = super.getParameter("categoryId").trim();
      String productName = super.getParameter("productName").trim();
      String mainImageUrl = super.getParameter("mainImageUrl").trim();
      String oldPriceStr = super.getParameter("oldPrice").trim();
      String newPriceStr = super.getParameter("newPrice").trim();
      String origin = super.getParameter("origin").trim();
      String pattern = super.getParameter("pattern").trim();
      String meterial = super.getParameter("meterial").trim();
      String description = super.getParameter("description").trim();
      String isActiveStr = super.getParameter("select_active").trim();
      String createProductStatus = "";

      int oldPrice = 0;
      int newPrice = 0;
      int isActive = 0;

      if (Helper.isNumeric(oldPriceStr)) {
        oldPrice = Integer.parseInt(oldPriceStr);
      }

      if (Helper.isNumeric(newPriceStr)) {
        newPrice = Integer.parseInt(newPriceStr);
      }

      if (Helper.isNumeric(isActiveStr)) {
        isActive = Integer.parseInt(isActiveStr);
      }

      String url = super.getContextPath()
          + "/system/products/?product_type=ALL&category=AO5&current_page=1&page_size=10";
      // Get Data
      Category category = this.categoryDAO.find(categoryId);
      ProductType productType = this.productTypeDAO.find(productTypeId);

      // Create product
      Product product = new Product();
      product.setProductId(productId);
      product.setProductName(productName);
      product.setMainImageUrl(mainImageUrl);
      product.setOldPrice(oldPrice);
      product.setNewPrice(newPrice);
      product.setDescription(description);
      product.setOrigin(origin);
      product.setPattern(pattern);
      product.setMeterial(meterial);
      product.setCategory(category);
      product.setProductTypeBean(productType);
      product.setIsActive((byte) isActive);

      this.productDAO.create(product);
      createProductStatus = Constants.SUCCESS_STATUS;
      super.getSession().setAttribute("createProductStatus", createProductStatus);
      // forward
      super.redirectToPage(url);

    } catch (Exception e) {
      super.log(e.getMessage());
      String error = super.getContextPath() + "/system/500";
      super.redirectToPage(error);
    }
  }

  // [GET] DetailProductServlet
  public void handleGetDetailProduct() throws ServletException, IOException {
    try {
      super.setEncoding(Constants.UTF8);
      // Link
      String url = "/pages/system/products/editProduct.jsp";

      // Param
      String productId = this.request.getParameter("product_id");

      // Get data
      Product product = this.productDAO.find(productId);
      List<Category> categories = this.categoryDAO.findAll();
      List<ProductType> productTypes = this.productTypeDAO.findAll();

      // Set att and forward
      super.setAttribute("product", product);
      super.setAttribute("productId", productId);
      super.setAttribute("categories", categories);
      super.setAttribute("productTypes", productTypes);
      super.forwardToPage(url);

    } catch (Exception e) {
      super.log(e.getMessage());
      String error = super.getContextPath() + "/system/500";
      super.redirectToPage(error);
    }
  }

  // [POST] UpdateProductServlet
  public void handlePostUpdateProduct() throws IOException {
    try {
      super.setEncoding(Constants.UTF8);
      // Link
      String url = super.getContextPath()
          + "/system/products/?product_type=ALL&category=AO5&current_page=1&page_size=10";

      // Params
      String productId = super.getParameter("productId").trim();
      String productTypeId = super.getParameter("categoryTypeId").trim();
      String categoryId = super.getParameter("categoryId").trim();
      String productName = super.getParameter("productName").trim();
      String mainImageUrl = super.getParameter("mainImageUrl").trim();
      String origin = super.getParameter("origin").trim();
      String pattern = super.getParameter("pattern").trim();
      String meterial = super.getParameter("meterial").trim();
      String description = super.getParameter("description").trim();
      String oldPriceStr = super.getParameter("oldPrice").trim();
      String newPriceStr = super.getParameter("newPrice").trim();
      String isActiveStr = super.getParameter("select_active").trim();
      String editProductStatus = "";

      int oldPrice = 0;
      int newPrice = 0;
      int isActive = 0;

      if (Helper.isNumeric(oldPriceStr)) {
        oldPrice = Integer.parseInt(oldPriceStr);
      }

      if (Helper.isNumeric(newPriceStr)) {
        newPrice = Integer.parseInt(newPriceStr);
      }

      if (Helper.isNumeric(isActiveStr)) {
        isActive = Integer.parseInt(isActiveStr);
      }
      // Get data
      Product product = this.productDAO.find(productId);
      Category category = this.categoryDAO.find(categoryId);
      ProductType productType = this.productTypeDAO.find(productTypeId);

      // Update product
      product.setProductName(productName);
      product.setMainImageUrl(mainImageUrl);
      product.setOldPrice(oldPrice);
      product.setNewPrice(newPrice);
      product.setOrigin(origin);
      product.setPattern(pattern);
      product.setMeterial(meterial);
      product.setCategory(category);
      product.setProductTypeBean(productType);
      product.setDescription(description);
      product.setIsActive((byte) isActive);
      this.productDAO.update(product);
      editProductStatus = Constants.SUCCESS_STATUS;

      super.getSession().setAttribute("editProductStatus", editProductStatus);
      super.redirectToPage(url);

    } catch (Exception e) {
      super.log(e.getMessage());
      String error = super.getContextPath() + "/system/500";
      super.redirectToPage(error);
    }

  }

  // [GET] delete product
  public void handleGetDeleteProduct() throws IOException {
    try {
      super.setEncoding(Constants.UTF8);
      // Link
      String url = super.getContextPath()
          + "/system/products/?product_type=ALL&category=AO5&current_page=1&page_size=10";

      // Get Param
      String productsSelected = super.getParameter("productsSelected");
      System.out.println(productsSelected);
      String[] productIds = null;
      List<Product> products = new ArrayList<>();
      Product product = null;
      byte isDeleted = 1;

      // Convert ids str to Array
      if (!productsSelected.equals("")) {
        productIds = productsSelected.split(",");
      }
      // Check
      if (productIds != null) {
        for (String productId : productIds) {
          product = this.productDAO.find(productId);
          product.setIsDelete(isDeleted);
          products.add(product);
        }
      }

      // Update to isdeleted field
      this.productDAO.bulkUpdate(products);

      // Redirect
      super.redirectToPage(url);

    } catch (Exception e) {
      super.log(e.getMessage());
      String error = super.getContextPath() + "/system/500";
      super.redirectToPage(error);
    }
  }

  // [GET] ListProductDeleted
  public void getListProductDeleted() throws IOException {
    try {
      super.setEncoding(Constants.UTF8);
      // Link
      String url = "/pages/system/products/trash/index.jsp";

      byte isDeleted = 1;
      Map<String, Object> params = new HashMap<>();
      params.put("isDelete", isDeleted);
      List<Product> products = this.productDAO.findByIsDeleted(params);

      // Set att
      super.setAttribute("products", products);

      // Redirect
      super.forwardToPage(url);

      // Set session
      super.getSession().setAttribute("recoveryProductItemStatus", null);

    } catch (Exception e) {
      super.log(e.getMessage());
      String error = super.getContextPath() + "/system/500";
      super.redirectToPage(error);
    }
  }

  // [GET] ListProductDeleted
  public void recoveryProductItem() throws IOException {
    try {
      super.setEncoding(Constants.UTF8);
      // Link
      String url = super.getContextPath() + "/system/products/trash/";
      // Get data
      String productId = super.getParameter("product_id");
      byte isDeleted = 1;
      byte unDeleted = 0;
      String recoveryProductItemStatus = "";

      Map<String, Object> params = new HashMap<>();
      params.put("isDelete", isDeleted);
      params.put("productId", productId);

      Product product = this.productDAO.findByProductIdAndIsDeleted(params);
      product.setIsDelete(unDeleted);
      this.productDAO.update(product);
      recoveryProductItemStatus = Constants.SUCCESS_STATUS;

      super.getSession().setAttribute("recoveryProductItemStatus", recoveryProductItemStatus);

      // Redirect
      super.redirectToPage(url);

    } catch (Exception e) {
      super.log(e.getMessage());
      String error = super.getContextPath() + "/system/500";
      super.redirectToPage(error);
    }
  }

  // [POST] RecoveryProductServlet
  public void recoveryAllProducts() throws IOException {
    try {
      super.setEncoding(Constants.UTF8);
      // Link
      String url = super.getContextPath()
          + "/system/products/?product_type=ALL&category=AO5&current_page=1&page_size=10";

      // Get Param
      String productsSelected = super.getParameter("productsSelected");
      System.out.println(productsSelected);
      String[] productIds = null;
      List<Product> products = new ArrayList<>();
      Product product = null;
      byte isDeleted = 0;

      // Convert ids str to Array
      if (!productsSelected.equals("")) {
        productIds = productsSelected.split(",");
      }
      // Check
      if (productIds != null) {
        for (String productId : productIds) {
          product = this.productDAO.find(productId);
          product.setIsDelete(isDeleted);
          products.add(product);
        }
      }

      // Update to isdeleted field
      this.productDAO.bulkUpdate(products);

      // Redirect
      super.redirectToPage(url);
    } catch (Exception e) {
      super.log(e.getMessage());
      String error = super.getContextPath() + "/system/500";
      super.redirectToPage(error);
    }
  }

}
