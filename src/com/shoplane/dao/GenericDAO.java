package com.shoplane.dao;

import java.util.List;

public interface GenericDAO<T> {
  public T create(T entity);

  public T update(T entity);

  public void delete(Object id);

  public T find(Object primaryKey);

  public List<T> findAll();

  public List<T> pagination(int currentPage, int pageSize);

  public int count();
}
