package registration;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
 public static Connection getConnection() throws SQLException, ClassNotFoundException {
     Class.forName("oracle.jdbc.driver.OracleDriver");
     return DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "ojps", "root");
 }
}
