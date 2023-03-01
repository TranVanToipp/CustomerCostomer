package fjs.cs.common;

import java.sql.Connection;
import java.sql.DriverManager;

import org.apache.jasper.tagplugins.jstl.core.Catch;

public class DbConnection {
	public static Connection getConnection() {
		Connection con = null;
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			String User = "root";
			String Pass = "";
			con = DriverManager.getConnection("jdbc:mysql://localhost:3306/customsystem", User, Pass);
		}catch(Exception e) {
			e.printStackTrace();
		}
		return con;
	}
}
