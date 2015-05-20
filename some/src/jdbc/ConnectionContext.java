package jdbc;

import java.sql.Connection;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;



public class ConnectionContext {

//	private static final Object MUTEX = new Object();
	private static String jndiName = "jdbc/mysql";
//	private static Connection conn= null;

	public static Connection getConnection() {
		Connection conn = null;
		try{
			Context initContext = (Context) new InitialContext()/*.lookup("java:comp/env/")*/;
			DataSource ds = (DataSource)initContext.lookup("java:comp/env/" + jndiName);
			conn = ds.getConnection();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return conn;
	}
}

