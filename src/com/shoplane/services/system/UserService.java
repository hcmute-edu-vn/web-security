package com.shoplane.services.system;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.shoplane.dao.RoleDAO;
import com.shoplane.dao.UserDAO;
import com.shoplane.models.Role;
import com.shoplane.models.User;
import com.shoplane.services.SuperService;
import com.shoplane.utils.Bcrypt;
import com.shoplane.utils.Constants;
import com.shoplane.utils.Helper;

public class UserService extends SuperService {

  UserDAO userDAO = null;
  RoleDAO roleDAO = null;

  public UserService(HttpServletRequest request, HttpServletResponse response) {
    super(request, response);
    this.userDAO = new UserDAO();
    this.roleDAO = new RoleDAO();
  }

  // [GET] ListUserServlet
  public void getListUser() throws IOException {
    try {
      super.setEncoding(Constants.UTF8);
      // Set active sidebar item
      super.getSession().setAttribute("urlPatten", Constants.USERS);
      // Define url
      String url = "/pages/system/users/index.jsp";

      String roleId = super.getParameter("role_id");
      String currentPageStr = super.getParameter("current_page");
      String pageSizeStr = super.getParameter("page_size");

      int currentPage = 1;
      int pageSize = 10;
      if (currentPageStr != null && pageSizeStr != null) {
        if (Helper.isNumeric(currentPageStr)) {
          currentPage = Integer.parseInt(currentPageStr);
        }

        if (Helper.isNumeric(pageSizeStr)) {
          pageSize = Integer.parseInt(pageSizeStr);
        }
      }
      if (roleId == null) {
        roleId = Constants.ALL_ROLE;
      }

      // Get Data
      List<User> users = new ArrayList<>();
      List<Role> roles = this.roleDAO.findAll();
      Role role = this.roleDAO.find(roleId);

      // Create params
      Map<String, Object> params = new HashMap<>();
      int totalItem = this.userDAO.count();

      if (roleId.equals(Constants.ALL_ROLE)) {
        users = this.userDAO.pagination(currentPage, pageSize);
      } else {
        params.put("role", role);
        users = this.userDAO.findByRole(params);
        totalItem = this.userDAO.countByRole(params);
      }

      // Chưa ổn lắm => Cần phải fix chỉnh lại chỗ này
      int totalPage = (int) Math.ceil((double) totalItem / pageSize);

      // Set att
      super.setAttribute("users", users);
      super.setAttribute("roles", roles);
      super.setAttribute("roleId", roleId);
      super.setAttribute("currentPage", currentPage);
      super.setAttribute("pageSize", pageSize);
      super.setAttribute("totalItem", totalItem);
      super.setAttribute("totalPage", totalPage);

      // forward
      super.forwardToPage(url);
      // Set null after run one time
      super.getSession().setAttribute("createUserStatus", null);
      super.getSession().setAttribute("editUserStatus", null);
    } catch (Exception e) {
      super.log(e.getMessage());
      String error = super.getContextPath() + "/system/500";
      super.redirectToPage(error);
    }
  }

  // [GET] CreateUserServlet
  public void getCreateUserForm() throws IOException {
    try {
      super.setEncoding(Constants.UTF8);
      // Define url
      String url = "/pages/system/users/createUser.jsp";
      // Get data
      List<Role> roles = this.roleDAO.findAll();
      // Set att
      super.setAttribute("roles", roles);
      // forward
      super.forwardToPage(url);
    } catch (Exception e) {
      super.log(e.getMessage());
      String error = super.getContextPath() + "/system/500";
      super.redirectToPage(error);
    }
  }

