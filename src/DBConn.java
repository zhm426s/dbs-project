import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

// superclass which creates a database connection
public class DBConn {

    // create the connection
    public static Connection createConn() {
        Connection conn = null;
        try {
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/hospital_management_sys", "root", "password");
            System.out.println("Connection secured.");
        } catch (SQLException e) {
            System.out.println("SQL Error: " + e.getMessage());
        }
        return conn;
    }

    // run this class the verify that connection is working
    public static void main(String[] args) {
        Connection conn = createConn();
    }
}
