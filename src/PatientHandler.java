import java.sql.*;

public class PatientHandler extends DBConn{

    public PatientHandler(){

    }

    // for use in testing
    public static void main(String[] args) {
        addPatient("123-98-7654", "John Doe Jr.", "2003-01-01", 'M', "johndoe2@example.org", "123-555-5678", "KDSO4338UJFS", "Aetna", 0.13, "Bronze Plan", "Fractured Tibia");
    }

    public static void addPatient(String ssn, String name, String dob, char bioSex, String email, String phone, String insID, String insProvider, double insPercent, String insPlan, String conditions){
        // parse condition array
        String[] conditionArr = conditions.split(" *,+ *"); // regex catches 1+ commas w/ any number of spaces before/after
        try {
            Connection conn = createConn();
            if (!(insProvider.equals(""))){
                // add insurance policy
                Statement addInsuranceStmt = conn.createStatement();
                String addInsurance = ("INSERT IGNORE INTO insurancepolicy" + // INSERT IGNORE only adds if the ID is unique (e.g. adding patients under same insurance wont add new insurance)
                    "(insuranceID, providerName, coveragePercent, planName)" +
                    "VALUES ('"+ insID +"', '" + insProvider + "', " + insPercent + ", '" + insPlan + "')");
                addInsuranceStmt.executeUpdate(addInsurance);
                System.out.println("Added patient insurance.");
            } else {
                insID = "NULL";
            }

            // add patient
            Statement addPatientStmt = conn.createStatement();
            String addPatient = ("INSERT INTO patient" +
                "(ssn, name, dateOfBirth, age, bioSex, email, phone, insuranceID)" +
                "VALUES ('"+ ssn +"', '"+ name +"', '"+ dob +"', TIMESTAMPDIFF(YEAR, '"+ dob +"', CURDATE()), '"+ bioSex +"', '"+ email +"', '"+ phone +"', '"+ insID +"')");
            addPatientStmt.executeUpdate(addPatient);
            System.out.println("Added patient.");

            // add conditions
            int i;
            for (i = 0; i < conditionArr.length; i++) {
                Statement addConditionStmt = conn.createStatement();
                String addCondition = "INSERT INTO condition_" +
                "(patientSSN, condition_)" +
                "VALUES ('"+ ssn +"', '"+ conditionArr[i] +"')";
                addConditionStmt.executeUpdate(addCondition);
                System.out.println("Added condition.");
            }
        } catch (SQLException e) {
            System.out.println("SQL Err: " + e.getMessage());
        }
    }
}