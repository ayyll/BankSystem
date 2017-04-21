package com.ayyll.dao.impl;

import java.sql.Timestamp;
import java.util.Date;
import java.util.List;
import org.apache.ibatis.session.SqlSession;
import com.ayyll.dao.AccountDao;
import com.ayyll.dbutil.MyBatisUtil;
import com.ayyll.entity.Account;
import com.ayyll.entity.Log;
import com.ayyll.entity.Pagination;

public class AccountDaoImpl implements AccountDao {

	public static final String ACC_NAMESPACE = "com.ayyll.mapper.AccountMapper";
	public static final String LOG_NAMESPACE = "com.ayyll.mapper.LogMapper";

	// 存款
	@Override
	public boolean accountSaveMoney(String account, int money) {

		Account ac = new Account(account, money);
		Date date = new Date();
		Timestamp tt = new Timestamp(date.getTime());
		// System.out.println(tt);
		int num = 0;
		Log log = new Log(account, money, "存款", tt);
		SqlSession session = MyBatisUtil.getSession();

		try {
			// 更新account表,返回受影响的行数
			num = session.update(ACC_NAMESPACE + ".saveMoney", ac);
			if (num == 0)
				return false;
			session.insert(LOG_NAMESPACE + ".changeLog", log);
			session.commit();

		} catch (Exception e) {
			e.printStackTrace();
			return false;
		} finally {
			session.close();
		}
		return true;
	}

	// 取款
	@Override
	public boolean takeMoney(Account acc) {

		// 查询账户余额，如果账户不存在或者取款金额大于余额,则本次操作失败
		int reMoney = queryMoney(acc.getCard());
		if (reMoney == -1 || acc.getMoney() > reMoney) {
			return false;
		}
		
		//操作日期
		Date date = new Date();
		Timestamp tt = new Timestamp(date.getTime());
		int num = 0;
		// 流水日志
		Log log = new Log(acc.getCard(), acc.getMoney(), "取款", tt);
		SqlSession session = MyBatisUtil.getSession();

		try {
			// 更新account表,返回受影响的行数
			num = session.update(ACC_NAMESPACE + ".takeMoney", acc);
			if (num == 0)
				return false;
			session.insert(LOG_NAMESPACE + ".changeLog", log);
			session.commit();

		} catch (Exception e) {
			e.printStackTrace();
			return false;
		} finally {
			session.close();
		}
		return true;
	}

	// 转账
	@Override
	public boolean transferMoney(Account saccount, String recAccount) {

		// 查询转账人账户余额，如果账户不存在或者转账金额大于余额,则本次操作失败
		int reMoney = queryMoney(saccount.getCard());
		if (reMoney == -1 || saccount.getMoney() > reMoney) {
			return false;
		}
		//操作日期
		Date date = new Date();
		Timestamp tt = new Timestamp(date.getTime());
		//收款人
		Account raccount = new Account();
		raccount.setCard(recAccount);
		raccount.setMoney(saccount.getMoney());
		
		int num = 0;
		// 流水日志(两条)
		Log log_out = new Log(saccount.getCard(), saccount.getMoney(), "转出", tt);
		Log log_in = new Log(recAccount, saccount.getMoney(), "转入", tt);
		
		SqlSession session = MyBatisUtil.getSession();
		
		try {
			// 更新account表,返回受影响的行数
			num = session.update(ACC_NAMESPACE + ".saveMoney", raccount);
			if(num == 0) return false;
			num = session.update(ACC_NAMESPACE + ".takeMoney", saccount);
			if(num == 0) return false;
			session.insert(LOG_NAMESPACE + ".changeLog", log_in);
			session.insert(LOG_NAMESPACE + ".changeLog", log_out);
			session.commit();
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		} finally {
			session.close();
		}
		return true;
	}

	// 判断账户是否存在
	@Override
	public boolean checkAccountIsExists(String account) {

		SqlSession session = MyBatisUtil.getSession();
		Account acc = new Account();
		acc.setCard(account);
		List<Account> accountList = session.selectList(ACC_NAMESPACE
				+ ".queryAccount", acc);

		session.commit();
		session.close();

		if (accountList.isEmpty())
			return false;
		return true;
	}

	// 判断账户是否正确
	@Override
	public boolean checkPasswordIsRight(Account acc) {

		SqlSession session = MyBatisUtil.getSession();
		List<Account> accountList = session.selectList(ACC_NAMESPACE
				+ ".queryPassword", acc);

		session.commit();
		session.close();

		if (accountList.isEmpty())
			return false;
		return true;
	}

	// 查询余额,如果账户不存在返回-1
	@Override
	public int queryMoney(String card) {

		SqlSession session = MyBatisUtil.getSession();
		Object obj = session.selectOne(ACC_NAMESPACE + ".queryMoney", card);
		session.commit();
		session.close();

		if (obj != null)
			return (Integer) obj;
		else
			return -1;
	}
	//开户
	@Override
	public boolean openAccount(Account account) {
		
		SqlSession session = MyBatisUtil.getSession();
		
		try {
			session.insert(ACC_NAMESPACE + ".openAccount", account);
			session.commit();
		} catch(Exception e) {
			e.printStackTrace();
			return false;
		} finally {
			session.close();
		}
		
		return true;
	}
	//查询账户总数
	@Override
	public int totalAccountNumber() {
		
		SqlSession session = MyBatisUtil.getSession();
		int num = session.selectOne(ACC_NAMESPACE + ".queryAccountNumber");
		return num;
	}
	//查询账户列表(分页查询)
	@Override
	public List<Account> getAccountList(int page, int count) {
		
		SqlSession session = MyBatisUtil.getSession();
		page = (page - 1)*count;
		Pagination pag = new Pagination(page, count);
		//System.out.println(pag);
		List<Account> list = session.selectList(ACC_NAMESPACE + ".queryAccountByPage", pag);
		return list;
	}
	//挂失账户
	@Override
	public boolean deleteAccount(Account account) {
		
		SqlSession session = MyBatisUtil.getSession();
		int num = 0;
		try {
			num = session.update(ACC_NAMESPACE + ".deleteAccount", account);
			session.commit();
		} catch(Exception e) {
			e.printStackTrace();
			return false;
		} finally {
			session.close();
		}
		if(num != 0) return true;
		return false;
	}
	//查询单个账户
	@Override
	public Account queryOneAccount(Account account) {
		
		SqlSession session = MyBatisUtil.getSession();
		return session.selectOne(ACC_NAMESPACE + ".queryOneAccount", account);
		
	}
	//根据卡号查询账单
	@Override
	public List<Log> getAccountLogByCard(Log msg) {
		
		SqlSession session = MyBatisUtil.getSession();
		return session.selectList(LOG_NAMESPACE + ".queryLogByCard", msg);
		 
	}
}