  // [POST] CreateUserServlet
  public void submitCreateUserForm() throws IOException {
    try {
      super.setEncoding(Constants.UTF8);
      // Define url
      String url = super.getContextPath() + "/system/users/?role_id=ROL0&current_page=1&page_size=10";
      // Get params
      String userId = super.getParameter("userId");
      String fullname = super.getParameter("fullname");
      String email = super.getParameter("email");
      String phonenumber = super.getParameter("phonenumber");
      String address = super.getParameter("address");
      String password = super.getParameter("password");
      String isActiveStr = super.getParameter("acctiveAcc");
      String roleId = super.getParameter("roleId");
      String pwdHashed = "";
      String createUserStatus = "";

      int isActive = 0;
      if (Helper.isNumeric(isActiveStr)) {
        isActive = Integer.parseInt(isActiveStr);
      }
      if (roleId == null) {
        roleId = Constants.USER_ROLE;
      }
      if (password == null) {
        password = "";
      }

      // hash pwd
      pwdHashed = Bcrypt.hashpwd(password);

      // Get data
      List<Role> roles = this.roleDAO.findAll();
      Role role = this.roleDAO.find(roleId);
      User user = new User();
      user.setUserId(userId);
      user.setFullname(fullname);
      user.setAddress(address);
      user.setRole(role);
      user.setIsActiveAcc((byte) isActive);
      user.setEmail(email);
      user.setPassword(pwdHashed);
      user.setPhonenumber(phonenumber);

      // Create
      this.userDAO.create(user);
      createUserStatus = Constants.SUCCESS_STATUS;
      // Set att
      super.setAttribute("roles", roles);
      super.getSession().setAttribute("createUserStatus", createUserStatus);

      // Redirect
      super.redirectToPage(url);
    } catch (Exception e) {
      super.log(e.getMessage());
      String error = super.getContextPath() + "/system/500";
      super.redirectToPage(error);
    }
  }

  // [GET] EditUserServlet
  public void getEditUserForm() throws IOException {
    try {
      super.setEncoding(Constants.UTF8);
      // Url
      String url = "/pages/system/users/editUser.jsp";
      // Get params
      String userId = request.getParameter("user_id");
      // Get data
      User user = this.userDAO.find(userId);
      List<Role> roles = this.roleDAO.findAll();

      super.setAttribute("userId", userId);
      super.setAttribute("user", user);
      super.setAttribute("roles", roles);
      super.forwardToPage(url);
    } catch (Exception e) {
      super.log(e.getMessage());
      String error = super.getContextPath() + "/system/500";
      super.redirectToPage(error);
    }
  }

  // [POST] EditUserServlet
  public void submitEditUserForm() throws IOException {
    try {
      super.setEncoding(Constants.UTF8);
      // Url
      String url = super.getContextPath() + "/system/users/?role_id=ROL0&current_page=1&page_size=10";
      // Get params
      String userId = request.getParameter("userId");
      String fullname = super.getParameter("fullname");
      String email = super.getParameter("email");
      String phonenumber = super.getParameter("phonenumber");
      String address = super.getParameter("address");
      String isActiveStr = super.getParameter("acctiveAcc");
      String roleId = super.getParameter("roleId");
      String editUserStatus = "";

      // Check
      int isActive = 0;
      if (Helper.isNumeric(isActiveStr)) {
        isActive = Integer.parseInt(isActiveStr);
      }
      if (roleId == null) {
        roleId = Constants.USER_ROLE;
      }

      // Get data
      User user = this.userDAO.find(userId);
      Role role = this.roleDAO.find(roleId);

      // Update
      if (user != null) {
        user.setFullname(fullname);
        user.setAddress(address);
        user.setRole(role);
        user.setIsActiveAcc((byte) isActive);
        user.setEmail(email);
        user.setPhonenumber(phonenumber);
        this.userDAO.update(user);
        editUserStatus = Constants.SUCCESS_STATUS;
      }

      // Set status if update success
      super.getSession().setAttribute("editUserStatus", editUserStatus);
      // Redirect
      super.redirectToPage(url);
    } catch (Exception e) {
      super.log(e.getMessage());
      String error = super.getContextPath() + "/system/500";
      super.redirectToPage(error);
    }
  }

}
