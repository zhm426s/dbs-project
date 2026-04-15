import java.sql.*;
import java.util.ArrayList;

public class TreatmentImpl extends DBConn{
    // treatmentID is left out because it is autoincrement
    // must load treatment type object first before calling, use null values for unused treatment types
    public void addTreatment(Treatment treatment, String type, Prescription prescription, Surgery surgery, Test test) {
        try {
            Connection conn = createConn();
            Statement stmt = conn.createStatement();
            String sql = "INSERT INTO treatment (treatmentName, description, baseCost) VALUES ('" + 
            treatment.getTreatmentName() + "', '" + treatment.getDescription() + "', " + treatment.getBaseCost() + ")";
            stmt.executeUpdate(sql);
            System.out.println("Added treatment.");

            // get generated treatmentID and set it in the object
            PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
                ResultSet rs = ps.getGeneratedKeys();
                if (rs.next()) {
                    int treatmentID = rs.getInt(1);
                    treatment.setTreatmentID(treatmentID);
                }
            
            // depending on type of treatment, calls a different method
            switch (type) {
                case "prescription":
                    prescription.setTreatmentID(treatment.getTreatmentID());
                    PrescriptionImpl prescriptionImpl = new PrescriptionImpl();
                    prescriptionImpl.addPrescription(prescription);
                    break;
                case "surgery":
                    surgery.setTreatmentID(treatment.getTreatmentID());
                    SurgeryImpl surgeryImpl = new SurgeryImpl();
                    surgeryImpl.addSurgery(surgery);
                    break;
                case "test":
                    test.setTreatmentID(treatment.getTreatmentID());
                    TestImpl testImpl = new TestImpl();
                    testImpl.addTest(test);
                    break;
            }
        } catch (SQLException e) {
            System.out.println("SQL Err: " + e.getMessage());
        }
    }

    public Treatment getTreatment(int treatmentID) {
        Treatment treatment = null;
        try {
            Connection conn = createConn();
            Statement stmt = conn.createStatement();
            String sql = "SELECT * FROM treatment WHERE treatmentID = " + treatmentID;
            ResultSet rs = stmt.executeQuery(sql);
            if (rs.next()) {
                treatment = new Treatment(rs.getString("treatmentName"), rs.getString("description"), rs.getDouble("baseCost"));
                treatment.setTreatmentID(rs.getInt("treatmentID"));
            }
        } catch (SQLException e) {
            System.out.println("SQL Err: " + e.getMessage());
        }
        return treatment;
    }

    public ArrayList<Treatment> getAllTreatments() {
        ArrayList<Treatment> treatments = new ArrayList<>();
        try {
            Connection conn = createConn();
            Statement stmt = conn.createStatement();
            String sql = "SELECT * FROM treatment";
            ResultSet rs = stmt.executeQuery(sql);
            while (rs.next()) {
                Treatment treatment = new Treatment(rs.getString("treatmentName"), rs.getString("description"), rs.getDouble("baseCost"));
                treatment.setTreatmentID(rs.getInt("treatmentID"));
                treatments.add(treatment);
            }
        } catch (SQLException e) {
            System.out.println("SQL Err: " + e.getMessage());
        }
        return treatments;
    }

    public void updateTreatment(Treatment treatment) {
        try {
            Connection conn = createConn();
            Statement stmt = conn.createStatement();
            String sql = "UPDATE treatment SET treatmentName = '" + treatment.getTreatmentName() +
            "', description = '" + treatment.getDescription() +
            "', baseCost = " + treatment.getBaseCost() +
            " WHERE treatmentID = " + treatment.getTreatmentID();
            stmt.executeUpdate(sql);
            System.out.println("Updated treatment.");
        } catch (SQLException e) {
            System.out.println("SQL Err: " + e.getMessage());
        }
    }

    public void deleteTreatment(int treatmentID) {
        try {
            Connection conn = createConn();
            Statement stmt = conn.createStatement();
            String sql = "DELETE FROM treatment WHERE treatmentID = " + treatmentID;
            stmt.executeUpdate(sql);
            System.out.println("Deleted treatment.");
        } catch (SQLException e) {
            System.out.println("SQL Err: " + e.getMessage());
        }
    }
}
