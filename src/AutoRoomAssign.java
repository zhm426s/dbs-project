import java.sql.*;
import java.util.ArrayList;

public class AutoRoomAssign {

    private String patientSSN;
    private int careProviderID;
    private String newConditions;

    // for careProviderID: use -1 for an unspecified care provider
    public AutoRoomAssign(String patientSSN, int careProviderID, String newConditions) {
        this.patientSSN = patientSSN;
        this.careProviderID = careProviderID;
        this.newConditions = newConditions;
    }

    public String getPatientSSN() {
        return patientSSN;
    }

    public void setPatientSSN(String patientSSN) {
        this.patientSSN = patientSSN;
    }

    public int getCareProviderID() {
        return careProviderID;
    }

    public void setCareProviderID(int careProviderID) {
        this.careProviderID = careProviderID;
    }

    public String getNewConditions() {
        return newConditions;
    }

    public void setNewConditions(String newConditions) {
        this.newConditions = newConditions;
    }

    // choose the room
    public Room chooseRoom(){
        RoomImpl roomGetter = new RoomImpl();
        ArrayList<Room> roomOptions = roomGetter.getAllRooms();
        // filter out unavailable rooms
        for (Room r : roomOptions){
            if (!(r.getStatus().equals("Available"))){
                roomOptions.remove(r);
            }
        }
        DepartmentImpl deptGetter = new DepartmentImpl();
        int deptID = 0; // will filter out rooms not in this department
        // try to id department via care provider
        if (careProviderID > 0){
            StaffImpl staffGetter = new StaffImpl();
            Staff careProvider = staffGetter.getStaff(careProviderID);
            deptID = careProvider.getDeptID(); 
        }
        // try to id department via conditions
        // TODO
        for (Room r : roomOptions){
            if (r.getDeptID() != deptID){
                roomOptions.remove(r);
            }
        }

        return roomOptions.get(0); // get first item not filtered out
    }
}
