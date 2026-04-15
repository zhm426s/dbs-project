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
    <!--Functions: add patient, edit patient info, set insurance, change insurance, remove insurance-->
    <body>
        <header>
            <h1>Enter Patient Information</h1>
            <button class="directory-button" onclick="location.href='patients.jsp';">Back to Patients Directory</button>
        </header>
        <main>
        <%
        String update = request.getParameter("update");
        String yesUpdate = "";
        String noUpdate = "";
        
        String ssn = "";
        String name = "";
        String dob = "";
        char sex = ' ';
        String email = "";
        String phone = "";
        String insID = "";
        String insurer = "";
        String insPlan = "";
        double insPercent = 0.05;
        
        String male = "";
        String female = "";
        String intersex = "";
        
        if (update == null){
        	noUpdate = " selected";
        } else {
        	yesUpdate = " selected";
        	
        	PatientImpl patientDAO = new PatientImpl();
            Patient updateP = patientDAO.getPatient(update);
            InsurancePolicyImpl insPolDAO = new InsurancePolicyImpl();
            
            ssn = updateP.getSsn();
            name = updateP.getName();
            dob = updateP.getDob();
            sex = updateP.getBioSex();
            email = updateP.getEmail();
            phone = updateP.getPhone();
            insID = updateP.getInsID();
            InsurancePolicy insP = insPolDAO.getInsurancePolicy(insID);
            insurer = insP.getInsProvider();
            insPlan = insP.getPlanType();
            insPercent = insP.getInsPercent();
            
            if (sex == ' ' || sex == 'M'){
            	male = " selected";
            } else if (sex == 'F'){
            	female = " selected";
            } else {
            	intersex = " selected";
            }
        }
        %>
            <div id="edit-form">
                <form class="edit-form" method="post" action="patients.jsp">
                    <div class="edit-field">
                        <label for="new">Is this a new patient?:</label><br>
                        <select id="new" name="new">
                            <option value="new"<%=noUpdate %>>Yes</option>
                            <option value="existing"<%=yesUpdate %>>No</option>
                        </select>
                    </div>
                    <div class="edit-field">
                        <label for="ssn">SSN:</label><br>
                        <input type="password" id="ssn" name="ssn" value="<%=ssn %>" required>
                    </div>
                    <div class="edit-field">
                        <label for="name">Name:</label><br>
                        <input type="text" id="name" name="name" value="<%=name %>"  placeholder="e.g. John, Doe, John Doe" required>
                    </div>
                    <div class="edit-field">
                        <label for="dob">Date of Birth (If unknown, enter estimated):</label><br>
                        <input type="date" id="dob" name="dob" value="<%=dob %>" required>
                    </div>
                    <div class="edit-field">
                        <label for="sex">Biological Sex:</label><br>
                        <select id="sex" name="sex">
                            <option value="m"<%=male %>>Male</option>
                            <option value="f"<%=female %>>Female</option>
                            <option value="x"<%=intersex %>>Intersex</option>
                        </select>
                    </div>
                    <div class="edit-field">
                        <label for="email">Email Address:</label><br>
                        <input type="email" id="email" name="email" value="<%=email %>" placeholder=" e.g.johndoe@example.org">
                    </div>
                    <div class="edit-field">
                        <label for="phone">Phone #:</label><br>
                        <input type="text" id="phone" name="phone" value="<%=phone %>" placeholder="e.g. 555-555-5555">
                    </div>
                    <div class="edit-field">
                        <label for="insuranceid">Insurance ID/Member Number:</label><br>
                        <input type="text" id="insuranceid" name="insuranceid" value="<%=insID %>" placeholder="e.g. 3PJ3I84928F">
                    </div> 
                    <div class="edit-field">
                        <label for="insurer">Insurance Provider:</label><br>
                        <input type="text" id="insurer" name="insurer" value="<%=insurer %>" placeholder="e.g. Aetna">
                    </div>   
                    <div class="edit-field">
                        <label for="insurancePlan">Insurance Plan Name:</label><br>
                        <input type="text" id="insurancePlan" name="insurancePlan" value="<%=insPlan %>" placeholder="e.g. Premium Benefits Plan">
                    </div>      
                    <div class="edit-field">
                        <label for="insurancePercent">Insurance Coverage Percent:</label><br>
                        <input type="number" id="insurancePercent" name="insurancePercent" min="0.05" max="100.0" value="<%=insPercent %>" step="0.01">
                    </div>
                    <input type="submit" value="Submit">
                    <input type="reset" value="Clear">
                </form>
            </div>
        </main>
    </body>
</html>