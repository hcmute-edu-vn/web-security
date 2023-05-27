package com.shoplane.services.client;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.owasp.encoder.Encode;

import com.shoplane.dao.CategoryDAO;
import com.shoplane.dao.OptionDAO;
import com.shoplane.dao.ProductDAO;
import com.shoplane.dao.ProductImageDAO;
import com.shoplane.dao.ProductTypeDAO;
import com.shoplane.models.Category;
import com.shoplane.models.Option;
import com.shoplane.models.Order;
import com.shoplane.models.Product;
import com.shoplane.models.ProductImage;
import com.shoplane.models.ProductType;
import com.shoplane.services.SuperService;
import com.shoplane.utils.Constants;
import com.shoplane.utils.Helper;

public class ProductService extends SuperService {
  ProductDAO productDAO = null;
  ProductTypeDAO productTypeDAO = null;
  CategoryDAO categoryDAO = null;
  ProductImageDAO productImageDAO = null;
  OptionDAO optionDAO = null;

  public ProductService(HttpServletRequest request, HttpServletResponse response) {
    super(request, response);
    this.productDAO = new ProductDAO();
    this.productTypeDAO = new ProductTypeDAO();
    this.categoryDAO = new CategoryDAO();
    this.productImageDAO = new ProductImageDAO();
    this.optionDAO = new OptionDAO();
  }

  // [GET] ListProductServlet => Client side
  public void getCollectionProduct() throws IOException {
    try {
      // Set encoding
      super.setEncoding(Constants.UTF8);

      // Link
      String url = "/pages/default/collections/index.jsp";
     
      // Get params and encrypt data
      String productTypeId = Encode.forHtml(super.getParameter("product_type"));
      String categoryId = Encode.forHtml(super.getParameter("category_id"));
      String currentPageStr = Encode.forHtml(super.getParameter("current_page"));
      String pageSizeStr = Encode.forHtml(super.getParameter("page_size"));
      String sortBy = Encode.forHtml(super.getParameter("sort_by_price"));
      
      System.out.println(categoryId);

      int currentPage = 1;
      int pageSize = 10;
      byte isDelete = 0;

      if (currentPageStr != null && pageSizeStr != null) {
		  if(currentPageStr.contains("-")) {
			  currentPageStr = currentPageStr.substring(1);
		}
		if(pageSizeStr.contains("-")) {
			pageSizeStr = pageSizeStr.substring(1);
		}
        if (Helper.isNumeric(currentPageStr) 
        		&& currentPageStr.length() < String.format("%d", Integer.MAX_VALUE).length()) {
          currentPage = Integer.parseInt(currentPageStr);
        }

        if (Helper.isNumeric(pageSizeStr)
        		&& pageSizeStr.length() < String.format("%d", Integer.MAX_VALUE).length()) {
        	
          pageSize = Integer.parseInt(pageSizeStr);
        }
      }
      if (sortBy == null)
        sortBy = Constants.DESC;

      List<ProductType> productTypes = this.productTypeDAO.findAll();
      ProductType productType = this.productTypeDAO.find(productTypeId);

      List<Category> categories = this.categoryDAO.findByProductType(productType);
      Category category = this.categoryDAO.find(categoryId);
      List<Product> products = new ArrayList<>();
      int totalItem = 0;

      Map<String, Object> params = new HashMap<>();
      params.put("isDelete", isDelete);
      params.put("productType", productType);

      if (categoryId.equals(Constants.SHIRT_ALL) && productTypeId.equals(Constants.SHIRT)) {
        products = this.productDAO.paginationByProductTypeAndIsDeleted(params, currentPage, pageSize, sortBy);
        totalItem = this.productDAO.countByProductTypeAndIsDeleted(params);
      }
      if (categoryId.equals(Constants.SHORT_ALL) && productTypeId.equals(Constants.SHORT)) {
        products = this.productDAO.paginationByProductTypeAndIsDeleted(params, currentPage, pageSize, sortBy);
        totalItem = this.productDAO.countByProductTypeAndIsDeleted(params);
      }
      if (!categoryId.equals(Constants.SHIRT_ALL) && !categoryId.equals(Constants.SHORT_ALL)) {
        params.put("category", category);
        products = this.productDAO.paginationByCategoryAndProductTypeAndIsDeleted(params, currentPage, pageSize,
            sortBy);
        totalItem = this.productDAO.countByProductTypeAndCategoryAndIsDeleted(params);
      }

      // Chưa ổn lắm => Cần phải fix chỉnh lại chỗ này
      int totalPage = (int) Math.ceil((double) totalItem / pageSize);

      super.setAttribute("products", products);
      super.setAttribute("productTypes", productTypes);
      super.setAttribute("categories", categories);
      super.setAttribute("category", category);
      // Set value of param url
      super.setAttribute("totalPage", totalPage);
      super.setAttribute("currentPage", currentPage);
      super.setAttribute("pageSize", pageSize);
      super.setAttribute("productType", productTypeId);
      super.setAttribute("categoryId", categoryId);
      

      // Forward
      super.forwardToPage(url);

    } catch (Exception e) {
      super.log(e.getMessage());
      String error = super.getContextPath() + "/500";
      super.redirectToPage(error);
    }
  }

