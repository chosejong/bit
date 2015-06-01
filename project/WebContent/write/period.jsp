<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	String startTime = request.getParameter("startfrom");
	String endTime = request.getParameter("endfrom");

	// DB에 접속
	String driverName = "com.mysql.jdbc.Driver";

	String url = "jdbc:mysql://localhost:3306/test";

	String id = "root";
	String pwd = "1234";

	try {
		//jdbc로드
		Class.forName(driverName);

	} catch (ClassNotFoundException e) {
		//out.println("Where is your mysql jdbc driver?");
		e.printStackTrace();
		return;
	}

	
	// DB연결
	Connection conn = DriverManager.getConnection(url, id, pwd);

	String sql = "insert into artfile(SDATE, EDATE) values(?, ?)";
	PreparedStatement pstmt = conn.prepareStatement(sql);

	pstmt.setString(1, startTime);

	pstmt.setString(2, endTime);

	pstmt.close();

	conn.close();
%>