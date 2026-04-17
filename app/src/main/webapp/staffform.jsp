<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="hms.*" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <title>Hospital MS- Staff Form</title>
        <meta charset="UTF-8">
        <link rel="stylesheet" href="styles.css">
    </head>
    <!--Functions: add staff, edit staff-->
    <body>
        <header>
            <h1>Enter Staff Information</h1>
            <button class="directory-button" onclick="location.href='staff.jsp';">Back to Staff Directory</button>
        </header>
        <main>
        <%
        String update = request.getParameter("update");
        String yesUpdate = "";
        String noUpdate = "";
        
        int empid = 0;
        String name = "";
        String address = "";
        String title = "";
        String special = "";
        int deptid = 0;
        
        if (update == null){
        	noUpdate = " selected";
        } else {
        	yesUpdate = " selected";
        	
        	StaffImpl staffDAO = new StaffImpl();
            Staff updateS = staffDAO.getStaff(Integer.parseInt(update));
            
            empid = updateS.getEmpID();
            name = updateS.getName();
            address = updateS.getAddress();
            title = updateS.getTitle();
            special = updateS.getSpecialization();
            deptid = updateS.getDeptID();
            
        }
        %>
            <div id="edit-form">
                <form class="edit" method="post" action="staff.jsp">
                    <div class="edit-field">
                        <label for="new">Is this a new staff member?:</label><br>
                        <select id="new" name="new">
                            <option value="new"<%=noUpdate %>>Yes</option>
                            <option value="<%=empid %>"<%=yesUpdate %>>No</option>
                        </select>
                    </div>
                    <div class="edit-field">
                        <label for="name">Name:</label><br>
                        <input type="text" id="name" name="name" value="<%=name %>" placeholder="e.g. John, Doe, John Doe" required>
                    </div>
                    <div class="edit-field">
                        <label for="address">Address:</label><br>
                        <input type="text" id="address" name="address" value="<%=address %>" placeholder="e.g. 123 Main St" required>
                    </div>
                    <div class="edit-field">
                        <label for="title">Title:</label><br>
                        <input type="text" id="title" name="title" value="<%=title %>" placeholder="e.g. Director of Medicine" required>
                    </div>
                    <div class="edit-field">
                        <label for="special">Specialization:</label><br>
                        <input type="text" id="special" name="special" value="<%=special %>" placeholder="e.g. Paediatrics" required>
                    </div>
                    <div class="edit-field">
                        <label for="deptid">Department ID (existing):</label><br>
                        <input type="text" id="deptid" name="deptid" value="<%=deptid %>" placeholder="e.g. 2" required>
                    </div>
                    <input type="submit" value="Submit">
                    <input type="reset" value="Clear">
                </form>
            </div>
        </main>
    </body>
</html>