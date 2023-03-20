package com.shoplane.dao;

import java.util.List;

import com.shoplane.models.Color;

public class ColorDAO extends JpaDAO<Color> implements GenericDAO<Color> {

  public ColorDAO() {
    super();
  }

  @Override
  public void delete(Object id) {
    super.delete(Color.class, id);

  }

  @Override
  public Color find(Object primaryKey) {
    return super.find(Color.class, primaryKey);
  }

  @Override
  public List<Color> findAll() {
    String queryName = "Color.findAll";
    return super.findAll(queryName, Color.class);
  }

  @Override
  public List<Color> pagination(int currentPage, int pageSize) {
    String queryName = "Color.findAll";
    return super.pagination(queryName, Color.class, currentPage, pageSize);
  }

  @Override
  public int count() {
    String queryName = "";
    return super.count(queryName);
  }

}
