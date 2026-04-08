public class Prescription {
    
    private int treatmentID;
    private String medicationName;
    private int dosage;
    private String unit;
    private String frequency;

    // for use in adding a prescription, where treatmentID is not yet known
    public Prescription(String medicationName, int dosage, String unit, String frequency) {
        this.medicationName = medicationName;
        this.dosage = dosage;
        this.unit = unit;
        this.frequency = frequency;
    }

    public Prescription(int treatmentID, String medicationName, int dosage, String unit, String frequency) {
        this.treatmentID = treatmentID;
        this.medicationName = medicationName;
        this.dosage = dosage;
        this.unit = unit;
        this.frequency = frequency;
    }

    public String getMedicationName() {
        return medicationName;
    }

    public void setMedicationName(String medicationName) {
        this.medicationName = medicationName;
    }

    public int getDosage() {
        return dosage;
    }

    public void setDosage(int dosage) {
        this.dosage = dosage;
    }

    public String getUnit() {
        return unit;
    }

    public void setUnit(String unit) {
        this.unit = unit;
    }

    public String getFrequency() {
        return frequency;
    }

    public void setFrequency(String frequency) {
        this.frequency = frequency;
    }

    public int getTreatmentID() {
        return treatmentID;
    }

    public void setTreatmentID(int treatmentID) {
        this.treatmentID = treatmentID;
    }


}
