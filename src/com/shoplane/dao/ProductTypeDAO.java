package com.shoplane.dao;

import java.util.List;
import java.util.Map;

import com.shoplane.models.ProductType;

public class ProductTypeDAO extends JpaDAO<ProductType> implements GenericDAO<ProductType> {
  public ProductTypeDAO() {
    super();
  }

  @Override
  public ProductType create(ProductType entity) {
    return super.create(entity);
  }

  @Override
  public ProductType update(ProductType entity) {
    return super.update(entity);
  }

  @Override
  public void delete(Object id) {
    super.delete(ProductType.class, id);
  }

  @Override
  public ProductType find(Object primaryKey) {
    return super.find(ProductType.class, primaryKey);
  }

  @Override
  public List<ProductType> findAll() {
    String queryString = "ProductType.findAll";
    return super.findAll(queryString, ProductType.class);
  }

  @Override
  public List<ProductType> findWithNamedQuery(String queryName, Map<String, Object> parameters) {
    return super.findWithNamedQuery(queryName, parameters);
  }

  @Override
  public List<ProductType> pagination(int currentPage, int pageSize) {
    String queryString = "ProductType.findAll";
    return super.pagination(queryString, ProductType.class, currentPage, pageSize);
  }

  @Override
  public int count() {
    // TODO Auto-generated method stub
    return 0;
  }
}
