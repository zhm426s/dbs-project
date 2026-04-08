public class Surgery {
    
    private String treatmentID;
    private String bodyLocation;
    private int surgeonID;

    public Surgery(String treatmentID, String bodyLocation, int surgeonID) {
        this.treatmentID = treatmentID;
        this.bodyLocation = bodyLocation;
        this.surgeonID = surgeonID;
    }

    public String getTreatmentID() {
        return treatmentID;
    }

    public void setTreatmentID(String treatmentID) {
        this.treatmentID = treatmentID;
    }

    public String getBodyLocation() {
        return bodyLocation;
    }

    public void setBodyLocation(String bodyLocation) {
        this.bodyLocation = bodyLocation;
    }

    public int getSurgeonID() {
        return surgeonID;
    }

    public void setSurgeonID(int surgeonID) {
        this.surgeonID = surgeonID;
    }


}
