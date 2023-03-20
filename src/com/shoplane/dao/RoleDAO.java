package com.shoplane.dao;

import java.util.List;
import java.util.Map;

import com.shoplane.models.Role;

public class RoleDAO extends JpaDAO<Role> implements GenericDAO<Role> {

  public RoleDAO() {
    super();
  }

  @Override
  public Role create(Role entity) {
    return super.create(entity);
  }

  @Override
  public Role update(Role entity) {
    return super.update(entity);
  }

  @Override
  public void delete(Object id) {
    super.delete(Role.class, id);
  }

  @Override
  public Role find(Object primaryKey) {
    return super.find(Role.class, primaryKey);
  }

  @Override
  public List<Role> findAll() {
    String queryName = "Role.findAll";
    return super.findAll(queryName, Role.class);
  }

  @Override
  public List<Role> findWithNamedQuery(String queryName, Map<String, Object> parameters) {
    return super.findWithNamedQuery(queryName, parameters);
  }

  @Override
  public List<Role> pagination(int currentPage, int pageSize) {
    String queryName = "Role.findAll";
    return super.pagination(queryName, Role.class, currentPage, pageSize);
  }

  @Override
  public int count() {
    // TODO Auto-generated method stub
    return 0;
  }

}
