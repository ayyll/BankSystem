package com.ayyll.controller;

import java.io.IOException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import com.ayyll.dao.AccountDao;
import com.ayyll.dao.impl.AccountDaoImpl;
import com.ayyll.dbutil.RandomUtils;
import com.ayyll.entity.Account;
import com.ayyll.entity.Log;
import com.fasterxml.jackson.databind.jsonFormatVisitors.JsonArrayFormatVisitor;
import com.fasterxml.jackson.databind.util.JSONPObject;

@Controller
@RequestMapping("/bank")
public class AccountController {

	// 存款操作
	@RequestMapping(value = "/save_money.do", method = RequestMethod.GET)
	public @ResponseBody
	Map<String, Object> save_money(HttpServletRequest request)
			throws IOException {
		// System.out.println(request.getParameter("account") +
		// request.getParameter("money"));
		String account = request.getParameter("account");
		int money = Integer.parseInt(request.getParameter("money"));
		AccountDao adao = new AccountDaoImpl();
		boolean op = adao.accountSaveMoney(account, money);

		Map<String, Object> map = new HashMap<String, Object>();
		// 判断存款操作是否成功
		if (op) {
			map.put("msg", "ok");
		} else {
			map.put("msg", "error");
		}

		return map;
	}

	//取款操作
	@RequestMapping(value = "/take_money.do",method = RequestMethod.POST)
	public @ResponseBody
	Map<String, Object> take_money(HttpServletRequest request)
			throws IOException {
		String account = request.getParameter("account");
		String password = request.getParameter("password");
		int money = Integer.parseInt(request.getParameter("money"));
		Map<String, Object> map = new HashMap<String, Object>();
		Account acc = new Account(account, money, password);
		//System.out.println(account + " " + password + " " + money);
		AccountDao adao = new AccountDaoImpl();
		boolean op = adao.takeMoney(acc);
		
		if(op) {
			map.put("msg", "ok");
		} else {
			map.put("msg", "error");
		}
		
		return map;	
	}
	//转账操作
	@RequestMapping(value = "/transfer_money.do",method = RequestMethod.POST)
	public @ResponseBody
	Map<String, Object> transfer_money(HttpServletRequest request)
			throws IOException {
		//转账人卡号
		String sendAccount = request.getParameter("sendAccount");
		//收款人卡号
		String recAccount = request.getParameter("recAccount");
		//转账人密码
		String password = request.getParameter("password");
		//转账金额
		int money = Integer.parseInt(request.getParameter("money"));
		
		Map<String, Object> map = new HashMap<String, Object>();
		Account saccount = new Account(sendAccount, money, password);
		AccountDao adao = new AccountDaoImpl();
		
		boolean op = adao.transferMoney(saccount,recAccount);
		
		if(op) {
			map.put("msg", "ok");
		} else {
			map.put("msg", "error");
		}
		
		return map;	
	}
	
	
	
	// 判断账户是否存在
	@RequestMapping(value = "/checkAccountIsExists.do", method = RequestMethod.GET)
	public @ResponseBody
	Map<String, Object> checkAccountIsExists(HttpServletRequest request)
			throws IOException {
		String account = request.getParameter("account");
		Map<String, Object> map = new HashMap<String, Object>();
		AccountDao adao = new AccountDaoImpl();

		boolean op = adao.checkAccountIsExists(account);

		if (op) {
			map.put("msg", "ok");
		} else {
			map.put("msg", "error");
		}

		return map;
	}

	// 判断密码是否正确
	@RequestMapping(value = "/checkPasswordIsRight.do", method = RequestMethod.GET)
	public @ResponseBody
	Map<String, Object> checkPasswordIsRight(HttpServletRequest request)
			throws IOException {
		String account = request.getParameter("account");
		String password = request.getParameter("password");
		Map<String, Object> map = new HashMap<String, Object>();
		AccountDao adao = new AccountDaoImpl();
		Account acc = new Account(account, password);
		
		boolean op = adao.checkPasswordIsRight(acc);

		if (op) {
			map.put("msg", "ok");
		} else {
			map.put("msg", "error");
		}

		return map;
	}
	
	//新建账户(开户)
	@RequestMapping(value = "/open_account.do", method = RequestMethod.POST)
	public @ResponseBody
	Map<String, Object> open_account(HttpServletRequest request)
			throws IOException {
		String name = request.getParameter("name");
		String sex = request.getParameter("sex");
		String password = request.getParameter("password");
		int money = Integer.parseInt(request.getParameter("money"));
		Date date = new Date();
		Timestamp tt = new Timestamp(date.getTime());
		//System.out.println(name + "," + sex + "," + password + "," + money);
		AccountDao adao = new AccountDaoImpl();
		Map<String, Object> map = new HashMap<String, Object>();
		//生成随机卡号(10位数字字符串)
		String card = null;
		do {
			card = RandomUtils.createRandomNumber(10);
			
		} while(adao.checkAccountIsExists(card));
		
		Account account = new Account(card, name, sex, money, tt, password,0);
		boolean op = adao.openAccount(account);
		
		if(op) {
			map.put("msg", "ok");
			map.put("card", card);
		} else {
			map.put("msg", "error");
		}
		
		return map;
	}
	
