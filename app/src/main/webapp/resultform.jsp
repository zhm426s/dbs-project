<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="hms.*" %>
<%@ page import="java.util.*" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <title>Hospital MS- Test Result Form</title>
        <meta charset="UTF-8">
        <link rel="stylesheet" href="styles.css">
    </head>
    <!--Functions: order treatment, edit treatment record-->
    <body>
        <header>
            <h1>Enter Test Results</h1>
            <button class="directory-button" onclick="location.href='treatments.jsp';">Back to Treatments Directory/Look Up Treatment</button>
        </header>
        <main>
            <div id="edit-form">
                <form class="edit" method="post" action="treatments.jsp">
                <select id="new" name="new">
                            <option value="newr" selected>Yes</option>
                        </select>
                    <div class="edit-field">
                        <label for="treatid">Treatment ID:</label><br>
                        <input type="text" id="treatid" name="treatid" placeholder="e.g. 2">
                    </div>
                    <div class="edit-field">
                        <label for="name">Patient Name (Matching record):</label><br>
                        <input type="text" id="name" name="name" placeholder="e.g. John, Doe, John Doe" required>
                    </div>
                    <div class="edit-field">
                        <label for="dob">Patient Date of Birth (Matching record):</label><br>
                        <input type="date" id="dob" name="dob" required>
                    </div>
                    <div class="edit-field">
                        <label for="date">Test Result Date:</label><br>
                        <input type="date" id="date" name="date" required>
                    </div>
                    <div class="edit-field">
                        <label for="result">Test Results:</label><br>
                        <input type="text" id="result" name="result" required>
                    </div>
                    <input type="submit" value="Submit">
                    <input type="reset" value="Clear">
                </form>
            </div>
        </main>
    </body>
</html>