package com.shoplane.models;

import java.io.Serializable;
import javax.persistence.*;
import java.util.List;


/**
 * The persistent class for the ProductTypes database table.
 * 
 */
@Entity
@Table(name="ProductTypes")
@NamedQuery(name="ProductType.findAll", query="SELECT p FROM ProductType p")
public class ProductType implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name="type_id")
	private String typeId;

	@Column(name="type_name")
	private String typeName;

	//bi-directional many-to-one association to Category
	@OneToMany(mappedBy="productTypeBean")
	private List<Category> categories;

	//bi-directional many-to-one association to Product
	@OneToMany(mappedBy="productTypeBean")
	private List<Product> products;

	public ProductType() {
	}

	public String getTypeId() {
		return this.typeId;
	}

	public void setTypeId(String typeId) {
		this.typeId = typeId;
	}

	public String getTypeName() {
		return this.typeName;
	}

	public void setTypeName(String typeName) {
		this.typeName = typeName;
	}

	public List<Category> getCategories() {
		return this.categories;
	}

	public void setCategories(List<Category> categories) {
		this.categories = categories;
	}

	public Category addCategory(Category category) {
		getCategories().add(category);
		category.setProductTypeBean(this);

		return category;
	}

	public Category removeCategory(Category category) {
		getCategories().remove(category);
		category.setProductTypeBean(null);

		return category;
	}

	public List<Product> getProducts() {
		return this.products;
	}

	public void setProducts(List<Product> products) {
		this.products = products;
	}

	public Product addProduct(Product product) {
		getProducts().add(product);
		product.setProductTypeBean(this);

		return product;
	}

	public Product removeProduct(Product product) {
		getProducts().remove(product);
		product.setProductTypeBean(null);

		return product;
	}

}