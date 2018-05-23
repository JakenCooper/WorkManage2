/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.item.dao;

import java.util.List;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.item.entity.WmTodoItem;

/**
 * 待办事项管理DAO接口
 * @author 杨萌
 * @version 2018-04-23
 */
@MyBatisDao
public interface WmTodoItemDao extends CrudDao<WmTodoItem> {
	public void deletemore(List<String> ids);
	
	
	public int sumcounttodoitem();
	
	public void updateone(WmTodoItem wmTodoItem);
	
	public int checkwmcontent(WmTodoItem wmTodoItem);
	
}