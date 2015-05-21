<%@page import="jdbc.ConnectionContext"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String mno = session.getAttribute("mno").toString();

	String groupName = request.getParameter("groupName");

	String count = request.getParameter("count");
	
	String myCount = mno+'-'+count;
	
	System.out.println(mno);
	System.out.println(groupName);
	System.out.println(count);
	System.out.println(myCount);
	
	Connection conn = ConnectionContext.getConnection();
	
	PreparedStatement pstmt = null;
	
	PreparedStatement pstmt2 = null;
	
	String sql = "insert into member_mygroup values(?, ?)";
	
	String sql2 ="insert into mygroup values(?, ?)";
	
	pstmt = conn.prepareStatement(sql);
	pstmt.setString(1, mno);
	pstmt.setString(2, myCount);
	
	pstmt.executeUpdate();
	
	pstmt2 = conn.prepareStatement(sql2);
	pstmt2.setString(1, myCount);
	pstmt2.setString(2, groupName);
	
	pstmt2.executeUpdate();
		
	pstmt.close();
	
	conn.close();
%>
