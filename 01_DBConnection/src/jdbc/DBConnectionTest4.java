package jdbc;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Properties;

import config.ServerInfo;

public class DBConnectionTest4 {

	
	/*
	 * 디비 서버에 대한 정보가 프로그램상에 하드코딩 되어져 있음!
	 * --> 해결책 : 별도의 모듈에 디비서버에 대한 정보를 뽑아내서 별도 처리
	 * 
	 * */
	
	
	public static void main(String[] args) {
		
		try {
			
			Properties p = new Properties();
			p.load(new FileInputStream("src/config/jdbc.properties"));
			// 1. 드라이버 로딩
			Class.forName(ServerInfo.DRIVER_NAME);
			
			//2. 디비 연결
			Connection conn = DriverManager.getConnection(ServerInfo.URL,ServerInfo.USER,ServerInfo.PASSWORD);
			
			
			//3. Statement 객체 생성 - DELETE
			String query = p.getProperty("jdbc.sql.delete");
			PreparedStatement st = conn.prepareStatement(query);

			//4. 쿼리문 실행ㄷ
			st.setInt(1, 1);
			
			int result = st.executeUpdate();
			System.out.println(result + "명 삭제!");
			//5. 결과가 잘 나오는지 확인 - select사용
			query = p.getProperty("jdbc.sql.select");
			PreparedStatement st2 = conn.prepareStatement(query);
			
			ResultSet rs = st2.executeQuery(query);
			
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
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}

