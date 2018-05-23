/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.myitems.dao;

import java.util.List;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.myitems.entity.WmUserItem;

/**
 * 我的工作管理DAO接口
 * @author 杨萌
 * @version 2018-04-26
 */
@MyBatisDao
public interface WmUserItemDao extends CrudDao<WmUserItem> {
	public int countuseritem();
	
	public void updateone(WmUserItem wmUserItem);
	
	
	public List<WmUserItem> findslinfo(WmUserItem wmUserItem);
	
	
	public WmUserItem  findonebyitemidanduser(WmUserItem wmUserItem);
	
	
	public void updatefinish(WmUserItem wmUserItem);
	
}