	//账户列表初始化(初次加载需要返回总页数)
	@RequestMapping(value = "/account_list_init.do", method = RequestMethod.GET)
	public @ResponseBody
	Map<String, Object> account_list_init(HttpServletRequest request)
			throws IOException {
		
		int page = Integer.parseInt(request.getParameter("page"));
		int count = Integer.parseInt(request.getParameter("count"));
		
		//System.out.println(page + "," + count);
		Map<String, Object> map = new HashMap<String, Object>();
		AccountDao adao = new AccountDaoImpl();
		int total = adao.totalAccountNumber();
		//分页查询
		List<Account> list = adao.getAccountList(page,count);
		
		List<String> opentime = new ArrayList<String>();
		for (int i = 0; i < list.size(); i++) {
			opentime.add(list.get(i).getOpen_date().toString());
		}
		map.put("opentime", opentime);
		map.put("info", list);
		map.put("total", total);
		return map;
	}
	//账户列表(分页查询)
	@RequestMapping(value = "/account_list.do", method = RequestMethod.GET)
	public @ResponseBody
	Map<String, Object> account_list(HttpServletRequest request)
			throws IOException {
		
		int page = Integer.parseInt(request.getParameter("page"));
		int count = Integer.parseInt(request.getParameter("count"));
		
		//System.out.println(page + "," + count);
		Map<String, Object> map = new HashMap<String, Object>();
		AccountDao adao = new AccountDaoImpl();
		//分页查询
		List<Account> list = adao.getAccountList(page,count);
		List<String> opentime = new ArrayList<String>();
		for (int i = 0; i < list.size(); i++) {
			opentime.add(list.get(i).getOpen_date().toString());
		}
		map.put("opentime", opentime);
		map.put("info", list);
		
		return map;
	}
	
	//账户挂失cancle_account.do
	@RequestMapping(value = "/cancle_account.do", method = RequestMethod.GET)
	public @ResponseBody
	Map<String, Object> cancle_account(HttpServletRequest request)
			throws IOException {
		String card = request.getParameter("account");
		String password = request.getParameter("password");
		Map<String, Object> map = new HashMap<String, Object>();
		Account account = new Account(card,password);
		AccountDao adao = new AccountDaoImpl();
		//先保存原先账户信息
		Account oldAcc = adao.queryOneAccount(account);
		//如果账户不存在或着已挂失 ,返回error(挂失失败)
		if(oldAcc == null) {
			map.put("msg", "error");
			return map;
		}
		//删除旧账户
		adao.deleteAccount(account);
		//在新开一个账户
		String newName = oldAcc.getName();
		String newSex = oldAcc.getSex();
		
		int newMoney = oldAcc.getMoney();
		Date date = new Date();
		Timestamp tt = new Timestamp(date.getTime());
		//生成随机卡号(10位数字字符串)
		String newCard = null;
		do {
			newCard = RandomUtils.createRandomNumber(10);
					
		} while(adao.checkAccountIsExists(newCard));
		//密码截取卡号后6位
		String newPassword = newCard.substring(4, newCard.length());
		Account newAccount = new Account(newCard, newName, newSex, newMoney, tt, newPassword,0);
	
		boolean op = adao.openAccount(newAccount);
		if(op) {
			map.put("msg", "ok");
			map.put("account_msg", newAccount);
		} else {
			map.put("msg", "error");
		}
		
		return map;
	}
	//查询流水账单(根据卡号查询)
	@RequestMapping(value = "/account_log.do", method = RequestMethod.GET)
	public @ResponseBody
	Map<String, Object> account_log(HttpServletRequest request)
			throws IOException {
		
		String account = request.getParameter("account");
		System.out.println(account);
		//System.out.println(page + "," + count);
		Map<String, Object> map = new HashMap<String, Object>();
		AccountDao adao = new AccountDaoImpl();
		Log log = new Log(account);
		//根据卡号查询账单
		List<Log> list = adao.getAccountLogByCard(log);
		System.out.println(list);
		//如果未查询到账单记录,直接返回
		if(list.isEmpty()) {
			map.put("msg", "error");
			return map;
		}
		List<String> dealtime = new ArrayList<String>();
		for (int i = 0; i < list.size(); i++) {
		dealtime.add(list.get(i).getDeal_time().toString());
		}
		map.put("dealtime", dealtime);
		map.put("info", list);
		map.put("msg", "ok");
		return map;
	}
}
