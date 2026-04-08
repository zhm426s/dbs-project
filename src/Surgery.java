public class Surgery {
    
    private int treatmentID;
    private String bodyLocation;
    private int surgeonID;

    // for use in addSurgrery, where treatmentID is not yet known
    public Surgery(String bodyLocation, int surgeonID) {
        this.bodyLocation = bodyLocation;
        this.surgeonID = surgeonID;
    }

    public Surgery(int treatmentID, String bodyLocation, int surgeonID) {
        this.treatmentID = treatmentID;
        this.bodyLocation = bodyLocation;
        this.surgeonID = surgeonID;
    }

    public int getTreatmentID() {
        return treatmentID;
    }

    public void setTreatmentID(int treatmentID) {
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
