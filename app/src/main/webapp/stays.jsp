<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="hms.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.time.LocalDate"%>
<%@ page import="java.time.temporal.ChronoUnit" %>

<%
String isNew = request.getParameter("new");
StayImpl stayDAO= new StayImpl();
BillImpl billDAO = new BillImpl();
RoomImpl roomDAO = new RoomImpl();
DepartmentImpl deptDAO = new DepartmentImpl();
StaffImpl staffDAO = new StaffImpl();
PatientImpl patientDAO = new PatientImpl();

boolean fstayid = false;
boolean fssn = false;
boolean fname = false;
boolean fstart = false;
boolean fend = false;
boolean fprovider = false;
boolean fcondition = false;
boolean fdeptid = false;
boolean froomid = false;
boolean fminLen = false;
boolean fmaxLen = false;

StringBuilder roomid = new StringBuilder("");
StringBuilder stayid = new StringBuilder("");
StringBuilder ssn = new StringBuilder("");
StringBuilder name = new StringBuilder("");
StringBuilder start = new StringBuilder("");
StringBuilder end = new StringBuilder("");
StringBuilder deptid = new StringBuilder("");
StringBuilder provider = new StringBuilder("");
StringBuilder condition = new StringBuilder("");
StringBuilder minLen = new StringBuilder("");
StringBuilder maxLen = new StringBuilder("");

