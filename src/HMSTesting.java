
public class HMSTesting {

    public static void main(String[] args) {
        PatientImpl patientDAO = new PatientImpl();

        Patient newPatient = new Patient("123-09-1929", "Jimmy Doe", "1948-02-02", 'M', "jimdoe@example.org", "123-555-8911", "JJO1298D723D", "Aetna", 0.13, "Bronze Plan", "Migraines");
        // patientDAO.addPatient(newPatient);
        // printPatientInfo(patientDAO.getPatient("123-09-1929"));
        /*ArrayList<Patient> patients = patientDAO.getAllPatients();
        for (Patient p : patients) {
            printPatientInfo(p);
            System.out.println("-----");
        }*/
    }

    public static void printPatientInfo(Patient patient) {
        System.out.println("SSN: " + patient.ssn);
        System.out.println("Name: " + patient.name);
        System.out.println("DOB: " + patient.dob);
        System.out.println("BioSex: " + patient.bioSex);
        System.out.println("Email: " + patient.email);
        System.out.println("Phone: " + patient.phone);
        System.out.println("Insurance ID: " + patient.insID);
        System.out.println("Conditions: " + patient.conditions);
    }
}
