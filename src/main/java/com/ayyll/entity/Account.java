package com.ayyll.entity;

import java.sql.Timestamp;

public class Account {
	private int id;
	private String card;
	private String name;
	private String sex;
	private int money;
	private Timestamp open_date;
	private String password;
	private int isDelete;
	
	public Account() {
		super();
	}

	public int getIsDelete() {
		return isDelete;
	}

	public void setIsDelete(int isDelete) {
		this.isDelete = isDelete;
	}

	public Account(String card, int money) {
		super();
		this.card = card;
		this.money = money;
	}

	
	public Account(String card, String password) {
		super();
		this.card = card;
		this.password = password;
	}
	

	public Account(String card, String name, String sex, int money,
			Timestamp open_date, String password, int isDelete) {
		super();
		this.card = card;
		this.name = name;
		this.sex = sex;
		this.money = money;
		this.open_date = open_date;
		this.password = password;
		this.isDelete = isDelete;
	}

	public Account(String card, String name, String sex, int money,
			Timestamp open_date, String password) {
		super();
		this.card = card;
		this.name = name;
		this.sex = sex;
		this.money = money;
		this.open_date = open_date;
		this.password = password;
	}

	public Account(String card, int money, String password) {
		super();
		this.card = card;
		this.money = money;
		this.password = password;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getCard() {
		return card;
	}

	public void setCard(String card) {
		this.card = card;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getSex() {
		return sex;
	}

	public void setSex(String sex) {
		this.sex = sex;
	}

	public int getMoney() {
		return money;
	}

	public void setMoney(int money) {
		this.money = money;
	}

	
	public Timestamp getOpen_date() {
		return open_date;
	}

	public void setOpen_date(Timestamp open_date) {
		this.open_date = open_date;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	@Override
	public String toString() {
		return "Account [id=" + id + ", card=" + card + ", name=" + name
				+ ", sex=" + sex + ", money=" + money + ", open_date="
				+ open_date + ", password=" + password + ", isDelete="
				+ isDelete + "]";
	}

	
}
