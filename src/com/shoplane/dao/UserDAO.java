package com.shoplane.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.shoplane.models.User;

public class UserDAO extends JpaDAO<User> implements GenericDAO<User> {
  public UserDAO() {
    super();
  }

  @Override
  public User create(User entity) {
    return super.create(entity);
  }

  @Override
  public User update(User entity) {
    return super.update(entity);
  }

  @Override
  public void delete(Object id) {
    super.delete(User.class, id);
  }

  @Override
  public User find(Object primaryKey) {
    return super.find(User.class, primaryKey);
  }

  @Override
  public List<User> findAll() {
    String queryString = "User.findAll";
    return super.findAll(queryString, User.class);
  }

  @Override
  public List<User> findWithNamedQuery(String queryName, Map<String, Object> parameters) {
    return super.findWithNamedQuery(queryName, parameters);
  }

  public User findByEmail(String email) {
    String queryName = "User.findByEmail";
    Map<String, Object> param = new HashMap<>();
    param.put("email", email);
    List<User> users = super.findWithNamedQuery(queryName, param);
    if (users.isEmpty()) {
      return null;
    }
    return users.get(0);
  }

  public List<User> findByIsDeleted(byte isDeleteAcc) {
    String queryName = "User.findByIsDeleted";
    Map<String, Object> param = new HashMap<>();
    param.put("isDeleteAcc", isDeleteAcc);
    return super.findWithNamedQuery(queryName, param);
  }

  @Override
  public List<User> pagination(int currentPage, int pageSize) {
    String queryString = "User.findAll";
    return super.pagination(queryString, User.class, currentPage, pageSize);
  }

  @Override
  public int count() {
    String queryName = "User.count";
    return super.count(queryName);
  }

  public List<User> findByRole(Map<String, Object> parameters) {
    String queryName = "User.findByRole";
    return super.findWithNamedQuery(queryName, parameters);
  }

  public int countByRole(Map<String, Object> parameters) {
    String queryName = "User.countByRole";
    return super.countWithNamedQuery(queryName, parameters);
  }

}
