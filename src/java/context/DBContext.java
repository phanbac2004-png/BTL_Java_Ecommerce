
package context;

import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;


public class DBContext {
    private static final String URL = "jdbc:mysql://localhost:3306/wishdata";
    private static final String USER = "root";
    private static final String PASSWORD = "";
    public static Connection getConnection() throws SQLException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection connect = DriverManager.getConnection(URL, USER, PASSWORD);
            return connect;
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(DBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }
}
 