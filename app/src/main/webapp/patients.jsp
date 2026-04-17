<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="hms.*" %>
<%@ page import="java.util.*" %>

<%
String isNew = request.getParameter("new");
PatientImpl patientDAO = new PatientImpl();
InsurancePolicyImpl insPolDAO = new InsurancePolicyImpl();

// filters on or off
boolean fssn = false;
boolean fname = false;
boolean fdob = false;
boolean fsex = false;
boolean femail = false;
boolean fphone = false;
boolean finsurer = false;
boolean fminAge = false;
boolean fmaxAge = false;

StringBuilder ssn = new StringBuilder("");
StringBuilder name = new StringBuilder("");
StringBuilder dob = new StringBuilder("");
StringBuilder bioSexStr = new StringBuilder("");
StringBuilder email = new StringBuilder("");
StringBuilder phone = new StringBuilder("");
StringBuilder insurer = new StringBuilder("");
StringBuilder minDOB = new StringBuilder("");
StringBuilder maxDOB = new StringBuilder("");

if (isNew != null){
	ssn.append(request.getParameter("ssn"));
	name.append(request.getParameter("name"));
	dob.append(request.getParameter("dob"));
	char bioSex = (request.getParameter("sex")).charAt(0);
	email.append(request.getParameter("email"));
	phone.append(request.getParameter("phone"));
	String insID = request.getParameter("insuranceid");
	insurer.append(request.getParameter("insurer"));
	String insPlan = request.getParameter("insurancePlan");
	String insPercentStr = request.getParameter("insurancePercent");
	double insPercent = 0.0;
	if (!insPercentStr.isEmpty()){
		insPercent = Double.parseDouble(insPercentStr);
	}
	Patient thisPatient;
	if (!insID.equals("")){
		thisPatient = new Patient(ssn.toString(), name.toString(), dob.toString(), bioSex, email.toString(), phone.toString(), insID, insurer.toString(), insPercent, insPlan);
	} else {
		thisPatient = new Patient(ssn.toString(), name.toString(), dob.toString(), bioSex, email.toString(), phone.toString(), "NULL");
	}
	if (isNew.equals("new")){
		patientDAO.addPatient(thisPatient);
	} else {
		patientDAO.updatePatient(thisPatient);
		if (!insID.equals("")){
			InsurancePolicy insP = new InsurancePolicy(insID, insurer.toString(), insPercent, insPlan);
			insPolDAO.updateInsurancePolicy(insP);
		}
	}
} else {
	String toDelete = request.getParameter("delete");
	if (toDelete != null){
		patientDAO.deletePatient(toDelete);
	}
	// filter/search fields
	ssn.append(request.getParameter("ssn"));
	name.append(request.getParameter("name"));
	dob.append(request.getParameter("dob"));
	bioSexStr.append(request.getParameter("sex"));
	char bioSex = ';';
	if (!(bioSexStr.toString().equals(";") || bioSexStr.toString().equals("null"))){
		bioSex = (bioSexStr).toString().charAt(0);
	}
	email.append(request.getParameter("email"));
	phone.append(request.getParameter("phone"));
	insurer.append(request.getParameter("insurer"));
	minDOB.append(request.getParameter("minDOB"));
	maxDOB.append(request.getParameter("maxDOB"));
	
	// get filters which apply
	fssn = !(ssn == null || ssn.toString().equals("") || ssn.toString().equals("null"));
	fname = !(name == null || name.toString().equals("") || name.toString().equals("null"));
	fdob = !(dob == null || dob.toString().equals("") || dob.toString().equals("null"));
	fsex = bioSex != ';';
	femail = !(email == null || email.toString().equals("") || email.toString().equals("null"));
	fphone = !(phone == null || phone.toString().equals("") || phone.toString().equals("null"));
	finsurer = !(insurer == null || insurer.toString().equals("") || insurer.toString().equals("null"));
	fminAge = !(minDOB == null || minDOB.toString().equals("") || minDOB.toString().equals("null"));
	fmaxAge = !(maxDOB == null || maxDOB.toString().equals("") || maxDOB.toString().equals("null"));
}
%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <title>Hospital MS- Patients</title>
        <meta charset="UTF-8">
        <link rel="stylesheet" href="styles.css">
    </head>
    <!--Functions: search patients (w filters), remove patient-->
    <body>
        <header>
            <h1>Patient Directory</h1>
            <button class="directory-button" onclick="location.href='index.html';">Back to Home</button>
        </header>
        <main>
            <!--for adding a new patient-->
            <button class="add-button" onclick="location.href='patientform.jsp';">Add Patient</button>
            <div id="search-form">
                <form class="search-filter" method="post">
                    <p>Search: </p>
                    <div class="search-field">
                        <label for="ssn">SSN:</label><br>
                        <input type="password" id="ssn" name="ssn">
                    </div>
                    <div class="search-field">
                        <label for="name">Name:</label><br>
                        <input type="text" id="name" name="name" placeholder="e.g. John, Doe, John Doe">
                    </div>
                    <div class="search-field">
                        <label for="dob">Date of Birth:</label><br>
                        <input type="date" id="dob" name="dob">
                    </div>
                    <div class="search-field">
                        <label for="email">Email Address:</label><br>
                        <input type="email" id="email" name="email" placeholder=" e.g.johndoe@example.org">
                    </div>
                    <div class="search-field">
                        <label for="phone">Phone #:</label><br>
                        <input type="tel" id="phone" name="phone" placeholder="e.g. 555-555-5555">
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
                        <label for="minDOB">Born After:</label><br>
                        <input type="date" id="minDOB" name="minDOB">
                    </div>
                    <div class="filter-field">
                        <label for="maxDOB">Born Before:</label><br>
                        <input type="date" id="maxDOB" name="maxDOB">
                    </div>
                    <div class="filter-field">
                        <label for="sex">Biological Sex:</label><br>
                        <select id="sex" name="sex">
                            <option value=";" selected>Show All</option>
                            <option value="m">Male</option>
                            <option value="f">Female</option>
                            <option value="x">Intersex</option>
                        </select>
                    </div>
                    <div class="filter-field">
                        <label for="insurer">Insurance Provider:</label><br>
                        <input type="text" id="insurer" name="insurer" placeholder="e.g. Aetna">
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
                        <th>Name</th>
                        <th>Currently Staying?</th> <!--Room number, or No-->
                        <th>Date of Birth</th>
                        <th>Sex</th>
                        <th>Email Address</th>
                        <th>Phone Number</th>
                        <th>Insurance</th> <!--Provider, Plan-->
                        <th class="update">Update</th> <!--for update button-->
                        <th class="delete">Delete</th> <!--for delete button-->
                    </tr>
                    <!--add rows depending on query results-->
                    <%
                    StringBuilder allRows = new StringBuilder("");
                    ArrayList<Patient> patientResults = patientDAO.getAllPatients();
                    // apply filters
                    if (fssn){
                    	patientResults = FilterUtil.filter(patientResults, p -> p.getSsn().equals(ssn.toString()));
                    }
                    if (fname){
                    	patientResults = FilterUtil.filter(patientResults, p -> p.getName().matches(".*" + name.toString() + ".*"));
                    }
                    if (fdob){
                    	patientResults = FilterUtil.filter(patientResults, p -> p.getDob().equals(dob.toString()));
                    }
                    if (femail){
                    	patientResults = FilterUtil.filter(patientResults, p -> p.getEmail().equals(email.toString()));
                    }
                    if (fphone){
                    	patientResults = FilterUtil.filter(patientResults, p -> p.getPhone().equals(phone.toString()));
                    }
                    if (finsurer){
                    	patientResults = FilterUtil.filter(patientResults, p -> ((insPolDAO.getInsurancePolicy(p.getInsID())).getInsProvider().matches(".*" + insurer.toString() + ".*")));
                    }
                    if (fsex){
                    	patientResults = FilterUtil.filter(patientResults, p -> p.getBioSex() == bioSexStr.charAt(0));
                    }
                   	if (fminAge){
                       	patientResults = FilterUtil.filter(patientResults, p -> p.getDob().compareTo(minDOB.toString()) >= 0);
                       }
                   if (fmaxAge){
                	   patientResults = FilterUtil.filter(patientResults, p -> p.getDob().compareTo(maxDOB.toString()) <= 0);
                   }
                
                    patientResults.forEach((p) -> {
                    	InsurancePolicy insP = insPolDAO.getInsurancePolicy(p.getInsID());
                    	allRows.append("<tr>" +
                                "<td>"+p.getName()+"</td>" +
                                "<td>[placeholder]</td>" +
                                "<td>"+p.getDob()+"</td>" +
                                "<td>"+p.getBioSex()+"</td>" +
                                "<td>"+p.getEmail()+"</td>" +
                                "<td>"+p.getPhone()+"</td>" +
                                "<td>"+insP.getInsProvider() + ", "+ insP.getPlanType()+"</td>" +
                                "<td class=\"update\"><form action=\"patientform.jsp\" method=\"post\"><button class=\"update-button\" type=\"submit\" value=\""+p.getSsn()+"\" name=\"update\">Update</button></form></td>" +
                                "<td class=\"delete\"><form method=\"post\"><button class=\"delete-button\" type=\"submit\" value=\""+p.getSsn()+"\" name=\"delete\">Delete</button></form></td>" +
                            "</tr>");
                    } );
                    %>
                    <%=allRows %>
                </table>
            </div>
        </main>
    </body>
</html>