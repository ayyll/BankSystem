# BankSystem
银行管理系统
最近回校答辩(中期答辩),排队进行，等了两个多小时后，上台正准备念"精心"准备的ppt，结果台下老师说，行了，别废话了，直接来重点吧。然后无奈只能翻过去前面扯的一堆大义凛然的话，说这是我做的毕业设计明曰银行管理系统，老师说你这题目有点大了，银行是你想管理就管理的吗？ok，我改好吧。然后说了一下用到的框架，以及界面的截图给他们看了一下，高老师看完之后说你这能和银行的数据连上吗。。(老哥你是在做梦吧) 很无奈的跟他说连不了，这只是个人做着玩的，然后就没有然后了，说下次再来的时候演示一下就行了。
  以上题外话。

顾名思义，本银行管理系统是基于SSM的增删查改小系统，只有管理员界面，想来想去用户好像用不到这玩意，现在也没有哪家银行能支持网上存取款之类的操作，如果用户界面只搞个查询和转账之类的太单调，索性功能全扔到管理员界面去了。
本文不谈具体实现，只说架构(orz，菜鸟眼中的架构).
# 项目总结构 #
项目结构如下(maven+myeclipse构建):
![3](银行管理系统/3.png)

pom.xml依赖：

```
<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">

	<modelVersion>4.0.0</modelVersion>
	<groupId>MybatisDemo</groupId>
	<artifactId>MybatisDemo</artifactId>
	<version>0.0.1-SNAPSHOT</version>
	<packaging>war</packaging>
	<name />
	<description />
	<properties>
		<project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
		<!-- jar 版本设置 -->
		<spring.version>4.2.4.RELEASE</spring.version>
	</properties>

	<dependencies>

		<!-- spring框架 -->
		<dependency>
			<groupId>org.springframework</groupId>
			<artifactId>spring-webmvc</artifactId>
			<version>${spring.version}</version>
		</dependency>

		<dependency>
			<groupId>org.springframework</groupId>
			<artifactId>spring-core</artifactId>
			<version>${spring.version}</version>
		</dependency>

		<dependency>
			<groupId>org.springframework</groupId>
			<artifactId>spring-orm</artifactId>
			<version>${spring.version}</version>
		</dependency>

		<dependency>
			<groupId>org.springframework</groupId>
			<artifactId>spring-aspects</artifactId>
			<version>${spring.version}</version>
		</dependency>

		<dependency>
			<groupId>org.springframework</groupId>
			<artifactId>spring-test</artifactId>
			<version>${spring.version}</version>
		</dependency>

		<dependency>
			<groupId>org.springframework</groupId>
			<artifactId>spring-jdbc</artifactId>
			<version>${spring.version}</version>
		</dependency>

		<dependency>
			<groupId>javax.servlet</groupId>
			<artifactId>servlet-api</artifactId>
			<version>2.5</version>
			<scope>provided</scope>
		</dependency>
		<dependency>
			<groupId>mysql</groupId>
			<artifactId>mysql-connector-java</artifactId>
			<version>5.1.38</version>
		</dependency>
		<dependency>
			<groupId>org.mybatis</groupId>
			<artifactId>mybatis</artifactId>
			<version>3.3.1</version>
		</dependency>
		<dependency>
			<groupId>org.mybatis</groupId>
			<artifactId>mybatis-spring</artifactId>
			<version>1.2.4</version>
		</dependency>
		<dependency>
			<groupId>log4j</groupId>
			<artifactId>log4j</artifactId>
			<version>1.2.17</version>
		</dependency>

		<dependency>
			<groupId>org.slf4j</groupId>
			<artifactId>slf4j-api</artifactId>
			<version>1.7.18</version>
		</dependency>

		<dependency>
            <groupId>com.fasterxml.jackson.core</groupId>
            <artifactId>jackson-databind</artifactId>
            <version>2.6.5</version>
        </dependency>

        <dependency>
            <groupId>com.fasterxml.jackson.core</groupId>
            <artifactId>jackson-core</artifactId>
            <version>2.6.5</version>
        </dependency>

        <dependency>
            <groupId>com.fasterxml.jackson.core</groupId>
            <artifactId>jackson-annotations</artifactId>
            <version>2.6.5</version>
        </dependency>
		
		<dependency>
			<groupId>commons-dbcp</groupId>
			<artifactId>commons-dbcp</artifactId>
			<version>1.4</version>
		</dependency>
		<!-- 添加junit依赖 -->
		<dependency>
			<groupId>junit</groupId>
			<artifactId>junit</artifactId>
			<version>4.10</version>
			<scope>test</scope>
		</dependency>
		<!-- JSP tag -->
		<dependency>
			<groupId>javax.servlet</groupId>
			<artifactId>jstl</artifactId>
			<version>1.2</version>
		</dependency>
		<dependency>
			<groupId>taglibs</groupId>
			<artifactId>standard</artifactId>
			<version>1.1.2</version>
		</dependency>
	</dependencies>

</project>
```

# 数据库表结构 #
想来还是从底往上说吧，数据库设计了3张表：
user表：3个字段,id,username,password 用来存储管理员账号的。实际上没啥用，管理员账号一个不就够了蛮。。
account表:存储银行账户信息，表结构如下:
![1](银行管理系统/1.png)
card为卡号，isDelete为是否删除标记，1为删除

账户流水日志表结构:
![2](银行管理系统/2.png)
deal为交易金额

DAO层
对于用户userdao，就是简单的用户登陆注册的操作，关于accountdao，操作很多。。但都是基于增删改查，查的话有一个分页查询，其实就是limit关键字的简单应用，算是一种最普通的分页查询，效率一般。

```
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
```

# controller层 #
controller层对应的代码对应着dao层撸一遍就好了。。
# View层 #
视图方面，bootstrap风格已然能满足我这等审美 
有点不足的是jsp页面没有放到WEB-INF目录下，这样外界有可能会访问到jsp页面，后来加了个过滤器，把未登陆的用户过滤掉了。[过滤器详细用法](http://www.ayyll.com/2017/04/19/%E8%BF%87%E6%BB%A4%E5%99%A8/)

关于分页,前端分页使用bootstrap分页插件

```
<!-- pagination分页 -->
<div class="pagination" align="center">
	<ul id="myul">
		<li><a href="#">首页</a></li>
		<li><a href="#">上一页</a></li>
		<li><a href="#">下一页</a></li>
		<li><a href="#">尾页</a></li>
	</ul>
</div>
```

后台分页查询时，假定前端传递的数据为page:当前请求页，
count：每页显示的数量
则后台分页查询可以这么写:
其中`index = (page - 1)*count;`

```
select * from account where isDelete=0 order by id limit #{index},#{count} 
```

# 总结 #
初次用ssm搭系统，熟练度上没得说，基本是边查遍搞，对于spring，拦截器和事务管理都没怎么用，虽然对于二者的作用有点笼统的概念，但确实没真正用过。对于mybatis，也只是用到了增删查改，存储过程啦，高级映射什么的还没概念，最近准备上手redis，想来一个对缓存也没什么概念的人来说，这好像又是天方夜谭。。
