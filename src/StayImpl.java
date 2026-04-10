import java.sql.*;
import java.util.ArrayList;

public class StayImpl extends DBConn {
    public void addStay(Stay stay) {
        String[] conditionArr = stay.getConditions().split(" *,+ *");
        try {
            Connection conn = createConn();
            Statement stmt = conn.createStatement();
            // stayid is autoincrement
            String sql = "INSERT INTO Stay (patientSSN, startDate, endDate, length, roomUsed, careProvider) VALUES (" +
            stay.getPatientSSN() + ", '" +
            stay.getStartDate() + "', '" +
            stay.getEndDate() + "', " +
            stay.getLength() + ", " +
            stay.getRoomUsed() + ", " +
            stay.getCareProvider() + ")";
            stmt.executeUpdate(sql);

            // get generated stayid
            PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
                ResultSet rs = ps.getGeneratedKeys();
                if (rs.next()) {
                    int stayID = rs.getInt(1);
                    stay.setStayID(stayID);
                }

            // add conditions
            int i;
            for (i = 0; i < conditionArr.length; i++) {
                Statement addConditionStmt = conn.createStatement();
                String addCondition = "INSERT INTO condition_" +
                "(stayID, condition_)" +
                "VALUES ("+ stay.getStayID() +", '"+ conditionArr[i] +"')";
                addConditionStmt.executeUpdate(addCondition);
                System.out.println("Added condition.");
            }
            System.out.println("Added stay.");
        } catch (SQLException e) {
            System.out.println("SQL Err: " + e.getMessage());
        }
    }

    // i figured this would be better since stayid has no actual meaning
    // it can return multiple/null, not sure if that is like a catastrophe or not
    public ArrayList<Stay> getStayBySSN(int patientSSN) {
        ArrayList<Stay> stays = new ArrayList<>();
        try {
            Connection conn = createConn();
            Statement stmt = conn.createStatement();
            String sql = "SELECT * FROM stay WHERE patientSSN = " + patientSSN;
            ResultSet rs = stmt.executeQuery(sql);
            while (rs.next()) {
                Stay stay = new Stay(rs.getInt("stayID"),
                rs.getInt("patientSSN"),
                rs.getDate("startDate"),
                rs.getDate("endDate"),
                rs.getInt("length"),
                rs.getInt("roomUsed"),
                rs.getInt("careProvider"),
                getStayConditions(rs.getInt("stayID")));
                stays.add(stay);
            }
         } catch (SQLException e) {
            System.out.println("SQL Err: " + e.getMessage());
        }
        return stays;
    }

    public String getStayConditions(int stayID) {
        StringBuilder conditions = new StringBuilder();
        String sql = "SELECT * FROM condition_ WHERE stayID = " + stayID;
        try (Connection conn = createConn();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                conditions.append(rs.getString("condition_")).append(", ");
            }
            if (conditions.length() > 0) {
                conditions.setLength(conditions.length() - 2); // remove trailing comma and space
            }
        } catch (SQLException e) {
            System.out.println("SQL Err: " + e.getMessage());
        }
        return conditions.toString();
    }

    public ArrayList<Stay> getAllStays() {
        ArrayList<Stay> stays = new ArrayList<>();
        try {
            Connection conn = createConn();
            Statement stmt = conn.createStatement();
            String sql = "SELECT * FROM stay";
            ResultSet rs = stmt.executeQuery(sql);
            while (rs.next()) {
                Stay stay = new Stay(rs.getInt("stayID"),
                rs.getInt("patientSSN"),
                rs.getDate("startDate"),
                rs.getDate("endDate"),
                rs.getInt("length"),
                rs.getInt("roomUsed"),
                rs.getInt("careProvider"),
                getStayConditions(rs.getInt("stayID")));
                stays.add(stay);
            }
        } catch (SQLException e) {
            System.out.println("SQL Err: " + e.getMessage());
        }
        return stays;
    }

    public void updateStay(Stay stay) {
        try {
            Connection conn = createConn();
            Statement stmt = conn.createStatement();
            String sql = "UPDATE stay SET patientSSN = " + stay.getPatientSSN() +
            ", startDate = '" + stay.getStartDate() +
            "', endDate = '" + stay.getEndDate() +
            "', length = " + stay.getLength() +
            ", roomUsed = " + stay.getRoomUsed() +
            ", careProvider = " + stay.getCareProvider() +
            " WHERE stayID = " + stay.getStayID();
            stmt.executeUpdate(sql);
            System.out.println("Updated stay.");
        } catch (SQLException e) {
            System.out.println("SQL Err: " + e.getMessage());
        }

        updateStayConditions(stay);
    }

    // do not call directly
    public void updateStayConditions(Stay stay) {
        String[] conditionArr = stay.getConditions().split(" *,+ *");
        String sql = "DELETE FROM condition_ WHERE stayID=?";
        try (Connection conn = createConn();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, String.valueOf(stay.getStayID()));
            stmt.executeUpdate();

            int i;
            for (i = 0; i < conditionArr.length; i++) {
                Statement addConditionStmt = conn.createStatement();
                String addCondition = "INSERT INTO condition_" +
                "(stayID, condition_)" +
                "VALUES ('"+ stay.getStayID() +"', '"+ conditionArr[i] +"')";
                addConditionStmt.executeUpdate(addCondition);
                System.out.println("Updated condition.");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void deleteStay(int stayID) {
        try {
            Connection conn = createConn();
            Statement stmt = conn.createStatement();
            String sql = "DELETE FROM stay WHERE stayID = " + stayID;
            stmt.executeUpdate(sql);
            System.out.println("Deleted stay.");
        } catch (SQLException e) {
            System.out.println("SQL Err: " + e.getMessage());
        }
    }

    public void deleteStayConditions(int stayID) {
        String sql = "DELETE FROM condition_ WHERE stayID=?";
        try (Connection conn = createConn();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, String.valueOf(stayID));
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
