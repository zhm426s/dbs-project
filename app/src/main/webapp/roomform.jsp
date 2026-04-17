<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="hms.*" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <title>Hospital MS- Room Form</title>
        <meta charset="UTF-8">
        <link rel="stylesheet" href="styles.css">
    </head>
    <!--Functions: add individual room, edit room-->
    <body>
        <header>
            <h1>Enter Room Information</h1>
            <button class="directory-button" onclick="location.href='rooms.jsp';">Back to Room Directory</button>
        </header>
        <main>
        <%
        String update = request.getParameter("update");
        String yesUpdate = "";
        String noUpdate = "";
        
        int roomid = 0;
        int rnum = 0;
        int fnum = 0;
        double rrate = 200.0;
        String building = "";
        int deptid = 0;
        
        if (update == null){
        	noUpdate = " selected";
        } else {
        	yesUpdate = " selected";
        	
        	RoomImpl roomDAO = new RoomImpl();
            Room updateR = roomDAO.getRoom(Integer.parseInt(update.substring(1)));
            
            roomid = updateR.getRoomID();
            rnum = updateR.getRoomNo();
            fnum = updateR.getFloorNo();
            building = updateR.getBuilding();
            rrate = updateR.getDailyRate();
            deptid = updateR.getDeptID();
            
        }
        %>
            <div id="edit-form">
                <form class="edit" method="post" action="rooms.jsp">
                    <div class="edit-field">
                        <label for="new">Is this a new room?:</label><br>
                        <select id="new" name="new">
                            <option value="new"<%=noUpdate %>>Yes</option>
                            <option value="r<%=roomid %>"<%=yesUpdate %>>No</option>
                        </select>
                    </div>
                    <div class="edit-field">
                        <label for="rnum">Room Number:</label><br>
                        <input type="number" id="rnum" name="rnum" min="0" max="30" value="<%=rnum %>" required>
                    </div>
                    <div class="edit-field">
                        <label for="fnum">Floor Number:</label><br>
                        <input type="number" id="fnum" name="fnum" min="0" max="30" value="<%=fnum %>" required>
                    </div>
                    <div class="edit-field">
                        <label for="deptid">Department (ID, existing):</label><br>
                        <input type="text" id="deptid" name="deptid" value="<%=deptid %>" placeholder="e.g. 2" required>
                    </div>
                    <div class="edit-field">
                        <label for="building">Building:</label><br>
                        <input type="text" id="building" name="building" value="<%=building %>" placeholder="e.g. Main Building">
                    </div>
                    <div class="edit-field">
                        <label for="rrate">Daily Rate ($):</label><br>
                        <input type="number" id="rrate" name="rrate" min="0" max="2000"  value="<%=rrate %>" step="0.01" required>
                    </div>
                    <input type="submit" value="Submit">
                    <input type="reset" value="Clear">
                </form>
            </div>
        </main>
    </body>
</html>