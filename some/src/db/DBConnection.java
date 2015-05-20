package db;

import java.sql.*;

public class DBConnection 
{
	public static Connection getconn() throws SQLException
	{
		Connection conn = null;
		try
		{
			String driverName = "com.mysql.jdbc.Driver";
			String url = "jdbc:mysql://192.168.1.210:3306";
			String id = "bit";
			String pwd = "bit";
			Class.forName(driverName);
			conn = DriverManager.getConnection(url, id, pwd);
			return conn;
		} catch (ClassNotFoundException ce)
		{
			System.out.println(ce.getMessage());
			return null;
		}
	}
}
