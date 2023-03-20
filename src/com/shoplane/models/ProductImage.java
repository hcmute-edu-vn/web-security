package com.shoplane.models;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.Lob;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

/**
 * The persistent class for the ProductImages database table.
 * 
 */
@Entity
@Table(name = "ProductImages")
@NamedQueries({
    @NamedQuery(name = "ProductImage.findAll", query = "SELECT p FROM ProductImage p"),
    @NamedQuery(name = "ProductImage.findByProduct", query = "SELECT p FROM ProductImage p WHERE p.product = :product")
})
public class ProductImage implements Serializable {
  private static final long serialVersionUID = 1L;

  @Id
  @Column(name = "image_id")
  private String imageId;

  @Lob
  @Column(name = "image_url")
  private String imageUrl;

  // bi-directional many-to-one association to Product
  @ManyToOne
  @JoinColumn(name = "product_id")
  private Product product;

  public ProductImage() {
  }

  public String getImageId() {
    return this.imageId;
  }

  public void setImageId(String imageId) {
    this.imageId = imageId;
  }

  public String getImageUrl() {
    return this.imageUrl;
  }

  public void setImageUrl(String imageUrl) {
    this.imageUrl = imageUrl;
  }

  public Product getProduct() {
    return this.product;
  }

  public void setProduct(Product product) {
    this.product = product;
  }

}