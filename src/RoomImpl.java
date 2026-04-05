import java.sql.*;
import java.util.ArrayList;

public class RoomImpl extends DBConn {
    public void addRoom(Room room) {
        String sql = "INSERT INTO room (building, floorNo, roomNo, status, dailyRate, deptID) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = createConn();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, room.getBuilding());
            stmt.setInt(2, room.getFloorNo());
            stmt.setInt(3, room.getRoomNo());
            stmt.setString(4, room.getStatus());
            stmt.setDouble(5, room.getDailyRate());
            stmt.setInt(6, room.getDeptID());

            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public Room getRoom(int roomNo) {
        String sql = "SELECT * FROM room WHERE roomNo = ?";
        try (Connection conn = createConn();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, roomNo);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return new Room(
                    rs.getString("building"),
                    rs.getInt("floorNo"),
                    rs.getInt("roomNo"),
                    rs.getString("status"),
                    rs.getDouble("dailyRate"),
                    rs.getInt("deptID")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public ArrayList<Room> getAllRooms() {
        ArrayList<Room> rooms = new ArrayList<>();
        String sql = "SELECT * FROM room";
        try (Connection conn = createConn();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                rooms.add(new Room(
                    rs.getString("building"),
                    rs.getInt("floorNo"),
                    rs.getInt("roomNo"),
                    rs.getString("status"),
                    rs.getDouble("dailyRate"),
                    rs.getInt("deptID")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return rooms;
    }

    public void updateRoom(Room room) {
        String sql = "UPDATE room SET building=?, floorNo=?, status=?, dailyRate=?, deptID=? WHERE roomNo=?";
        try (Connection conn = createConn();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, room.getBuilding());
            stmt.setInt(2, room.getFloorNo());
            stmt.setString(3, room.getStatus());
            stmt.setDouble(4, room.getDailyRate());
            stmt.setInt(5, room.getDeptID());
            stmt.setInt(6, room.getRoomNo());

            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // specifically for changing the status and nothing more
    public void updateRoomStatus(int roomNo, String status) {
        String sql = "UPDATE room SET status=? WHERE roomNo=?";
        try (Connection conn = createConn();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, status);
            stmt.setInt(2, roomNo);

            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void deleteRoom(int roomNo) {
        String sql = "DELETE FROM room WHERE roomNo=?";
        try (Connection conn = createConn();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, roomNo);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}