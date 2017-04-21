package com.ayyll.dao;

import java.util.List;
import com.ayyll.entity.User;

/**
 * @author Administrator
 *
 */
public interface UserDao {

		/**
		 * 添加用户
		 * @param user
		 */
		public void addUser(User user);
		
		/**
		 * 查询所有用户
		 * @return 返回结果保存在集合
		 */
		public List<User> queryAllUser();
		
		/**
		 * 查询单个用户
		 * @return 
		 */
		public List<User> queryUser(User user);

		/**
		 * 修改用户密码
		 * @param user
		 */
		public void updateUser(User user);
}
