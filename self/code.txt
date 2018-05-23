package com.jaken.sp.util;

import java.util.List;
import java.util.Map;
import java.util.Set;

public class LoginedUserCache {

	private LoginedUserCache(){}
	private static LoginedUserCache cacheInstance;
	
	static{
		cacheInstance=new LoginedUserCache();
	}
	public static LoginedUserCache newInstance(){
		return LoginedUserCache.cacheInstance;
	}
	
	private Set<String> sessionIdSet;
	
	// sessionid-lastopertime
	private Map<String, Long> sessionExpireMap;
	
	//name may repeat many times,forward to accurate way(fe.depid+username)
	private List<String> loginedUserNameList;
	
	
}
