package com.thinkgem.jeesite.modules.ols.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.ols.dao.OnlineSchedulingDao;
import com.thinkgem.jeesite.modules.ols.entity.OnlineScheduling;

@Service
@Transactional(readOnly = true)
public class OnlineSchedulingService extends CrudService<OnlineSchedulingDao,OnlineScheduling>{
	
	@Autowired
	private OnlineSchedulingDao onlineSchedulingDao;
	
	public List<OnlineScheduling> findonlineSchedulingList(Map<String, Object>map){
		return onlineSchedulingDao.findonlineSchedulingList(map);
	}

}
