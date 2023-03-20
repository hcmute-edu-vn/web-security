package com.shoplane.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.shoplane.models.Option;
import com.shoplane.models.Product;

public class OptionDAO extends JpaDAO<Option> implements GenericDAO<Option> {
  public OptionDAO() {
    super();
  }

  @Override
  public Option create(Option entity) {
    return super.create(entity);
  }

  @Override
  public Option update(Option entity) {
    return super.update(entity);
  }

  @Override
  public void delete(Object id) {
    super.delete(Option.class, id);

  }

  @Override
  public Option find(Object primaryKey) {
    return super.find(Option.class, primaryKey);
  }

  @Override
  public List<Option> findAll() {
    String queryString = "Option.findAll";
    return super.findAll(queryString, Option.class);
  }

  @Override
  public List<Option> findWithNamedQuery(String queryName, Map<String, Object> parameters) {
    return super.findWithNamedQuery(queryName, parameters);
  }

  public List<Option> findByProduct(Product product) {
    String queryName = "Option.findByProduct";
    Map<String, Object> param = new HashMap<>();
    param.put("product", product);
    return this.findWithNamedQuery(queryName, param);
  }

  @Override
  public List<Option> pagination(int currentPage, int pageSize) {
    String queryString = "Option.findAll";
    return super.pagination(queryString, Option.class, currentPage, pageSize);
  }

  @Override
  public int count() {
    // TODO Auto-generated method stub
    return 0;
  }
}
