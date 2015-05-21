<%@page import="java.util.StringTokenizer"%>
<%@page import="java.io.Console"%>
<%@page import="java.util.ArrayList"%>
<%@page import="jdbc.ConnectionContext"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="application/json; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String mno = session.getAttribute("mno").toString();

	Connection conn = ConnectionContext.getConnection();
	
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	ArrayList<String> groupNames  = new ArrayList<String>();
	
	try {
		String sql = "select MYGROUPNAME from mygroup a, member_mygroup b where a.grno=b.grno and b.MNO=?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, mno);

		rs = pstmt.executeQuery();

		while (rs.next()) {
			groupNames.add('"'+rs.getString("mygroupname")+'"');
		}
		System.out.println(groupNames);
	} catch (Exception e) {

		e.printStackTrace();

	} finally {
		if (rs != null)
			try {
				rs.close();
			} catch (SQLException sqle) {
			
			}
		if (pstmt != null)
			try {
				pstmt.close();
			} catch (SQLException sqle) {
		
			}
		if (conn != null)
			try {
				conn.close();
			} catch (SQLException sqle) {
			
			}
	}
%>
<%=groupNames.toString()%>11