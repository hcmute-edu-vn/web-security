package com.shoplane.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.shoplane.models.Product;
import com.shoplane.models.ProductImage;

public class ProductImageDAO extends JpaDAO<ProductImage> implements GenericDAO<ProductImage> {

  public ProductImageDAO() {
    super();
  }

  @Override
  public ProductImage create(ProductImage entity) {
    return super.create(entity);
  }

  @Override
  public ProductImage update(ProductImage entity) {
    return super.update(entity);
  }

  @Override
  public void delete(Object id) {
    super.delete(ProductImage.class, id);
  }

  @Override
  public ProductImage find(Object primaryKey) {
    return super.find(ProductImage.class, primaryKey);
  }

  @Override
  public List<ProductImage> findAll() {
    String queryName = "ProductImage.findAll";
    return super.findAll(queryName, ProductImage.class);
  }

  @Override
  public List<ProductImage> findWithNamedQuery(String queryName, Map<String, Object> parameters) {
    return super.findWithNamedQuery(queryName, parameters);
  }

  public List<ProductImage> findByProduct(Product product) {
    String queryName = "ProductImage.findByProduct";
    Map<String, Object> param = new HashMap<>();
    param.put("product", product);
    return this.findWithNamedQuery(queryName, param);
  }

  @Override
  public List<ProductImage> pagination(int currentPage, int pageSize) {
    String queryName = "ProductImage.findAll";
    return super.pagination(queryName, ProductImage.class, currentPage, pageSize);
  }

  @Override
  public int count() {
    // TODO Auto-generated method stub
    return 0;
  }

  public int bulkDelete(List<ProductImage> productImages) {
    int rowCountDeleted = 0;
    for (ProductImage productImage : productImages) {
      this.delete(productImage.getImageId());
      rowCountDeleted++;
    }
    return rowCountDeleted;
  }
}
