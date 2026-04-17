<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="hms.*" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <title>Hospital MS- Patient Form</title>
        <meta charset="UTF-8">
        <link rel="stylesheet" href="styles.css">
    </head>
    <!--Functions: manually edit bill-->
    <body>
        <header>
            <h1>Enter Bill Information</h1>
            <button class="directory-button" onclick="location.href='bills.html';">Back to Billing</button>
        </header>
        <main>
        <%
        String update = request.getParameter("update");
        
        BillImpl billDAO = new BillImpl();
    	PatientImpl patientDAO = new PatientImpl();
        Bill updateB = billDAO.getBillByStayID(Integer.parseInt(update));
        
        int stayid = updateB.getStayID();
        String ssn = updateB.getPatientSSN();
        
        Patient thisPatient = patientDAO.getPatient(ssn);
    	String insuranceid = thisPatient.getInsID();
        
        double rrate = updateB.getRoomCost();
        double treatCost = updateB.getTreatmentCost();
        double subtotal = updateB.getSubtotal();
        double insCoverage = updateB.getInsuranceCoverageAmount();
        double tax = updateB.getTaxAmount();
        double total = updateB.getTotalDue();
        %>
            <div id="edit-form">
                <form class="edit" method="post" action="bills.jsp">
                <div class="edit-field">
                        <label for="edit">Editing Bill:</label><br>
                        <select id="edit" name="edit">
                            <option value="edit" selected></option>
                        </select>
                    </div>
                    <div class="edit-field">
                        <label for="ssn">Patient SSN:</label><br>
                        <input type="password" id="ssn" name="ssn" value="<%=ssn %>" required>
                    </div>
                    <div class="edit-field">
                        <label for="stayid">Stay ID:</label><br>
                        <input type="text" id="stayid" name="stayid" value="<%=stayid %>" placeholder="e.g. 2" required>
                    </div>
                    <div class="edit-field">
                        <label for="insuranceid">Insurance ID/Member Number:</label><br>
                        <input type="text" id="insuranceid" name="insuranceid" value="<%=insuranceid %>" placeholder="e.g. 3PJ3I84928F">
                    </div> 
                    <div class="edit-field">
                        <label for="rrate">Room Total Cost ($):</label><br>
                        <input type="number" id="rrate" name="rrate" min="0" max="2000" value="<%=rrate %>" step="0.01">
                    </div>
                    <div class="edit-field">
                        <label for="treatCost">Treatment Cost ($):</label><br>
                        <input type="number" id="treatCost" name="treatCost" min="0" max="20000" value="<%=treatCost %>" step="0.01">
                    </div>
                    <div class="edit-field">
                        <label for="subtotal">Subtotal ($):</label><br>
                        <input type="number" id="subtotal" name="subtotal" min="0" max="10000000" value="<%=subtotal %>" step="0.01" required>
                    </div>
                    <div class="edit-field">
                        <label for="insCoverage">Insurance Coverage Amount ($):</label><br>
                        <input type="number" id="insCoverage" name="insCoverage" min="0" max="10000000" value="<%=insCoverage %>" step="0.01" required>
                    </div>
                    <div class="edit-field">
                        <label for="tax">Tax Amount ($):</label><br>
                        <input type="number" id="tax" name="tax" min="0" max="10000000" value="<%=tax %>" step="0.01" required>
                    </div>    
                    <div class="edit-field">
                        <label for="total">Total ($):</label><br>
                        <input type="number" id="total" name="total" min="0" max="10000000" value="<%=total %>" step="0.01" required>
                    </div>
                    <input type="submit" value="Submit">
                    <input type="reset" value="Clear">
                </form>
            </div>
        </main>
    </body>
</html>