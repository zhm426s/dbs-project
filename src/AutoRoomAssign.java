import java.sql.*;
import java.util.ArrayList;
import java.util.Arrays;
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import java.util.regex.Pattern;
import java.util.ListIterator;

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
        PatientImpl patientGetter = new PatientImpl();
        Patient patient = patientGetter.getPatient(patientSSN);
        // filter out unavailable rooms
        for (Room r : roomOptions){
            if (!(r.getStatus().equals("Available"))){
                roomOptions.remove(r);
            }
        }
        if (roomOptions.size() > 1) {
            DepartmentImpl deptGetter = new DepartmentImpl();
            ArrayList<Department> depts = new ArrayList<>(); // will filter out rooms not in these departments

            // try to id department based on patient age
            LocalDate patientDOB = LocalDate.parse(patient.getDob());
            long patientAge = ChronoUnit.YEARS.between(patientDOB, LocalDate.now());

            // get departments for infants, children, and older people
            ArrayList<Department> nicus = deptGetter.getDepartmentByName("NICU");
            nicus.addAll(deptGetter.getDepartmentByName("Infant"));
            ArrayList<Department> pediatrics = deptGetter.getDepartmentByName("Paediatric");
            pediatrics.addAll(deptGetter.getDepartmentByName("Pediatric"));
            pediatrics.addAll(deptGetter.getDepartmentByName("Child"));
            ArrayList<Department> geriatrics = deptGetter.getDepartmentByName("Geriatric");
            geriatrics.addAll(deptGetter.getDepartmentByName("Elder"));
            
            if (patientAge < 16) {
                if (patientAge < 2) {
                    depts.addAll(nicus);
                } else {
                    depts.addAll(pediatrics);
                }
            } else if (patientAge > 69) {
                depts.addAll(geriatrics);
            }

            // try to id department via care provider
            if (careProviderID > 0){
                StaffImpl staffGetter = new StaffImpl();
                Staff careProvider = staffGetter.getStaff(careProviderID);
                depts.add(deptGetter.getDepartment(careProvider.getDeptID()));
            }

            if (depts.isEmpty()){
                // try to id department via conditions
                ArrayList<String> conditionList = new ArrayList<String>(Arrays.asList(newConditions.split(" *,+ *")));
                ListIterator<String> li = conditionList.listIterator();

                // big 2d array storing some condition regex keywords sorted by specialty
                String [][] conditionCats = {
                    {".*acute.*", ".*coma.*", ".*overdose.*", ".*shock.*", ".*sepsis.*", ".*stroke.*"}, // ICU
                    {".*cancer.*", ".*\\w+oma\\s"}, // oncology
                    {".*heart.*", ".*cardi.*", ".*aneurysm.*", ".*angio.*", ".*tensi.*", ".*arrhythmia.*", ".*atrial.*", ".*blood.*", ".*arter.*", ".*ischem.*", ".*mitra.*", ".*vasc.*", ".*ventric.*"}, // cardiology
                    {".*bronch.*", ".*chest.*", ".*pulm.*", ".*lung.*", ".*pne.*"}, // pulmonology
                    {".*fract.*", ".*cl.*", ".*arthr.*", ".*bone.*", ".*spin.*", ".*disc.*", ".*dislocat.*", ".*fasci.*", ".*hip.*", ".*joint.*", ".*knee.*", ".*labrum.*", ".*ligament.*", ".*osteo.*", ".*sciatic.*", ".*scolio.*", ".*sesam.*", ".*sprain.*", ".*tunnel.*", ".*tend.*", ".*back.*", ".*wrist.*", ".*elbow.*", ".*hand.*", ".*finger.*", ".*arm.*", ".*leg.*", ".*foot.*"}, // orthopedics
                    {".*gnos.*", ".*phas.*", ".*nerv.*", ".*brain.*", ".*cere.*", ".*chorea.*", ".*enceph.*", ".*myel.*", ".*ton.*", ".*neur.*", ".*sthes.*", ".*paral.*", ".*syn.*", ".*kine.*"}, // neurology
                    {".*meno.*", ".*ov.*", ".*pregnan.*", ".*hyster.*"} // gynecology
                }; 
                String [] deptCats = {"ICU", "Oncol", "Cardiol", "Pulmo", "Orthoped", "Neuro", "Gyne"};

                // iterate through condition matches, add departments that match
                for (int i = 0; i < conditionCats.length; i++){
                    for (int j = 0; j < conditionCats[i].length; j++){
                        while(li.hasNext()) {
                            String cond = li.next();
                            if (Pattern.matches(conditionCats[i][j], cond)){
                                depts.addAll(deptGetter.getDepartmentByName(deptCats[i]));
                                break;
                            }
                        }
                        li = conditionList.listIterator();
                    }
                }

            }
            // if still empty, add primary care and general
            if (depts.isEmpty()){
                depts.addAll(deptGetter.getDepartmentByName("Primary"));
                depts.addAll(deptGetter.getDepartmentByName("General"));
            }
            
            for (Room r : roomOptions){
                for (Department d : depts) {
                    if (r.getDeptID() != d.getDeptID()){
                        roomOptions.remove(r);
                    }
                }
            }
        }

        return roomOptions.get(0); // get first item not filtered out
    }
}
