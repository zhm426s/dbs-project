public class Treatment {
    
    private int treatmentID;
    private String treatmentName;
    private String description;
    private double baseCost;

    public Treatment(String treatmentName, String description, double baseCost) {
        this.treatmentName = treatmentName;
        this.description = description;
        this.baseCost = baseCost;
    }

    public int getTreatmentID() {
        return treatmentID;
    }

    public void setTreatmentID(int treatmentID) {
        this.treatmentID = treatmentID;
    }

    public String getTreatmentName() {
        return treatmentName;
    }

    public void setTreatmentName(String treatmentName) {
        this.treatmentName = treatmentName;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public double getBaseCost() {
        return baseCost;
    }

    public void setBaseCost(double baseCost) {
        this.baseCost = baseCost;
    }
}