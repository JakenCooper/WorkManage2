/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.myitems.entity;

import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 我的工作管理Entity
 * @author 杨萌
 * @version 2018-04-26
 */
public class WmUserItem extends DataEntity<WmUserItem> {
	
	private static final long serialVersionUID = 1L;
	private String user;		// 用户名
	private String itemId;		// 事项ID
	private String isFinished;		// 是否完成
	private String handleType;		// 办理类型
	private String handleResult;		// 办理原因
	private String layuiPage;
	private String layuiLimit;
	
	//item表中关联字段
	private String content;
	private String itemType;
	private String title;
	private String finishdate;
	
	//排序关联
	private String field; //排序字段
	private String order; //排序方式

	//搜索时间
	private String start;
    private String end;	
	
	
	

	
	public String getFinishdate() {
		return finishdate;
	}

	public void setFinishdate(String finishdate) {
		this.finishdate = finishdate;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getStart() {
		return start;
	}

	public void setStart(String start) {
		this.start = start;
	}

	public String getEnd() {
		return end;
	}

	public void setEnd(String end) {
		this.end = end;
	}

	public String getField() {
		return field;
	}

	public void setField(String field) {
		this.field = field;
	}

	

	public String getOrder() {
		return order;
	}

	public void setOrder(String order) {
		this.order = order;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getItemType() {
		return itemType;
	}

	public void setItemType(String itemType) {
		this.itemType = itemType;
	}

	public String getLayuiPage() {
		return layuiPage;
	}

	public void setLayuiPage(String layuiPage) {
		this.layuiPage = layuiPage;
	}

	public String getLayuiLimit() {
		return layuiLimit;
	}

	public void setLayuiLimit(String layuiLimit) {
		this.layuiLimit = layuiLimit;
	}

	public WmUserItem() {
		super();
	}

	public WmUserItem(String id){
		super(id);
	}

	@Length(min=0, max=64, message="用户名长度必须介于 0 和 64 之间")
	public String getUser() {
		return user;
	}

	public void setUser(String user) {
		this.user = user;
	}
	
	@Length(min=0, max=64, message="事项ID长度必须介于 0 和 64 之间")
	public String getItemId() {
		return itemId;
	}

	public void setItemId(String itemId) {
		this.itemId = itemId;
	}
	
	@Length(min=0, max=64, message="是否完成长度必须介于 0 和 64 之间")
	public String getIsFinished() {
		return isFinished;
	}

	public void setIsFinished(String isFinished) {
		this.isFinished = isFinished;
	}
	
	@Length(min=0, max=64, message="办理类型长度必须介于 0 和 64 之间")
	public String getHandleType() {
		return handleType;
	}

	public void setHandleType(String handleType) {
		this.handleType = handleType;
	}
	
	@Length(min=0, max=255, message="办理原因长度必须介于 0 和 255 之间")
	public String getHandleResult() {
		return handleResult;
	}

	public void setHandleResult(String handleResult) {
		this.handleResult = handleResult;
	}
	
}