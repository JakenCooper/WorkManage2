package com.thinkgem.jeesite.modules.itemattch.entity;

public class WmTodoItemAttachModel {
	private Integer code;
	private String preid;
	private String absPath;
	
	
	public WmTodoItemAttachModel(Integer code, String preid, String absPath) {
		super();
		this.code = code;
		this.preid = preid;
		this.absPath = absPath;
	}
	public Integer getCode() {
		return code;
	}
	public void setCode(Integer code) {
		this.code = code;
	}
	public String getPreid() {
		return preid;
	}
	public void setPreid(String preid) {
		this.preid = preid;
	}
	public String getAbsPath() {
		return absPath;
	}
	public void setAbsPath(String absPath) {
		this.absPath = absPath;
	}
}
