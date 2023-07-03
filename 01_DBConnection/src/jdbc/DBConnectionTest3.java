package jdbc;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import config.ServerInfo;

public class DBConnectionTest3 {

	
	/*
	 * 디비 서버에 대한 정보가 프로그램상에 하드코딩 되어져 있음!
	 * --> 해결책 : 별도의 모듈에 디비서버에 대한 정보를 뽑아내서 별도 처리
	 * 
	 * */
	
	
	public static void main(String[] args) {
		
		try {
			// 1. 드라이버 로딩
			Class.forName(ServerInfo.DRIVER_NAME);
			
			//2. 디비 연결
			Connection conn = DriverManager.getConnection(ServerInfo.URL,ServerInfo.USER,ServerInfo.PASSWORD);
			
			//3. Statement 객체 생성 - UPDATE
			String query = "UPDATE emp SET dept_title = ? WHERE emp_id = ?"; 
			PreparedStatement st = conn.prepareStatement(query);
			
			//4. 쿼리문 실행
			st.setString(1, "디자인팀");
			st.setInt(2, 1);
			
			int result = st.executeUpdate();
			System.out.println(result + "명 수정!");
			
			//5. 결과가 잘 나오는지 확인 - select사용
			String query2 = "SELECT * FROM emp";
			PreparedStatement st2 = conn.prepareStatement(query2);
			
			ResultSet rs = st2.executeQuery(query2);
			
			while(rs.next()) {
			String a = rs.getString("dept_title");
			String b = rs.getString("emp_name");
			int c = rs.getInt("emp_id");
			System.out.println(a+b+" "+c+"명");
			}
	
			
			
			
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
}

