package com.kh.model.dao;

import java.io.FileInputStream;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Properties;

import com.kh.model.vo.Member;

import config.ServerInfo;

public class MemberDAO implements MemberDAOTemplate {

private Properties p = new Properties();
	
	public MemberDAO() {
		try {
			p.load(new FileInputStream("src/config/jdbc.properties"));
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public Connection getConnect() throws SQLException {
		Connection conn = DriverManager.getConnection(ServerInfo.URL,ServerInfo.USER,ServerInfo.PASSWORD);
		return conn;
	}
	
	public void closeAll(PreparedStatement st, Connection conn) throws SQLException {
			if(st!=null)
				st.close();
			if(conn!=null)
				conn.close();
	}
	
	public void closeAll(ResultSet rs, PreparedStatement st, Connection conn) throws SQLException {
		if(rs!=null)
			rs.close();
		closeAll(st,conn);
	}
	
	public void registerMember(Member vo) throws SQLException {
		Connection conn = getConnect();
		PreparedStatement st = conn.prepareStatement(p.getProperty("register"));
		st.setString(1, vo.getId());
		st.setString(2, vo.getPassword());

		st.setString(3, vo.getName());
		
		st.executeUpdate();
		

		
		closeAll(st, conn);
	}
	
	public void updatePassword(Member vo) throws SQLException { 
		Connection conn = getConnect();
		PreparedStatement st = conn.prepareStatement(p.getProperty("updatepw"));
		st.setString(1, vo.getPassword());
		st.setString(2, vo.getId());
		st.executeUpdate();
		
		
	}
	
	public void updateName(Member vo) throws SQLException {
			Connection conn = getConnect();
			PreparedStatement st = conn.prepareStatement(p.getProperty("updatename"));
			
			st.setString(1, vo.getName());
			st.setString(2, vo.getId());
//			st.setString(3, vo.getPassword());
			
			st.executeUpdate();
			
	}
	
	public Member getMember(String id) throws SQLException {
		Member m = null;
		Connection conn = getConnect();
		PreparedStatement st = conn.prepareStatement(p.getProperty("getmember"));
		
		st.setString(1, id);
		ResultSet rs = st.executeQuery();
		String s = "";
		String s1 = "";
		String s2 = "";
		if(rs.next()) {
			m = new Member(id,rs.getString("password"),rs.getString("name"));
		}
		
		closeAll(rs,st,conn);
		return m;
	}
	
	public Member login(Member vo) throws SQLException {
		Connection conn = getConnect();
		PreparedStatement st = conn.prepareStatement(p.getProperty("login"));
		st.setString(1, vo.getId());
		st.setString(2, vo.getPassword());
		ResultSet rs = st.executeQuery();
		Member m = null;
		if(rs.next()) {
			m = new Member(vo.getId(),vo.getPassword(),vo.getName());
		}
		closeAll(rs,st,conn);
		return m;
	}

	

/*
 * dao 란 ?
 * Database Access Object의 약자로 디비에 접근하는 로직(일명 비즈니스 로직)을 담고
 * 있는 객체
 * */

}
