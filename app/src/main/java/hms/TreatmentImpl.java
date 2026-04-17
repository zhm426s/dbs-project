package hms;

import java.sql.*;
import java.util.ArrayList;

public class TreatmentImpl extends DBConn{
    // treatmentID is left out because it is autoincrement
    // must load treatment type object first before calling, use null values for unused treatment types
    // for the treatmentid, can just load null or 0 and then get the generated key and set it in the object
    public int addTreatment(Treatment treatment, String type, Prescription prescription, Surgery surgery, Test test, int stayID) {
    	int treatmentID = 0;
    	try {
            Connection conn = createConn();
            Statement stmt = conn.createStatement();
            String sql = "INSERT INTO treatment (name, description, baseCost) VALUES ('" + 
            treatment.getTreatmentName() + "', '" + treatment.getDescription() + "', " + treatment.getBaseCost() + ")";
            PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            stmt.executeUpdate(sql);
            System.out.println("Added treatment.");

            // get generated treatmentID and set it in the object
                ResultSet rs = ps.getGeneratedKeys();
                if (rs.next()) {
                    treatmentID = rs.getInt(1);
                    System.out.println(rs.getInt(1));
                    treatment.setTreatmentID(treatmentID);
                   
                }
                treatment.setTreatmentID(getTreatmentID(treatment));
                addStayTreatment(treatment.getTreatmentID(), stayID);
                treatmentID = treatment.getTreatmentID();
            
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
        return treatmentID;
    }
    
    public int getTreatmentID(Treatment treatment) {
    	int treatmentID = 0;
    	try {
    		Connection conn =createConn();
            Statement stmt = conn.createStatement();
            String sql = "SELECT treatmentID FROM Treatment WHERE name = '"+ treatment.getTreatmentName() + "' AND description = '" + treatment.getDescription() +
            		"' AND baseCost = " + treatment.getBaseCost();
            ResultSet rs = stmt.executeQuery(sql);
            if (rs.next()) {
                treatmentID = rs.getInt("treatmentID");
            }
            
    	} catch (SQLException e) {
            System.out.println("SQL Err: " + e.getMessage());
        }
    	return treatmentID;
    }
    
    public void addStayTreatment(int treatmentID, int stayID) {
        try {
            Connection conn = createConn();
            Statement stmt = conn.createStatement();
            String sql = "INSERT INTO staytreatment (stayID, treatmentID) VALUES (" +
            stayID + ", " +
            treatmentID + ")";
            stmt.executeUpdate(sql);
            System.out.println("Added stay-treatment.");
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
                treatment = new Treatment(rs.getString("name"), rs.getString("description"), rs.getDouble("baseCost"));
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
                Treatment treatment = new Treatment(rs.getString("name"), rs.getString("description"), rs.getDouble("baseCost"));
                treatment.setTreatmentID(rs.getInt("treatmentID"));
                treatments.add(treatment);
            }
        } catch (SQLException e) {
            System.out.println("SQL Err: " + e.getMessage());
        }
        return treatments;
    }
    
    public ArrayList<Treatment> getAllOnlyPrescriptions() {
        ArrayList<Treatment> treatments = new ArrayList<>();
        try {
            Connection conn = createConn();
            Statement stmt = conn.createStatement();
            String sql = "SELECT * FROM treatment t JOIN prescription p ON t.treatmentID = p.treatmentID";
            ResultSet rs = stmt.executeQuery(sql);
            while (rs.next()) {
                Treatment treatment = new Treatment(rs.getString("name"), rs.getString("description"), rs.getDouble("baseCost"));
                treatment.setTreatmentID(rs.getInt("treatmentID"));
                treatments.add(treatment);
            }
        } catch (SQLException e) {
            System.out.println("SQL Err: " + e.getMessage());
        }
        return treatments;
    }
    
    public ArrayList<Treatment> getAllOnlySurgeries() {
        ArrayList<Treatment> treatments = new ArrayList<>();
        try {
            Connection conn = createConn();
            Statement stmt = conn.createStatement();
            String sql = "SELECT * FROM treatment t JOIN surgery s ON t.treatmentID = s.treatmentID";
            ResultSet rs = stmt.executeQuery(sql);
            while (rs.next()) {
                Treatment treatment = new Treatment(rs.getString("name"), rs.getString("description"), rs.getDouble("baseCost"));
                treatment.setTreatmentID(rs.getInt("treatmentID"));
                treatments.add(treatment);
            }
        } catch (SQLException e) {
            System.out.println("SQL Err: " + e.getMessage());
        }
        return treatments;
    }
    
    public ArrayList<Treatment> getAllOnlyTests() {
        ArrayList<Treatment> treatments = new ArrayList<>();
        try {
            Connection conn = createConn();
            Statement stmt = conn.createStatement();
            String sql = "SELECT * FROM treatment t JOIN test u ON t.treatmentID = u.treatmentID";
            ResultSet rs = stmt.executeQuery(sql);
            while (rs.next()) {
                Treatment treatment = new Treatment(rs.getString("name"), rs.getString("description"), rs.getDouble("baseCost"));
                treatment.setTreatmentID(rs.getInt("treatmentID"));
                treatments.add(treatment);
            }
        } catch (SQLException e) {
            System.out.println("SQL Err: " + e.getMessage());
        }
        return treatments;
    }
    
    public Patient getPatientFromTreatment(int treatmentID) {
        PatientImpl patientDAO = new PatientImpl();
        try {
            Connection conn = createConn();
            Statement stmt = conn.createStatement();
            String sql = "SELECT patientSSN FROM stay s JOIN staytreatment t ON s.stayID = t.stayID WHERE treatmentID = " + treatmentID;
            ResultSet rs = stmt.executeQuery(sql);
            if (rs.next()) {
                return patientDAO.getPatient(rs.getString("patientSSN"));
            }
        } catch (SQLException e) {
            System.out.println("SQL Err: " + e.getMessage());
        }
        return null;
    }
    
    public Stay getStayFromTreatment(int treatmentID) {
        StayImpl stayDAO = new StayImpl();
        try {
            Connection conn = createConn();
            Statement stmt = conn.createStatement();
            String sql = "SELECT stayID FROM staytreatment t WHERE treatmentID = " + treatmentID;
            ResultSet rs = stmt.executeQuery(sql);
            if (rs.next()) {
                return stayDAO.getStay(rs.getInt("stayID"));
            }
        } catch (SQLException e) {
            System.out.println("SQL Err: " + e.getMessage());
        }
        return null;
    }

    public void updateTreatment(Treatment treatment, int stayID) {
        try {
            Connection conn = createConn();
            Statement stmt = conn.createStatement();
            String sql = "UPDATE treatment SET name = '" + treatment.getTreatmentName() + "', description = '" + treatment.getDescription() + "', baseCost = " + treatment.getBaseCost() + " WHERE treatmentID = " + treatment.getTreatmentID();
            stmt.executeUpdate(sql);
            System.out.println("Updated treatment.");
            updateStayTreatment(treatment.getTreatmentID(), stayID);
        } catch (SQLException e) {
            System.out.println("SQL Err: " + e.getMessage());
        }
    }
    
    public void updateStayTreatment(int treatmentID, int stayID) {
        try {
            Connection conn = createConn();
            Statement stmt = conn.createStatement();
            String sql = "UPDATE staytreatment SET stayID = " + stayID
            +" WHERE treatmentID = " + treatmentID;
            stmt.executeUpdate(sql);
            System.out.println("Updated stay-treatment.");
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
