/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.item.entity;

import java.util.Date;

import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.common.persistence.DataEntity;
import com.thinkgem.jeesite.common.utils.excel.annotation.ExcelField;

/**
 * 待办事项管理Entity
 * @author 杨萌
 * @version 2018-04-23
 */
public class WmTodoItem extends DataEntity<WmTodoItem> {
	
	private static final long serialVersionUID = 1L;
	private String content;		// 内容
	private String operationType;		// 待操作类型
	private String itemType;		// 事项类型
	private String status;		// 状态
	/*private String page;
	private String limit;*/
	private String title;
	private String isreplay;
	
	private String layuiPage;
	private String layuiLimit;
	//是否已经申领 标志
	private String showicon;
	
	private String user;
	
	private String finishdate;
	
	//排序
	private String field;
	private String order;
	
	private String preId;
	
	
	
	public String getPreId() {
		return preId;
	}

	public void setPreId(String preId) {
		this.preId = preId;
	}

	public String getIsreplay() {
		return isreplay;
	}

	public void setIsreplay(String isreplay) {
		this.isreplay = isreplay;
	}

	


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

	public String getUser() {
		return user;
	}

	public void setUser(String user) {
		this.user = user;
	}

	public String getShowicon() {
		return showicon;
	}

	public void setShowicon(String showicon) {
		this.showicon = showicon;
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

	private String month;
	
	
	public String getMonth() {
		return month;
	}

	public void setMonth(String month) {
		this.month = month;
	}

	/*public String getPage() {
		return page;
	}

	public void setPage(String page) {
		this.page = page;
	}

	public String getLimit() {
		return limit;
	}

	public void setLimit(String limit) {
		this.limit = limit;
	}*/

	public WmTodoItem() {
		super();
	}

	public WmTodoItem(String id){
		super(id);
	}

	@ExcelField(title="内容", align=2, sort=25)
	@Length(min=0, max=255, message="内容长度必须介于 0 和 255 之间")
	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}
	
	@ExcelField(title="待操作类型", align=2, sort=20 ,dictType="item_operationType")
	@Length(min=0, max=64, message="待操作类型长度必须介于 0 和 64 之间")
	public String getOperationType() {
		return operationType;
	}

	public void setOperationType(String operationType) {
		this.operationType = operationType;
	}
	
	@ExcelField(title="事项类型", align=2, sort=20 ,dictType="item_itemType") 
	@Length(min=0, max=64, message="事项类型长度必须介于 0 和 64 之间")
	public String getItemType() {
		return itemType;
	}

	public void setItemType(String itemType) {
		this.itemType = itemType;
	}
	@ExcelField(title="状态", align=2, sort=20,dictType="item_status")
	@Length(min=0, max=64, message="状态长度必须介于 0 和 64 之间")
	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
	
}