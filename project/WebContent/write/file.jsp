<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.io.File"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	// 저장 타입
	request.setCharacterEncoding("utf-8");

	File file = null;	
	String fileName = null;
	String mimeType = null;
	String savePath = null;
	long fileSize = 0L;
		savePath = "E:\\apache-tomcat-8.0.22\\temp";
	//String savePath = application.getRealPath("E:/apache-tomcat-8.0.22/temp");
	try {
		// 사이즈 제한
		int size = 5 * 1024 * 1024;
		
		MultipartRequest my = new MultipartRequest(request, savePath,
				size, "utf-8", new DefaultFileRenamePolicy());

		file = my.getFile("file");
		fileName = file.getName();
		fileSize = file.length();

		String mime_FileName = new String(
				fileName.getBytes("ISO-8859-1"), "UTF-8");
		mimeType = application.getMimeType(mime_FileName);
	} catch (Exception e) {

	}
	// 현재 시간 저장
	Calendar calendar = Calendar.getInstance();
		
	Date date = new Date(calendar.getTimeInMillis());
		
	SimpleDateFormat simp = new SimpleDateFormat("yy-MM-dd HH:mm");
		
	String today = simp.format(date);

	// DB에 접속
	String driverName = "com.mysql.jdbc.Driver";
	
	String url = "jdbc:mysql://localhost:3306/test";

	String id = "root";
	String pwd = "1234";
	
	try {
		//jdbc로드
		Class.forName(driverName);
		
	} catch (ClassNotFoundException e) {
		out.println("Where is your mysql jdbc driver?");
		e.printStackTrace();
		return;
	}
	
	// DB연결
	Connection conn = DriverManager.getConnection(url, id, pwd);
	
	String sql = "insert into artfile values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
	PreparedStatement pstmt = conn.prepareStatement(sql);
	// 파일 이름
	pstmt.setString(1, null);
	
	pstmt.setString(2, fileName);
	
	pstmt.setInt(3, 1);
	// 저장될 파일 이름
	pstmt.setString(4, fileName);
	// 파일 사이즈
	pstmt.setLong(5, fileSize);
	// 파일 타입
	pstmt.setString(6, mimeType);
	// 파일 경로
	pstmt.setString(7, savePath);
	// 파일 올린시간
	pstmt.setString(8, today);
	// 수정 시간?
	pstmt.setString(9, null);
	
	pstmt.setInt(10, 1001);
	
	pstmt.setInt(11, 2);
	
	pstmt.executeUpdate();

	pstmt.close();
	conn.close();
%>