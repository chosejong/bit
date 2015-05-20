<%@page import="jdbc.ConnectionContext"%>
<%@ page language="java" contentType="application/json; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%
	String id = request.getParameter("id");
	String password = request.getParameter("passwd");

	String mno = null;
	String passwd = null;
	String nickname = null;
	
	Connection conn = ConnectionContext.getConnection();
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	try {
		String sql = "select * from member where id=?";
		
		pstmt = conn.prepareStatement(sql);
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, id);

		rs = pstmt.executeQuery();

		while (rs.next()) {
			mno = rs.getString("MNO");
			id = rs.getString("ID");
			passwd = rs.getString("passwd");
			nickname = rs.getString("nickname");
		}

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
	
	session.setAttribute("mno", mno);
	session.setAttribute("id", id);
	session.setAttribute("nickname", nickname);
	
%>
{ 
	"mno" : "<%=mno%>",
	"id" : "<%=id%>",
	"password" : "<%=passwd%>",
	"nickname" : "<%=nickname%>"
}