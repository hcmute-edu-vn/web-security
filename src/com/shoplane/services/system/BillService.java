package com.shoplane.services.system;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.shoplane.dao.BillDAO;
import com.shoplane.dao.RoleDAO;
import com.shoplane.dao.UserDAO;
import com.shoplane.models.Bill;
import com.shoplane.models.Role;
import com.shoplane.models.User;
import com.shoplane.services.SuperService;
import com.shoplane.utils.Constants;
import com.shoplane.utils.Helper;

public class BillService extends SuperService {

  BillDAO billDAO = null;
  UserDAO userDAO = null;
  RoleDAO roleDAO = null;

  public BillService(HttpServletRequest request, HttpServletResponse response) {
    super(request, response);
    this.billDAO = new BillDAO();
    this.userDAO = new UserDAO();
    this.roleDAO = new RoleDAO();
  }

  // [GET] ListBillServlet
  public void getListBill() throws IOException {
    try {
      super.setEncoding(Constants.UTF8);
      // Set url patten active sidebar item
      super.getSession().setAttribute("urlPatten", Constants.BILLS);
      // Set encoding
      super.setEncoding(Constants.UTF8);
      // define url
      String url = "/pages/system/bills/index.jsp";
      String statusStr = super.getParameter("status");
      String currentPageStr = super.getParameter("current_page");
      String pageSizeStr = super.getParameter("page_size");

      // Convert string to int
      int currentPage = 1;
      int pageSize = 10;
      int status = 2;

      if (currentPageStr != null && pageSizeStr != null) {
        if (Helper.isNumeric(currentPageStr)) {
          currentPage = Integer.parseInt(currentPageStr);
        }

        if (Helper.isNumeric(pageSizeStr)) {
          pageSize = Integer.parseInt(pageSizeStr);
        }
      }
      if (statusStr != null) {
        if (Helper.isNumeric(statusStr)) {
          status = Integer.parseInt(statusStr);
        }
      }

      Map<String, Object> params = new HashMap<>();
      List<Bill> bills = new ArrayList<>();
      int totalItem = this.billDAO.count();

      // Get data
      if (statusStr.equals(Constants.ALL_STATUS)) {
        bills = this.billDAO.pagination(currentPage, pageSize);
      } else {
        params.put("statusBill", (byte) status);
        bills = this.billDAO.paginationByStatus(params, currentPage, pageSize);
        totalItem = this.billDAO.countByStatus(params);
      }
      // Chưa ổn lắm => Cần phải fix chỉnh lại chỗ này
      int totalPage = (int) Math.ceil((double) totalItem / pageSize);

      // set params and forward
      super.setAttribute("bills", bills);
      super.setAttribute("status", status);
      super.setAttribute("currentPage", currentPage);
      super.setAttribute("pageSize", pageSize);
      super.setAttribute("totalPage", totalPage);

      super.forwardToPage(url);

      super.getSession().setAttribute("createBillStatus", null);
      super.getSession().setAttribute("editBillStatus", null);

    } catch (Exception e) {
      super.log(e.getMessage());
      String error = super.getContextPath() + "/system/500";
      super.redirectToPage(error);
    }
  }

  // [GET] EditBillServlet
  public void getEditBill() throws IOException {
    try {
      super.setEncoding(Constants.UTF8);
      // define url to forward
      String url = "/pages/system/bills/editBill.jsp";
      // get bill Id
      String billId = request.getParameter("bill_id");
      // find bill By Id
      Bill foundBill = this.billDAO.find(billId);
      // Get data
      Role role = this.roleDAO.find(Constants.USER_ROLE);
      Map<String, Object> params = new HashMap<>();
      params.put("role", role);
      List<User> users = this.userDAO.findByRole(params);

      // Set Att
      super.setAttribute("billId", billId);
      super.setAttribute("bill", foundBill);
      super.setAttribute("users", users);
      // forward parameter to another page
      super.forwardToPage(url);

    } catch (Exception e) {
      super.log(e.getMessage());
      String error = super.getContextPath() + "/system/500";
      super.redirectToPage(error);
    }
  }

  // [POST] EditBillServlet
  public void updateBill() throws IOException {
    try {
      super.setEncoding(Constants.UTF8);
      // define url to redirect
      String url = super.getContextPath() + "/system/bills/?status=2&current_page=1&page_size=10";

      // get updated value from updating form
      String billId = super.getParameter("billId");
      byte status = Byte.parseByte(request.getParameter("statusBill"));
      String editBillStatus = "";

      // Get data
      Bill updatedBill = this.billDAO.find(billId);

      // validate Bill
      if (updatedBill != null) {
        updatedBill.setStatusBill(status);
        this.billDAO.update(updatedBill);
        editBillStatus = Constants.SUCCESS_STATUS;
        super.getSession().setAttribute("editBillStatus", editBillStatus);
      }

      // redirect to BillServlet
      this.redirectToPage(url);

    } catch (Exception e) {
      super.log(e.getMessage());
      String error = super.getContextPath() + "/system/500";
      this.redirectToPage(error);
    }
  }

  // [GET] CreateBillServlet
  public void getBillForm() throws IOException {
    try {
      super.setEncoding(Constants.UTF8);
      // define url to redirect
      String url = "/pages/system/bills/createBill.jsp";

      // Get data
      Role role = this.roleDAO.find(Constants.USER_ROLE);
      Map<String, Object> params = new HashMap<>();
      params.put("role", role);
      List<User> users = this.userDAO.findByRole(params);

      // Set att
      super.setAttribute("users", users);
      super.forwardToPage(url);

    } catch (Exception e) {
      super.log(e.getMessage());
      String error = super.getContextPath() + "/system/500";
      this.redirectToPage(error);
    }
  }

  // [POST] CreateBillServlet
  public void submitCreateBillForm() throws IOException {
    try {
      super.setEncoding(Constants.UTF8);
      // define url to redirect
      String url = super.getContextPath() + "/system/bills/?status=2&current_page=1&page_size=10";
      // Get data
      String billId = super.getParameter("billId");
      String createdAtStr = super.getParameter("date");
      String customerId = super.getParameter("customerId");
      String statusBillStr = super.getParameter("statusBill");
      Date createAt = null;
      User customer = null;
      int statusBill = 0;
      String createBillStatus = "";

      // Format date
      if (createdAtStr == null || createdAtStr.equals("")) {
        createAt = new Date();
      } else {
        createAt = new SimpleDateFormat("yyyy-mm-dd").parse(createdAtStr);
      }

      // Get customer
      if (customerId != null) {
        customer = this.userDAO.find(customerId);
      }

      // Check status
      if (statusBillStr != null) {
        if (Helper.isNumeric(statusBillStr)) {
          statusBill = Integer.parseInt(statusBillStr);
        }
      }

      // Create bill
      Bill bill = new Bill();
      bill.setBillId(billId);
      bill.setDate(createAt);
      bill.setUser(customer);
      bill.setStatusBill((byte) statusBill);
      this.billDAO.create(bill);

      // Set notification
      createBillStatus = Constants.SUCCESS_STATUS;
      super.getSession().setAttribute("createBillStatus", createBillStatus);

      // Redirect
      super.redirectToPage(url);

    } catch (Exception e) {
      super.log(e.getMessage());
      String error = super.getContextPath() + "/system/500";
      this.redirectToPage(error);
    }
  }

}
