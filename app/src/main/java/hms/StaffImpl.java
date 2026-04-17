package hms;

import java.sql.*;
import java.util.ArrayList;

public class StaffImpl  extends DBConn {
    // empid is omitted because automincrement
    public void addStaff(Staff staff) {
        try {
            Connection conn = createConn();
            Statement stmt = conn.createStatement();
            String sql = "INSERT INTO staff (name, address, title, specialization, deptID) VALUES ('" +
                staff.getName() + "', '" + staff.getAddress() + "', '" + staff.getTitle() + "', '" + staff.getSpecialization() + "', " + staff.getDeptID() + ")";
            stmt.executeUpdate(sql);
            System.out.println("Added staff member.");
        } catch (SQLException e) {
            System.out.println("SQL Err: " + e.getMessage());
        }
    }

    public Staff getStaff(int empID) {
        String sql = "SELECT * FROM staff WHERE empID = ?";
        try (Connection conn = createConn();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, empID);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return new Staff(
                    rs.getInt("empID"),
                    rs.getString("name"),
                    rs.getString("address"),
                    rs.getString("title"),
                    rs.getString("specialization"),
                    rs.getInt("deptID")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public ArrayList<Staff> getAllStaff() {
        ArrayList<Staff> staffList = new ArrayList<>();
        String sql = "SELECT * FROM staff";
        try (Connection conn = createConn();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                staffList.add(new Staff(
                    rs.getInt("empID"),
                    rs.getString("name"),
                    rs.getString("address"),
                    rs.getString("title"),
                    rs.getString("specialization"),
                    rs.getInt("deptID")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return staffList;
    }

    public void updateStaff(Staff staff) {
        String sql = "UPDATE staff SET name=?, address=?, title=?, specialization=?, deptID=? WHERE empID=?";
        try (Connection conn = createConn();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, staff.getName());
            stmt.setString(2, staff.getAddress());
            stmt.setString(3, staff.getTitle());
            stmt.setString(4, staff.getSpecialization());
            stmt.setInt(5, staff.getDeptID());
            stmt.setInt(6, staff.getEmpID());

            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void deleteStaff(int empID) {
        String sql = "DELETE FROM staff WHERE empID=?";
        try (Connection conn = createConn();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, empID);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}