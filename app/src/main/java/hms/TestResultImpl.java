package hms;

import java.sql.*;
import java.util.ArrayList;
import java.util.Date;

public class TestResultImpl extends DBConn {
    public void addTest(TestResult testResult) {
        try {
            Connection conn = createConn();
            Statement stmt = conn.createStatement();
            String sql = "INSERT INTO TestResult (patientSSN, date_, treatmentID, result, orderedByDoctor) VALUES ('" +
            testResult.getPatientSSN() + "', '" +
            testResult.getDate_() + "', " +
            testResult.getTreatmentID() + ", '" +
            testResult.getResult() + "', " +
            testResult.getOrderedByDoctor() + ")";
            stmt.executeUpdate(sql);
            System.out.println("Added test result.");
        } catch (SQLException e) {
            System.out.println("SQL Err: " + e.getMessage());
        }
    }

    public TestResult getTestResult(String patientSSN, String date_) {
        TestResult testResult = null;
        try {
            Connection conn = createConn();
            Statement stmt = conn.createStatement();
            String sql = "SELECT * FROM TestResult WHERE patientSSN = '" + patientSSN + "' AND date_ = '" + date_ + "'";
            ResultSet rs = stmt.executeQuery(sql);
            if (rs.next()) {
                testResult = new TestResult(
                    rs.getString("patientSSN"),
                    rs.getString("date_"),
                    rs.getInt("treatmentID"),
                    rs.getString("result"),
                    rs.getInt("orderedByDoctor")
                );
            }
         } catch (SQLException e) {
            System.out.println("SQL Err: " + e.getMessage());
        }
        return testResult;
    }
    
    public TestResult getTestResultByTID(int treatmentID) {
        TestResult testResult = null;
        try {
            Connection conn = createConn();
            Statement stmt = conn.createStatement();
            String sql = "SELECT * FROM TestResult WHERE treatmentID = " +  treatmentID;
            ResultSet rs = stmt.executeQuery(sql);
            if (rs.next()) {
                testResult = new TestResult(
                    rs.getString("patientSSN"),
                    rs.getString("date_"),
                    rs.getInt("treatmentID"),
                    rs.getString("result"),
                    rs.getInt("orderedByDoctor")
                );
            }
         } catch (SQLException e) {
            System.out.println("SQL Err: " + e.getMessage());
        }
        return testResult;
    }

    public ArrayList<TestResult> getAllTestResults() {
        ArrayList<TestResult> testResults = new ArrayList<>();
        try {
            Connection conn = createConn();
            Statement stmt = conn.createStatement();
            String sql = "SELECT * FROM TestResult";
            ResultSet rs = stmt.executeQuery(sql);
            while (rs.next()) {
                TestResult testResult = new TestResult(
                    rs.getString("patientSSN"),
                    rs.getString("date_"),
                    rs.getInt("treatmentID"),
                    rs.getString("result"),
                    rs.getInt("orderedByDoctor")
                );
                testResults.add(testResult);
            }
        } catch (SQLException e) {
            System.out.println("SQL Err: " + e.getMessage());
        }
        return testResults;
    }

    public void updateTestResult(TestResult testResult) {
        try {
            Connection conn = createConn();
            Statement stmt = conn.createStatement();
            String sql = "UPDATE TestResult SET patientSSN = '" +
            testResult.getPatientSSN() + "', date_ = '" +
            testResult.getDate_() + "', treatmentID = " +
            testResult.getTreatmentID() + ", result = '" +
            testResult.getResult() + "', orderedByDoctor = " +
            testResult.getOrderedByDoctor() +

            " WHERE treatmentID = " + testResult.getTreatmentID() + "";
            stmt.executeUpdate(sql);
            System.out.println("Updated test result.");
        } catch (SQLException e) {
            System.out.println("SQL Err: " + e.getMessage());
        }
    }

    public void deleteTestResult(String patientSSN, Date date_) {
        try {
            Connection conn = createConn();
            Statement stmt = conn.createStatement();
            String sql = "DELETE FROM TestResult WHERE patientSSN = '" + patientSSN + "' AND date_ = '" + date_ + "'";
            stmt.executeUpdate(sql);
            System.out.println("Deleted test result.");
        } catch (SQLException e) {
            System.out.println("SQL Err: " + e.getMessage());
        }
    }
}
