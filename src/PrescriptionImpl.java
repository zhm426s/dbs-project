import java.sql.*;
import java.util.ArrayList;

public class PrescriptionImpl extends DBConn {
    public void addPrescription(Prescription prescription) {
        String[] brandNameArr = prescription.getBrandName().split(" *,+ *");
        try {
            Connection conn = createConn();
            Statement stmt = conn.createStatement();
            String sql = "INSERT INTO prescription (treatmentID, genericName, dosage, frequency) VALUES (" + 
            prescription.getTreatmentID() + ", '" + prescription.getGenericName() + "', '" + prescription.getDosage() + "', '" + prescription.getFrequency() + "')";
            stmt.executeUpdate(sql);
            System.out.println("Added prescription.");

            // add brand names
            int i;
            for (i = 0; i < brandNameArr.length; i++) {
                Statement addBrandNameStmt = conn.createStatement();
                String addBrandName = "INSERT INTO brandname_ (treatmentID, brandName) " +
                "VALUES ('"+ prescription.getTreatmentID() +"', '"+ brandNameArr[i] +"')";
                addBrandNameStmt.executeUpdate(addBrandName);
                System.out.println("Added brand name.");
            }
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
                prescription = new Prescription(
                    rs.getInt("treatmentID"),
                    rs.getString("genericName"),
                    rs.getInt("dosage"),
                    rs.getString("unit"),
                    rs.getString("frequency"),
                    getBrandNames(rs.getInt("treatmentID"))
                );
            }
        } catch (SQLException e) {
            System.out.println("SQL Err: " + e.getMessage());
        }
        return prescription;
    }

    public String getBrandNames(int treatmentID) {
        String sql = "SELECT brandName FROM brandname_ WHERE treatmentID = ?";
        StringBuilder brandNames = new StringBuilder();
        try (Connection conn = createConn();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, treatmentID);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                brandNames.append(rs.getString("brandName")).append(", ");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return brandNames.toString();
    }

    public ArrayList<Prescription> getAllPrescriptions() {
        ArrayList<Prescription> prescriptions = new ArrayList<>();
        try {
            Connection conn = createConn();
            Statement stmt = conn.createStatement();
            String sql = "SELECT * FROM prescription";
            ResultSet rs = stmt.executeQuery(sql);
            while (rs.next()) {
                Prescription prescription = new Prescription(
                    rs.getInt("treatmentID"),
                    rs.getString("genericName"),
                    rs.getInt("dosage"),
                    rs.getString("unit"),
                    rs.getString("frequency"),
                    getBrandNames(rs.getInt("treatmentID"))
                );
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
            String sql = "UPDATE prescription SET genericName = '" +
            prescription.getGenericName() +
            "', dosage = " + prescription.getDosage() +
            ", unit = '" + prescription.getUnit() +
            "', frequency = '" + prescription.getFrequency() +
            "' WHERE treatmentID = " + prescription.getTreatmentID();
            stmt.executeUpdate(sql);
            System.out.println("Updated prescription.");
        } catch (SQLException e) {
            System.out.println("SQL Err: " + e.getMessage());
        }

        updateBrandNames(prescription);
    }

    // don't call directly
    public void updateBrandNames(Prescription prescription) {
        String[] brandNameArr = prescription.getBrandName().split(" *,+ *");
        String sql = "DELETE FROM brandname_ WHERE treatmentID=?";
        try (Connection conn = createConn();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, prescription.getTreatmentID());
            stmt.executeUpdate();

            int i;
            for (i = 0; i < brandNameArr.length; i++) {
                Statement addBrandNameStmt = conn.createStatement();
                String addBrandName = "INSERT INTO brandname_ (treatmentID, brandName) VALUES (?, ?)";
                addBrandNameStmt.executeUpdate(addBrandName);
                System.out.println("Updated brand name.");
            }
        } catch (SQLException e) {
            e.printStackTrace();
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

    public void deleteBrandNames(int treatmentID) {
        String sql = "DELETE FROM brandname_ WHERE treatmentID=?";
        try (Connection conn = createConn();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, treatmentID);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
