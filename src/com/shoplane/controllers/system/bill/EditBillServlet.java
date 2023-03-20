package com.shoplane.controllers.system.bill;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.shoplane.services.system.BillService;

@WebServlet(urlPatterns = { "/system/bills/detail", "/system/bills/detail/" })
public class EditBillServlet extends HttpServlet {
  private static final long serialVersionUID = 1L;

  public EditBillServlet() {
    super();
  }

  @Override
  protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    BillService billService = new BillService(request, response);
    billService.getEditBill();
  }

  @Override
  protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    BillService billService = new BillService(request, response);
    billService.updateBill();
  }

}
