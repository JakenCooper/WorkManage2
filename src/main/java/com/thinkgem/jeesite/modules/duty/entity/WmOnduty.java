/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.duty.entity;

import com.fasterxml.jackson.annotation.JsonFormat;
import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.common.persistence.DataEntity;
import com.thinkgem.jeesite.common.supcan.annotation.treelist.cols.SupCol;
import com.thinkgem.jeesite.common.utils.excel.annotation.ExcelField;

/**
 * 在线排班管理Entity
 * @author 陈宏
 * @version 2018-04-24
 */
public class WmOnduty extends DataEntity<WmOnduty> {
	
	private static final long serialVersionUID = 1L;
	private String id;
	private String date;		// 日期
	private String changeTime;		// 交班时间
	private String changeUser;		// 交班人
	private String ondutyUser;  	// 值班人
	private String receiveTime;		// 值班时间
	private String realOndutyUser;		// 实际值班人
	private String changeStatus;		// 交接状态
	private String leader;		// 带班领导
	private String layuiPage;
	private String layuiLimit;
	private String wmDesc;
	private String field;   //layui 表头排序字段
	private String order;   //layui 表头排序方式
	
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

	@ExcelField(title="描述", align=2, sort=40)
	public String getWmDesc() {
		return wmDesc;
	}

	public void setWmDesc(String wmDesc) {
		this.wmDesc = wmDesc;
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

	public WmOnduty() {
		super();
	}

	public WmOnduty(String id){
		super(id);
	}
	
	@SupCol(isUnique="true", isHide="true")
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@ExcelField(title="值班日期", align=2, sort=20)
	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public String getChangeTime() {
		return changeTime;
	}

	public void setChangeTime(String changeTime) {
		this.changeTime = changeTime;
	}
	
	@Length(min=0, max=64, message="交班人长度必须介于 0 和 64 之间")
	//@ExcelField(title="接班人", align=2, sort=25)
	public String getChangeUser() {
		return changeUser;
	}

	public void setChangeUser(String changeUser) {
		this.changeUser = changeUser;
	}
	
	@Length(min=0, max=64, message="值班人长度必须介于 0 和 64 之间")
	@ExcelField(title="值班人", align=2, sort=30)
	public String getOndutyUser() {
		return ondutyUser;
	}

	public void setOndutyUser(String ondutyUser) {
		this.ondutyUser = ondutyUser;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public String getReceiveTime() {
		return receiveTime;
	}

	public void setReceiveTime(String receiveTime) {
		this.receiveTime = receiveTime;
	}
	
	@Length(min=0, max=64, message="实际值班人长度必须介于 0 和 64 之间")
	public String getRealOndutyUser() {
		return realOndutyUser;
	}

	public void setRealOndutyUser(String realOndutyUser) {
		this.realOndutyUser = realOndutyUser;
	}
	
	@Length(min=0, max=64, message="交接状态长度必须介于 0 和 64 之间")
	public String getChangeStatus() {
		return changeStatus;
	}
	
	public void setChangeStatus(String changeStatus) {
		this.changeStatus = changeStatus;
	}
	
	@Length(min=0, max=64, message="带班领导长度必须介于 0 和 64 之间")
	@ExcelField(title="带班领导", align=2, sort=35)
	public String getLeader() {
		return leader;
	}

	public void setLeader(String leader) {
		this.leader = leader;
	}
	
}