package com.shoplane.services.client;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.owasp.encoder.Encode;

import com.shoplane.dao.BillDAO;
import com.shoplane.dao.UserDAO;
import com.shoplane.models.Bill;
import com.shoplane.models.Order;
import com.shoplane.models.User;
import com.shoplane.services.SendMail;
import com.shoplane.services.SuperService;
import com.shoplane.utils.Constants;
import com.shoplane.utils.Helper;

public class CartService extends SuperService {

  BillDAO billDAO = null;
  UserDAO userDAO = null;

  public CartService(HttpServletRequest request, HttpServletResponse response) {
    super(request, response);
    billDAO = new BillDAO();
    userDAO = new UserDAO();
  }

  // [GET] CartServlet
  public void getOrderList() throws IOException {
    try {
      super.setEncoding(Constants.UTF8);
      String url = "/pages/default/cart/index.jsp";
      @SuppressWarnings("unchecked")
      List<Order> orders = (List<Order>) request.getSession().getAttribute("orders");
      if (orders == null) {

        orders = new ArrayList<>();
      }
      // Set att
      request.setAttribute("orders", orders);
      // Forward to cart page
      super.forwardToPage(url);

    } catch (Exception e) {
      super.log(e.getMessage());
      String error = super.getContextPath() + "/500";
      this.redirectToPage(error);
    }
  }

  // [POST] CartServlet
  public void deleteItemOrder() throws IOException {
    try {
      super.setEncoding(Constants.UTF8);
      // Get sesion
      HttpSession session = super.getSession();
      // Get data
      String opId = Encode.forHtml(super.getParameter("oId"));
      String url = "/pages/default/cart/index.jsp";
      String deleteItemStatus = "";
      @SuppressWarnings("unchecked")
      List<Order> ors = (List<Order>) super.getSession().getAttribute("orders");

      // Handle delete item
      int index = -1;
      if (ors != null) {
        for (int i = 0; i < ors.size(); i++) {
          if (ors.get(i).getOption().getOptionId().equals(opId)) {
            index = i;
            break;
          }
        }
        if (index != -1) {
          ors.remove(index);
          deleteItemStatus = Constants.SUCCESS_STATUS;
          super.setAttribute("deleteItemStatus", deleteItemStatus);
          session.setAttribute("orders", ors);
          super.getSession().setAttribute("orderSize", ors.size());
        }
      }
      super.forwardToPage(url);
    } catch (Exception e) {
      super.log(e.getMessage());
      String error = super.getContextPath() + "/500";
      this.redirectToPage(error);
    }
  }

  // [GET] CartCheckoutServlet
  public void getCheckoutOrdersForm() throws IOException {
    try {
      super.setEncoding(Constants.UTF8);
      // forward url
      String url = "/pages/default/checkouts/index.jsp";

      // Forward
      super.forwardToPage(url);
    } catch (Exception e) {
      super.log(e.getMessage());
      String error = super.getContextPath() + "/500";
      this.redirectToPage(error);
    }
  }
  
  private int getTotalPrice(List<Order> orders) {
	  int total = 0;
	  int deliveryCost = 35000;
	  for (Order order : orders) {
		  total += order.getPrice();
	  }
	  return total + deliveryCost;
}

  // [POST] CartCheckoutServlet
  public void submitCheckoutOrders() throws IOException {
    try {
      super.setEncoding(Constants.UTF8);
      // Get data from session
      @SuppressWarnings("unchecked")
      List<Order> orders = (List<Order>) request.getSession().getAttribute("orders");
      User user = (User) request.getSession().getAttribute(Constants.USER_SESSION);

      // Get data from form checkout
      String fullname = Encode.forHtml(request.getParameter("fullname"));
      String phonenumber = Encode.forHtml(request.getParameter("phonenumber"));
      String address = Encode.forHtml(request.getParameter("address"));

      // create Bill
      String billId = Helper.getRandom();
      int totalPrice = getTotalPrice(orders);
      Bill bill = new Bill();
      bill.setBillId(billId);
      bill.setDate(new Date());
      bill.setUser(user);
      bill.setOrders(orders);
      bill.setTotalPrice(totalPrice);

      // Set bill in each order
      for (Order order : orders) {
        order.setBill(bill);
      }

      if (user != null) {
        user.setFullname(fullname);
        user.setPhonenumber(phonenumber);
        user.setAddress(address);
        // update user
        this.userDAO.update(user);

        // Insert Bill, list order to db
        Bill billCreated = this.billDAO.create(bill);
        // Bill billCreated = new Bill();
        if (billCreated != null) {
          // Send mail
          SendMail sendMail = new SendMail();
          sendMail.sendReceipt(user.getEmail(), billCreated);
          super.getSession().removeAttribute("orders");
          super.getSession().removeAttribute("orderSize");
          String msg = Constants.SUCCESS_STATUS;
          response.getWriter().append(msg);
        }
      } else {
        String msg = Constants.FAILURE_STATUS;
        response.getWriter().append(msg);
      }

    } catch (Exception e) {
      super.log(e.getMessage());
      String error = super.getContextPath() + "/500";
      this.redirectToPage(error);
    }
  }
}
