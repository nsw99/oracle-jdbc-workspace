package com.youtube.model.vo;

import java.util.Date;

public class VideoLike {
	
	private int VlikeCode;
	private Date VlikeDate;
	
	
	private Member member;
	private Video video;
	public VideoLike() {
		// TODO Auto-generated constructor stub
	}
	public VideoLike(int vlikeCode, Date vlikeDate, Member member, Video video) {
		VlikeCode = vlikeCode;
		VlikeDate = vlikeDate;
		this.member = member;
		this.video = video;
	}
	public int getVlikeCode() {
		return VlikeCode;
	}
	public void setVlikeCode(int vlikeCode) {
		VlikeCode = vlikeCode;
	}
	public Date getVlikeDate() {
		return VlikeDate;
	}
	public void setVlikeDate(Date vlikeDate) {
		VlikeDate = vlikeDate;
	}
	public Member getMember() {
		return member;
	}
	public void setMember(Member member) {
		this.member = member;
	}
	public Video getVideo() {
		return video;
	}
	public void setVideo(Video video) {
		this.video = video;
	}
	@Override
	public String toString() {
		return "VideoLike [VlikeCode=" + VlikeCode + ", VlikeDate=" + VlikeDate + ", member=" + member + ", video="
				+ video + "]";
	}
	
	
	
	
	
}
