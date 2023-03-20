package com.shoplane.models;

import java.io.Serializable;
import javax.persistence.*;
import java.util.List;


/**
 * The persistent class for the Sizes database table.
 * 
 */
@Entity
@Table(name="Sizes")
@NamedQuery(name="Size.findAll", query="SELECT s FROM Size s")
public class Size implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name="size_id")
	private String sizeId;

	@Column(name="size_name")
	private String sizeName;

	//bi-directional many-to-one association to Option
	@OneToMany(mappedBy="size")
	private List<Option> options;

	public Size() {
	}

	public String getSizeId() {
		return this.sizeId;
	}

	public void setSizeId(String sizeId) {
		this.sizeId = sizeId;
	}

	public String getSizeName() {
		return this.sizeName;
	}

	public void setSizeName(String sizeName) {
		this.sizeName = sizeName;
	}

	public List<Option> getOptions() {
		return this.options;
	}

	public void setOptions(List<Option> options) {
		this.options = options;
	}

	public Option addOption(Option option) {
		getOptions().add(option);
		option.setSize(this);

		return option;
	}

	public Option removeOption(Option option) {
		getOptions().remove(option);
		option.setSize(null);

		return option;
	}

}