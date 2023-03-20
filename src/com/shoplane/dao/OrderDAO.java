package com.shoplane.dao;

import java.util.List;

import com.shoplane.models.Order;

public class OrderDAO extends JpaDAO<Order> implements GenericDAO<Order> {

  @Override
  public Order create(Order entity) {
    return super.create(entity);
  }

  @Override
  public Order update(Order entity) {
    return super.update(entity);
  }

  @Override
  public void delete(Object id) {
    super.delete(Order.class, id);
  }

  @Override
  public Order find(Object primaryKey) {
    return super.find(Order.class, primaryKey);
  }

  @Override
  public List<Order> findAll() {
    String queryName = "Order.findAll";
    return super.findAll(queryName, Order.class);
  }

  @Override
  public List<Order> pagination(int currentPage, int pageSize) {
    String queryName = "Order.findAll";
    return super.pagination(queryName, Order.class, currentPage, pageSize);
  }

  @Override
  public int count() {
    // TODO Auto-generated method stub
    return 0;
  }

}
