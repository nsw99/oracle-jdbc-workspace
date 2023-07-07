package com.youtube.model.vo;

public class Member {

	private String memberId;
	private String memberPassword;
	private String memberNickname;
	private String memberEmail;
	private String memberPhone;
	private char Gender;
	private String memberAuthority;
	public Member() {
		// TODO Auto-generated constructor stub
	}
	public Member(String memberId, String memberPassword, String memberNickname, String memberEmail, String memberPhone,
			char gender, String memberAuthority) {
		this.memberId = memberId;
		this.memberPassword = memberPassword;
		this.memberNickname = memberNickname;
		this.memberEmail = memberEmail;
		this.memberPhone = memberPhone;
		Gender = gender;
		this.memberAuthority = memberAuthority;
	}
	public String getMemberId() {
		return memberId;
	}
	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}
	public String getMemberPassword() {
		return memberPassword;
	}
	public void setMemberPassword(String memberPassword) {
		this.memberPassword = memberPassword;
	}
	public String getMemberNickname() {
		return memberNickname;
	}
	public void setMemberNickname(String memberNickname) {
		this.memberNickname = memberNickname;
	}
	public String getMemberEmail() {
		return memberEmail;
	}
	public void setMemberEmail(String memberEmail) {
		this.memberEmail = memberEmail;
	}
	public String getMemberPhone() {
		return memberPhone;
	}
	public void setMemberPhone(String memberPhone) {
		this.memberPhone = memberPhone;
	}
	public char getGender() {
		return Gender;
	}
	public void setGender(char gender) {
		Gender = gender;
	}
	public String getMemberAuthority() {
		return memberAuthority;
	}
	public void setMemberAuthority(String memberAuthority) {
		this.memberAuthority = memberAuthority;
	}
	@Override
	public String toString() {
		return "Member [memberId=" + memberId + ", memberPassword=" + memberPassword + ", memberNickname="
				+ memberNickname + ", memberEmail=" + memberEmail + ", memberPhone=" + memberPhone + ", Gender="
				+ Gender + ", memberAuthority=" + memberAuthority + "]";
	}
	
	
	
}
