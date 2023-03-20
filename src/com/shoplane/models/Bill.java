package com.shoplane.models;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * The persistent class for the Bills database table.
 * 
 */
@Entity
@Table(name = "Bills")
@NamedQueries({
    @NamedQuery(name = "Bill.findAll", query = "SELECT b FROM Bill b"),
    @NamedQuery(name = "Bill.findByUser", query = "SELECT b FROM Bill b WHERE b.user = :user"),
    @NamedQuery(name = "Bill.findByStatus", query = "SELECT b FROM Bill b WHERE b.statusBill = :statusBill ORDER BY b.totalPrice DESC"),
    @NamedQuery(name = "Bill.count", query = "SELECT COUNT(b) FROM Bill b"),
    @NamedQuery(name = "Bill.countByStatus", query = "SELECT COUNT(b) FROM Bill b WHERE b.statusBill = :statusBill"),
    @NamedQuery(name = "Bill.totalPrice", query = "SELECT SUM(b.totalPrice) FROM Bill b")
})
public class Bill implements Serializable {
  private static final long serialVersionUID = 1L;

  @Id
  @Column(name = "bill_id")
  private String billId;

  @Temporal(TemporalType.TIMESTAMP)
  private Date date;

  @Column(name = "status_bill")
  private byte statusBill;

  @Column(name = "total_price")
  private int totalPrice;

  // bi-directional many-to-one association to User
  @ManyToOne
  @JoinColumn(name = "user_id")
  private User user;

  // bi-directional many-to-one association to Order
  @OneToMany(mappedBy = "bill", fetch = FetchType.EAGER, cascade = CascadeType.PERSIST)
  private List<Order> orders;

  public Bill() {
  }

  public String getBillId() {
    return this.billId;
  }

  public void setBillId(String billId) {
    this.billId = billId;
  }

  public Date getDate() {
    return this.date;
  }

  public void setDate(Date date) {
    this.date = date;
  }

  public byte getStatusBill() {
    return this.statusBill;
  }

  public void setStatusBill(byte statusBill) {
    this.statusBill = statusBill;
  }

  public int getTotalPrice() {
    return this.totalPrice;
  }

  public void setTotalPrice(int totalPrice) {
    this.totalPrice = totalPrice;
  }

  public User getUser() {
    return this.user;
  }

  public void setUser(User user) {
    this.user = user;
  }

  public List<Order> getOrders() {
    return this.orders;
  }

  public void setOrders(List<Order> orders) {
    this.orders = orders;
  }

  public Order addOrder(Order order) {
    getOrders().add(order);
    order.setBill(this);

    return order;
  }

  public Order removeOrder(Order order) {
    getOrders().remove(order);
    order.setBill(null);

    return order;
  }

}