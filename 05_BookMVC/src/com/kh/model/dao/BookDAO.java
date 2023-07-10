package com.kh.model.dao;

import java.io.FileInputStream;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Properties;

import com.kh.model.vo.Book;
import com.kh.model.vo.Member;
import com.kh.model.vo.Rent;

import config.ServerInfo;

public class BookDAO implements BookDAOTemplate {

	private Properties p = new Properties();
	private ArrayList<Book> book = new ArrayList<Book>();
	
	
	
	public BookDAO() {
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
		Connection conn = DriverManager.getConnection(ServerInfo.URL, ServerInfo.USER, ServerInfo.PASSWORD);
		return conn;
	}


	@Override
	public void closeAll(PreparedStatement st, Connection conn) throws SQLException {
		
			st.close();
			conn.close();
	}

	@Override
	public void closeAll(ResultSet rs, PreparedStatement st, Connection conn) throws SQLException {
			rs.close();
		closeAll(st, conn);
	}

	@Override
	public ArrayList<Book> printBookAll() throws SQLException {
		Connection conn = getConnect();

		PreparedStatement st = conn.prepareStatement(p.getProperty("printBookAll"));
		ResultSet rs = st.executeQuery();
		while (rs.next()) {
			Book bo = new Book();
			bo.setBkNo(rs.getInt("BK_NO"));
			bo.setBkTitle(rs.getString("BK_TITLE"));
			bo.setBkAuthor(rs.getString("BK_AUTHOR"));
			book.add(bo);
		}

		closeAll(rs, st, conn);
		return book;
	}

	@Override
	public int registerBook(Book book) throws SQLException {
		Connection conn = getConnect();
		PreparedStatement st = conn.prepareStatement(p.getProperty("registerBook"));
		st.setString(1, book.getBkTitle());
		st.setString(2, book.getBkAuthor());
		int result = st.executeUpdate();
		closeAll(st,conn);
		return result;
	}

	@Override
	public int sellBook(int no) throws SQLException {
		Connection conn = getConnect();
		PreparedStatement st = conn.prepareStatement(p.getProperty("sellBook"));
		st.setInt(1, no);
		int result = st.executeUpdate();
		closeAll(st,conn);
		return result;
	}

	@Override
	public int registerMember(Member member) throws SQLException {
		Connection conn = getConnect();
		PreparedStatement st = conn.prepareStatement(p.getProperty("registerMember"));
		st.setString(1, member.getMemberId());
		st.setString(2, member.getMemberPwd());
		st.setString(3, member.getMemberName());
		int result = st.executeUpdate();
		return result;
	}

	@Override
	public Member login(String id, String password) throws SQLException {
		Connection conn = getConnect();
		PreparedStatement st = conn.prepareStatement(p.getProperty("login"));
		st.setString(1, id);
		st.setString(2,password);
		ResultSet rs = st.executeQuery();
		Member m = null;
		if(rs.next()) {
			m = new Member();
			m.setMemberNo(rs.getInt("member_no"));
			m.setMemberId(rs.getString("member_id"));
			m.setMemberPwd(rs.getString("member_pwd"));
			m.setMemberName(rs.getString("member_name"));
			m.setStatus(rs.getString("status").charAt(0));
			m.setEnrolldate(rs.getDate("enroll_date"));
	}
		closeAll(rs,st,conn);
		return m;
	}

	@Override
	public int deleteMember(String id, String password) throws SQLException {
		Connection conn =getConnect();
		PreparedStatement st = conn.prepareStatement(p.getProperty("deleteMember"));
		st.setString(1, id);
		st.setString(2, password);
		int result = st.executeUpdate();
		closeAll(st,conn);
		return result;
	}

	@Override
	public int rentBook(Rent rent) throws SQLException {
		Connection conn = getConnect();
		PreparedStatement st = conn.prepareStatement(p.getProperty("rentbook"));
		st.setInt(1, rent.getMember().getMemberNo());
		st.setInt(2, rent.getBook().getBkNo());
		int result = st.executeUpdate();
		closeAll(st,conn);
		return result;
	}

	@Override
	public int deleteRent(int no) throws SQLException {
		Connection conn = getConnect();
		PreparedStatement st = conn.prepareStatement(p.getProperty("deleteRent"));
		Rent rent = new Rent();
		rent.setRentNo(no);
		st.setInt(1, rent.getRentNo());
		int result = st.executeUpdate();
		return result;
	}

	@Override
	public ArrayList<Rent> printRentBook(String id) throws SQLException {
		Connection conn = getConnect();
		PreparedStatement st = conn.prepareStatement(p.getProperty("printRentBook"));
		st.setString(1, id);
		
		
		ResultSet rs = st.executeQuery(); 
		ArrayList<Rent> rt = new ArrayList<>();
		while(rs.next()) {
			Rent rent = new Rent();	
			rent.setRentNo(rs.getInt("rent_no"));
			rent.setRentdate(rs.getDate("rent_date"));
			rent.setBook(new Book(rs.getString("bk_title"),rs.getString("bk_author")));
		
			rt.add(rent);
		
		}
		closeAll(rs,st,conn);
		return rt;
		
	}
}
