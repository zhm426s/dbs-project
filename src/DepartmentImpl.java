import java.sql.*;
import java.util.ArrayList;

public class DepartmentImpl extends DBConn {
    public void addDepartment(Department department) {
        try {
            Connection conn = createConn();
            Statement stmt = conn.createStatement();
            String sql = "INSERT INTO department (deptID, deptName, building) VALUES (" +
                department.getDeptID() + ", '" + department.getDeptName() + "', '" + department.getBuilding() + "')";
            stmt.executeUpdate(sql);
            System.out.println("Added department.");
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
                    rs.getString("building")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
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
                    rs.getString("building")
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
}
