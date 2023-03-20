package com.shoplane.models;

import java.io.Serializable;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.Lob;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;

/**
 * The persistent class for the Products database table.
 * 
 */
@Entity
@Table(name = "Products")
@NamedQueries({
    @NamedQuery(name = "Product.findByCategory", query = "SELECT p FROM Product p WHERE p.category = :category"),
    @NamedQuery(name = "Product.findByProductName", query = "SELECT p FROM Product p WHERE p.productName LIKE :productName"),

    @NamedQuery(name = "Product.findAll", query = "SELECT p FROM Product p"),
    @NamedQuery(name = "Product.count", query = "SELECT COUNT(p) FROM Product p"),

    @NamedQuery(name = "Product.findByProductType", query = "SELECT p FROM Product p WHERE p.productTypeBean = :productType"),
    @NamedQuery(name = "Product.countByProductType", query = "SELECT COUNT(p) FROM Product p WHERE p.productTypeBean = :productType"),

    @NamedQuery(name = "Product.findByIsDeleted", query = "SELECT p FROM Product p WHERE p.isDelete = :isDelete"),
    @NamedQuery(name = "Product.findByProductIdAndIsDeleted", query = "SELECT p FROM Product p WHERE p.isDelete = :isDelete AND p.productId = :productId"),
    @NamedQuery(name = "Product.countByIsDeleted", query = "SELECT COUNT(p) FROM Product p WHERE p.isDelete = :isDelete"),

    @NamedQuery(name = "Product.findByCategoryAndProductType", query = "SELECT p FROM Product p WHERE p.category = :category AND p.productTypeBean = :productType"),
    @NamedQuery(name = "Product.findByCategoryAndProductTypeAndPriceAsc", query = "SELECT p FROM Product p WHERE p.category = :category AND p.productTypeBean = :productType ORDER BY p.newPrice ASC"),
    @NamedQuery(name = "Product.findByCategoryAndProductTypeAndPriceDesc", query = "SELECT p FROM Product p WHERE p.category = :category AND p.productTypeBean = :productType ORDER BY p.newPrice DESC"),
    @NamedQuery(name = "Product.countByProductTypeAndCategory", query = "SELECT COUNT(p) FROM Product p WHERE p.category = :category AND p.productTypeBean = :productType"),

    @NamedQuery(name = "Product.findByProductTypeAndIsDeleted", query = "SELECT p FROM Product p WHERE p.isDelete = :isDelete AND p.productTypeBean = :productType"),
    @NamedQuery(name = "Product.findByProductTypeAndIsDeletedAndPriceAsc", query = "SELECT p FROM Product p WHERE p.isDelete = :isDelete AND p.productTypeBean = :productType ORDER BY p.newPrice ASC"),
    @NamedQuery(name = "Product.findByProductTypeAndIsDeletedAndPriceDesc", query = "SELECT p FROM Product p WHERE p.isDelete = :isDelete AND p.productTypeBean = :productType ORDER BY p.newPrice DESC"),
    @NamedQuery(name = "Product.countByProductTypeAndIsDeleted", query = "SELECT COUNT(p) FROM Product p WHERE p.isDelete = :isDelete AND p.productTypeBean = :productType"),

    @NamedQuery(name = "Product.findByCategoryAndProductTypeAndIsDeletedAndPriceAsc", query = "SELECT p FROM Product p WHERE p.category = :category AND p.productTypeBean = :productType AND p.isDelete = :isDelete ORDER BY p.newPrice ASC"),
    @NamedQuery(name = "Product.findByCategoryAndProductTypeAndIsDeletedAndPriceDesc", query = "SELECT p FROM Product p WHERE p.category = :category AND p.productTypeBean = :productType AND p.isDelete = :isDelete ORDER BY p.newPrice DESC"),
    @NamedQuery(name = "Product.findByCategoryAndProductTypeAndIsDeleted", query = "SELECT p FROM Product p WHERE p.category = :category AND p.productTypeBean = :productType AND p.isDelete = :isDelete"),
    @NamedQuery(name = "Product.countByProductTypeAndCategoryAndIsDeleted", query = "SELECT COUNT(p) FROM Product p WHERE p.category = :category AND p.productTypeBean = :productType AND p.isDelete = :isDelete")
})
public class Product implements Serializable {
  private static final long serialVersionUID = 1L;

