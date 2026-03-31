
public class Patient {

    private String ssn;
    private String name;
    private String dob;
    private char bioSex;
    private String email;
    private String phone;
    private String insID;
    private String conditions;

    public Patient(String ssn, String name, String dob, char bioSex, String email, String phone, String insID, String insProvider, double insPercent, String insPlan, String conditions){
        this.ssn = ssn;
        this.name = name;
        this.dob = dob;
        this.bioSex = bioSex;
        this.email = email;
        this.phone = phone;
        this.insID = insID;
        if (this.insID != null) {
            InsurancePlan insurance = new InsurancePlan(insID, insProvider, insPercent, insPlan);
            InsurancePlanImpl insuranceDAO = new InsurancePlanImpl();
            insuranceDAO.addInsurancePlan(insurance);
        }
        
        this.conditions = conditions;
    }

    // "default" constructor for methods that don't care about insurance info
    public Patient(String ssn, String name, String dob, char bioSex, String email, String phone, String insID, String conditions) {
        this.ssn = ssn;
        this.name = name;
        this.dob = dob;
        this.bioSex = bioSex;
        this.email = email;
        this.phone = phone;
        this.insID = insID;
        this.conditions = conditions;

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

    public String getConditions() {
        return conditions;
    }

    public void setConditions(String conditions) {
        this.conditions = conditions;
    }
}
