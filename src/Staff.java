public class Staff {
    
    private int empID;
    private String name;
    private String address;
    private String title;
    private String specialization;
    private int deptID;

    // for use in adding
    public Staff(String name, String address, String title, String specialization, int deptID) {
        this.name = name;
        this.address = address;
        this.title = title;
        this.specialization = specialization;
        this.deptID = deptID;
    }

    public Staff(int empID, String name, String address, String title, String specialization, int deptID) {
        this.empID = empID;
        this.name = name;
        this.address = address;
        this.title = title;
        this.specialization = specialization;
        this.deptID = deptID;
    }

    public int getEmpID() {
        return empID;
    }

    public void setEmpID(int empID) {
        this.empID = empID;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getSpecialization() {
        return specialization;
    }

    public void setSpecialization(String specialization) {
        this.specialization = specialization;
    }

    public int getDeptID() {
        return deptID;
    }

    public void setDeptID(int deptID) {
        this.deptID = deptID;
    }


}
