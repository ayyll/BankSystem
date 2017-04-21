package com.ayyll.dao.impl;

import java.util.List;
import org.apache.ibatis.session.SqlSession;
import com.ayyll.dao.UserDao;
import com.ayyll.dbutil.MyBatisUtil;
import com.ayyll.entity.User;

public class UserDaoImpl implements UserDao{
	
	public static final String NAMESPACE = "com.ayyll.mapper.UserMapper"; 
	@Override
	public void addUser(User user) {
		
		SqlSession session = MyBatisUtil.getSession();  
        session.insert(NAMESPACE + ".addUser" , user);  
      
        session.commit();  
        session.close();  	
	}

	@Override
	public List<User> queryAllUser() {
		
		 SqlSession session = MyBatisUtil.getSession();  
	     List<User> userList = session.selectList(NAMESPACE + ".queryAllUser");  
	             
	     session.commit();  
	     session.close();  
	          
	     return userList;  
	}

	@Override
	public List<User> queryUser(User user) {
		
		SqlSession session = MyBatisUtil.getSession(); 
		List<User> userList = session.selectList(NAMESPACE + ".queryUser",user);
		
		session.commit();  
	    session.close();
	    
		return userList;
	}

	@Override
	public void updateUser(User user) {
		
		SqlSession session = MyBatisUtil.getSession(); 
		session.update(NAMESPACE + ".updateUser", user);
		
		session.commit();  
	    session.close();
	}

}
