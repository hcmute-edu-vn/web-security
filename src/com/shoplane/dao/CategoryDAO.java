package com.shoplane.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.shoplane.models.Category;

public class CategoryDAO extends JpaDAO<Category> implements GenericDAO<Category> {
  public CategoryDAO() {
    super();
  }

  @Override
  public Category create(Category entity) {
    return super.create(entity);
  }

  @Override
  public Category update(Category entity) {
    return super.update(entity);
  }

  @Override
  public void delete(Object id) {
    super.delete(Category.class, id);

  }

  @Override
  public Category find(Object primaryKey) {
    // TODO Auto-generated method stub
    return super.find(Category.class, primaryKey);
  }

  @Override
  public List<Category> findAll() {
    String queryString = "Category.findAll";
    return super.findAll(queryString, Category.class);
  }

  @Override
  public List<Category> findWithNamedQuery(String queryName, Map<String, Object> parameters) {
    // TODO Auto-generated method stub
    return super.findWithNamedQuery(queryName, parameters);
  }

  public List<Category> findByProductType(Object pType) {
    String queryName = "Category.findByProductType";
    Map<String, Object> param = new HashMap<>();
    param.put("productType", pType);
    return this.findWithNamedQuery(queryName, param);
  }

  public List<Category> findByCategoryName(String categoryName) {
    String queryName = "Category.findByCategoryName";
    Map<String, Object> param = new HashMap<>();
    param.put("categoryName", categoryName);
    return this.findWithNamedQuery(queryName, param);
  }

  @Override
  public List<Category> pagination(int currentPage, int pageSize) {
    String queryString = "Category.findAll";
    return super.pagination(queryString, Category.class, currentPage, pageSize);
  }

  @Override
  public int count() {
    // TODO Auto-generated method stub
    return 0;
  }
}
