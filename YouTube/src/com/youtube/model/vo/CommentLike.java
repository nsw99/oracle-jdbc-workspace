package com.youtube.model.vo;

import java.util.Date;

public class CommentLike {
	private int commLikeCode;
	private Date commLikeDate;
	private int commentCode;
	
	private Member member;

	public CommentLike() {
		// TODO Auto-generated constructor stub
	}

	public CommentLike(int commLikeCode, Date commLikeDate, int commentCode, Member member) {
		this.commLikeCode = commLikeCode;
		this.commLikeDate = commLikeDate;
		this.commentCode = commentCode;
		this.member = member;
	}

	public int getCommLikeCode() {
		return commLikeCode;
	}

	public void setCommLikeCode(int commLikeCode) {
		this.commLikeCode = commLikeCode;
	}

	public Date getCommLikeDate() {
		return commLikeDate;
	}

	public void setCommLikeDate(Date commLikeDate) {
		this.commLikeDate = commLikeDate;
	}

	public int getCommentCode() {
		return commentCode;
	}

	public void setCommentCode(int commentCode) {
		this.commentCode = commentCode;
	}

	public Member getMember() {
		return member;
	}

	public void setMember(Member member) {
		this.member = member;
	}

	@Override
	public String toString() {
		return "CommentLike [commLikeCode=" + commLikeCode + ", commLikeDate=" + commLikeDate + ", commentCode="
				+ commentCode + ", member=" + member + "]";
	}
	

	
	
}
