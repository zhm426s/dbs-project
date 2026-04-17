<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="hms.*" %>
<%@ page import="java.util.*" %>

<%
String isNew = request.getParameter("new");
DepartmentImpl deptDAO = new DepartmentImpl();

boolean fdeptid = false;
boolean fname = false;
boolean fbuilding = false;


StringBuilder deptid = new StringBuilder("");
StringBuilder name = new StringBuilder("");
StringBuilder building = new StringBuilder("");

if (isNew != null){
	name.append(request.getParameter("name"));
	building.append(request.getParameter("building"));
	String floorno = request.getParameter("floors");
	Department thisDept = new Department(0, name.toString(), building.toString(), floorno);
	if (isNew.equals("new")){
		deptDAO.addDepartment(thisDept);
	} else {
		deptid.append(isNew);
		thisDept.setDeptID(Integer.parseInt(deptid.toString()));
		deptDAO.updateDepartment(thisDept);
	}
} else {
	String toDelete = request.getParameter("delete");
	if (toDelete != null){
		deptDAO.deleteDepartment(Integer.parseInt(toDelete));
	}
	name.append(request.getParameter("name"));
	building.append(request.getParameter("building"));
	deptid.append(request.getParameter("deptid"));
	
	fbuilding = !(building == null || building.toString().equals("") || building.toString().equals("null"));
	fname = !(name == null || name.toString().equals("") || name.toString().equals("null"));
	fdeptid = !(deptid == null || deptid.toString().equals("") || deptid.toString().equals("null"));
	
}
%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <title>Hospital MS- Departments</title>
        <meta charset="UTF-8">
        <link rel="stylesheet" href="styles.css">
    </head>
    <!--Functions: view departments, remove department-->
    <body>
        <header>
            <h1>Department Directory</h1>
            <button class="directory-button" onclick="location.href='index.html';">Back to Home</button>
        </header>
        <main>
        <p>Total Departments in System: <%=deptDAO.getCountDepartments() %></p>
            <!--for adding a new dept-->
            <button class="add-button" onclick="location.href='departmentform.jsp';">Add Department</button>
            <div id="search-form">
                <form class="search-filter" method="post">
                    <p>Search: </p>
                    <div class="search-field">
                        <label for="deptid">Dept ID:</label><br>
                        <input type="text" id="deptid" name="deptid" placeholder="e.g. 2">
                    </div>
                    <div class="search-field">
                        <label for="name">Dept Name:</label><br>
                        <input type="text" id="name" name="name" placeholder="e.g. Primary Care">
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
                        <label for="building">Building:</label><br>
                        <input type="text" id="building" name="building" placeholder="e.g. Main Building">
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
                        <th>ID</th>
                        <th>Department Name</th>
                        <th>Building</th> 
                        <th>Floors</th>
                        <th class="update">Update</th> <!--for update button-->
                        <th class="delete">Delete</th> <!--for delete button-->
                    </tr>
                    <!--add rows depending on query results-->
                    <%
                    StringBuilder allRows = new StringBuilder("");
                    ArrayList<Department> deptResults = deptDAO.getAllDepartments();
            		if (fdeptid){
                    	deptResults = FilterUtil.filter(deptResults, d -> d.getDeptID() == (Integer.parseInt(deptid.toString())));
                    }
            		if (fname){
                    	deptResults = FilterUtil.filter(deptResults, d -> d.getDeptName().matches(".*" + name.toString() + ".*"));
                    }
            		if (fbuilding){
                    	deptResults = FilterUtil.filter(deptResults, d -> d.getBuilding().matches(".*" + building.toString() + ".*"));
                    }
            		
            		deptResults.forEach((d) -> {
                    	allRows.append("<tr>" +
                                "<td>"+d.getDeptID()+"</td>" +
                                "<td>"+d.getDeptName()+"</td>" +
                                "<td>"+d.getBuilding()+"</td>" +
                                "<td>"+d.getFloorno()+"</td>" +
                                "<td class=\"update\"><form action=\"departmentform.jsp\" method=\"post\"><button class=\"update-button\" type=\"submit\" value=\""+d.getDeptID()+"\" name=\"update\">Update</button></form></td>" +
                                "<td class=\"delete\"><form method=\"post\"><button class=\"delete-button\" type=\"submit\" value=\""+d.getDeptID()+"\" name=\"delete\">Delete</button></form></td>" +
                            "</tr>");
                    } );
                    %>
                    <%=allRows %>
                </table>
            </div>
        </main>
    </body>
</html>