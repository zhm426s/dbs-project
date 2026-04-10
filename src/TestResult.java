import java.util.Date;

public class TestResult {
    
    private String patientSSN;
    private Date date_;
    private int treatmentID;
    private String result;
    private int orderedByDoctor;

    public TestResult(String patientSSN, Date date_, int treatmentID, String result, int orderedByDoctor) {
        this.patientSSN = patientSSN;
        this.date_ = date_;
        this.treatmentID = treatmentID;
        this.result = result;
        this.orderedByDoctor = orderedByDoctor;
    }

    public String getPatientSSN() {
        return patientSSN;
    }

    public void setPatientSSN(String patientSSN) {
        this.patientSSN = patientSSN;
    }

    public Date getDate_() {
        return date_;
    }

    public void setDate_(Date date_) {
        this.date_ = date_;
    }

    public int getTreatmentID() {
        return treatmentID;
    }

    public void setTreatmentID(int treatmentID) {
        this.treatmentID = treatmentID;
    }

    public String getResult() {
        return result;
    }

    public void setResult(String result) {
        this.result = result;
    }

    public int getOrderedByDoctor() {
        return orderedByDoctor;
    }

    public void setOrderedByDoctor(int orderedByDoctor) {
        this.orderedByDoctor = orderedByDoctor;
    }
}
