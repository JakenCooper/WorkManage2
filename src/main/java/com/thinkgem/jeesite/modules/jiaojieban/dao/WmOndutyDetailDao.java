/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.jiaojieban.dao;

import java.util.List;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.jiaojieban.entity.WmOndutyDetail;

/**
 * 交接班管理DAO接口
 * @author 陈宏
 * @version 2018-04-26
 */
@MyBatisDao
public interface WmOndutyDetailDao extends CrudDao<WmOndutyDetail> {
	public List<WmOndutyDetail> WmOndutyDetailInfo();
	public int findWmOndutyDetailCount();
	public int upDateWmOndutyDetail(WmOndutyDetail wmOndutyDetail);
	public WmOndutyDetail beforeDetailInfo();
}