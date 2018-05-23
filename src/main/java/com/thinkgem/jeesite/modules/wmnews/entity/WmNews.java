/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.wmnews.entity;

import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 通知管理Entity
 * @author 陈宏
 * @version 2018-05-09
 */
public class WmNews extends DataEntity<WmNews> {
	
	private static final long serialVersionUID = 1L;
	private String content;		// 内容
	private String title;		// 标题
	
	private String sender;		// 发送人
			
	private String messageid;		// 消息id
	
	//分页
	private String layuiPage;
	private String layuiLimit;
	//排序关联
	private String field; //排序字段
	private String order; //排序方式
	
	private String start;
	private String end;
	
	
	
	//从表字段
	private String user;
	
	private String replaycontent;
	
	private String status;		// 状态
	
	private String receivers;
	
	
	

	public String getReceivers() {
		return receivers;
	}

	public void setReceivers(String receivers) {
		this.receivers = receivers;
	}

	public String getReplaycontent() {
		return replaycontent;
	}

	public void setReplaycontent(String replaycontent) {
		this.replaycontent = replaycontent;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	

	public String getUser() {
		return user;
	}

	public void setUser(String user) {
		this.user = user;
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

	//用户搜索 接收or发送
	private String type;
	
	
	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
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

	public WmNews() {
		super();
	}

	public WmNews(String id){
		super(id);
	}

	@Length(min=0, max=255, message="内容长度必须介于 0 和 255 之间")
	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}
	
	@Length(min=0, max=255, message="标题长度必须介于 0 和 255 之间")
	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}
	
	
	@Length(min=0, max=255, message="发送人长度必须介于 0 和 255 之间")
	public String getSender() {
		return sender;
	}

	public void setSender(String sender) {
		this.sender = sender;
	}
	
	
	
	
	
	@Length(min=0, max=255, message="消息id长度必须介于 0 和 255 之间")
	public String getMessageid() {
		return messageid;
	}

	public void setMessageid(String messageid) {
		this.messageid = messageid;
	}
	
}