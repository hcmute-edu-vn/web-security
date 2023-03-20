package com.shoplane.services.system;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.shoplane.dao.BillDAO;
import com.shoplane.dao.ProductDAO;
import com.shoplane.dao.RoleDAO;
import com.shoplane.dao.UserDAO;
import com.shoplane.models.Role;
import com.shoplane.services.SuperService;

public class DashBoardService extends SuperService {

  BillDAO billDAO = null;
  UserDAO userDAO = null;
  ProductDAO productDAO = null;
  RoleDAO roleDAO = null;

  public DashBoardService(HttpServletRequest request, HttpServletResponse response) {
    super(request, response);
    billDAO = new BillDAO();
    userDAO = new UserDAO();
    productDAO = new ProductDAO();
    this.roleDAO = new RoleDAO();
  }

  public void getDashboard() throws IOException {
    try {
      String url = "/pages/system/dashboard/index.jsp";

      Map<String, Object> param = new HashMap<>();
      param.put("isDelete", (byte) 0);

      // Get role
      List<Role> roles = this.roleDAO.findAll();
      List<Integer> userCountIntegers = new ArrayList<>();

      for (Role role : roles) {
        Map<String, Object> params = new HashMap<>();
        params.put("role", role);
        int count = this.userDAO.findByRole(params).size();
        userCountIntegers.add(count);
        params.remove("role");
      }

      // Get data
      int billCount = this.billDAO.count();
      int productCount = this.productDAO.countByIsDeleted(param);
      int userCount = this.userDAO.count();
      int totalPriceBills = this.billDAO.totalPrice();
      int adminUserCount = userCountIntegers.get(1);
      int customerUserCount = userCountIntegers.get(2);
      int employeeUserCount = userCountIntegers.get(3);
      for (Integer integer : userCountIntegers) {
        System.out.println(integer);
      }

      // Set data
      super.setAttribute("adminUserCount", adminUserCount);
      super.setAttribute("customerUserCount", customerUserCount);
      super.setAttribute("employeeUserCount", employeeUserCount);
      super.setAttribute("billCount", billCount);
      super.setAttribute("productCount", productCount);
      super.setAttribute("userCount", userCount);
      super.setAttribute("totalPriceBills", totalPriceBills);

      // Set url active sidebar
      super.getSession().setAttribute("urlPatten", "");
      super.forwardToPage(url);
    } catch (Exception e) {
      super.log(e.getMessage());
      String error = super.getContextPath() + "/system/500";
      super.redirectToPage(error);
    }
  }

}
