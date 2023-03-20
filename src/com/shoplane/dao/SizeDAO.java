package com.shoplane.dao;

import java.util.List;
import java.util.Map;

import com.shoplane.models.Size;

public class SizeDAO extends JpaDAO<Size> implements GenericDAO<Size> {

  public SizeDAO() {
    super();
  }

  @Override
  public Size create(Size entity) {
    return super.create(entity);
  }

  @Override
  public Size update(Size entity) {
    return super.update(entity);
  }

  @Override
  public void delete(Object id) {
    super.delete(Size.class, id);
  }

  @Override
  public Size find(Object primaryKey) {
    return super.find(Size.class, primaryKey);
  }

  @Override
  public List<Size> findAll() {
    String queryName = "Size.findAll";
    return super.findAll(queryName, Size.class);
  }

  @Override
  public List<Size> findWithNamedQuery(String queryName, Map<String, Object> parameters) {
    return super.findWithNamedQuery(queryName, parameters);
  }

  @Override
  public List<Size> pagination(int currentPage, int pageSize) {
    String queryName = "Size.findAll";
    return super.pagination(queryName, Size.class, currentPage, pageSize);
  }

  @Override
  public int count() {
    // TODO Auto-generated method stub
    return 0;
  }

}
