import java.sql.*;

public class TreatmentImpl extends DBConn{
    // treatmentID is left out because it is autoincrement
    // must load treatment type object first before calling
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
            
            // add a switch statement for each type of treatment later
            switch (type) {
                case "prescription":
                    PrescriptionImpl prescriptionImpl = new PrescriptionImpl();
                    prescriptionImpl.addPrescription(prescription);
                    break;
                case "surgery":
                    SurgeryImpl surgeryImpl = new SurgeryImpl();
                    surgeryImpl.addSurgery(surgery);
                    break;
                case "test":
                    TestImpl testImpl = new TestImpl();
                    testImpl.addTest(test);
                    break;
            }
        } catch (SQLException e) {
            System.out.println("SQL Err: " + e.getMessage());
        }
    }

    // leaving this for later because i think this should maybe be like insurance policy where it automatically gets created
}
