package com.ayyll.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.ayyll.dao.UserDao;
import com.ayyll.dao.impl.UserDaoImpl;
import com.ayyll.entity.User;
import com.fasterxml.jackson.databind.util.JSONPObject;

@Controller
@RequestMapping("/user")
public class UserController {


	// 用户注册
	@RequestMapping(value = "/register.do", method = RequestMethod.POST)
	public @ResponseBody
	Map<String, Object> register(HttpServletRequest request) throws IOException {
		
		UserDao udao = new UserDaoImpl();
		User user = new User();
		// System.out.println(request.getParameter("username"));
		// System.out.println(request.getParameter("password"));
		user.setUsername(request.getParameter("username"));
		user.setPassword(request.getParameter("password"));
		udao.addUser(user);

		// 返回map数组 spring的@ResponseBody会帮我们自动转换成json类型
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("msg", "ok");
		return map;
	}

	// 用户登陆
	@RequestMapping(value = "/login.do", method = RequestMethod.POST)
	public @ResponseBody
	Map<String, Object> login(HttpServletRequest request) throws IOException {
		
		UserDao udao = new UserDaoImpl();
		User user = new User();
		String username = request.getParameter("username");
		user.setUsername(username);
		user.setPassword(request.getParameter("password"));
		List<User> ans = udao.queryUser(user);

		Map<String, Object> map = new HashMap<String, Object>();
		HttpSession session = request.getSession();
		
		// 密码正确
		if (ans.size() > 0) {
			map.put("msg", "yes");
			session.setAttribute("username",username);
		} else {
			map.put("msg", "no");
		}

		return map;
	}

	// 修改密码
	@RequestMapping(value = "/updatepsw.do", method = RequestMethod.POST)
	public @ResponseBody
	Map<String, Object> updatepsw(HttpServletRequest request) throws IOException {

		UserDao udao = new UserDaoImpl();
		User user = new User();
		user.setUsername(request.getParameter("username"));
		user.setPassword(request.getParameter("oldPassword"));
		System.out.println(request.getParameter("username"));
		System.out.println(request.getParameter("oldPassword"));
		System.out.println(request.getParameter("password"));
		Map<String, Object> map = new HashMap<String, Object>();
		List<User> ans = udao.queryUser(user);
		
		// 密码正确
		if (ans.size() > 0) {
			user.setPassword(request.getParameter("password"));
			udao.updateUser(user);
			//修改成功
			map.put("msg", "yes");
		} else {
			//密码不匹配，修改失败
			map.put("msg", "no");
		}
		
		return map;
	}
}
