package com.shoplane.services.client;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.shoplane.dao.BillDAO;
import com.shoplane.dao.UserDAO;
import com.shoplane.models.Bill;
import com.shoplane.models.User;
import com.shoplane.services.SuperService;
import com.shoplane.utils.Bcrypt;
import com.shoplane.utils.Constants;

public class AccountService extends SuperService {
  BillDAO billDAO = null;
  UserDAO userDAO = null;

  public AccountService(HttpServletRequest request, HttpServletResponse response) {
    super(request, response);
    this.billDAO = new BillDAO();
    userDAO = new UserDAO();
  }

  // [GET] GetAccountServlet
  public void getAccount() throws IOException {
    try {
      super.setEncoding(Constants.UTF8);
      String url = "/pages/default/account/index.jsp";
      // Get data
      User user = (User) request.getSession().getAttribute("user");
      List<Bill> bills = new ArrayList<>();
      bills = this.billDAO.findByUser(user);
      // Set att
      super.setAttribute("bills", bills);
      // Forwards
      super.forwardToPage(url);
      super.getSession().setAttribute("modifyAccountStatus", null);
      super.getSession().setAttribute("changePasswordAccountStatus", null);
    } catch (Exception e) {
      super.log(e.getMessage());
      String error = super.getContextPath() + "/500";
      super.redirectToPage(error);
    }
  }

  // [GET] ChangePasswordAccountServlet
  public void getChangePasswordForm() throws IOException {
    try {
      super.setEncoding(Constants.UTF8);
      // link
      String url = "/pages/default/account/changePasswordAccount.jsp";
      // Forwards
      super.forwardToPage(url);
    } catch (Exception e) {
      super.log(e.getMessage());
      String error = super.getContextPath() + "/500";
      super.redirectToPage(error);
    }
  }

  // [POST] ChangePasswordAccountServlet
  public void submitChangePasswordForm() throws IOException {
    try {
      super.setEncoding(Constants.UTF8);
      // link
      String url = super.getContextPath() + "/account";
      String changePasswordAccountStatus = "";

      // Get data from form
      String currentPassword = super.getParameter("currentPassword");
      String newPassword = super.getParameter("newPassword").trim();
      String confirmPassword = super.getParameter("confirmPassword").trim();

      // Get data
      User user = (User) request.getSession().getAttribute(Constants.USER_SESSION);
      String errorMsg = "";

      // Validate
      if (user != null) {
        // Check input password match pwd in db
        if (Bcrypt.checkpwd(currentPassword, user.getPassword())) {
          // Check new Password and confirm password
          if (newPassword.equals(confirmPassword)) {
            String passwordHashed = Bcrypt.hashpwd(newPassword);
            user.setPassword(passwordHashed);
            User userUpdated = this.userDAO.update(user);
            super.getSession().setAttribute(Constants.USER_SESSION, userUpdated);
            super.getSession().setAttribute("errMsg", null);
            changePasswordAccountStatus = Constants.SUCCESS_STATUS;
          } else {
            errorMsg = "* Xác nhận mật khẩu không chính xác";
            changePasswordAccountStatus = Constants.FAILURE_STATUS;
            url += "/change-password";
          }
        } else {
          changePasswordAccountStatus = Constants.FAILURE_STATUS;
          errorMsg = "* Mật khẩu không chính xác";
          url += "/change-password";
        }
      }
      // Set status session
      super.getSession().setAttribute("changePasswordAccountStatus", changePasswordAccountStatus);
      // set att
      super.getSession().setAttribute("errMsg", errorMsg);
      // Redirect
      super.redirectToPage(url);

    } catch (Exception e) {
      super.log(e.getMessage());
      String error = super.getContextPath() + "/500";
      super.redirectToPage(error);
    }
  }

  // [GET] ModifyAccountServlet
  public void getModifyAccountForm() throws IOException {
    try {
      super.setEncoding(Constants.UTF8);
      // link
      String url = "/pages/default/account/modifyAccount.jsp";

      /*
       * String email = "doduongthaituan201102@gmail.com";
       * SendMail sendMail = new SendMail();
       * sendMail.sendReceipt(email);
       */

      // Forwards
      super.forwardToPage(url);

    } catch (Exception e) {
      super.log(e.getMessage());
      String error = super.getContextPath() + "/500";
      super.redirectToPage(error);
    }
  }

  // [POST] ModifyAccountServlet
  public void submitModifyAccountForm() throws IOException {
    try {
      super.setEncoding(Constants.UTF8);
      // link
      String url = super.getContextPath() + "/account";

      // Get data
      String fullname = super.getParameter("fullname");
      String phonenumber = super.getParameter("phonenumber");
      String address = super.getParameter("address");
      String errMsg = "";
      String modifyAccountStatus = "";
      User customer = (User) super.getSession().getAttribute(Constants.USER_SESSION);

      if (customer != null) {
        customer.setFullname(fullname);
        customer.setAddress(address);
        customer.setPhonenumber(phonenumber);
        User customerUpdated = this.userDAO.update(customer);
        errMsg = "* Cập nhật thông tin thành công";
        modifyAccountStatus = Constants.SUCCESS_STATUS;
        super.getSession().setAttribute(Constants.USER_SESSION, customerUpdated);
      } else {
        modifyAccountStatus = Constants.FAILURE_STATUS;
        errMsg = "* Cập nhật thông tin thất bại";
        url += "/modify";
      }

      // Set att
      super.getSession().setAttribute("modifyAccountStatus", modifyAccountStatus);
      super.setAttribute("errMsg", errMsg);
      // Forwards
      super.redirectToPage(url);

    } catch (Exception e) {
      super.log(e.getMessage());
      String error = super.getContextPath() + "/500";
      super.redirectToPage(error);
    }
  }

}