if (isNew != null){
	name.append(request.getParameter("name"));
	String dob = request.getParameter("dob");
	ArrayList<Patient> allPatients = patientDAO.getAllPatients();
	allPatients = FilterUtil.filter(allPatients, p -> p.getName().matches(".*" + name.toString() + ".*"));
	allPatients = FilterUtil.filter(allPatients, p -> p.getDob().equals(dob.toString()));
	ssn.append(allPatients.get(0).getSsn());
	
	start.append(request.getParameter("startDate"));
	roomid.append(request.getParameter("roomid"));
	provider.append(request.getParameter("provider"));
	String conditions = request.getParameter("conditions");
	int roomidint = Integer.parseInt(roomid.toString());
	if (request.getParameter("auto") != null){
		AutoRoomAssign autoAssign = new AutoRoomAssign(ssn.toString(), Integer.parseInt(provider.toString()), conditions);
		roomidint = autoAssign.chooseRoom().getRoomID();
		System.out.println(roomidint);
	}
	
	if (isNew.equals("new")){
		Stay thisStay = new Stay(ssn.toString(), start.toString(), start.toString(), 0, roomidint, Integer.parseInt(provider.toString()), conditions, "");
		stayDAO.addStay(thisStay);
		roomDAO.updateRoomStatus(roomidint, "Occupied");
	} else {
		stayid.append(isNew);
		Stay oldStay = stayDAO.getStay(Integer.parseInt(stayid.toString()));
		Stay thisStay = new Stay(Integer.parseInt(stayid.toString()), ssn.toString(), start.toString(), oldStay.getEndDate(), oldStay.getLength(), roomidint, Integer.parseInt(provider.toString()), conditions, oldStay.getTreatments());
		stayDAO.updateStay(thisStay);
	} 
} else {
	String toDelete = request.getParameter("delete");
	if (toDelete != null){
		stayDAO.deleteStay(Integer.parseInt(toDelete));
	}
	String toEnd = request.getParameter("update");
	if (toEnd != null){
		Stay endingStay = stayDAO.getStay(Integer.parseInt(toEnd));
		LocalDate startDate = LocalDate.parse(endingStay.getStartDate());
        long length = ChronoUnit.DAYS.between(startDate, LocalDate.now());

		endingStay.setEndDate(LocalDate.now().toString());
		endingStay.setLength((int)length);
		
		System.out.print("Ending");
		stayDAO.updateStay(endingStay);
		roomDAO.updateRoomStatus(endingStay.getRoomUsed(), "Available");
	}
	stayid.append(request.getParameter("stayid"));
	ssn.append(request.getParameter("ssn"));
	name.append(request.getParameter("name"));
	start.append(request.getParameter("start"));
	end.append(request.getParameter("end"));
	provider.append(request.getParameter("provider"));
	roomid.append(request.getParameter("roomid"));
	condition.append(request.getParameter("condition"));
	minLen.append(request.getParameter("minLen"));
	maxLen.append(request.getParameter("maxLen"));
	deptid.append(request.getParameter("deptid"));
	
	fstayid = !(stayid == null || stayid.toString().equals("") || stayid.toString().equals("null"));
	fssn = !(ssn == null || ssn.toString().equals("") || ssn.toString().equals("null"));
	fname = !(name == null || name.toString().equals("") || name.toString().equals("null"));
	fstart = !(start == null || start.toString().equals("") || start.toString().equals("null"));
	fend = !(end == null || end.toString().equals("") || end.toString().equals("null"));
	fprovider = !(provider == null || provider.toString().equals("") || provider.toString().equals("null"));
	froomid = !(roomid == null || roomid.toString().equals("") || roomid.toString().equals("null"));
	fcondition = !(condition == null || condition.toString().equals("") || condition.toString().equals("null"));
	fminLen = !(minLen == null || minLen.toString().equals("") || minLen.toString().equals("null"));
	fmaxLen = !(maxLen == null || maxLen.toString().equals("") || maxLen.toString().equals("null"));
	fdeptid = !(deptid == null || deptid.toString().equals("") || deptid.toString().equals("null"));
}
%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <title>Hospital MS- Stays</title>
        <meta charset="UTF-8">
        <link rel="stylesheet" href="styles.css">
    </head>
    <!--Functions: end stay, search current/past stays (w filters)-->
    <body>
        <header>
            <h1>Stay Directory</h1>
            <button class="directory-button" onclick="location.href='index.html';">Back to Home</button>
        </header>
        <main>
        <p>Total Stay Records in System: <%=stayDAO.getCountStays() %></p>
            <!--for beginning stays-->
            <button class="add-button" onclick="location.href='stayform.jsp';">Begin Stay</button>
            <div id="search-form">
                <form class="search-filter" method="post">
                    <p>Search: </p>
                    <div class="search-field">
                        <label for="stayid">Stay ID:</label><br>
                        <input type="text" id="stayid" name="stayid" placeholder="e.g. 2">
                    </div>
                    <div class="search-field">
                        <label for="ssn">Patient SSN:</label><br>
                        <input type="password" id="ssn" name="ssn">
                    </div>
                    <div class="search-field">
                        <label for="name">Patient Name:</label><br>
                        <input type="text" id="name" name="name" placeholder="e.g. John, Doe, John Doe">
                    </div>
                    <div class="search-field">
                        <label for="start">Start Date:</label><br>
                        <input type="date" id="start" name="start">
                    </div>
                    <div class="search-field">
                        <label for="end">End Date:</label><br>
                        <input type="date" id="end" name="end">
                    </div>
                    <div class="search-field">
                        <label for="provider">Care Provider ID:</label><br>
                        <input type="text" id="provider" name="provider" placeholder="e.g. John, Doe, John Doe">
                    </div>
                    <div class="search-field">
                        <label for="roomid">Room ID:</label><br>
                        <input type="text" id="roomid" name="roomid" placeholder="e.g. 2">
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
                        <label for="condition">Condition:</label><br>
                        <input type="text" id="condition" name="condition" placeholder="e.g. Fever">
                    </div>  
                    <div class="filter-field">
                        <label for="minLen">Minimum Length of Stay:</label><br>
                        <input type="number" id="minLen" name="minLen" min="0" max="100">
                    </div>
                    <div class="filter-field">
                        <label for="maxLen">Maximum Length of Stay:</label><br>
                        <input type="number" id="maxLen" name="maxLen" min="0" max="100">
                    </div>
                    <div class="filter-field">
                        <label for="deptid">Department ID:</label><br>
                        <input type="text" id="deptid" name="deptid" placeholder="e.g. Primary Care">
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
                        <th>Stay ID</th>
                        <th>Patient Name, DOB</th>
                        <th>Room ID</th> 
                        <th>Main Care Provider</th>
                        <th>Start Date</th>
                        <th>End Date (Same start and end indicates ongoing)</th>
                        <th>Length</th>
                        <th class="bill">View Bill</th> <!--for bill button-->
                        <th class="update">Update</th> <!--for update button-->
                        <th class="update">End Stay</th> <!--for end button-->
                        <th class="delete">Delete Record</th> <!--for delete button-->
                    </tr>
                    <!--add rows depending on query results-->
                    <%
                    StringBuilder allRows = new StringBuilder("");
                    ArrayList<Stay> stayResults = stayDAO.getAllStays();
            		if (fstayid){
                    	stayResults = FilterUtil.filter(stayResults, s -> s.getStayID() == (Integer.parseInt(stayid.toString())));
                    }
            		if (fssn){
                    	stayResults = FilterUtil.filter(stayResults, s -> s.getPatientSSN().equals(ssn.toString()));
                    }
                    if (fname){
                    	ArrayList<Patient> allPatients = patientDAO.getAllPatients();
                    	allPatients = FilterUtil.filter(allPatients, p -> p.getName().matches(".*" + name.toString() + ".*"));
                    	ArrayList<String> patientSSNs = new ArrayList<>();
                    	allPatients.forEach((p) -> {
                    		patientSSNs.add(p.getSsn());
                    	});
                    	stayResults = FilterUtil.filter(stayResults, s -> patientSSNs.contains(s.getPatientSSN()));
                    }
            		if (fstart){
                    	stayResults = FilterUtil.filter(stayResults, s -> s.getStartDate().equals(start.toString()));
                    }
            		if (fend){
                    	stayResults = FilterUtil.filter(stayResults, s -> s.getEndDate().equals(end.toString()));
                    }
            		if (fprovider){
                    	stayResults = FilterUtil.filter(stayResults, s -> s.getCareProvider() == (Integer.parseInt(provider.toString())));
                    }
            		if (froomid){
                    	stayResults = FilterUtil.filter(stayResults, s -> s.getRoomUsed() == (Integer.parseInt(deptid.toString())));
                    }
            		if (fcondition){
                    	stayResults = FilterUtil.filter(stayResults, s -> s.getConditions().matches(".*" + condition.toString() + ".*"));
                    }
            		if (fminLen){
                    	stayResults = FilterUtil.filter(stayResults, s -> s.getLength() >= Integer.parseInt(minLen.toString()));
                    }
            		if (fmaxLen){
                    	stayResults = FilterUtil.filter(stayResults, s -> s.getLength() <= Integer.parseInt(maxLen.toString()));
                    }
            		if (fdeptid){
            			ArrayList<Room> allRooms = roomDAO.getAllRooms();
                    	allRooms = FilterUtil.filter(allRooms, r -> r.getDeptID() == Integer.parseInt(deptid.toString()));
                    	ArrayList<Integer> roomids = new ArrayList<>();
                    	allRooms.forEach((r) -> {
                    		roomids.add(r.getRoomID());
                    	});
                    	stayResults = FilterUtil.filter(stayResults, s -> roomids.contains(s.getRoomUsed()));
                    }
            		
            		stayResults.forEach((s) -> {
                    	Patient patientS = patientDAO.getPatient(s.getPatientSSN());
                    	allRows.append("<tr>" +
                    			"<td>"+s.getStayID()+"</td>" +
                                "<td>"+patientS.getName()+ ", "+ patientS.getDob()+"</td>" +
                                "<td>"+s.getRoomUsed()+"</td>" +
                                "<td>"+s.getCareProvider()+"</td>" +
                                "<td>"+s.getStartDate()+"</td>" +
                                "<td>"+s.getEndDate()+"</td>" +
                                "<td>"+s.getLength()+"</td>" +
                                "<td class=\"bill\"><form action=\"bills.jsp\" method=\"post\"><button class=\"sbill-button\" type=\"submit\" value=\""+s.getStayID()+"\" name=\"stayid\">View Bill</button></form></td>" +
                                "<td class=\"update\"><form action=\"stayform.jsp\" method=\"post\"><button class=\"update-button\" type=\"submit\" value=\""+s.getStayID()+"\" name=\"update\">Update</button></form></td>" +
                                "<td class=\"update\"><form method=\"post\"><button class=\"update-button\" type=\"submit\" value=\""+s.getStayID()+"\" name=\"update\">End Stay</button></form></td>" +
                                "<td class=\"delete\"><form method=\"post\"><button class=\"delete-button\" type=\"submit\" value=\""+s.getStayID()+"\" name=\"delete\">Delete</button></form></td>" +
                            "</tr>");
                    } );
                    %>
                    <%=allRows %>
                </table>
            </div>
        </main>
    </body>
</html>