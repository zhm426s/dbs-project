public class HMSTesting {

    public static void main(String[] args) {
        PatientHandler newPatient = new PatientHandler("123-98-7293", "Jane Doe", "1984-02-02", 'F', "johndoe2@example.org", "123-555-8298", "KDSO4338UJFS", "Aetna", 0.13, "Bronze Plan", "Migraines");
        newPatient.addPatient();
    }
}
