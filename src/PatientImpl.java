import java.sql.*;
import java.util.ArrayList;

public class PatientImpl extends DBConn {
    public void addPatient(Patient patient) {
        // parse condition array
        String[] conditionArr = patient.conditions.split(" *,+ *"); // regex catches 1+ commas w/ any number of spaces before/after
        try {
            Connection conn = createConn();
            if (!(patient.insProvider.equals(""))){
                // add insurance policy
                Statement addInsuranceStmt = conn.createStatement();
                String addInsurance = ("INSERT IGNORE INTO insurancepolicy" + // INSERT IGNORE only adds if the ID is unique (e.g. adding patients under same insurance wont add new insurance)
                    "(insuranceID, providerName, coveragePercent, planName)" +
                    "VALUES ('"+ patient.insID +"', '" + patient.insProvider + "', " + patient.insPercent + ", '" + patient.insPlan + "')");
                addInsuranceStmt.executeUpdate(addInsurance);
                System.out.println("Added patient insurance.");
            } else {
                patient.insID = "NULL";
            }

            // add patient
            Statement addPatientStmt = conn.createStatement();
            String addPatient = ("INSERT INTO patient" +
                "(ssn, name, dateOfBirth, age, bioSex, email, phone, insuranceID)" +
                "VALUES ('"+ patient.ssn +"', '"+ patient.name +"', '"+ patient.dob +"', TIMESTAMPDIFF(YEAR, '"+ patient.dob +"', CURDATE()), '"+ patient.bioSex +"', '"+ patient.email +"', '"+ patient.phone +"', '"+ patient.insID +"')");
            addPatientStmt.executeUpdate(addPatient);
            System.out.println("Added patient.");

            // add conditions
            int i;
            for (i = 0; i < conditionArr.length; i++) {
                Statement addConditionStmt = conn.createStatement();
                String addCondition = "INSERT INTO condition_" +
                "(patientSSN, condition_)" +
                "VALUES ('"+ patient.ssn +"', '"+ conditionArr[i] +"')";
                addConditionStmt.executeUpdate(addCondition);
                System.out.println("Added condition.");
            }
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
                    rs.getString("insuranceID"),
                    "", // insProvider not stored in patient table, would require join to retrieve
                    0.0,
                    "",
                    ""  // not sure how to handle this yet because it's in a whole other table
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
                    rs.getString("insuranceID"),
                    "",
                    0.0,
                    "",
                    ""
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return patients;
    }

    public void updatePatient(Patient patient) {
        String sql = "UPDATE patient SET name=?, dateOfBirth=?, bioSex=?, email=?, phone=?, insuranceID=? WHERE ssn=?";
        try (Connection conn = createConn();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, patient.name);
            stmt.setString(2, patient.dob);
            stmt.setString(3, String.valueOf(patient.bioSex));
            stmt.setString(4, patient.email);
            stmt.setString(5, patient.phone);
            stmt.setString(6, patient.insID);
            stmt.setString(7, patient.ssn);

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
}