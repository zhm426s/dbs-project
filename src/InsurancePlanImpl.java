import java.sql.*;

public class InsurancePlanImpl extends DBConn {
    
    public void addInsurancePlan(InsurancePlan insurancePlan) {
        try {
            Connection conn = createConn();
            Statement stmt = conn.createStatement();
            String sql = ("INSERT IGNORE INTO insurancepolicy" +    // IGNORE is used to avoid duplicates if the plan already exists
                "(insuranceID, providerName, coveragePercent, planName)" +
                "VALUES ('"+ insurancePlan.getInsID() +"', '" + insurancePlan.getInsProvider() + "', " + insurancePlan.getInsPercent() + ", '" + insurancePlan.getPlanType() + "')");
            stmt.executeUpdate(sql);
            System.out.println("Added insurance plan.");
        } catch (SQLException e) {
            System.out.println("SQL Err: " + e.getMessage());
        }
    }
}
