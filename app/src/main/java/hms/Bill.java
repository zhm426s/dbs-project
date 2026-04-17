package hms;

public class Bill {
    
    private int billID; //autoincrement
    private String patientSSN; //fk to Patient (can just grab from stay)
    private int stayID; //fk to stay
    private String insuranceID; //fk to insurance
    private double roomCost; // stay.roomUsed * stay.length
    private double treatmentCost; // sum of baseCost of all treatments in stay
    private double subtotal; // roomCost + treatmentCost
    private double insuranceCoverageAmount; //fk to insurancepolicy.coveragePercent * subtotal
    private double taxAmount; // subtotal * 0.089 (atlanta sales tax)
    private double totalDue; // subtotal - insuranceCoverageAmount + taxAmount

    // for adding
    public Bill(String patientSSN, int stayID, String insuranceID, double roomCost, double treatmentCost, double subtotal, double insuranceCoverageAmount, double taxAmount, double totalDue) {
        this.patientSSN = patientSSN;
        this.stayID = stayID;
        this.insuranceID = insuranceID;
        this.roomCost = roomCost;
        this.treatmentCost = treatmentCost;
        this.subtotal = subtotal;
        this.insuranceCoverageAmount = insuranceCoverageAmount;
        this.taxAmount = taxAmount;
        this.totalDue = totalDue;
    }

    public Bill(int billID, String patientSSN, int stayID, String insuranceID, double roomCost, double treatmentCost, double subtotal, double insuranceCoverageAmount, double taxAmount, double totalDue) {
        this.billID = billID;
        this.patientSSN = patientSSN;
        this.stayID = stayID;
        this.insuranceID = insuranceID;
        this.roomCost = roomCost;
        this.treatmentCost = treatmentCost;
        this.subtotal = subtotal;
        this.insuranceCoverageAmount = insuranceCoverageAmount;
        this.taxAmount = taxAmount;
        this.totalDue = totalDue;
    }

    // sets probably shouldn't be here but i'm just adding these out of principle
    public int getBillID() {
        return billID;
    }

    public void setBillID(int billID) {
        this.billID = billID;
    }

    public String getPatientSSN() {
        return patientSSN;
    }

    public void setPatientSSN(String patientSSN) {
        this.patientSSN = patientSSN;
    }

    public int getStayID() {
        return stayID;
    }

    public void setStayID(int stayID) {
        this.stayID = stayID;
    }

    public String getInsuranceID() {
        return insuranceID;
    }

    public void setInsuranceID(String insuranceID) {
        this.insuranceID = insuranceID;
    }

    public double getRoomCost() {
        return roomCost;
    }

    public void setRoomCost(double roomCost) {
        this.roomCost = roomCost;
    }

    public double getTreatmentCost() {
        return treatmentCost;
    }

    public void setTreatmentCost(double treatmentCost) {
        this.treatmentCost = treatmentCost;
    }

    public double getSubtotal() {
        return subtotal;
    }

    public void setSubtotal(double subtotal) {
        this.subtotal = subtotal;
    }

    public double getInsuranceCoverageAmount() {
        return insuranceCoverageAmount;
    }

    public void setInsuranceCoverageAmount(double insuranceCoverageAmount) {
        this.insuranceCoverageAmount = insuranceCoverageAmount;
    }

    public double getTaxAmount() {
        return taxAmount;
    }

    public void setTaxAmount(double taxAmount) {
        this.taxAmount = taxAmount;
    }

    public double getTotalDue() {
        return totalDue;
    }

    public void setTotalDue(double totalDue) {
        this.totalDue = totalDue;
    }

    
}
