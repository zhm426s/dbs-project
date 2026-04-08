import java.sql.*;
import java.util.ArrayList;

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
    
    public Test getTest(int treatmentID) {
        Test test = null;
        try {
            Connection conn = createConn();
            Statement stmt = conn.createStatement();
            String sql = "SELECT * FROM test WHERE treatmentID = " + treatmentID;
            ResultSet rs = stmt.executeQuery(sql);
            if (rs.next()) {
                test = new Test(rs.getInt("treatmentID"), rs.getString("type"), rs.getString("analyte"), rs.getString("testName"));
            }
         } catch (SQLException e) {
            System.out.println("SQL Err: " + e.getMessage());
        }
        return test;
    }

    public ArrayList<Test> getAllTests() {
        ArrayList<Test> tests = new ArrayList<>();
        try {
            Connection conn = createConn();
            Statement stmt = conn.createStatement();
            String sql = "SELECT * FROM test";
            ResultSet rs = stmt.executeQuery(sql);
            while (rs.next()) {
                Test test = new Test(rs.getInt("treatmentID"), rs.getString("type"), rs.getString("analyte"), rs.getString("testName"));
                tests.add(test);
            }
        } catch (SQLException e) {
            System.out.println("SQL Err: " + e.getMessage());
        }
        return tests;
    }

    public void updateTest(Test test) {
        try {
            Connection conn = createConn();
            Statement stmt = conn.createStatement();
            String sql = "UPDATE test SET type = '" + test.getType() + "', analyte = '" + test.getAnalyte() + "', testName = '" + test.getTestName() + "' WHERE treatmentID = " + test.getTreatmentID();
            stmt.executeUpdate(sql);
            System.out.println("Updated test.");
        } catch (SQLException e) {
            System.out.println("SQL Err: " + e.getMessage());
        }
    }

    public void deleteTest(int treatmentID) {
        try {
            Connection conn = createConn();
            Statement stmt = conn.createStatement();
            String sql = "DELETE FROM test WHERE treatmentID = " + treatmentID;
            stmt.executeUpdate(sql);
            System.out.println("Deleted test.");
        } catch (SQLException e) {
            System.out.println("SQL Err: " + e.getMessage());
        }
    }
}
