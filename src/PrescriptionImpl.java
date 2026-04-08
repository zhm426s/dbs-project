import java.sql.*;

public class PrescriptionImpl extends DBConn {
    public void addPrescription(Prescription prescription) {
        try {
            Connection conn = createConn();
            Statement stmt = conn.createStatement();
            String sql = "INSERT INTO prescription (treatmentID, medicationName, dosage, frequency) VALUES (" + 
            prescription.getTreatmentID() + ", '" + prescription.getMedicationName() + "', '" + prescription.getDosage() + "', '" + prescription.getFrequency() + "')";
            stmt.executeUpdate(sql);
            System.out.println("Added prescription.");
        } catch (SQLException e) {
            System.out.println("SQL Err: " + e.getMessage());
        }
    }
}
