package hms;

public class Prescription {
    
    private int treatmentID;
    private String genericName;
    private int dosage;
    private String unit;
    private String frequency;
    private String brandName;

    // for use in adding a prescription, where treatmentID is not yet known
    public Prescription(String genericName, int dosage, String unit, String frequency, String brandName) {
        this.genericName = genericName;
        this.dosage = dosage;
        this.unit = unit;
        this.frequency = frequency;
        this.brandName = brandName;
    }

    public Prescription(int treatmentID, String genericName, int dosage, String unit, String frequency, String brandName) {
        this.treatmentID = treatmentID;
        this.genericName = genericName;
        this.dosage = dosage;
        this.unit = unit;
        this.frequency = frequency;
        this.brandName = brandName;
    }

    public String getGenericName() {
        return genericName;
    }

    public void setGenericName(String genericName) {
        this.genericName = genericName;
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

    public String getBrandName() {
        return brandName;
    }

    public void setBrandName(String brandName) {
        this.brandName = brandName;
    }
}
