package hms;

import java.sql.*;
import java.util.ArrayList;

public class PatientImpl extends DBConn {
    // make insurance policy be added in here, not the constructor
    public void addPatient(Patient patient) {
        try {
            Connection conn = createConn();

            // add patient
            Statement addPatientStmt = conn.createStatement();
            String addPatient = ("INSERT INTO patient" +
                "(ssn, name, dateOfBirth, age, bioSex, email, phone, insuranceID)" +
                "VALUES ('"+ patient.getSsn() +"', '"+ patient.getName() +"', '"+ patient.getDob() +"', TIMESTAMPDIFF(YEAR, '"+ patient.getDob() +"', CURDATE()), '"+ patient.getBioSex() +"', '"+ patient.getEmail() +"', '"+ patient.getPhone() +"', '"+ patient.getInsID() +"')");
            addPatientStmt.executeUpdate(addPatient);
            System.out.println("Added patient.");

        } catch (SQLException e) {
            System.out.println("SQL Err: " + e.getMessage());
        }
    }

    public Patient getPatient(String ssn) {
        String sql = "SELECT * FROM patient WHERE ssn = ?";
        try (Connection conn = createConn();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, ssn);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return new Patient(
                    rs.getString("ssn"),
                    rs.getString("name"),
                    rs.getString("dateOfBirth"),
                    rs.getString("bioSex").charAt(0),
                    rs.getString("email"),
                    rs.getString("phone"),
                    rs.getString("insuranceID")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return null;
    }

    public ArrayList<Patient> getAllPatients() {
        ArrayList<Patient> patients = new ArrayList<>();
        String sql = "SELECT * FROM patient";
        try (Connection conn = createConn();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                patients.add(new Patient(
                    rs.getString("ssn"),
                    rs.getString("name"),
                    rs.getString("dateOfBirth"),
                    rs.getString("bioSex").charAt(0),
                    rs.getString("email"),
                    rs.getString("phone"),
                    rs.getString("insuranceID")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return patients;
    }
    
    public int getCountPatients() {
    	int count = 0;
    	String sql = "SELECT COUNT(*) FROM patient";
        try (Connection conn = createConn();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            if (rs.next()) {
                count = rs.getInt("COUNT(*)");   
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return count;
    }

    public void updatePatient(Patient patient) {
        String sql = "UPDATE patient SET name=?, dateOfBirth=?, bioSex=?, email=?, phone=?, insuranceID=? WHERE ssn=?";
        try (Connection conn = createConn();
        	
            PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, patient.getName());
            stmt.setString(2, patient.getDob());
            stmt.setString(3, String.valueOf(patient.getBioSex()));
            stmt.setString(4, patient.getEmail());
            stmt.setString(5, patient.getPhone());
            stmt.setString(6, patient.getInsID());
            stmt.setString(7, patient.getSsn());

            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void deletePatient(String ssn) {
        String sql = "DELETE FROM patient WHERE ssn=?";
        try (Connection conn = createConn();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, ssn);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void deletePatientConditions(String ssn) {
        String sql = "DELETE FROM condition_ WHERE patientSSN=?";
        try (Connection conn = createConn();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, ssn);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}