  @Id
  @Column(name = "product_id")
  private String productId;

  @Lob
  private String description;

  @Column(name = "is_active")
  private byte isActive;

  @Column(name = "is_delete")
  private byte isDelete;

  @Lob
  @Column(name = "main_image_url")
  private String mainImageUrl;

  private String meterial;

  @Column(name = "new_price")
  private int newPrice;

  @Column(name = "old_price")
  private int oldPrice;

  private String origin;

  private String pattern;

  @Column(name = "product_name")
  private String productName;

  // bi-directional many-to-one association to Option
  @OneToMany(mappedBy = "product")
  private List<Option> options;

  // bi-directional many-to-one association to ProductImage
  @OneToMany(mappedBy = "product")
  private List<ProductImage> productImages;

  // bi-directional many-to-one association to Category
  @ManyToOne
  @JoinColumn(name = "category_id")
  private Category category;

  // bi-directional many-to-one association to ProductType
  @ManyToOne
  @JoinColumn(name = "product_type")
  private ProductType productTypeBean;

  public Product() {
  }

  public String getProductId() {
    return this.productId;
  }

  public void setProductId(String productId) {
    this.productId = productId;
  }

  public String getDescription() {
    return this.description;
  }

  public void setDescription(String description) {
    this.description = description;
  }

  public byte getIsActive() {
    return this.isActive;
  }

  public void setIsActive(byte isActive) {
    this.isActive = isActive;
  }

  public byte getIsDelete() {
    return this.isDelete;
  }

  public void setIsDelete(byte isDelete) {
    this.isDelete = isDelete;
  }

  public String getMainImageUrl() {
    return this.mainImageUrl;
  }

  public void setMainImageUrl(String mainImageUrl) {
    this.mainImageUrl = mainImageUrl;
  }

  public String getMeterial() {
    return this.meterial;
  }

  public void setMeterial(String meterial) {
    this.meterial = meterial;
  }

  public int getNewPrice() {
    return this.newPrice;
  }

  public void setNewPrice(int newPrice) {
    this.newPrice = newPrice;
  }

  public int getOldPrice() {
    return this.oldPrice;
  }

  public void setOldPrice(int oldPrice) {
    this.oldPrice = oldPrice;
  }

  public String getOrigin() {
    return this.origin;
  }

  public void setOrigin(String origin) {
    this.origin = origin;
  }

  public String getPattern() {
    return this.pattern;
  }

  public void setPattern(String pattern) {
    this.pattern = pattern;
  }

  public String getProductName() {
    return this.productName;
  }

  public void setProductName(String productName) {
    this.productName = productName;
  }

  public List<Option> getOptions() {
    return this.options;
  }

  public void setOptions(List<Option> options) {
    this.options = options;
  }

  public Option addOption(Option option) {
    getOptions().add(option);
    option.setProduct(this);

    return option;
  }

  public Option removeOption(Option option) {
    getOptions().remove(option);
    option.setProduct(null);

    return option;
  }

  public List<ProductImage> getProductImages() {
    return this.productImages;
  }

  public void setProductImages(List<ProductImage> productImages) {
    this.productImages = productImages;
  }

  public ProductImage addProductImage(ProductImage productImage) {
    getProductImages().add(productImage);
    productImage.setProduct(this);

    return productImage;
  }

  public ProductImage removeProductImage(ProductImage productImage) {
    getProductImages().remove(productImage);
    productImage.setProduct(null);

    return productImage;
  }

  public Category getCategory() {
    return this.category;
  }

  public void setCategory(Category category) {
    this.category = category;
  }

  public ProductType getProductTypeBean() {
    return this.productTypeBean;
  }

  public void setProductTypeBean(ProductType productTypeBean) {
    this.productTypeBean = productTypeBean;
  }

}