package com.shoplane.dao;

import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.persistence.Query;

public class JpaDAO<T> {
  private static final EntityManagerFactory entityManagerFactory;

  static {
    entityManagerFactory = Persistence.createEntityManagerFactory("shoplane-ft");
  }

  public JpaDAO() {
  }

  // create instance
  public T create(T entity) {
    EntityManager entityManager = entityManagerFactory.createEntityManager();
    entityManager.getTransaction().begin();
    entityManager.persist(entity);
    entityManager.getTransaction().commit();
    entityManager.close();
    return entity;
  }

  // Update
  public T update(T entity) {
    EntityManager entityManager = entityManagerFactory.createEntityManager();
    entityManager.getTransaction().begin();
    entity = entityManager.merge(entity);
    entityManager.getTransaction().commit();
    entityManager.close();
    return entity;
  }

  // Delete
  public void delete(Class<T> type, Object id) {
    EntityManager entityManager = entityManagerFactory.createEntityManager();
    entityManager.getTransaction().begin();
    Object reference = entityManager.getReference(type, id);
    entityManager.remove(reference);
    entityManager.getTransaction().commit();
    entityManager.close();
  }

  // Find
  public T find(Class<T> type, Object primaryKey) {
    EntityManager entityManager = entityManagerFactory.createEntityManager();
    T result = entityManager.find(type, primaryKey);
    if (result != null) {
      entityManager.refresh(result);
    }
    entityManager.close();
    return result;
  }

  @SuppressWarnings("unchecked")
  public T findSingleResultByNamedQuery(String queryName, Map<String, Object> params) {
    EntityManager entityManager = entityManagerFactory.createEntityManager();
    Query query = entityManager.createNamedQuery(queryName);
    Set<Entry<String, Object>> setParameters = params.entrySet();
    for (Entry<String, Object> entry : setParameters) {
      query.setParameter(entry.getKey(), entry.getValue());
    }
    T result = (T) query.getSingleResult();
    entityManager.close();
    return result;
  }

  // Find all
  @SuppressWarnings("unchecked")
  public List<T> findAll(String queryString, Class<T> type) {
    EntityManager entityManager = entityManagerFactory.createEntityManager();
    Query query = entityManager.createNamedQuery(queryString, type);
    List<T> result = query.getResultList();
    entityManager.close();
    return result;
  }

  @SuppressWarnings("unchecked")
  public List<T> findWithNamedQuery(String queryName, Map<String, Object> parameters) {
    EntityManager entityManager = entityManagerFactory.createEntityManager();
    Query query = entityManager.createNamedQuery(queryName);
    Set<Entry<String, Object>> setParameters = parameters.entrySet();
    for (Entry<String, Object> entry : setParameters) {
      query.setParameter(entry.getKey(), entry.getValue());
    }
    List<T> result = query.getResultList();
    entityManager.close();
    return result;
  }

  // Find all
  @SuppressWarnings("unchecked")
  public List<T> pagination(String queryString, Class<T> type, int currentPage, int pageSize) {
    EntityManager entityManager = entityManagerFactory.createEntityManager();
    Query query = entityManager.createNamedQuery(queryString, type);
    List<T> result = query.setFirstResult((currentPage - 1) * pageSize)
        .setMaxResults(pageSize).getResultList();
    entityManager.close();
    return result;
  }

  @SuppressWarnings("unchecked")
  public List<T> paginationWithNamedQuery(String queryName, Class<T> type, Map<String, Object> parameters,
      int currentPage, int pageSize) {
    EntityManager entityManager = entityManagerFactory.createEntityManager();

    Query query = entityManager.createNamedQuery(queryName);
    Set<Entry<String, Object>> setParameters = parameters.entrySet();
    for (Entry<String, Object> entry : setParameters) {
      query.setParameter(entry.getKey(), entry.getValue());
    }

    List<T> result = query.setFirstResult((currentPage - 1) * pageSize)
        .setMaxResults(pageSize).getResultList();
    entityManager.close();
    return result;
  }

  public int count(String queryName) {
    EntityManager entityManager = entityManagerFactory.createEntityManager();
    entityManager.getTransaction().begin();

    int maxResults = ((Long) entityManager.createNamedQuery(queryName).getSingleResult()).intValue();

    entityManager.getTransaction().commit();
    entityManager.close();
    return maxResults;
  }

  public int countWithNamedQuery(String queryName, Map<String, Object> params) {
    EntityManager entityManager = entityManagerFactory.createEntityManager();
    entityManager.getTransaction().begin();
    Query query = entityManager.createNamedQuery(queryName);
    Set<Entry<String, Object>> setParameters = params.entrySet();
    for (Entry<String, Object> entry : setParameters) {
      query.setParameter(entry.getKey(), entry.getValue());
    }
    int maxResults = ((Long) query.getSingleResult()).intValue();
    entityManager.getTransaction().commit();
    entityManager.close();
    return maxResults;
  }
}
