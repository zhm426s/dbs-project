<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="hms.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.time.LocalDate"%>
<%@ page import="java.time.temporal.ChronoUnit" %>

<%
String edit = request.getParameter("edit");
BillImpl billDAO= new BillImpl();
StayImpl stayDAO= new StayImpl();
RoomImpl roomDAO = new RoomImpl();
DepartmentImpl deptDAO = new DepartmentImpl();
StaffImpl staffDAO = new StaffImpl();
PatientImpl patientDAO = new PatientImpl();

boolean fstayid = false;
boolean fssn = false;
boolean fname = false;
boolean fminTot = false;
boolean fmaxTot = false;

StringBuilder stayid = new StringBuilder("");
StringBuilder ssn = new StringBuilder("");
StringBuilder name = new StringBuilder("");
StringBuilder minTot = new StringBuilder("");
StringBuilder maxTot = new StringBuilder("");

if (edit != null){
	ssn.append(request.getParameter("ssn"));
	stayid.append(request.getParameter("stayid"));
	String insuranceid = request.getParameter("insuranceid");
	String rrate = request.getParameter("rrate");
	String treatid = request.getParameter("treatid");
	String treatCost = request.getParameter("treatCost");
	String subtotal = request.getParameter("subtotal");
	String insCoverage = request.getParameter("insCoverage");
	String tax = request.getParameter("tax");
	String total = request.getParameter("total");
	
	Bill oldBill = billDAO.getBillByStayID(Integer.parseInt(stayid.toString()));
	Bill thisBill = new Bill(oldBill.getBillID(), ssn.toString(), oldBill.getStayID(), insuranceid, Double.parseDouble(rrate), Double.parseDouble(treatCost), Double.parseDouble(subtotal), Double.parseDouble(insCoverage), Double.parseDouble(tax), Double.parseDouble(total));
	billDAO.updateBill(thisBill);
} else {
	String toDelete = request.getParameter("delete");
	if (toDelete != null){
		stayDAO.deleteStay(Integer.parseInt(toDelete));
	}
	stayid.append(request.getParameter("stayid"));
	ssn.append(request.getParameter("ssn"));
	name.append(request.getParameter("name"));
	minTot.append(request.getParameter("minTot"));
	maxTot.append(request.getParameter("maxTot"));
	
	fstayid = !(stayid == null || stayid.toString().equals("") || stayid.toString().equals("null"));
	fssn = !(ssn == null || ssn.toString().equals("") || ssn.toString().equals("null"));
	fname = !(name == null || name.toString().equals("") || name.toString().equals("null"));
	fminTot = !(minTot == null || minTot.toString().equals("") || minTot.toString().equals("null"));
	fmaxTot = !(maxTot == null || maxTot.toString().equals("") || maxTot.toString().equals("null"));
}
%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <title>Hospital MS- Bills</title>
        <meta charset="UTF-8">
        <link rel="stylesheet" href="styles.css">
    </head>
    <!--Functions: (bill auto-created for every stay, treatments auto-added to bill when ordered) view billing history (w filters), view + print bill for patient (calc oop costs included), delete bill record -->    <body>
        <header>
            <h1>Billing Directory</h1>
            <button class="directory-button" onclick="location.href='index.html';">Back to Home</button>
        </header>
        <main>
        <p>Total Bills in System: <%=billDAO.getCountBills() %></p>
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
                        <label for="stayid">Stay ID: </label><br>
                        <input type="text" id="stayid" name="stayid" placeholder="e.g. 2">
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
                        <label for="minTot">Minimum Total ($):</label><br>
                        <input type="number" id="minTot" name="minTot" min="0" max="10000000" step="500">
                    </div>
                    <div class="filter-field">
                        <label for="maxTot">Maximum Total ($):</label><br>
                        <input type="number" id="maxTot" name="maxTot" min="0" max="10000000" step="500">
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
                        <th>Patient Name, DOB</th>
                        <th>Stay ID</th>
                        <th>Room Cost</th>
                        <th>Treatments</th>
                        <th>Treatment Costs</th>
                        <th>Subtotal</th>
                        <th>Insurance Coverage</th>
                        <th>Tax</th>
                        <th>Total</th>
                        <th class="update">Edit</th> <!--for edit button-->
                        <th class="delete">Delete</th> <!--for delete button-->
                    </tr>
                    <!--add rows depending on query results-->
                    <%
                    StringBuilder allRows = new StringBuilder("");
                    ArrayList<Bill> billResults = billDAO.getAllBills();
            		if (fstayid){
                    	billResults = FilterUtil.filter(billResults, b -> b.getStayID() == (Integer.parseInt(stayid.toString())));
                    }
            		if (fssn){
                    	billResults = FilterUtil.filter(billResults, b -> b.getPatientSSN().equals(ssn.toString()));
                    }
                    if (fname){
                    	ArrayList<Patient> allPatients = patientDAO.getAllPatients();
                    	allPatients = FilterUtil.filter(allPatients, p -> p.getName().matches(".*" + name.toString() + ".*"));
                    	ArrayList<String> patientSSNs = new ArrayList<>();
                    	allPatients.forEach((p) -> {
                    		patientSSNs.add(p.getSsn());
                    	});
                    	billResults = FilterUtil.filter(billResults, b -> patientSSNs.contains(b.getPatientSSN()));
                    }
            		if (fminTot){
                    	billResults = FilterUtil.filter(billResults, b -> b.getTotalDue() >= Double.parseDouble(minTot.toString()));
                    }
            		if (fmaxTot){
                    	billResults = FilterUtil.filter(billResults, b -> b.getTotalDue() <= Double.parseDouble(maxTot.toString()));
                    }
            		
            		billResults.forEach((b) -> {
                    	Patient patientB = patientDAO.getPatient(b.getPatientSSN());
                    	Stay stayB = stayDAO.getStay(b.getStayID());
                    	allRows.append("<tr>" +
                    			"<td>"+patientB.getName()+ ", "+ patientB.getDob()+"</td>" +
                                "<td>"+b.getStayID()+"</td>" +
                                "<td>$"+b.getRoomCost()+"</td>" +
                                "<td>"+stayB.getTreatments()+"</td>" +
                                "<td>$"+b.getTreatmentCost()+"</td>" +
                                "<td>$"+b.getSubtotal()+"</td>" +
                                "<td>$"+b.getInsuranceCoverageAmount()+"</td>" +
                                "<td>$"+b.getTaxAmount()+"</td>" +
                                "<td>$"+b.getTotalDue()+"</td>" +
                                "<td class=\"update\"><form action=\"billform.jsp\" method=\"post\"><button class=\"update-button\" type=\"submit\" value=\""+b.getStayID()+"\" name=\"update\">Update</button></form></td>" +
                                "<td class=\"delete\"><form method=\"post\"><button class=\"delete-button\" type=\"submit\" value=\""+b.getStayID()+"\" name=\"delete\">Delete</button></form></td>" +
                            "</tr>");
                    } );
                    %>
                    <%=allRows %>
                </table>
            </div>
        </main>