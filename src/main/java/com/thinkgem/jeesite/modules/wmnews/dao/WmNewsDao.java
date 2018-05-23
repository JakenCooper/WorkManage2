/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.wmnews.dao;

import java.util.List;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.myitems.entity.WmUserItem;
import com.thinkgem.jeesite.modules.wmnews.entity.WmNews;

/**
 * 通知管理DAO接口
 * @author 陈宏
 * @version 2018-05-09
 */
@MyBatisDao
public interface WmNewsDao extends CrudDao<WmNews> {
	
	
	public List<WmNews> findslinfo(WmNews wmNews);
	
	public WmNews findnewss(WmNews wmNews);
	
	
	public int findSumCountdetail(WmNews wmNews);
	
	public List<String> findroleidbyuserid(String userid);
	
	public WmNews getbymessageid(String messageid);
	
	
}