<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="hms.*" %>
<%@ page import="java.util.*" %>

<%
String isNew = request.getParameter("new");
RoomImpl roomDAO = new RoomImpl();
DepartmentImpl deptDAO = new DepartmentImpl();

boolean froomid = false;
boolean fbuilding = false;
boolean ffloor = false;
boolean froomno = false;
boolean fdeptid = false;
boolean fstatus = false;
boolean fminRate = false;
boolean fmaxRate = false;

StringBuilder roomid = new StringBuilder("");
StringBuilder building = new StringBuilder("");
StringBuilder floor = new StringBuilder("");
StringBuilder roomno = new StringBuilder("");
StringBuilder deptid = new StringBuilder("");
StringBuilder status = new StringBuilder("");
StringBuilder minRate = new StringBuilder("");
StringBuilder maxRate = new StringBuilder("");

if (isNew != null){
	building.append(request.getParameter("building"));
	floor.append(request.getParameter("fnum"));
	deptid.append(request.getParameter("deptid"));
	roomno.append(request.getParameter("rnum"));
	double rate = Double.parseDouble(request.getParameter("rrate"));
	String numRoomStr = request.getParameter("frooms");
	int numRoom = 0;
	if (numRoomStr != null){
		numRoom = Integer.parseInt(numRoomStr);
	}
	if (isNew.equals("newr")){
		Room thisRoom = new Room(0, building.toString(), Integer.parseInt(floor.toString()), Integer.parseInt(roomno.toString()), "Available", rate, Integer.parseInt(deptid.toString()));
		roomDAO.addRoom(thisRoom);
	} else if (isNew.equals("newf")) {
		int i;
		for (i = 0; i < numRoom; i++){
			Room thisRoom = new Room(0, building.toString(), Integer.parseInt(floor.toString()), i, "Available", rate, Integer.parseInt(deptid.toString()));
			roomDAO.addRoom(thisRoom);
		}
	} else if (isNew.charAt(0) == 'r'){
		roomid.append(isNew.substring(1));
		Room oldRoom = roomDAO.getRoom(Integer.parseInt(roomid.toString()));
		Room thisRoom = new Room(oldRoom.getRoomID(), building.toString(), Integer.parseInt(floor.toString()), Integer.parseInt(roomno.toString()), oldRoom.getStatus(), rate, Integer.parseInt(deptid.toString()));
		roomDAO.updateRoom(thisRoom);
	} else {
		ArrayList<Room> allRooms = FilterUtil.filter(roomDAO.getAllRooms(), r -> r.getFloorNo() == Integer.parseInt(floor.toString()));
		int newRooms = numRoom - allRooms.size();
		allRooms.forEach((r) -> {
			Room thisRoom = new Room(r.getRoomID(), building.toString(), Integer.parseInt(floor.toString()), r.getRoomNo(), r.getStatus(), rate, Integer.parseInt(deptid.toString()));
			roomDAO.updateRoom(thisRoom);
		});
		int i;
		for (i = allRooms.size(); i < numRoom; i++){
			Room thisRoom = new Room(0, building.toString(), Integer.parseInt(floor.toString()), i, "Available", rate, Integer.parseInt(deptid.toString()));
			roomDAO.addRoom(thisRoom);
		}
	}
} else {
	String toDelete = request.getParameter("delete");
	if (toDelete != null){
		roomDAO.deleteRoom(Integer.parseInt(toDelete));
	}
	roomid.append(request.getParameter("roomid"));
	building.append(request.getParameter("building"));
	floor.append(request.getParameter("floor"));
	roomno.append(request.getParameter("roomno"));
	deptid.append(request.getParameter("deptid"));
	status.append(request.getParameter("status"));
	minRate.append(request.getParameter("minRate"));
	maxRate.append(request.getParameter("maxRate"));
	
	froomid = !(roomid == null || roomid.toString().equals("") || roomid.toString().equals("null"));
	fbuilding = !(building == null || building.toString().equals("") || building.toString().equals("null"));
	ffloor = !(floor == null || floor.toString().equals("") || floor.toString().equals("null"));
	froomno = !(roomno == null || roomno.toString().equals("") || roomno.toString().equals("null"));
	fdeptid = !(deptid == null || deptid.toString().equals("") || deptid.toString().equals("null"));
	fstatus = !(status == null || status.toString().equals("") || status.toString().equals("null"));
	fminRate = !(minRate == null || minRate.toString().equals("") || minRate.toString().equals("null"));
	fmaxRate = !(maxRate == null || maxRate.toString().equals("") || maxRate.toString().equals("null"));
}
%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <title>Hospital MS- Rooms</title>
        <meta charset="UTF-8">
        <link rel="stylesheet" href="styles.css">
    </head>
    <!--Functions: search rooms, remove room(s)-->
    <body>
        <header>
            <h1>Room Directory</h1>
            <button class="directory-button" onclick="location.href='index.html';">Back to Home</button>
        </header>
        <main>
            <!--for adding a new floor or room-->
            <div id="actions">
                <button class="add-button" onclick="location.href='floorform.jsp';">Add Floor</button>
                <button class="add-button" onclick="location.href='roomform.jsp';">Add Individual Room</button>
            </div>
            <div id="search-form">
                <form class="search-filter" method="post">
                    <p>Search: </p>
                    <div class="search-field">
                        <label for="roomid">Room ID:</label><br>
                        <input type="text" id="roomid" name="roomid">
                    </div>
                    <div class="search-field">
                        <label for="building">Building:</label><br>
                        <input type="text" id="building" name="building" placeholder="e.g. Main Building">
                    </div>
                    <div class="search-field">
                        <label for="floor">Floor Number:</label><br>
                        <input type="text" id="floor" name="floor" placeholder="e.g. 2">
                    </div>
                    <div class="search-field">
                        <label for="roomno">Room Number:</label><br>
                        <input type="text" id="roomno" name="email" placeholder="e.g. 200">
                    </div>
                    <div class="search-field">
                        <label for="deptid">Department ID:</label><br>
                        <input type="text" id="deptid" name="deptid" placeholder="e.g. Primary Care">
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
                        <input type="radio" id="occupied" name="status" value="Occupied">
                        <label for="occupied">Occupied</label><br>
                        <input type="radio" id="vacant" name="status" value="Available">
                        <label for="vacant">Available</label><br>
                        <input type="radio" id="either" name="status" value="">
                        <label for="either">Show All</label>
                    </div>   
                    <div class="filter-field">
                        <label for="minRate">Minimum Daily Rate ($):</label><br>
                        <input type="number" id="minRate" name="minRate" min="0" max="2000"  step="0.01">
                    </div>
                    <div class="filter-field">
                        <label for="maxRate">Maximum Daily Rate ($):</label><br>
                        <input type="number" id="maxRate" name="maxRate" min="0" max="2000"  step="0.01">
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
                        <th>Room ID</th>
                        <th>Room Number</th>
                        <th>Floor</th>
                        <th>Building</th>
                        <th>Status</th>
                        <th>Daily Rate</th>
                        <th>Department</th>
                        <th class="update">Update</th> <!--for update button-->
                        <th class="update">Update Floor</th> <!--for update button-->
                        <th class="delete">Delete</th> <!--for delete button-->
                    </tr>
                    <!--add rows depending on query results-->
                    <%
                    StringBuilder allRows = new StringBuilder("");
                    ArrayList<Room> roomResults = roomDAO.getAllRooms();
            		if (froomid){
                    	roomResults = FilterUtil.filter(roomResults, r -> r.getRoomID() == (Integer.parseInt(roomid.toString())));
                    }
            		if (fbuilding){
                    	roomResults = FilterUtil.filter(roomResults, r -> r.getBuilding().matches(".*" + building.toString() + ".*"));
                    }
            		if (ffloor){
                    	roomResults = FilterUtil.filter(roomResults, r -> r.getRoomID() == (Integer.parseInt(floor.toString())));
                    }
            		if (froomno){
                    	roomResults = FilterUtil.filter(roomResults, r -> r.getRoomNo() == (Integer.parseInt(roomno.toString())));
                    }
            		if (fdeptid){
                    	roomResults = FilterUtil.filter(roomResults, r -> r.getDeptID() == (Integer.parseInt(deptid.toString())));
                    }
            		if (fstatus){
                    	roomResults = FilterUtil.filter(roomResults, r -> r.getStatus().matches(".*" + status.toString() + ".*"));
                    }
            		if (fminRate){
                    	roomResults = FilterUtil.filter(roomResults, r -> r.getDailyRate() >= Double.parseDouble(minRate.toString()));
                    }
            		if (fmaxRate){
                    	roomResults = FilterUtil.filter(roomResults, r -> r.getDailyRate() <= Double.parseDouble(maxRate.toString()));
                    }
            		
            		roomResults.forEach((r) -> {
                    	Department deptR = deptDAO.getDepartment(r.getDeptID());
                    	allRows.append("<tr>" +
                    			"<td>"+r.getRoomID()+"</td>" +
                                "<td>"+r.getRoomNo()+"</td>" +
                                "<td>"+r.getFloorNo()+"</td>" +
                                "<td>"+r.getBuilding()+"</td>" +
                                "<td>"+r.getStatus()+"</td>" +
                                "<td>"+r.getDailyRate()+"</td>" +
                                "<td>"+deptR.getDeptID() + ", "+ deptR.getDeptName()+"</td>" +
                                "<td class=\"update\"><form action=\"roomform.jsp\" method=\"post\"><button class=\"update-button\" type=\"submit\" value=\"r"+r.getRoomID()+"\" name=\"update\">Update</button></form></td>" +
                                "<td class=\"update\"><form action=\"floorform.jsp\" method=\"post\"><button class=\"update-button\" type=\"submit\" value=\""+r.getFloorNo()+"\" name=\"update\">Update Floor</button></form></td>" +
                                "<td class=\"delete\"><form method=\"post\"><button class=\"delete-button\" type=\"submit\" value=\""+r.getRoomID()+"\" name=\"delete\">Delete</button></form></td>" +
                            "</tr>");
                    } );
                    %>
                    <%=allRows %>
                </table>
            </div>
        </main>
    </body>
</html>