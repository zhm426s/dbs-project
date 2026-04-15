package hms;

import java.sql.*;
import java.util.ArrayList;

public class InsurancePolicyImpl extends DBConn {
    public void addInsurancePlan(InsurancePolicy insurancePlan) {
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

    public InsurancePolicy getInsurancePolicy(String insuranceID) {
        String sql = "SELECT * FROM insurancepolicy WHERE insuranceID = ?";
        try (Connection conn = createConn();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, insuranceID);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return new InsurancePolicy(
                    rs.getString("insuranceID"),
                    rs.getString("providerName"),
                    rs.getDouble("coveragePercent"),
                    rs.getString("planName")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public ArrayList<InsurancePolicy> getAllInsurancePolicies() {
        ArrayList<InsurancePolicy> insurancePolicies = new ArrayList<>();
        String sql = "SELECT * FROM insurancepolicy";
        try (Connection conn = createConn();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                insurancePolicies.add(new InsurancePolicy(
                    rs.getString("insuranceID"),
                    rs.getString("providerName"),
                    rs.getDouble("coveragePercent"),
                    rs.getString("planName")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return insurancePolicies;
    }

    public void updateInsurancePolicy(InsurancePolicy insurancePolicy) {
        String sql = "UPDATE insurancepolicy SET providerName=?, coveragePercent=?, planName=? WHERE insuranceID=?";
        try (Connection conn = createConn();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, insurancePolicy.getInsProvider());
            stmt.setDouble(2, insurancePolicy.getInsPercent());
            stmt.setString(3, insurancePolicy.getPlanType());
            stmt.setString(4, insurancePolicy.getInsID());

            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void deleteInsurancePolicy(String insuranceID) {
        String sql = "DELETE FROM insurancepolicy WHERE insuranceID=?";
        try (Connection conn = createConn();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, insuranceID);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}