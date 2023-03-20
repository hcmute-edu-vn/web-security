package com.shoplane.models;

import java.io.Serializable;
import javax.persistence.*;
import java.util.List;


/**
 * The persistent class for the Colors database table.
 * 
 */
@Entity
@Table(name="Colors")
@NamedQuery(name="Color.findAll", query="SELECT c FROM Color c")
public class Color implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name="color_id")
	private String colorId;

	@Column(name="color_name")
	private String colorName;

	//bi-directional many-to-one association to Option
	@OneToMany(mappedBy="color")
	private List<Option> options;

	public Color() {
	}

	public String getColorId() {
		return this.colorId;
	}

	public void setColorId(String colorId) {
		this.colorId = colorId;
	}

	public String getColorName() {
		return this.colorName;
	}

	public void setColorName(String colorName) {
		this.colorName = colorName;
	}

	public List<Option> getOptions() {
		return this.options;
	}

	public void setOptions(List<Option> options) {
		this.options = options;
	}

	public Option addOption(Option option) {
		getOptions().add(option);
		option.setColor(this);

		return option;
	}

	public Option removeOption(Option option) {
		getOptions().remove(option);
		option.setColor(null);

		return option;
	}

}