/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.wmnewsreceivers.dao;

import java.util.List;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.item.entity.WmTodoItem;
import com.thinkgem.jeesite.modules.wmnewsreceivers.entity.WmNewsReceiver;

/**
 * 消息接收管理DAO接口
 * @author 杨萌
 * @version 2018-05-10
 */
@MyBatisDao
public interface WmNewsReceiverDao extends CrudDao<WmNewsReceiver> {
	public void updateone(WmNewsReceiver wmNewsReceiver);
	public void updatstatus(WmNewsReceiver wmNewsReceiver);
	
	public WmNewsReceiver findwmnews(WmNewsReceiver wmNewsReceiver);
	
	public List<WmNewsReceiver> finduserlistbynewsid(String newsid);
	
	//判断用户是否存在未读的消息
	public int readornot(WmNewsReceiver wmNewsReceiver);
	
	
}