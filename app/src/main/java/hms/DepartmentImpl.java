package hms;

import java.sql.*;
import java.util.ArrayList;

public class DepartmentImpl extends DBConn {
    // deptid is left out because it is autoincrement
    public void addDepartment(Department department) {
        String[] floornoArr = department.getFloorno().split(" *,+ *"); // regex catches 1+ commas w/ any number of spaces before/after
        try {
            Connection conn = createConn();
            Statement stmt = conn.createStatement();
            String sql = "INSERT INTO department (deptName, building) VALUES ('" + 
            department.getDeptName() + "', '" + department.getBuilding() + "')";
            stmt.executeUpdate(sql);
            System.out.println("Added department.");

            // add floornos
            int i;
            for (i = 0; i < floornoArr.length; i++) {
                Statement addfloornoStmt = conn.createStatement();
                String addFloorno = "INSERT INTO floorno_ (deptID, floorno) " +
                "VALUES ('"+ department.getDeptID() +"', '"+ floornoArr[i] +"')";
                addfloornoStmt.executeUpdate(addFloorno);
                System.out.println("Added floorno.");
            }
        } catch (SQLException e) {
            System.out.println("SQL Err: " + e.getMessage());
        }
    }

    public Department getDepartment(int deptID) {
        String sql = "SELECT * FROM department WHERE deptID = ?";
        try (Connection conn = createConn();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, deptID);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return new Department(
                    rs.getInt("deptID"),
                    rs.getString("deptName"),
                    rs.getString("building"),
                    getFloornos(rs.getInt("deptID"))
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // needed this for auto room assignment, theres probably a way to make this more general for searching/filtering by diff columns
    public ArrayList<Department> getDepartmentByName(String deptName) {
        ArrayList<Department> departments = new ArrayList<>();
        String sql = "SELECT * FROM department WHERE deptName LIKE %?%";
        try (Connection conn = createConn();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, deptName);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                departments.add(new Department(
                    rs.getInt("deptID"),
                    rs.getString("deptName"),
                    rs.getString("building"),
                    getFloornos(rs.getInt("deptID"))
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return departments;
    }

    public String getFloornos(int deptID) {
        String sql = "SELECT floorno FROM floorno_ WHERE deptID = ?";
        StringBuilder floornos = new StringBuilder();
        try (Connection conn = createConn();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, deptID);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                floornos.append(rs.getString("floorno")).append(", ");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return floornos.toString();
    }

    public ArrayList<Department> getAllDepartments() {
        ArrayList<Department> departments = new ArrayList<>();
        String sql = "SELECT * FROM department";
        try (Connection conn = createConn();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                departments.add(new Department(
                    rs.getInt("deptID"),
                    rs.getString("deptName"),
                    rs.getString("building"),
                    getFloornos(rs.getInt("deptID"))
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return departments;
    }

    public void updateDepartment(Department department) {
        String sql = "UPDATE department SET deptName=?, building=? WHERE deptID=?";
        try (Connection conn = createConn();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, department.getDeptName());
            stmt.setString(2, department.getBuilding());
            stmt.setInt(3, department.getDeptID());

            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        updateFloornos(department);
    }

    // don't call this directly
    public void updateFloornos(Department department) {
        String[] floornoArr = department.getFloorno().split(" *,+ *"); // regex catches 1+ commas w/ any number of spaces before/after
        String sql = "DELETE FROM floorno_ WHERE deptID=?";
        try (Connection conn = createConn();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, department.getDeptID());
            stmt.executeUpdate();

            int i;
            for (i = 0; i < floornoArr.length; i++) {
            	String addFloorno = "INSERT INTO floorno_ (deptID, floorno) VALUES (?, ?)";
                PreparedStatement addFloornoStmt = conn.prepareStatement(addFloorno);
                addFloornoStmt.setInt(1, department.getDeptID());
                addFloornoStmt.setInt(2, Integer.parseInt(floornoArr[i]));
                addFloornoStmt.executeUpdate();
                System.out.println("Updated floorno.");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void deleteDepartment(int deptID) {
        String sql = "DELETE FROM department WHERE deptID=?";
        try (Connection conn = createConn();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, deptID);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void deleteFloornos(int deptID) {
        String sql = "DELETE FROM floorno_ WHERE deptID=?";
        try (Connection conn = createConn();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, deptID);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}