package hms;

public class Patient {

    private String ssn;
    private String name;
    private String dob;
    private char bioSex;
    private String email;
    private String phone;
    private String insID;

    // main constructor used for creating patient, creates insurance plan (if applicable) at the same time
    public Patient(String ssn, String name, String dob, char bioSex, String email, String phone, String insID, String insProvider, double insPercent, String insPlan){
        this.ssn = ssn;
        this.name = name;
        this.dob = dob;
        this.bioSex = bioSex;
        this.email = email;
        this.phone = phone;
        this.insID = insID;
        if (this.insID != null) {
            InsurancePolicy insurance = new InsurancePolicy(insID, insProvider, insPercent, insPlan);
            InsurancePolicyImpl insuranceDAO = new InsurancePolicyImpl();
            insuranceDAO.addInsurancePlan(insurance);
        }
    }

    // "default" constructor for methods that don't care about insurance info
    public Patient(String ssn, String name, String dob, char bioSex, String email, String phone, String insID) {
        this.ssn = ssn;
        this.name = name;
        this.dob = dob;
        this.bioSex = bioSex;
        this.email = email;
        this.phone = phone;
        this.insID = insID;

    }

    // for use in testing
    public static void main(String[] args) {
    }

    public String getSsn() {
        return ssn;
    }

    public void setSsn(String ssn) {
        this.ssn = ssn;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDob() {
        return dob;
    }

    public void setDob(String dob) {
        this.dob = dob;
    }

    public char getBioSex() {
        return bioSex;
    }

    public void setBioSex(char bioSex) {
        this.bioSex = bioSex;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getInsID() {
        return insID;
    }

    public void setInsID(String insID) {
        this.insID = insID;
    }

}
