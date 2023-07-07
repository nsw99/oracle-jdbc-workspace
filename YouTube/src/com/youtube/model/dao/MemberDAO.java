package com.youtube.model.dao;

import java.io.FileInputStream;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Properties;

import com.youtube.model.vo.Member;
import com.youtube.model.vo.Subscribe;

import config.ServerInfo;

public class MemberDAO implements MemberDAOTemplate{

	private Properties p = new Properties();
	public MemberDAO() {
		try {
			p.load(new FileInputStream("src/config/jdbc.properties"));
			Class.forName(ServerInfo.DRIVER_NAME);
		} catch (IOException e) {
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
		
	}
	@Override
	public Connection getConnect() throws SQLException {
		return DriverManager.getConnection(ServerInfo.URL,ServerInfo.USER,ServerInfo.PASSWORD);
	}

	@Override
	public void closeAll(PreparedStatement st, Connection conn) throws SQLException {
		st.close();
		conn.close();
		
	}

	@Override
	public void closeAll(ResultSet rs, PreparedStatement st, Connection conn) throws SQLException {
		rs.close();
		closeAll(st,conn);

	}

	@Override
	public int register(Member member) throws SQLException {
		Connection conn = getConnect();
		PreparedStatement st = conn.prepareStatement(p.getProperty("register"));
		st.setString(1, member.getMemberId());
		st.setString(2, member.getMemberPassword());
		st.setString(3, member.getMemberNickname());
		
		int result = st.executeUpdate();
		closeAll(st,conn);
		return result;
	}

	@Override
	public Member login(String id, String password) throws SQLException {
		Connection conn = getConnect();
		PreparedStatement st = conn.prepareStatement(p.getProperty("login"));
		
		Member member = null;
		
		st.setString(1, id);
		st.setString(2, password);
		ResultSet rs = st.executeQuery();
		
		if(rs.next()) {
			member = new Member();
			member.setMemberId(rs.getString("MEMBER_ID"));
			member.setMemberPassword(rs.getString("MEMBER_PASSWORD"));
			member.setMemberNickname(rs.getString("MEMBER_NICKNAME"));
			
//			member.setMemberEmail(rs.getString("MEMBER_EMAIL"));
//			member.setMemberPhone(rs.getString("MEMBER_PHONE"));
//			member.setGender(rs.getString("MEMBER_GENDER").charAt(0));
//			member.setMemberAuthority(rs.getString("MEMBER_AUTHORITY"));
			
			
		}
		closeAll(rs,st,conn);
		return member;
	}
	//구독 추가, 구독 취소, 내가 구독한 채널 목록 보기
	@Override
	public int addSubscribe(Subscribe subscribe) throws SQLException {
		Connection conn = getConnect();
		PreparedStatement st = conn.prepareStatement("");
		
		
		return 0;
	}

	@Override
	public int deleteSubscribe(int subsCode) throws SQLException {
		return 0;
	}

	@Override
	public ArrayList<Subscribe> mySubscribeList(String memberId) throws SQLException {
		return null;
	}

}
