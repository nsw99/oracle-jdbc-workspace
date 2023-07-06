package com.kh.model.vo;

import java.util.Date;

public class Rent {

	private int rentNo;
	private Member member;
	private Book book;
	private Date rentdate;
	public Rent() {
		super();
		// TODO Auto-generated constructor stub
	}
	public Rent(int rentNo, Member member, Book book, Date rentdate) {
		super();
		this.rentNo = rentNo;
		this.member = member;
		this.book = book;
		this.rentdate = rentdate;
	}
	public Rent(Member member, Book book) {
		this.member = member;
		this.book = book;
	}
	public int getRentNo() {
		return rentNo;
	}
	public void setRentNo(int rentNo) {
		this.rentNo = rentNo;
	}
	public Member getMember() {
		return member;
	}
	public void setMember(Member member) {
		this.member = member;
	}
	public Book getBook() {
		return book;
	}
	public void setBook(Book book) {
		this.book = book;
	}
	public Date getRentdate() {
		return rentdate;
	}
	public void setRentdate(Date rentdate) {
		this.rentdate = rentdate;
	}
	@Override
	public String toString() {
		return "Rent [rentNo=" + rentNo + ", member=" + member + ", book=" + book + ", rentdate=" + rentdate + "]";
	}
	
	
} 