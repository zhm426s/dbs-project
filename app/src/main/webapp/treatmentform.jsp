<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="hms.*" %>
<%@ page import="java.util.*" %>
    
<!DOCTYPE html>
<html lang="en">
    <head>
        <title>Hospital MS- Treatment Form</title>
        <meta charset="UTF-8">
        <link rel="stylesheet" href="styles.css">
    </head>
    <!--Functions: order treatment, edit treatment record-->
    <body>
        <header>
            <h1>Enter Treatment Information</h1>
            <button class="directory-button" onclick="location.href='treatments.jsp';">Back to Treatments Directory</button>
            <button class="directory-button" onclick="location.href='patients.jsp';">Look Up Patient</button>
        </header>
        <main>
        <%
        String update = request.getParameter("update");
        String yesUpdate = "";
        String noUpdate = "";
        
        int treatid = 0;
        String name = "";
        String dob = "";
        int stayid = 0;
        double baseCost = 300.0;
        String tname = "";
        String tdesc = "";
        int orderer = 0;
        String testType = "";
        String testName = "";
        String testAna = "";
        int surgeon = 0;
        String bodyLoc = "";
        String med = "";
        String medb = "";
        int dosage = 0;
        String unit = "";
        String frequency = "";
        
        String pres = "";
        String surg = "";
        String test = "";
        
        // types
        
        if (update == null){
        	noUpdate = " selected";
        	pres = " selected";
        } else {
        	yesUpdate = " selected";
        	
        	TreatmentImpl treatDAO = new TreatmentImpl();
            Treatment updateT = treatDAO.getTreatment(Integer.parseInt(update.substring(1)));
            
            treatid = updateT.getTreatmentID();
            
            Patient patientT = treatDAO.getPatientFromTreatment(treatid);
            name = patientT.getName();
            dob = patientT.getDob();
            
            Stay stayT = treatDAO.getStayFromTreatment(treatid);
            stayid = stayT.getStayID();
            
            baseCost = updateT.getBaseCost();
            tname = updateT.getTreatmentName();
            tdesc = updateT.getDescription();
            
        	if (update.charAt(0) == 'p'){
        		pres = " selected";
        		
        		PrescriptionImpl presDAO = new PrescriptionImpl();
            	Prescription presT = presDAO.getPrescription(treatid);
            	
            	med = presT.getGenericName();
            	medb = presT.getBrandName();
            	dosage = presT.getDosage();
            	unit = presT.getUnit();
            	frequency = presT.getFrequency();
            	
        	} else if (update.charAt(0) == 's'){
        		surg = " selected";
        		
        		SurgeryImpl surgDAO = new SurgeryImpl();
        		Surgery surgT = surgDAO.getSurgery(treatid);
        		
        		surgeon = surgT.getSurgeonID();
        		bodyLoc = surgT.getBodyLocation();
        		
        	} else {
        		test = " selected";
        		
            	TestImpl testDAO = new TestImpl();
            	TestResultImpl testRDAO = new TestResultImpl();
            	Test testT = testDAO.getTest(treatid);
            	TestResult testRT = testRDAO.getTestResultByTID(treatid);
            	
            	orderer = testRT.getOrderedByDoctor();
            	testName = testT.getTestName();
            	testType = testT.getType();
            	testAna = testT.getAnalyte();	
            	
        	}
            
        }
        %>
            <div id="edit-form">
                <form class="edit" method="post" action="treatments.jsp">
                    <div class="edit-field">
                        <label for="new">Is this a new treatment record?:</label><br>
                        <select id="new" name="new">
                            <option value="new"<%=noUpdate %>>Yes</option>
                            <option value="<%=treatid %>"<%=yesUpdate %>>No</option>
                        </select>
                    </div>
                    <div class="edit-field">
                        <label for="name">Patient Name (Matching record):</label><br>
                        <input type="text" id="name" name="name" value="<%=name %>" placeholder="e.g. John, Doe, John Doe" required>
                    </div>
                    <div class="edit-field">
                        <label for="dob">Patient Date of Birth (Matching record):</label><br>
                        <input type="date" id="dob" name="dob" value="<%=dob %>" required>
                    </div>
                    <div class="edit-field">
                        <label for="type">Treatment Type:</label><br>
                        <select id="type" name="type">
                            <option value="test"<%=test %>>Test</option>
                            <option value="prescription"<%=pres %>>Prescription</option>
                            <option value="surgery"<%=surg %>>Surgery</option>
                        </select>
                    </div>
                    <div class="edit-field">
                        <label for="stayid">Stay ID:</label><br>
                        <input type="text" id="stayid" name="stayid"value="<%=stayid %>" placeholder="e.g. 2" required>
                    </div>
                    <div class="edit-field">
                        <label for="baseCost">Base Cost ($):</label><br>
                        <input type="number" id="baseCost" name="baseCost" value="<%=baseCost %>" min="0" max="20000" value="300" step="0.01" required>
                    </div>
                    <div class="edit-field">
                        <label for="tname">Treatment Name:</label><br>
                        <input type="text" id="tname" name="tname" value="<%=tname %>" placeholder="e.g. X-Ray Hand R" required>
                    </div>
                    <div class="edit-field">
                        <label for="tdesc">Treatment Description:</label><br>
                        <input type="text" id="tdesc" name="tdesc" value="<%=tdesc %>" placeholder="e.g. X-Ray Imaging of Right Hand">
                    </div> 
                    <div class="edit-field show-test">
                        <label for="orderer">(Test) Ordering Doctor ID:</label><br>
                        <input type="text" id="orderer" name="orderer" value="<%=orderer %>" placeholder="e.g. 2">
                    </div>  
                    <div class="edit-field show-test">
                        <label for="testType">(Test) Type:</label><br>
                        <input type="text" id="testType" name="testType" value="<%=testType %>" placeholder="e.g. X-Ray">
                    </div>
                    <div class="edit-field show-test">
                        <label for="testAna">(Test) Analyte:</label><br>
                        <input type="text" id="testAna" name="testAna" value="<%=testAna %>" placeholder="e.g. Blood">
                    </div>
                    <div class="edit-field show-test">
                        <label for="testName">(Test) Test Name:</label><br>
                        <input type="text" id="testName" name="testName" value="<%=testName %>" placeholder="e.g. Iron Test">
                    </div>
                    <div class="edit-field show-surg">
                        <label for="surgeon">(Surgery) Surgeon ID:</label><br>
                        <input type="text" id="surgeon" name="surgeon" value="<%=surgeon %>" placeholder="e.g. 2">
                    </div>
                    <div class="edit-field show-surg">
                        <label for="bodyLoc">(Surgery) Body Location:</label><br>
                        <input type="text" id="bodyLoc" name="bodyLoc" value="<%=bodyLoc %>" placeholder="e.g. Leg">
                    </div>
                    <div class="edit-field show-pres">
                        <label for="med">(Prescription) Medication (Generic):</label><br>
                        <input type="text" id="med" name="med" value="<%=med %>" placeholder="e.g. Ibuprofen">
                    </div>
                    <div class="edit-field show-pres">
                        <label for="medb">(Prescription) Medication (Brand):</label><br>
                        <input type="text" id="medb" name="medb" value="<%=medb %>" placeholder="e.g. Advil">
                    </div>
                    <div class="edit-field show-pres">
                        <label for="dose">(Prescription) Dosage:</label><br>
                        <input type="number" id="dose" name="dose" value="<%=dosage %>" min="1" max="4000" placeholder="e.g. 250">
                    </div>
                    <div class="edit-field show-pres">
                        <label for="unit">(Prescription) Dosage Unit:</label><br>
                        <input type="text" id="unit" name="unit" value="<%=unit %>" placeholder="e.g. mg">
                    </div>
                    <div class="edit-field show-pres">
                        <label for="freq">(Prescription) Frequency:</label><br>
                        <input type="text" id="freq" name="freq" value="<%=frequency %>" placeholder="e.g. Once daily">
                    </div>
                    <input type="submit" value="Submit">
                    <input type="reset" value="Clear">
                </form>
            </div>
        </main>
    </body>
</html>