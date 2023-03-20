package com.shoplane.controllers.system.user;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.shoplane.dao.RoleDAO;
import com.shoplane.dao.UserDAO;
import com.shoplane.models.Role;
import com.shoplane.models.User;
import com.shoplane.services.system.UserService;

@WebServlet(urlPatterns = { "/system/users/", "/system/users" })
public class ListUserServlet extends HttpServlet {
  private static final long serialVersionUID = 1L;

  UserDAO userDAO = null;

  public ListUserServlet() {
    super();
    this.userDAO = new UserDAO();
  }

  @Override
  protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    UserService userService = new UserService(request, response);
    userService.getListUser();
  }

  public void update(HttpServletRequest request, HttpServletResponse response, String url)
      throws ServletException, IOException {
    try {
      User user = new User();
      Role role = new Role();
      RoleDAO roleDAO = new RoleDAO();

      role = roleDAO.find(request.getParameter("roleAccount"));
      // BeanUtils.populate(user, request.getParameterMap());

      user.setRole(role);
      this.userDAO.update(user);
      response.sendRedirect(url);
    } catch (Exception e) {
      System.out.println(e.getMessage());
    }
  }
}
