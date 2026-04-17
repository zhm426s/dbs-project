<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="hms.*" %>
<%@ page import="java.util.*" %>

<%
String isNew = request.getParameter("new");
StaffImpl staffDAO = new StaffImpl();
DepartmentImpl deptDAO = new DepartmentImpl();

boolean fempid = false;
boolean fname = false;
boolean faddress = false;
boolean ftitle = false;
boolean fdeptid = false;
boolean fspecial = false;

StringBuilder empid = new StringBuilder("");
StringBuilder name = new StringBuilder("");
StringBuilder address = new StringBuilder("");
StringBuilder title = new StringBuilder("");
StringBuilder deptid = new StringBuilder("");
StringBuilder special = new StringBuilder("");

if (isNew != null){
	name.append(request.getParameter("name"));
	address.append(request.getParameter("address"));
	title.append(request.getParameter("title"));
	special.append(request.getParameter("special"));
	deptid.append(request.getParameter("deptid"));
	Staff thisStaff = new Staff(0, name.toString(), address.toString(), title.toString(), special.toString(), Integer.parseInt(deptid.toString()));
	if (isNew.equals("new")){
		staffDAO.addStaff(thisStaff);
	} else {
		empid.append(isNew);
		thisStaff.setEmpID(Integer.parseInt(empid.toString()));
		staffDAO.updateStaff(thisStaff);
	}
} else {
	String toDelete = request.getParameter("delete");
	if (toDelete != null){
		staffDAO.deleteStaff(Integer.parseInt(toDelete));
	}
	empid.append(request.getParameter("empid"));
	name.append(request.getParameter("name"));
	address.append(request.getParameter("address"));
	title.append(request.getParameter("title"));
	special.append(request.getParameter("special"));
	deptid.append(request.getParameter("deptid"));
	
	fempid = !(empid == null || empid.toString().equals("") || empid.toString().equals("null"));
	fname = !(name == null || name.toString().equals("") || name.toString().equals("null"));
	faddress = !(address == null || address.toString().equals("") || address.toString().equals("null"));
	ftitle = !(title == null || title.toString().equals("") || title.toString().equals("null"));
	fspecial = !(special == null || special.toString().equals("") || special.toString().equals("null"));
	fdeptid = !(deptid == null || deptid.toString().equals("") || deptid.toString().equals("null"));
	
}
%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <title>Hospital MS- Staff</title>
        <meta charset="UTF-8">
        <link rel="stylesheet" href="styles.css">
    </head>
    <!--Functions: search staff (w filters), remove staff-->
    <body>
        <header>
            <h1>Staff Directory</h1>
            <button class="directory-button" onclick="location.href='index.html';">Back to Home</button>
        </header>
        <main>
        <p>Total Staff in System: <%=staffDAO.getCountStaff() %></p>
            <!--for adding a new staff member-->
            <button class="add-button" onclick="location.href='staffform.jsp';">Add Staff Member</button>
            <div id="search-form">
                <form class="search-filter" method="post">
                    <p>Search: </p>
                    <div class="search-field">
                        <label for="empid">Employee ID:</label><br>
                        <input type="text" id="empid" name="empid" placeholder="e.g. 2">
                    </div>
                    <div class="search-field">
                        <label for="name">Name:</label><br>
                        <input type="text" id="name" name="name" placeholder="e.g. John, Doe, John Doe">
                    </div>
                    <div class="search-field">
                        <label for="address">Address:</label><br>
                        <input type="text" id="address" name="address" placeholder="e.g. 123 Main St">
                    </div>
                    <div class="search-field">
                        <label for="title">Title:</label><br>
                        <input type="text" id="title" name="title" placeholder="e.g. Director of Medicine">
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
                        <label for="deptid">Department (ID):</label><br>
                        <input type="text" id="deptid" name="deptid" placeholder="e.g. 2">
                    </div>
                    <div class="filter-field">
                        <label for="special">Specialization:</label><br>
                        <input type="text" id="special" name="special" placeholder="e.g. Paediatrics">
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
                        <th>EmpID</th>
                        <th>Name</th>
                        <th>Title</th>
                        <th>Specialization</th>
                        <th>Address</th>
                        <th>Department</th>
                        <th class="update">Update</th> <!--for update button-->
                        <th class="delete">Delete</th> <!--for delete button-->
                    </tr>
                    <!--add rows depending on query results-->
                    <%
                    StringBuilder allRows = new StringBuilder("");
                    ArrayList<Staff> staffResults = staffDAO.getAllStaff();
            		if (fempid){
                    	staffResults = FilterUtil.filter(staffResults, s -> s.getEmpID() == (Integer.parseInt(empid.toString())));
                    }
            		if (fname){
                    	staffResults = FilterUtil.filter(staffResults, s -> s.getName().matches(".*" + name.toString() + ".*"));
                    }
            		if (faddress){
                    	staffResults = FilterUtil.filter(staffResults, s -> s.getAddress().matches(".*" + address.toString() + ".*"));
                    }
            		if (ftitle){
                    	staffResults = FilterUtil.filter(staffResults, s -> s.getTitle().matches(".*" + title.toString() + ".*"));
                    }
            		if (fspecial){
                    	staffResults = FilterUtil.filter(staffResults, s -> s.getSpecialization().matches(".*" + special.toString() + ".*"));
                    }
            		if (fdeptid){
                    	staffResults = FilterUtil.filter(staffResults, s -> s.getDeptID() == (Integer.parseInt(deptid.toString())));
                    }
            		
            		staffResults.forEach((s) -> {
                    	Department deptS = deptDAO.getDepartment(s.getDeptID());
                    	allRows.append("<tr>" +
                                "<td>"+s.getEmpID()+"</td>" +
                                "<td>"+s.getName()+"</td>" +
                                "<td>"+s.getTitle()+"</td>" +
                                "<td>"+s.getSpecialization()+"</td>" +
                                "<td>"+s.getAddress()+"</td>" +
                                "<td>"+deptS.getDeptID() + ", "+ deptS.getDeptName()+"</td>" +
                                "<td class=\"update\"><form action=\"staffform.jsp\" method=\"post\"><button class=\"update-button\" type=\"submit\" value=\""+s.getEmpID()+"\" name=\"update\">Update</button></form></td>" +
                                "<td class=\"delete\"><form method=\"post\"><button class=\"delete-button\" type=\"submit\" value=\""+s.getEmpID()+"\" name=\"delete\">Delete</button></form></td>" +
                            "</tr>");
                    } );
                    %>
                    <%=allRows %>
                </table>
            </div>
        </main>
    </body>
</html>