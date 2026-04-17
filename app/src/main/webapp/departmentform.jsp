<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="hms.*" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <title>Hospital MS- Department Form</title>
        <meta charset="UTF-8">
        <link rel="stylesheet" href="styles.css">
    </head>
    <!--Functions: add department, edit dept info-->
    <body>
        <header>
            <h1>Enter Department Information</h1>
            <button class="directory-button" onclick="location.href='departments.jsp';">Back to Departments Directory</button>
        </header>
        <main>
        <%
        String update = request.getParameter("update");
        String yesUpdate = "";
        String noUpdate = "";
        
        int deptid = 0;
        String name = "";
        String building = "";
        String floorno = "";
        
        if (update == null){
        	noUpdate = " selected";
        } else {
        	yesUpdate = " selected";
        	
        	DepartmentImpl deptDAO = new DepartmentImpl();
            Department updateD = deptDAO.getDepartment(Integer.parseInt(update));
            
            deptid = updateD.getDeptID();
            name = updateD.getDeptName();
            building = updateD.getBuilding();
            floorno = updateD.getFloorno();
            
        }
        %>
            <div id="edit-form">
                <form class="edit" method="post" action="departments.jsp">
                    <div class="edit-field">
                        <label for="new">Is this a new department?:</label><br>
                        <select id="new" name="new">
                            <option value="new"<%=noUpdate %>>Yes</option>
                            <option value="<%=deptid %>"<%=yesUpdate %>>No</option>
                        </select>
                    </div>
                    <div class="edit-field">
                        <label for="name">Department Name:</label><br>
                        <input type="text" id="name" name="name" name="name" value="<%=name %>" placeholder="e.g. Primary Care" required>
                    </div>
                    <div class="edit-field">
                        <label for="building">Building:</label><br>
                        <input type="text" id="building" name="building" value="<%=building %>" placeholder="e.g. Main Building" required>
                    </div>
                    <div class="edit-field">
                        <label for="floors">Floors (comma-separated list):</label><br>
                        <input type="text" id="floors" name="floors" value="<%=floorno %>" placeholder="e.g. 1,2,3" required>
                    </div>
                    <input type="submit" value="Submit">
                    <input type="reset" value="Clear">
                </form>
            </div>
        </main>
    </body>
</html>