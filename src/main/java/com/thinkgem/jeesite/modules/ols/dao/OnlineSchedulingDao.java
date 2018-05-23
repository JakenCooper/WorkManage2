package com.thinkgem.jeesite.modules.ols.dao;

import java.util.List;
import java.util.Map;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.ols.entity.OnlineScheduling;
@MyBatisDao
public interface OnlineSchedulingDao extends CrudDao<OnlineScheduling>{
	public List<OnlineScheduling> findonlineSchedulingList(Map<String, Object> map);
}
