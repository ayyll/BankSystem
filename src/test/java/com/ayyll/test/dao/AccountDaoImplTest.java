package com.ayyll.test.dao;

import java.sql.Timestamp;
import java.util.Date;
import java.util.Random;

import org.junit.Before;
import org.junit.Ignore;
import org.junit.Test;
import com.ayyll.dao.AccountDao;
import com.ayyll.dao.impl.AccountDaoImpl;
import com.ayyll.dbutil.RandomUtils;
import com.ayyll.entity.Account;
import com.ayyll.entity.Log;

public class AccountDaoImplTest {
	private AccountDao ad; 
	@Before
	public void before() {
		ad = new AccountDaoImpl();
	}
	
	//测试存款操作
	@Ignore
	public void testSaveMoney() {
		System.out.println(ad.accountSaveMoney("6228480284", 10));
	}
	//查询账号是否存在
	@Ignore
	public void testQueryAccount() {
		
		System.out.println(ad.checkAccountIsExists("6228480284"));
	}
	//查询密码是否正确
	@Ignore
	public void testQueryPassword() {
		Account acc = new Account("6228480284", "123456");
		System.out.println(ad.checkPasswordIsRight(acc));
	}
	
	//查询账户余额,-1代表账户不存在
	@Ignore
	public void testQueryMoney() {
		System.out.println(ad.queryMoney("6228480289"));
	}
	//测试取钱
	@Ignore
	public void testTakeMoney() {
		Account acc = new Account("622848023", 30, "123456");
		System.out.println(ad.takeMoney(acc));
	}
	//测试转账
	@Ignore
	public void testTransferMoney() {
		Account saccount = new Account("6228480283", 10);
		String recAccount = "6228480284";
		System.out.println(ad.transferMoney(saccount, recAccount));
	}
	//测试开户
	@Ignore
	public void testOpenAccount() {
		Date date = new Date();
		Timestamp tt = new Timestamp(date.getTime());
		String card,name,sex,password;
		int money = 0;
		Random r = new Random();
		for(int i = 0; i < 19; i++) {
			card = RandomUtils.createRandomNumber(10);
			name = RandomUtils.createRandomName();
			password = RandomUtils.createRandomString(6);
			sex = i % 3 == 0? "女":"男";
			if(i % 100 == 0) sex = "保密";
			money = r.nextInt(100000);
			Account account = new Account(card, name, sex, money, tt, password);
			ad.openAccount(account);
		}
	}
	//测试查询账户总数
	@Ignore
	public void testQueryAccountNumber() {
		System.out.println(ad.totalAccountNumber());
	}
	//测试分页查询
	@Ignore
	public void testQueryAccountByPage() {
		System.out.println(ad.getAccountList(1, 1));
	}
	//测试账户挂失(update伪删除)
	@Ignore
	public void testDeleteAccount() {
		Account account = new Account("6436577961","jzb5Y1");
		System.out.println(ad.deleteAccount(account));
	}
	//测试查询单个账户
	@Ignore
	public void testQueryOneAccount() {
		Account account = new Account("2219621654","S8AYkr");
		System.out.println(ad.queryOneAccount(account));
	}
	
	@Test
	public void testQueryLog() {
	    Log log = new Log("147894408");
	    System.out.println(ad.getAccountLogByCard(log).isEmpty());
		System.out.println(ad.getAccountLogByCard(log));
	}
}
