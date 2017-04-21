package com.ayyll.entity;

public class Pagination {
	private int page;
	private int count;
	
	public Pagination() {
		super();
	}
	public Pagination(int page, int count) {
		super();
		this.page = page;
		this.count = count;
	}
	@Override
	public String toString() {
		return "Pagination [page=" + page + ", count=" + count + "]";
	}
	public int getPage() {
		return page;
	}
	public void setPage(int page) {
		this.page = page;
	}
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}
	
	
}
