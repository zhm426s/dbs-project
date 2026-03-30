
public class Patient extends DBConn{

    String ssn;
    String name;
    String dob;
    char bioSex;
    String email;
    String phone;
    String insID;
    String insProvider;
    double insPercent;
    String insPlan;
    String conditions;

    public Patient(String ssn, String name, String dob, char bioSex, String email, String phone, String insID, String insProvider, double insPercent, String insPlan, String conditions){
        this.ssn = ssn;
        this.name = name;
        this.dob = dob;
        this.bioSex = bioSex;
        this.email = email;
        this.phone = phone;
        this.insID = insID;
        this.insProvider = insProvider;
        this.insPercent = insPercent;
        this.insPlan = insPlan;
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
}
