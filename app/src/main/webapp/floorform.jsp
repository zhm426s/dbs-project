<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="hms.*" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <title>Hospital MS- Floor Form</title>
        <meta charset="UTF-8">
        <link rel="stylesheet" href="styles.css">
    </head>
    <!--Functions: add floor (w/ all rooms), edit floor-->
    <body>
        <header>
            <h1>Enter Floor Information</h1>
            <button class="directory-button" onclick="location.href='rooms.jsp';">Back to Room Directory</button>
        </header>
        <main>
        <%
        String update = request.getParameter("update");
        String yesUpdate = "";
        String noUpdate = "";
        
        int frooms = 30;
        int minRooms = 1;
        int fnum = 0;
        double rrate = 200.0;
        String building = "";
        int deptid = 0;
        
        if (update == null){
        	noUpdate = " selected";
        } else {
        	yesUpdate = " selected";
        	
        	RoomImpl roomDAO = new RoomImpl();
        	ArrayList<Room> updateF = FilterUtil.filter(roomDAO.getAllRooms(), r -> r.getFloorNo() == Integer.parseInt(update));
            
            fnum = Integer.parseInt(update);
            building = updateF.get(0).getBuilding();
            rrate = updateF.get(0).getDailyRate();
            deptid = updateF.get(0).getDeptID();
            frooms = updateF.size();
            minRooms = frooms;
            
        }
        %>
            <div id="edit-form">
                <form class="edit" method="post" action="rooms.jsp">
                    <div class="edit-field">
                        <label for="new">Is this a new floor?:</label><br>
                        <select id="new" name="new">
                            <option value="newf"<%=noUpdate %>>Yes</option>
                            <option value="existingf"<%=yesUpdate %>>No</option>
                        </select>
                    </div>
                    <div class="edit-field">
                        <label for="fnum">Floor Number:</label><br>
                        <input type="number" id="fnum" name="fnum" min="0" max="30" value="<%=fnum %>" required>
                    </div>
                    <div class="edit-field">
                        <label for="deptid">Department (ID, enter existing):</label><br>
                        <input type="text" id="deptid" name="deptid" value="<%=deptid %>" placeholder="e.g. 2" required>
                    </div>
                    <div class="edit-field">
                        <label for="building">Building:</label><br>
                        <input type="text" id="building" name="building" value="<%=building %>" placeholder="e.g. Main Building">
                    </div>
                    <div class="edit-field"> <!--will auto-create this number of rooms with number 100 * fnum + rnum, assigned to this floor and same department-->
                        <label for="frooms">Number of Rooms:</label><br>
                        <input type="number" id="frooms" name="frooms" min="<%=minRooms %>" max="99" value="<%=frooms %>" required>
                    </div>
                    <div class="edit-field">
                        <label for="rrate">Daily Rate of Rooms ($):</label><br>
                        <input type="number" id="rrate" name="rrate" min="0" max="2000" value="<%=rrate %>" step="0.01" required>
                    </div>
                    <input type="submit" value="Submit">
                    <input type="reset" value="Clear">
                </form>
            </div>
        </main>
    </body>
</html>