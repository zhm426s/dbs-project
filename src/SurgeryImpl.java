import java.sql.*;

public class SurgeryImpl extends DBConn {
    public void addSurgery(Surgery surgery) {
        try {
            Connection conn = createConn();
            Statement stmt = conn.createStatement();
            String sql = "INSERT INTO surgery (treatmentID, bodyLocation, surgeonID) VALUES (" + 
            surgery.getTreatmentID() + ", '" + surgery.getBodyLocation() + "', " + surgery.getSurgeonID() + ")";
            stmt.executeUpdate(sql);
            System.out.println("Added surgery.");
        } catch (SQLException e) {
            System.out.println("SQL Err: " + e.getMessage());
        }
    }
}
