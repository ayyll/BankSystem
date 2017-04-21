package com.ayyll.test.dao;

import java.util.List;

import org.junit.Before;
import org.junit.Ignore;
import org.junit.Test;
import com.ayyll.dao.UserDao;
import com.ayyll.dao.impl.UserDaoImpl;
import com.ayyll.entity.User;
public class UserDaoImplTest {
	private UserDao udao; 
	
	@Before
	public void before() {
		udao = new UserDaoImpl();
	}
	
	@Ignore
	public void testAddUser() {
		User u = new User("yy","123456");
		udao.addUser(u);
	}
	
	@Ignore
	public void testQueryAllUser() {
		List<User> ans = udao.queryAllUser();
		for(User each : ans) {
			System.out.println(each);
		}
	}
	
	@Ignore
	public void testQueryUser() {
		User user = new User();
		user.setPassword("123456");
		user.setUsername("yy");
		List<User> ans = udao.queryUser(user);
		for(User each : ans) {
			System.out.println(each);
		}
	}
	
	@Test
	public void testUpdateUser() {
		User user = new User();
		user.setPassword("767576");
		user.setUsername("yy");
		udao.updateUser(user);
	}
}
