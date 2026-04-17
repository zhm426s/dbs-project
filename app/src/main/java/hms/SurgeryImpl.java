package hms;

import java.sql.*;
import java.util.ArrayList;

public class SurgeryImpl extends DBConn {
    public void addSurgery(Surgery surgery) {
        try {
            Connection conn = createConn();
            Statement stmt = conn.createStatement();
            String sql = "INSERT INTO surgery (treatmentID, bodyLocation, surgeon) VALUES (" + 
            surgery.getTreatmentID() + ", '" + surgery.getBodyLocation() + "', " + surgery.getSurgeonID() + ")";
            stmt.executeUpdate(sql);
            System.out.println("Added surgery.");
        } catch (SQLException e) {
            System.out.println("SQL Err: " + e.getMessage());
        }
    }
    
    public Surgery getSurgery(int treatmentID) {
        Surgery surgery = null;
        try {
            Connection conn = createConn();
            Statement stmt = conn.createStatement();
            String sql = "SELECT * FROM surgery WHERE treatmentID = " + treatmentID;
            ResultSet rs = stmt.executeQuery(sql);
            if (rs.next()) {
                surgery = new Surgery(rs.getInt("treatmentID"), rs.getString("bodyLocation"), rs.getInt("surgeon"));
            }
        } catch (SQLException e) {
            System.out.println("SQL Err: " + e.getMessage());
        }
        return surgery;
    }

    public ArrayList<Surgery> getAllSurgeries() {
        ArrayList<Surgery> surgeries = new ArrayList<>();
        try {
            Connection conn = createConn();
            Statement stmt = conn.createStatement();
            String sql = "SELECT * FROM surgery";
            ResultSet rs = stmt.executeQuery(sql);
            while (rs.next()) {
                Surgery surgery = new Surgery(rs.getInt("treatmentID"), rs.getString("bodyLocation"), rs.getInt("surgeonID"));
                surgeries.add(surgery);
            }
        } catch (SQLException e) {
            System.out.println("SQL Err: " + e.getMessage());
        }
        return surgeries;
    }

    public void updateSurgery(Surgery surgery) {
        try {
            Connection conn = createConn();
            Statement stmt = conn.createStatement();
            String sql = "UPDATE surgery SET bodyLocation = '" + surgery.getBodyLocation() + "', surgeonID = " + surgery.getSurgeonID() + " WHERE treatmentID = " + surgery.getTreatmentID();
            stmt.executeUpdate(sql);
            System.out.println("Updated surgery.");
        } catch (SQLException e) {
            System.out.println("SQL Err: " + e.getMessage());
        }
    }

    public void deleteSurgery(int treatmentID) {
        try {
            Connection conn = createConn();
            Statement stmt = conn.createStatement();
            String sql = "DELETE FROM surgery WHERE treatmentID = " + treatmentID;
            stmt.executeUpdate(sql);
            System.out.println("Deleted surgery.");
        } catch (SQLException e) {
            System.out.println("SQL Err: " + e.getMessage());
        }
    }
}
