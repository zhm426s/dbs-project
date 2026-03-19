import java.sql.*;
import java.util.ArrayList;

// class which creates all tables for the db
public class DBInit extends DBConn {

    public static void createTable(Connection conn, String createCode){
        try {
            Statement statement = conn.createStatement();
            statement.execute(createCode);
            System.out.println("Successfully created table.");

        } catch (Exception e) {
            System.out.println("SQL Error: " + e.getMessage());
        }
    }

    public static void main(String[] args) {
        ArrayList<String> c = new ArrayList<>();
        // create InsurancePolicy
        c.add("CREATE TABLE IF NOT EXISTS InsurancePolicy (" +
            "insuranceID INT AUTO_INCREMENT PRIMARY KEY, " +
            "providerName VARCHAR(30), " +
            "coveragePercent FLOAT, " +
            "planName VARCHAR(40));");
        // create Patient
        c.add("CREATE TABLE IF NOT EXISTS Patient (" +
            "ssn CHAR(11) PRIMARY KEY NOT NULL, " +
            "name VARCHAR(200), " +
            "dateOfBirth DATE, " +
            "bioSex CHAR(1), " + 
            "email VARCHAR(200), " +
            "phone VARCHAR(15), " +
            "insuranceID INT, " +
            "FOREIGN KEY (insuranceID) REFERENCES InsurancePolicy(insuranceID)" +
            ");");
        // create Condition
        // note: i had to change the table and column names "condition" because it is a protected word in sql
        c.add("CREATE TABLE IF NOT EXISTS PatientCondition (" +
            "patientSSN CHAR(11) NOT NULL, " +
            "conditionName VARCHAR(200), " +
            "CONSTRAINT PK_Condition PRIMARY KEY (patientSSN, conditionName), " +
            "FOREIGN KEY (patientSSN) REFERENCES Patient(ssn)" +
            ");");
        // other tables' create statements are added like so
        // be sure to order them such that foreign keys arent pointing to tables that are created after it

        // create all tables
        Connection conn = createConn();
        for (int i=0; i < c.size(); i++) {
            createTable(conn, c.get(i));
        }
    }

}
