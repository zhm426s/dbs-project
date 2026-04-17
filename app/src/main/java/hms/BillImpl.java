package hms;

import java.sql.*;
import java.util.ArrayList;
import java.util.Arrays;

public class BillImpl extends DBConn {

    public Bill calculateBill(Stay stay) {

            String insuranceID = null;
        // get insurance through patient ssn
        try {
            Connection conn = createConn();
            Statement stmt = conn.createStatement();
            String sql = "SELECT insuranceID, coveragePercent FROM insurance WHERE insID = (SELECT insuranceID FROM patient WHERE ssn='" + stay.getPatientSSN() + "')";
            ResultSet rs = stmt.executeQuery(sql);
            if (rs.next()) {
                insuranceID = rs.getString("insuranceID");
            }
        } catch (SQLException e) {
            System.out.println("SQL Err: " + e.getMessage());
        }

        InsurancePolicyImpl insuranceDAO = new InsurancePolicyImpl();
        InsurancePolicy patientInsurance = insuranceDAO.getInsurancePolicy(insuranceID);

        RoomImpl roomDAO = new RoomImpl();
        Room room = roomDAO.getRoom(stay.getRoomUsed());
        double roomCost = room.getDailyRate() * stay.getLength();

        StayImpl stayDAO = new StayImpl();
        String[] treatmentArr = stayDAO.getStayTreatments(stay.getStayID()).split(", ");
        // getStayTreatments returns a comma-separated string, so we need to convert it to int
        int[] intArray = Arrays.stream(treatmentArr)
                       .map(String::trim)
                       .mapToInt(Integer::parseInt)
                       .toArray();
        double treatmentCost = 0.0;
        for (int treatmentID : intArray) {
            TreatmentImpl treatmentDAO = new TreatmentImpl();
            Treatment treatment = treatmentDAO.getTreatment(treatmentID);
            treatmentCost += treatment.getBaseCost();
        }

        double subtotal = roomCost + treatmentCost;

        double insuranceCoverageAmount = subtotal * patientInsurance.getInsPercent();

        double taxAmount = subtotal * 0.089;

        double totalDue = subtotal - insuranceCoverageAmount + taxAmount;
        
        return new Bill(stay.getPatientSSN(), stay.getStayID(), insuranceID, roomCost, treatmentCost, subtotal, insuranceCoverageAmount, taxAmount, totalDue);
    }

    // should only be called by addStay (?)
    public void addBill(Bill bill) {
        try {
            Connection conn = createConn();
            Statement stmt = conn.createStatement();

            String sql = "INSERT INTO bill" +
                    "(patientSSN, stayID, insuranceID, roomCost, treatmentCost, subtotal, insuranceCoverageAmount, taxAmount, totalDue) VALUES ('" +
                    bill.getPatientSSN() +"', "+
                    bill.getStayID() +", "+
                    bill.getInsuranceID() +", "+
                    bill.getRoomCost() +", "+
                    bill.getTreatmentCost() +", "+
                    bill.getSubtotal() +", "+
                    bill.getInsuranceCoverageAmount() +", "+
                    bill.getTaxAmount() +", "+
                    bill.getTotalDue() +")";
            stmt.executeUpdate(sql);
        } catch (Exception e) {
            System.out.println("SQL Err: " + e.getMessage());
        }
    }

    public Bill getBillByStayID(int stayID) {
        Bill bill = null;
        try {
            Connection conn = createConn();
            Statement stmt = conn.createStatement();
            String sql = "SELECT * FROM bill WHERE stayID=" + stayID;
            ResultSet rs = stmt.executeQuery(sql);
            if (rs.next()) {
                bill = new Bill(
                rs.getString("patientSSN"),
                rs.getInt("stayID"),
                rs.getString("insuranceID"),
                rs.getDouble("roomCost"),
                rs.getDouble("treatmentCost"),
                rs.getDouble("subtotal"),
                rs.getDouble("insuranceCoverageAmount"),
                rs.getDouble("taxAmount"),
                rs.getDouble("totalDue"));
            }
        } catch (SQLException e) {
            System.out.println("SQL Err: " + e.getMessage());
        }
        return bill;
    }

    public ArrayList<Bill> getAllBills() {
         ArrayList<Bill> bills = new ArrayList<>();
        try {
            Connection conn = createConn();
            Statement stmt = conn.createStatement();
            String sql = "SELECT * FROM bill";
            ResultSet rs = stmt.executeQuery(sql);
            while (rs.next()) {
                Bill bill = new Bill(
                rs.getString("patientSSN"),
                rs.getInt("stayID"),
                rs.getString("insuranceID"),
                rs.getDouble("roomCost"),
                rs.getDouble("treatmentCost"),
                rs.getDouble("subtotal"),
                rs.getDouble("insuranceCoverageAmount"),
                rs.getDouble("taxAmount"),
                rs.getDouble("totalDue"));
                bills.add(bill);
            }
        } catch (SQLException e) {
            System.out.println("SQL Err: " + e.getMessage());
        }
        return bills;
    }

    //unsure if this should even exist
    public void updateBill(Bill bill) {
        try {
            Connection conn = createConn();
            Statement stmt = conn.createStatement();
            String sql = "UPDATE bill SET " +
                    "patientSSN='" + bill.getPatientSSN() +"', "+
                    "insuranceID=" + bill.getInsuranceID() +", "+
                    "roomCost=" + bill.getRoomCost() +", "+
                    "treatmentCost=" + bill.getTreatmentCost() +", "+
                    "subtotal=" + bill.getSubtotal() +", "+
                    "insuranceCoverageAmount=" + bill.getInsuranceCoverageAmount() +", "+
                    "taxAmount=" + bill.getTaxAmount() +", "+
                    "totalDue=" + bill.getTotalDue() +
                    " WHERE stayID=" + bill.getStayID();
            stmt.executeUpdate(sql);
        } catch (SQLException e) {
            System.out.println("SQL Err: " + e.getMessage());
        }
    }

    // can be used to fix errors?
    public void deleteBill(int stayID) {
        try {
            Connection conn = createConn();
            Statement stmt = conn.createStatement();
            String sql = "DELETE FROM bill WHERE stayID=" + stayID;
            stmt.executeUpdate(sql);
        } catch (SQLException e) {
            System.out.println("SQL Err: " + e.getMessage());
        }
    }
}
