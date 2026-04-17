<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="hms.*" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <title>Hospital MS- Begin Stay</title>
        <meta charset="UTF-8">
        <link rel="stylesheet" href="styles.css">
    </head>
    <!--Functions: begin stay (sp patient or make new), (assign/unassign, auto assign rooms: part of beginning stay)-->
    <body>
        <header>
            <h1>Enter New Stay Information</h1>
            <button class="directory-button" onclick="location.href='stays.jsp';">Back to Stays Directory</button>
            <button class="directory-button" onclick="location.href='patients.jsp';">Look Up Existing or Add New Patient</button>
        </header>
        <main>
        <%
        String update = request.getParameter("update");
        String yesUpdate = "";
        String noUpdate = "";
        
        int stayid = 0;
        String name = "";
        String dob = "";
        String startDate = "";
        String conditions = "";
        int provider = 0;
        int roomid = 0;
        
        if (update == null){
        	noUpdate = " selected";
        } else {
        	yesUpdate = " selected";
        	
        	StayImpl stayDAO = new StayImpl();
        	PatientImpl patientDAO = new PatientImpl();
            Stay updateS = stayDAO.getStay(Integer.parseInt(update));
            
            stayid = updateS.getStayID();
            
            Patient thisPatient = patientDAO.getPatient(updateS.getPatientSSN());
        	name = thisPatient.getName();
        	dob = thisPatient.getDob();
            
            startDate = updateS.getStartDate();
            conditions = updateS.getConditions();
            provider = updateS.getCareProvider();
            roomid = updateS.getRoomUsed();
            
        }
        %>
            <div id="edit-form">
                <form class="edit" method="post" action="stays.jsp">
                <div class="edit-field">
                        <label for="new">Is this a new stay record?:</label><br>
                        <select id="new" name="new">
                            <option value="new"<%=noUpdate %>>Yes</option>
                            <option value="<%=stayid %>"<%=yesUpdate %>>No</option>
                        </select>
                    </div>
                    <div class="edit-field">
                        <label for="name">Patient Name (Matching Record):</label><br>
                        <input type="text" id="name" name="name" value="<%=name %>" placeholder="e.g. John, Doe, John Doe" required>
                    </div>
                    <div class="edit-field">
                        <label for="dob">Patient Date of Birth (Matching Record):</label><br>
                        <input type="date" id="dob" name="dob" value="<%=dob %>" required>
                    </div>
                    <div class="edit-field">
                        <label for="startDate">Starting Date:</label><br>
                        <input type="date" id="startDate" name="startDate" value="<%=startDate %>" required>
                    </div>
                    <div class="edit-field">
                        <label for="conditions">Conditions (Separate with ",")</label>
                        <input type="text" id="conditions" name="conditions" value="<%=conditions %>" placeholder="e.g Fever">
                    </div>
                    <div class="edit-field">
                        <label for="provider">Care Provider ID:</label><br>
                        <input type="text" id="provider" name="provider" value="<%=provider %>" placeholder="e.g. 2">
                    </div>
                    <p>Enter Room ID or select "Auto-Assign"</p>
                    <div class="edit-field">
                        <label for="roomid">Room ID:</label><br>
                        <input type="text" id="roomid" name="roomid" value="<%=roomid %>" placeholder="e.g. 2">
                    </div>
                    <label for="auto-assign-button">Auto Assign</label><br>
                    <input type="checkbox" id="auto-assign-button" name="auto" value="auto">
                    <input type="submit" value="Submit">
                    <input type="reset" value="Clear">
                </form>
            </div>
        </main>
    </body>
</html>