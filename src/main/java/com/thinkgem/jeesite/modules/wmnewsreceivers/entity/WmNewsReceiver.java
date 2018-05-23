/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.wmnewsreceivers.entity;

import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 消息接收管理Entity
 * @author 杨萌
 * @version 2018-05-10
 */
public class WmNewsReceiver extends DataEntity<WmNewsReceiver> {
	
	private static final long serialVersionUID = 1L;
	private String user;		// 接收人
	private String newsid;		// 消息id
	private String status;		// 状态
	private String replaycontent;		// 回复内容
	
	//关联字段
	private String content;
	private String title;
	private String sender;
	 
	
	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getSender() {
		return sender;
	}

	public void setSender(String sender) {
		this.sender = sender;
	}

	public WmNewsReceiver() {
		super();
	}

	public WmNewsReceiver(String id){
		super(id);
	}

	@Length(min=0, max=255, message="接收人长度必须介于 0 和 255 之间")
	public String getUser() {
		return user;
	}

	public void setUser(String user) {
		this.user = user;
	}
	
	@Length(min=0, max=255, message="消息id长度必须介于 0 和 255 之间")
	public String getNewsid() {
		return newsid;
	}

	public void setNewsid(String newsid) {
		this.newsid = newsid;
	}
	
	@Length(min=0, max=255, message="状态长度必须介于 0 和 255 之间")
	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
	
	@Length(min=0, max=255, message="回复内容长度必须介于 0 和 255 之间")
	public String getReplaycontent() {
		return replaycontent;
	}

	public void setReplaycontent(String replaycontent) {
		this.replaycontent = replaycontent;
	}
	
}