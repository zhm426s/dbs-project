public class Room {
    
    // roomID is autoincrement so it is omitted
    private String building;
    private int floorNo;
    private int roomNo;
    private String status; // "Available", "Occupied", "Maintenance"
    private double dailyRate;
    private int deptID;

    public Room(String building, int floorNo, int roomNo, String status, double dailyRate, int deptID) {
        this.building = building;
        this.floorNo = floorNo;
        this.roomNo = roomNo;
        this.status = status;
        this.dailyRate = dailyRate;
        this.deptID = deptID;
    }

    public String getBuilding() {
        return building;
    }

    public void setBuilding(String building) {
        this.building = building;
    }

    public int getFloorNo() {
        return floorNo;
    }

    public void setFloorNo(int floorNo) {
        this.floorNo = floorNo;
    }

    public int getRoomNo() {
        return roomNo;
    }

    public void setRoomNo(int roomNo) {
        this.roomNo = roomNo;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public double getDailyRate() {
        return dailyRate;
    }

    public void setDailyRate(double dailyRate) {
        this.dailyRate = dailyRate;
    }

    public int getDeptID() {
        return deptID;
    }

    public void setDeptID(int deptID) {
        this.deptID = deptID;
    }


}
