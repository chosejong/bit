<%@page import="java.util.UUID"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	// 저장 타입
	request.setCharacterEncoding("utf-8");
	/*  */
	String mId = request.getParameter("id");
	String mName = request.getParameter("name");
	String mPassword = request.getParameter("password");
	
	boolean confirm = false;
	
	String driverName = "com.mysql.jdbc.Driver";
	
	String url = "jdbc:mysql://localhost:3306/test";
	
	String id = "root";
	String pwd = "1234";

	// db에 접속
/* 	String driverName = "com.mysql.jdbc.Driver";
	String url = "jdbc:mysql://192.168.1.210:3306";
	String id = "bit";
	String pwd = "bit";
 */
	try {
		//jdbc로드
		Class.forName(driverName);
	} catch (ClassNotFoundException e) {
		out.println("Where is your mysql jdbc driver?");
		e.printStackTrace();
		return;
	}
	//System.out.println("mysql jdbc Driver registered!!");

	// db 연결
	Connection conn = DriverManager.getConnection(url, id, pwd);

	//out.println("db 연결 성공");
	// e-mail 중복검사 (DB)
	String sql = "select * from member where id=?";
	PreparedStatement pstmt = conn.prepareStatement(sql);
	pstmt.setString(1, mId);
	ResultSet rs = pstmt.executeQuery();
	//System.out.println("1");
	if (rs.next()) 
	{
		//System.out.println("2");
		confirm = true;
	}
	
	// e-mail이 없을경우
	if (!confirm) {
		System.out.println("2-1");
		sql = "insert into member values(?, ?, ?, ?)";
		PreparedStatement pstmt2 = conn.prepareStatement(sql);
		pstmt2 = conn.prepareStatement(sql);
		pstmt2.setString(1, null);
		pstmt2.setString(2, mId);
		pstmt2.setString(3, mPassword);
		pstmt2.setString(4, mName);

		pstmt2.executeUpdate();
		
		pstmt2.close();
	}
	
	System.out.println("3");
	pstmt.close();

	//db 해제
	conn.close();
%>
{"confirm":"<%=confirm %>"}
