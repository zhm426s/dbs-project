package hms;

public class Test {
    
    private int treatmentID;
    private String type;
    private String analyte;
    private String testName;

    // for use in adding a test, where treatmentID is not yet known
    public Test(String type, String analyte, String testName) {
        this.type = type;
        this.analyte = analyte;
        this.testName = testName;
    }

    public Test(int treatmentID, String type, String analyte, String testName) {
        this.treatmentID = treatmentID;
        this.type = type;
        this.analyte = analyte;
        this.testName = testName;
    }

    public int getTreatmentID() {
        return treatmentID;
    }

    public void setTreatmentID(int treatmentID) {
        this.treatmentID = treatmentID;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getAnalyte() {
        return analyte;
    }

    public void setAnalyte(String analyte) {
        this.analyte = analyte;
    }

    public String getTestName() {
        return testName;
    }

    public void setTestName(String testName) {
        this.testName = testName;
    }


}
