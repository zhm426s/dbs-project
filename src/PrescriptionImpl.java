import java.sql.*;
import java.util.ArrayList;

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

        public Prescription getPrescription(int treatmentID) {
        Prescription prescription = null;
        try {
            Connection conn = createConn();
            Statement stmt = conn.createStatement();
            String sql = "SELECT * FROM prescription WHERE treatmentID = " + treatmentID;
            ResultSet rs = stmt.executeQuery(sql);
            if (rs.next()) {
                prescription = new Prescription(rs.getInt("treatmentID"), rs.getString("medicationName"), rs.getInt("dosage"), rs.getString("unit"), rs.getString("frequency"));
            }
        } catch (SQLException e) {
            System.out.println("SQL Err: " + e.getMessage());
        }
        return prescription;
    }

    public ArrayList<Prescription> getAllPrescriptions() {
        ArrayList<Prescription> prescriptions = new ArrayList<>();
        try {
            Connection conn = createConn();
            Statement stmt = conn.createStatement();
            String sql = "SELECT * FROM prescription";
            ResultSet rs = stmt.executeQuery(sql);
            while (rs.next()) {
                Prescription prescription = new Prescription(rs.getInt("treatmentID"), rs.getString("medicationName"), rs.getInt("dosage"), rs.getString("unit"), rs.getString("frequency"));
                prescriptions.add(prescription);
            }
        } catch (SQLException e) {
            System.out.println("SQL Err: " + e.getMessage());
        }
        return prescriptions;
    }

    public void updatePrescription(Prescription prescription) {
        try {
            Connection conn = createConn();
            Statement stmt = conn.createStatement();
            String sql = "UPDATE prescription SET medicationName = '" + prescription.getMedicationName() + "', dosage = " + prescription.getDosage() + ", unit = '" + prescription.getUnit() + "', frequency = '" + prescription.getFrequency() + "' WHERE treatmentID = " + prescription.getTreatmentID();
            stmt.executeUpdate(sql);
            System.out.println("Updated prescription.");
        } catch (SQLException e) {
            System.out.println("SQL Err: " + e.getMessage());
        }
    }

    public void deletePrescription(int treatmentID) {
        try {
            Connection conn = createConn();
            Statement stmt = conn.createStatement();
            String sql = "DELETE FROM prescription WHERE treatmentID = " + treatmentID;
            stmt.executeUpdate(sql);
            System.out.println("Deleted prescription.");
        } catch (SQLException e) {
            System.out.println("SQL Err: " + e.getMessage());
        }
    }
}
