package com.hanming.oa.realm;


import java.util.HashSet;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.SimpleAuthenticationInfo;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.apache.shiro.util.ByteSource;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;

import com.hanming.oa.model.User;
import com.hanming.oa.service.UserService;


public class MyRealm extends AuthorizingRealm {
	//日志规范
	private static final Logger logger = LoggerFactory.getLogger(MyRealm.class);
	
	@Autowired
	UserService userService;
	
	//授权
	@Override
	protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principalCollection) {
		//获得经过认证的主体信息
		User user = (User) principalCollection.getPrimaryPrincipal();
		Integer userId = user.getId();
		
		List<String> resourceList = userService.selectAllResource(userId);
		List<String> roleList = userService.selectAllRole(userId);
		
		SimpleAuthorizationInfo info = new SimpleAuthorizationInfo();
		info.setRoles(new HashSet<>(roleList));
		info.setStringPermissions(new HashSet<>(resourceList));
		
		return info;
	}

	//认证
	@Override
	protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken authenticationToken) throws AuthenticationException {
		
		String username = authenticationToken.getPrincipal().toString();
		//String password = new String((char[])authenticationToken.getCredentials());
		User user = userService.selectByUsername(username);
		
		if (user!=null) {
			SecurityUtils.getSubject().getSession().setAttribute("username", username);
			SecurityUtils.getSubject().getSession().setAttribute("id", user.getId());
			// 第 1 个参数可以传一个实体对象，然后在认证的环节可以取出
            // 第 2 个参数应该传递在数据库中“正确”的数据，然后和 token 中的数据进行匹配
			SimpleAuthenticationInfo info = new SimpleAuthenticationInfo(user,user.getPassword(),getName());
			//设置盐值
			info.setCredentialsSalt(ByteSource.Util.bytes(username.getBytes()));
			System.out.println(info.getCredentialsSalt().toString());
			
			return info;
		}
		return null;
	}
}
