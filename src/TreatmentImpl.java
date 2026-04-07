import java.sql.*;

public class TreatmentImpl extends DBConn{
    // treatmentID is left out because it is autoincrement
    public void addTreatment(Treatment treatment) {
        try {
            Connection conn = createConn();
            Statement stmt = conn.createStatement();
            String sql = "INSERT INTO treatment (treatmentName, description, baseCost) VALUES ('" + 
            treatment.getTreatmentName() + "', '" + treatment.getDescription() + "', " + treatment.getBaseCost() + ")";
            stmt.executeUpdate(sql);
            System.out.println("Added treatment.");
        } catch (SQLException e) {
            System.out.println("SQL Err: " + e.getMessage());
        }
    }

    // leaving this for later because i think this should maybe be like insurance policy where it automatically gets created
}
