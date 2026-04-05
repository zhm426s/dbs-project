public class Department {
    
    private int deptID;
    private String deptName;
    private String building;

    public Department(int deptID, String deptName, String building) {
        this.deptID = deptID;
        this.deptName = deptName;
        this.building = building;
    }

    public int getDeptID() {
        return deptID;
    }

    public void setDeptID(int deptID) {
        this.deptID = deptID;
    }

    public String getDeptName() {
        return deptName;
    }

    public void setDeptName(String deptName) {
        this.deptName = deptName;
    }

    public String getBuilding() {
        return building;
    }

    public void setBuilding(String building) {
        this.building = building;
    }

}
