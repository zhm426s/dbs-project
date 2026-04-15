import java.util.Date;

public class Stay {
    
    private int stayID;
    private int patientSSN;
    private Date startDate;
    private Date endDate;
    private int length;
    private int roomUsed;
    private int careProvider;
    private String conditions;
    private String treatments;

    // for use in adding (stayid is autoincrement)
    public Stay(int patientSSN, Date startDate, Date endDate, int length, int roomUsed, int careProvider, String conditions, String treatments) {
        this.patientSSN = patientSSN;
        this.startDate = startDate;
        this.endDate = endDate;
        this.length = length;
        this.roomUsed = roomUsed;
        this.careProvider = careProvider;
        this.conditions = conditions;
        this.treatments = treatments;
    }

    public Stay(int stayID, int patientSSN, Date startDate, Date endDate, int length, int roomUsed, int careProvider, String conditions, String treatments) {
        this.stayID = stayID;
        this.patientSSN = patientSSN;
        this.startDate = startDate;
        this.endDate = endDate;
        this.length = length;
        this.roomUsed = roomUsed;
        this.careProvider = careProvider;
        this.conditions = conditions;
        this.treatments = treatments;
    }

    public int getStayID() {
        return stayID;
    }

    public void setStayID(int stayID) {
        this.stayID = stayID;
    }

    public int getPatientSSN() {
        return patientSSN;
    }

    public void setPatientSSN(int patientSSN) {
        this.patientSSN = patientSSN;
    }

    public Date getStartDate() {
        return startDate;
    }

    public void setStartDate(Date startDate) {
        this.startDate = startDate;
    }

    public Date getEndDate() {
        return endDate;
    }

    public void setEndDate(Date endDate) {
        this.endDate = endDate;
    }

    public int getLength() {
        return length;
    }

    public void setLength(int length) {
        this.length = length;
    }

    public int getRoomUsed() {
        return roomUsed;
    }

    public void setRoomUsed(int roomUsed) {
        this.roomUsed = roomUsed;
    }

    public int getCareProvider() {
        return careProvider;
    }

    public void setCareProvider(int careProvider) {
        this.careProvider = careProvider;
    }

    public String getConditions() {
        return conditions;
    }

    public void setConditions(String conditions) {
        this.conditions = conditions;
    }

    public String getTreatments() {
        return treatments;
    }

    public void setTreatments(String treatments) {
        this.treatments = treatments;
    }
}
