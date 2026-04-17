<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="hms.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.time.LocalDate"%>

<%
String isNew = request.getParameter("new");
TreatmentImpl treatDAO = new TreatmentImpl();
PrescriptionImpl presDAO = new PrescriptionImpl();
SurgeryImpl surgDAO = new SurgeryImpl();
TestImpl testDAO = new TestImpl();
TestResultImpl testRDAO = new TestResultImpl();
PatientImpl patientDAO = new PatientImpl();
StaffImpl staffDAO = new StaffImpl();
StayImpl stayDAO= new StayImpl();
BillImpl billDAO = new BillImpl();

boolean ftreatid = false;
boolean fssn = false;
boolean fname = false;
boolean ftname = false;
boolean fmed = false;
boolean ftestType = false;
boolean fsurgeon = false;
boolean ftype = false;

StringBuilder treatid = new StringBuilder("");
StringBuilder ssn = new StringBuilder("");
StringBuilder name = new StringBuilder("");
StringBuilder tname = new StringBuilder("");
StringBuilder med = new StringBuilder("");
StringBuilder testType = new StringBuilder("");
StringBuilder surgeon = new StringBuilder("");
StringBuilder type = new StringBuilder("");

if (isNew != null){
	name.append(request.getParameter("name"));
	String dob = request.getParameter("dob");
	ArrayList<Patient> allPatients = patientDAO.getAllPatients();
	allPatients = FilterUtil.filter(allPatients, p -> p.getName().matches(".*" + name.toString() + ".*"));
	allPatients = FilterUtil.filter(allPatients, p -> p.getDob().equals(dob.toString()));
	ssn.append(allPatients.get(0).getSsn());
	
	type.append(request.getParameter("type"));
	String stayid = request.getParameter("stayid");
	String baseCost = request.getParameter("baseCost");
	tname.append(request.getParameter("tname"));
	String tdesc = request.getParameter("tdesc");
	
	testType.append(request.getParameter("testType"));
	String testAna = request.getParameter("testAna");
	String testName = request.getParameter("testName");
	surgeon.append(request.getParameter("surgeon"));
	String bodyLoc = request.getParameter("bodyLoc");
	med.append(request.getParameter("med"));
	String medb = request.getParameter("medb");
	String dosage = request.getParameter("dose");
	String unit = request.getParameter("unit");
	String freq = request.getParameter("freq");
	
	treatid.append(request.getParameter("treatid"));
	String date = request.getParameter("date");
	String result = request.getParameter("result");
	String orderer = request.getParameter("orderer");
	
	if (isNew.equals("new")){
		Treatment thisTreatment = new Treatment(tname.toString(),tdesc.toString(), Double.parseDouble(baseCost.toString()));
		int treatidint = 0;
		switch (type.toString()) {
        case "prescription":
            Prescription thisPres = new Prescription(med.toString(), Integer.parseInt(dosage), unit, freq, medb);
            treatidint = treatDAO.addTreatment(thisTreatment, type.toString(), thisPres, null, null, Integer.parseInt(stayid.toString()));
        	break;
        case "surgery":
        	Surgery thisSurg = new Surgery(bodyLoc, Integer.parseInt(surgeon.toString()));
        	treatidint = treatDAO.addTreatment(thisTreatment, type.toString(), null, thisSurg, null, Integer.parseInt(stayid.toString()));
            break;
        case "test":
        	Test thisTest = new Test(testType.toString(), testAna, testName);
        	treatidint = treatDAO.addTreatment(thisTreatment, type.toString(), null, null, thisTest, Integer.parseInt(stayid.toString()));
        	out.print(treatidint);
        	TestResult thisTestR = new TestResult(ssn.toString(), LocalDate.now().toString(), treatidint, null, Integer.parseInt(orderer));
        	testRDAO.addTest(thisTestR);
            break;
    	}
		Stay assocStay = stayDAO.getStay(Integer.parseInt(stayid.toString()));
		assocStay.setTreatments(assocStay.getTreatments() + treatidint + ",");
		Bill assocBill = billDAO.calculateBill(assocStay);
		billDAO.updateBill(assocBill);
	} else if (isNew.equals("newr")) {		
		TestResult oldResult = testRDAO.getTestResultByTID(Integer.parseInt(treatid.toString()));
		TestResult thisTestR = new TestResult(ssn.toString(), date, Integer.parseInt(treatid.toString()), result, oldResult.getOrderedByDoctor());
		testRDAO.updateTestResult(thisTestR);
	} else {
		treatid.append(isNew);
		Treatment thisTreatment = new Treatment(Integer.parseInt(isNew), tname.toString(),tdesc.toString(), Double.parseDouble(baseCost.toString()));
		treatDAO.updateTreatment(thisTreatment, Integer.parseInt(stayid.toString()));
		switch (type.toString()) {
        case "prescription":
            Prescription thisPres = new Prescription(Integer.parseInt(isNew), med.toString(), Integer.parseInt(dosage), unit, freq, medb);
            presDAO.updatePrescription(thisPres);
        	break;
        case "surgery":
        	Surgery thisSurg = new Surgery(Integer.parseInt(isNew), bodyLoc, Integer.parseInt(surgeon.toString()));
        	surgDAO.updateSurgery(thisSurg);
            break;
        case "test":
        	Test thisTest = new Test(Integer.parseInt(isNew), testType.toString(), testAna, testName);
        	testDAO.updateTest(thisTest);
        	TestResult oldTestR = testRDAO.getTestResult(ssn.toString(), date);
        	TestResult thisTestR = new TestResult(ssn.toString(), oldTestR.getDate_(), Integer.parseInt(treatid.toString()), oldTestR.getResult(), Integer.parseInt(orderer));
        	testRDAO.updateTestResult(thisTestR);
            break;
    	}
	}
} else {
	String toDelete = request.getParameter("delete");
	if (toDelete != null){
		treatDAO.deleteTreatment(Integer.parseInt(toDelete));
	}
	treatid.append(request.getParameter("treatid"));
	ssn.append(request.getParameter("ssn"));
	tname.append(request.getParameter("tname"));
	med.append(request.getParameter("med"));
	testType.append(request.getParameter("testType"));
	surgeon.append(request.getParameter("surgeon"));
	type.append(request.getParameter("type"));
	
	ftreatid = !(treatid == null || treatid.toString().equals("") || treatid.toString().equals("null"));
	fssn = !(ssn == null || ssn.toString().equals("") || ssn.toString().equals("null"));
	ftname = !(tname == null || tname.toString().equals("") || tname.toString().equals("null"));
	fmed = !(med == null || med.toString().equals("") || med.toString().equals("null"));
	ftestType = !(testType == null || testType.toString().equals("") || testType.toString().equals("null"));
	fsurgeon = !(surgeon == null || surgeon.toString().equals("") || surgeon.toString().equals("null"));
	ftype = !(type == null || type.toString().equals("") || type.toString().equals("null"));
}
%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <title>Hospital MS- Treatments</title>
        <meta charset="UTF-8">
        <link rel="stylesheet" href="styles.css">
    </head>
    <!--Functions: search treatment records (w filters), remove test record-->
    <body>
        <header>
            <h1>Treatment Directory</h1>
            <button class="directory-button" onclick="location.href='index.html';">Back to Home</button>
        </header>
        <main>
        <p>Total Treatments in System: <%=treatDAO.getCountTreatments() %></p>
            <div id="actions">
                <!--for ordering a new treatment-->
                <button class="add-button" onclick="location.href='treatmentform.jsp';">Order New Treatment</button>
                <!--for inputting test results-->
                <button class="add-button" onclick="location.href='resultform.jsp';">Input Test Results</button>
            </div>
            <div id="search-form">
                <form class="search-filter" method="post">
                    <p>Search: </p>
                    <div class="search-field">
                        <label for="ssn">Patient SSN:</label><br>
                        <input type="password" id="ssn" name="ssn">
                    </div>
                    <div class="search-field">
                        <label for="name">Patient Name:</label><br>
                        <input type="text" id="name" name="name" placeholder="e.g. John, Doe, John Doe">
                    </div>
                    <div class="search-field">
                        <label for="treatid">Treatment ID:</label><br>
                        <input type="text" id="treatid" name="treatid" placeholder="e.g. 2">
                    </div>
                    <div class="search-field">
                        <label for="tname">Treatment Name:</label><br>
                        <input type="text" id="tname" name="tname" placeholder="e.g. X-Ray Hand R">
                    </div>
                    <div class="search-field">
                        <label for="med">(Prescription) Medication:</label><br>
                        <input type="text" id="med" name="med" placeholder="e.g. Ibuprofen">
                    </div>
                    <div class="search-field">
                        <label for="testType">(Test) Type:</label><br>
                        <input type="text" id="testType" name="testType" placeholder="e.g. X-Ray">
                    </div>
                    <div class="search-field">
                        <label for="surgeon">(Surgery) Surgeon ID:</label><br>
                        <input type="text" id="surgeon" name="surgeon" placeholder="e.g. 2">
                    </div>
                    <div class="search-field">    
                        <input type="submit" value="Search">
                        <input type="reset" value="Clear Search">
                    </div>
                </form>
            </div>
            <div id="filter-form">
                <form class="search-filter" method="post">
                    <p>Filter: </p>
                    <div class="filter-field">
                        <label for="type">Treatment Type:</label><br>
                        <select id="type" name="type">
                            <option value="">Show All</option>
                            <option value="test">Test</option>
                            <option value="prescription">Prescription</option>
                            <option value="surgery">Surgery</option>
                        </select>
                    </div>     
                    <div class="filter-field">    
                        <input type="submit" value="Filter">
                        <input type="reset" value="Clear Filters">
                    </div>
                </form>
            </div>
            <div id="results">
                <p>Results: </p>
                <table id="results-table">
                    <tr>
                        <th>Treatment ID</th>
                        <th>Type</th>
                        <th>Name</th>
                        <th>Description</th>
                        <th>Prescription Details</th> <!--Medication, Dosage at Unit, Frequency-->
                        <th>Test Details</th> <!--Type, Analyte-->
                        <th>Test Results</th> 
                        <th>Surgery Details</th> <!--Body Location, Surgeon Name-->
                        <th class="update">Update</th> <!--for update button-->
                        <th class="delete">Delete</th> <!--for delete button-->
                    </tr>
                    <!--add rows depending on query results-->
                    <%
                    StringBuilder allRows = new StringBuilder("");
                    ArrayList<Treatment> treatResults = treatDAO.getAllTreatments();
            		if (ftype){
            			switch (type.toString()) {
                        case "prescription":
                        	treatResults = treatDAO.getAllOnlyPrescriptions();
                            break;
                        case "surgery":
                        	treatResults = treatDAO.getAllOnlySurgeries();
                            break;
                        case "test":
                        	treatResults = treatDAO.getAllOnlyTests();
                            break;
                    	}
                    }
            		if (ftreatid){
                    	treatResults = FilterUtil.filter(treatResults, t -> t.getTreatmentID() == (Integer.parseInt(treatid.toString())));
                    }
            		if (fssn){
                    	treatResults = FilterUtil.filter(treatResults, t -> treatDAO.getPatientFromTreatment(t.getTreatmentID()).getSsn().equals(ssn.toString()));
                    }
            		if (ftname){
                    	treatResults = FilterUtil.filter(treatResults, t -> t.getTreatmentName().equals(tname.toString()));
                    }
            		if (fmed){
                    	treatResults = FilterUtil.filter(treatResults, t -> presDAO.getPrescription(t.getTreatmentID()).getGenericName().equals(med.toString()));
                    }
            		if (ftestType){
                    	treatResults = FilterUtil.filter(treatResults, t -> testDAO.getTest(t.getTreatmentID()).getType().equals(testType.toString()));
                    }
            		if (fsurgeon){
                    	treatResults = FilterUtil.filter(treatResults, t -> surgDAO.getSurgery(t.getTreatmentID()).getSurgeonID() == Integer.parseInt(surgeon.toString()));
                    }
            		
            		treatResults.forEach((t) -> {
                    	Prescription presT = presDAO.getPrescription(t.getTreatmentID());
                    	Surgery surgT = surgDAO.getSurgery(t.getTreatmentID());
                    	Test testT = testDAO.getTest(t.getTreatmentID());
                    	TestResult testRT = testRDAO.getTestResultByTID(t.getTreatmentID());
                    	
                    	String surgeonName = "";
                    	String bodyLocation = "";
                    	String genericName = "";
                    	int dose = 0;
                    	String unit = "";
                    	String frequency = "";
                    	String testName = "";
                    	String tType = "";
                    	String testAnalyte = "";
                    	String testRes = "";
                    	String testDate = "";
                    	
                    	String ttype = "";
                    	String ttypeU = "";
                    	if (presT != null){
                    		ttype = "Prescription";
                    		ttypeU = "p";
                    		
                    		genericName = presT.getGenericName();
                        	dose = presT.getDosage();
                        	unit = presT.getUnit();
                        	frequency = presT.getFrequency();
                    	} else if (surgT != null){
                    		ttype = "Surgery";
                    		ttypeU = "s";
                    		
                    		Staff surgeonT = staffDAO.getStaff(surgT.getSurgeonID());
                    		surgeonName = surgeonT.getName();
                    		bodyLocation = surgT.getBodyLocation();
                    	} else if (testT != null){
                    		ttype = "Test";
                    		ttypeU = "t";
                    		
                    		testName = testT.getTestName();
                        	tType = testT.getType();
                        	testAnalyte = testT.getAnalyte();
                        	testRes = testRT.getResult();
                        	testDate = testRT.getDate_();
                    	}
                    	allRows.append("<tr>" +
                    			"<td>"+t.getTreatmentID()+"</td>" +
                                "<td>"+ttype+"</td>" +
                                "<td>"+t.getTreatmentName()+"</td>" +
                                "<td>"+t.getDescription()+"</td>" +
                                "<td>"+genericName+", "+dose+" at "+unit+" "+frequency+"</td>" +
                                "<td>"+testName+": "+tType+", "+testAnalyte+"</td>" +
                                "<td>"+testRes + ", "+ testDate+"</td>" +
                                "<td>"+bodyLocation + ", Performed By "+ surgeonName+"</td>" +
                                "<td class=\"update\"><form action=\"treatmentform.jsp\" method=\"post\"><button class=\"update-button\" type=\"submit\" value=\""+ttypeU+t.getTreatmentID()+"\" name=\"update\">Update</button></form></td>" +
                                "<td class=\"delete\"><form method=\"post\"><button class=\"delete-button\" type=\"submit\" value=\""+t.getTreatmentID()+"\" name=\"delete\">Delete</button></form></td>" +
                            "</tr>");
                    } );
                    %>
                    <%=allRows %>
                </table>
            </div>
        </main>
    </body>
</html>