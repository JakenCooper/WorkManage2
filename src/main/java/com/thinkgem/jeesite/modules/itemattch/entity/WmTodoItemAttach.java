package com.thinkgem.jeesite.modules.itemattch.entity;

import java.util.Date;

import com.thinkgem.jeesite.common.persistence.DataEntity;
import com.thinkgem.jeesite.modules.item.entity.WmTodoItem;

public class WmTodoItemAttach extends DataEntity<WmTodoItemAttach>{
	
	private static final long serialVersionUID = -5075575031669365097L;
	
	public WmTodoItemAttach(String wmTodoItemId, String addDate, String fileName) {
		super();
		this.wmTodoItemId = wmTodoItemId;
		this.addDate = addDate;
		this.fileName = fileName;
	}

	private String id;
	
	private String wmTodoItemId;
	
	private String addDate;
	
	private String fileName;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getWmTodoItemId() {
		return wmTodoItemId;
	}

	public void setWmTodoItemId(String wmTodoItemId) {
		this.wmTodoItemId = wmTodoItemId;
	}

	public String getAddDate() {
		return addDate;
	}

	public void setAddDate(String addDate) {
		this.addDate = addDate;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
}