  // [GET] ProductDetailServlet
  public void getProductDetail() throws IOException {
    try {
      // Set encoding
      super.setEncoding(Constants.UTF8);
      String url = "/pages/default/productDetail.jsp";
      // Get data
      String productId = Encode.forHtml(super.getParameter("product_id").trim());
      if (productId != null) {
        // Get product by productId
        Product product = this.productDAO.find(productId);

        request.getSession().setAttribute("product", product);

        // Get list image preview
        List<ProductImage> productImages = this.productImageDAO.findByProduct(product);
        request.setAttribute("productImages", productImages);

        List<Option> options = this.optionDAO.findByProduct(product);
        request.setAttribute("options", options);

        // Forward url
        super.forwardToPage(url);

      }
    } catch (Exception e) {
      super.log(e.getMessage());
      String error = super.getContextPath() + "/500";
      super.redirectToPage(error);
    }
  }

  // [POST] addProductToCart
  public void addProductItemToCart() throws IOException {
    try {
      // Get data from input form
      super.setEncoding(Constants.UTF8);
      String optionId = Encode.forHtml(super.getParameter("oId").trim());
      String quantyString = Encode.forHtml(super.getParameter("quanty").trim().replace("-", ""));
      int quanty = Integer.parseInt(quantyString);
      // Get Option
      Option option = this.optionDAO.find(optionId);
      // Calc price
      int price = option.getProduct().getNewPrice() * quanty;
      // orderid
      String oId = Helper.getRandom();
      // Create order
      Order o = new Order();
      o.setOrderId(oId);
      o.setDate(new Date());
      o.setOrderedQuantity(quanty);
      o.setPrice(price);
      o.setOption(option);

      // Add order to list
      @SuppressWarnings("unchecked")
      List<Order> ors = (List<Order>) super.getSession().getAttribute("orders");
      if (ors == null) {
        ors = new ArrayList<>();
        ors.add(o);
      } else {
        boolean flag = false;
        for (Order or : ors) {
          if (or.getOption().getOptionId().equals(o.getOption().getOptionId())) {
            int currOrderQuanty = or.getOrderedQuantity() + o.getOrderedQuantity();
            int newPriceOrder = or.getPrice() + o.getPrice();
            or.setOrderedQuantity(currOrderQuanty);
            or.setPrice(newPriceOrder);
            flag = true;
            break;
          }
        }
        if (!flag) {
          ors.add(o);
        }
      }
      // Set att session
      super.getSession().setAttribute("orders", ors);
      super.getSession().setAttribute("orderSize", ors.size());
    } catch (Exception e) {
      super.log(e.getMessage());
      String error = super.getContextPath() + "/500";
      super.redirectToPage(error);
    }
  }

  // [GET] SearchProductServlet
  public void searchProductByName() throws IOException {
    try {
      super.setEncoding(Constants.UTF8);
      String url = "/pages/default/searchProduct.jsp";
      String productName = Encode.forHtml(request.getParameter("product_name").trim());
      if (productName != null) {
        List<Product> listProductWithSearch = new ArrayList<>();
        listProductWithSearch = this.productDAO.findByProductName(productName);
        super.setAttribute("findProduct", productName);
        super.setAttribute("listProductWithSearch", listProductWithSearch);
        super.forwardToPage(url);
      }
    } catch (Exception e) {
      super.log(e.getMessage());
      String error = super.getContextPath() + "/500";
      super.redirectToPage(error);
    }
  }

}
