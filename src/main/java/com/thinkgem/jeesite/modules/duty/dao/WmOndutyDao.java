/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.duty.dao;

import java.util.List;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.duty.entity.WmOnduty;

/**
 * 在线排班管理DAO接口
 * @author 陈宏
 * @version 2018-04-24
 */
@MyBatisDao
public interface WmOndutyDao extends CrudDao<WmOnduty> {
	public List<WmOnduty> findList(WmOnduty wmOnduty);
	public int findWmOndutyCount();
	public int updateWmOnduty(WmOnduty wmOnduty);
	public WmOnduty findWmOndutyByStatus(WmOnduty wmOnduty);
}