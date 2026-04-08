import java.sql.*;

public class TestImpl extends DBConn {
    public void addTest(Test test) {
        try {
            Connection conn = createConn();
            Statement stmt = conn.createStatement();
            String sql = "INSERT INTO Test (treatmentID, type, analyte, testName) VALUES (" + test.getTreatmentID() + ", '" + test.getType() + "', '" + test.getAnalyte() + "', '" + test.getTestName() + "')";
            stmt.executeUpdate(sql);
            System.out.println("Added test.");
        } catch (SQLException e) {
            System.out.println("SQL Err: " + e.getMessage());
        }
    }
    
}
