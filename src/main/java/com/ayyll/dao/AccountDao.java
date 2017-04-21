package com.ayyll.dao;

import java.util.List;
import com.ayyll.entity.Account;
import com.ayyll.entity.Log;

/**
 * @author Administrator
 *
 */
/**
 * @author Administrator
 *
 */
public interface AccountDao {
	
	/**
	 * 存款
	 * @param account 账户
	 * @param money 金额
	 * @return 操作是否成功
	 */
	public boolean accountSaveMoney(String account,int money);
	
	/**
	 * 判断账户是否存在
	 * @param account 卡号
	 * @return 是否存在
	 */
	public boolean checkAccountIsExists(String account);

	/**
	 * 判断密码是否正确
	 * @param acc 账户信息
	 * @return 密码是否正确
	 */
	public boolean checkPasswordIsRight(Account acc);

	/**
	 * 取款操作
	 * @param acc
	 * @return 返回取款操作是否成功.密码或账号错误会导致操作失败,余额不足也会操作失败
	 */
	public boolean takeMoney(Account acc);
	
	/**
	 * 查询余额
	 * @param card 卡号
	 * @return 余额,卡号不存在返回-1
	 */
	public int queryMoney(String card);

	/**
	 * 转账
	 * @param saccount 转账人账户
	 * @param recAccount 收款人卡号
	 * @return 返回转账操作是否成功.密码或账号错误会导致操作失败,余额不足也会操作失败
	 */
	public boolean transferMoney(Account saccount, String recAccount);
	
	/**
	 * 开户
	 * @param account
	 * @return 返回开户是否成功(卡号不能重复)
	 */
	public boolean openAccount(Account account);

	/**
	 * 查询账户总数(用于分页)
	 * @return
	 */
	public int totalAccountNumber();

	/**
	 * 查询账户列表(分页查询)
	 * @param page
	 * @param count
	 * @return
	 */
	public List<Account> getAccountList(int page, int count);
	
	/**
	 * 删除账户(挂失)
	 * @param account
	 * @return
	 */
	public boolean deleteAccount(Account account);
	
	/**
	 * 查询单个账户
	 * @param account
	 * @return
	 */
	public Account queryOneAccount(Account account);

	/**
	 * 根据卡号或者姓名查询流水账单
	 * @param msg
	 * @return
	 */
	public List<Log> getAccountLogByCard(Log msg);
}
