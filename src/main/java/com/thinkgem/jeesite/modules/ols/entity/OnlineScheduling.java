package com.thinkgem.jeesite.modules.ols.entity;

import java.util.Date;

import com.thinkgem.jeesite.common.persistence.DataEntity;

public class OnlineScheduling extends DataEntity<OnlineScheduling>{
	private static final long serialVersionUID = 1L;
	private Date date;		// 日期
	private Date changeTime;		// 交班时间
	private String changeUser;		// 交班人
	private String ondutyUser;		// 值班人
	private Date receiveTime;		// 接班时间
	private String realOndutyUser;		// 实际值班人
	private String changeStatus;		// 交接状态
	private String leader;		// 带班领导
	public Date getDate() {
		return date;
	}
	public void setDate(Date date) {
		this.date = date;
	}
	public Date getChangeTime() {
		return changeTime;
	}
	public void setChangeTime(Date changeTime) {
		this.changeTime = changeTime;
	}
	public String getChangeUser() {
		return changeUser;
	}
	public void setChangeUser(String changeUser) {
		this.changeUser = changeUser;
	}
	public String getOndutyUser() {
		return ondutyUser;
	}
	public void setOndutyUser(String ondutyUser) {
		this.ondutyUser = ondutyUser;
	}
	public Date getReceiveTime() {
		return receiveTime;
	}
	public void setReceiveTime(Date receiveTime) {
		this.receiveTime = receiveTime;
	}
	public String getRealOndutyUser() {
		return realOndutyUser;
	}
	public void setRealOndutyUser(String realOndutyUser) {
		this.realOndutyUser = realOndutyUser;
	}
	public String getChangeStatus() {
		return changeStatus;
	}
	public void setChangeStatus(String changeStatus) {
		this.changeStatus = changeStatus;
	}
	public String getLeader() {
		return leader;
	}
	public void setLeader(String leader) {
		this.leader = leader;
	}
	public OnlineScheduling() {
		super();
	}
	@Override
	public String toString() {
		return "OnlineScheduling [date=" + date + ", changeTime=" + changeTime + ", changeUser=" + changeUser
				+ ", ondutyUser=" + ondutyUser + ", receiveTime=" + receiveTime + ", realOndutyUser=" + realOndutyUser
				+ ", changeStatus=" + changeStatus + ", leader=" + leader + "]";
	}
	
	
}
