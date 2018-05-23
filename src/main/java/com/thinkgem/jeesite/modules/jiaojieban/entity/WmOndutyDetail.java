/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.jiaojieban.entity;

import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.common.persistence.DataEntity;
import com.thinkgem.jeesite.common.utils.excel.annotation.ExcelField;

/**
 * 交接班管理Entity
 * @author 陈宏
 * @version 2018-04-26
 */
public class WmOndutyDetail extends DataEntity<WmOndutyDetail> {
	
	private static final long serialVersionUID = 1L;
	private String computerNumber;		// 电脑台数
	private String faxMachineNumber;		// 传真机台数
	private String keyNum;		// 钥匙数量
	private String zsSysTransStatus;		// o6系统运行情况
	private String zsSysTransStatusRestarTime;		// o6系统重启时间
	private String zhuanWangStatus;		// 专网线路监控状态
	private String jiFangSafeStatus;		// 机房监控及安全情况
	private String leader;		// 带班领导
	private String changeUser;		// 接班人
	private String ondutyUser;		// 值班人员
	private String jiaoBanTime;		// 交班时间
	private String layuiLimit;
	private String layuiPage;
	private String desc;
	private String wmOndutyId;
	private String zhiBanTime;
	private String field;
	private String order;
	
	

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

	public String getZhiBanTime() {
		return zhiBanTime;
	}

	public void setZhiBanTime(String zhiBanTime) {
		this.zhiBanTime = zhiBanTime;
	}

	public String getWmOndutyId() {
		return wmOndutyId;
	}

	public void setWmOndutyId(String wmOndutyId) {
		this.wmOndutyId = wmOndutyId;
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

	public String getDesc() {
		return desc;
	}

	public void setDesc(String desc) {
		this.desc = desc;
	}

	public WmOndutyDetail() {
		super();
	}

	public WmOndutyDetail(String id){
		super(id);
	}


	
	@Length(min=0, max=64, message="电脑台数长度必须介于 0 和 64 之间")
	public String getComputerNumber() {
		return computerNumber;
	}

	public void setComputerNumber(String computerNumber) {
		this.computerNumber = computerNumber;
	}
	
	@Length(min=0, max=64, message="传真机台数长度必须介于 0 和 64 之间")
	public String getFaxMachineNumber() {
		return faxMachineNumber;
	}

	public void setFaxMachineNumber(String faxMachineNumber) {
		this.faxMachineNumber = faxMachineNumber;
	}
	
	@Length(min=0, max=64, message="钥匙数量长度必须介于 0 和 64 之间")
	public String getKeyNum() {
		return keyNum;
	}

	public void setKeyNum(String keyNum) {
		this.keyNum = keyNum;
	}
	
	@Length(min=0, max=64, message="o6系统运行情况长度必须介于 0 和 64 之间")
	public String getZsSysTransStatus() {
		return zsSysTransStatus;
	}

	public void setZsSysTransStatus(String zsSysTransStatus) {
		this.zsSysTransStatus = zsSysTransStatus;
	}
	
	public String getZsSysTransStatusRestarTime() {
		return zsSysTransStatusRestarTime;
	}

	public void setZsSysTransStatusRestarTime(String zsSysTransStatusRestarTime) {
		this.zsSysTransStatusRestarTime = zsSysTransStatusRestarTime;
	}
	
	@Length(min=0, max=64, message="专网线路监控状态长度必须介于 0 和 64 之间")
	public String getZhuanWangStatus() {
		return zhuanWangStatus;
	}

	public void setZhuanWangStatus(String zhuanWangStatus) {
		this.zhuanWangStatus = zhuanWangStatus;
	}
	
	@Length(min=0, max=64, message="机房监控及安全情况长度必须介于 0 和 64 之间")
	public String getJiFangSafeStatus() {
		return jiFangSafeStatus;
	}

	public void setJiFangSafeStatus(String jiFangSafeStatus) {
		this.jiFangSafeStatus = jiFangSafeStatus;
	}
	
	@Length(min=0, max=64, message="带班领导长度必须介于 0 和 64 之间")
	@ExcelField(title="带班领导", align=2, sort=25)
	public String getLeader() {
		return leader;
	}

	public void setLeader(String leader) {
		this.leader = leader;
	}
	
	@Length(min=0, max=64, message="交班人员长度必须介于 0 和 64 之间")
	public String getChangeUser() {
		return changeUser;
	}

	public void setChangeUser(String changeUser) {
		this.changeUser = changeUser;
	}
	
	@Length(min=0, max=64, message="值班人员长度必须介于 0 和 64 之间")
	@ExcelField(title="值班人", align=2, sort=25)
	public String getOndutyUser() {
		return ondutyUser;
	}

	public void setOndutyUser(String ondutyUser) {
		this.ondutyUser = ondutyUser;
	}
	@ExcelField(title="值班时间", align=2, sort=25)
	public String getJiaoBanTime() {
		return jiaoBanTime;
	}

	public void setJiaoBanTime(String jiaoBanTime) {
		this.jiaoBanTime = jiaoBanTime;
	}
	
}