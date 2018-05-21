
<html>

<body>
    <table border="1">
        <tr>
            <td valign="top">
                <%-- -------- Include menu HTML code -------- --%>
                <jsp:include page="menu.html" />
            </td>
            <td>

            <%-- Set the scripting language to Java and --%>
            <%-- Import the java.sql package --%>
            <%@ page language="java" import="java.sql.*" %>
    
            <%-- -------- Open Connection Code -------- --%>
            <%
                try {
                    Class.forName("org.postgresql.Driver");
                    String dbURL = "jdbc:postgresql:cse132?user=postgres&password=admin";
                    Connection conn = DriverManager.getConnection(dbURL);

            %>

	    <!-- Add an HTML table header row to format the results -->
                <table border="1">
                    <tr>
			<th>Student SSN</th>
		    </tr
                    <tr>
                        <form action="query1c.jsp" method="get">
			    <th>
				<input list="students" name="SSN">
			            <datalist id="students">
				        <option value="1">
				        <option value="2">
				        <option value="3">
				        <option value="4">
				        <option value="5">
				        <option value="6">
				        <option value="7">
				        <option value="8">
				        <option value="9">
				        <option value="10">
				        <option value="11">
				        <option value="12">
				        <option value="13">
				        <option value="14">
				        <option value="15">
				        <option value="16">
				        <option value="17">
				        <option value="18">
				        <option value="19">
				        <option value="20">
				        <option value="21">
				        <option value="22">
			            </datalist>
			    </th>
                            <th><input type="submit" value="Select"></th>
                        </form>
                    </tr>

	    <%
                    // Create the statement
                    Statement statement = conn.createStatement();

                    ResultSet rs0 = statement.executeQuery
                    ("SELECT * FROM Student");
	    %>
	    
            <!-- Add an HTML table header row to format the results -->
                <table border="1">
		    <tr>
			<th>Student List</th>
		    </tr>
                    <tr>
                        <th>SSN</th>
                        <th>First</th>
			<th>Middle</th>
                        <th>Last</th>
                    </tr>

            <%-- -------- Iteration Code -------- --%>
            <%
                    // Iterate over the ResultSet
        
                    while ( rs0.next() ) {
        
            %>

                    <tr>
                        <form action="query1c.jsp" method="get">

                            <td>
                                <input value="<%= rs0.getInt("SSN") %>" 
                                    name="SSN">
                            </td>
    
                            <td>
                                <input value="<%= rs0.getString("FIRSTNAME") %>" 
                                    name="FIRSTNAME">
                            </td>
    
                            <td>
                                <input value="<%= rs0.getString("MIDDLENAME") %>" 
                                    name="MIDDLENAME">
                            </td>
    
                            <td>
                                <input value="<%= rs0.getString("LASTNAME") %>" 
                                    name="LASTNAME">
                            </td>
    
                        </form>
                    </tr>
            <%
                    }
            %>


	    	    <tr>
			<th>Student's course(s)</th>
		    </tr>
                    <tr>
                        <th>Course</th>
                        <th>Section</th>
                        <th>Class title</th>
                        <th>Quarter</th>
                        <th>Year</th>
                        <th>Currently Offered</th>
                        <th>Next Quarter</th>
                        <th>Next Year</th>
                        <th>Grade</th>
                        <th>Units</th>
                    </tr>

            <%-- -------- SELECT Button Code -------- --%>
            <%
                    String action = request.getParameter("action");

		    int v = Integer.parseInt(request.getParameter("SSN"));

                    ResultSet rs = statement.executeQuery
		    ("SELECT c.*, p.grade, p.units " +
		    "FROM student s, pastclass p, classes c " +
		    "WHERE s.ssn = "+v+" AND s.ssn = p.studentssn AND p.coursenumber = c.coursenumber AND p.quarter = c.quarteroffered AND p.year = c.year");

            %>

            <%-- -------- Iteration Code -------- --%>
            <%
                    // Iterate over the ResultSet
        
                    while ( rs.next() ) {
        
            %>

                    <tr>
                        <form action="query1c.jsp" method="get">

                            <td>
                                <input value="<%= rs.getString("coursenumber") %>" 
                                    name="coursenumber">
                            </td>
    
                            <td>
                                <input value="<%= rs.getInt("sectionid") %>" 
                                    name="sectionid">
                            </td>
    
                            <td>
                                <input value="<%= rs.getString("classtitle") %>" 
                                    name="classtitle">
                            </td>
    
                            <td>
                                <input value="<%= rs.getString("quarteroffered") %>" 
                                    name="quarteroffered">
                            </td>
    
                            <td>
                                <input value="<%= rs.getInt("year") %>" 
                                    name="year">
                            </td>
    
                            <td>
                                <input value="<%= rs.getString("currently") %>" 
                                    name="currently">
                            </td>
    
                            <td>
                                <input value="<%= rs.getString("nextquarter") %>" 
                                    name="nextquarter">
                            </td>
    
                            <td>
                                <input value="<%= rs.getInt("nextyear") %>" 
                                    name="nextyear">
                            </td>
    
                            <td>
                                <input value="<%= rs.getString("grade") %>" 
                                    name="grade">
                            </td>

                            <td>
                                <input value="<%= rs.getInt("units") %>" 
                                    name="units">
                            </td>
    
                        </form>
                    </tr>
            <%
                    }
            %>

            <!-- Add an HTML table header row to format the results -->
                <table border="1">
                    <tr>
                        <th>fa2014</th>
                    </tr>

            <%-- -------- Iteration Code -------- --%>
            <%

                    ResultSet rs1 = statement.executeQuery
		    ("SELECT AVG(number_grade) AS gpa " +
		    "FROM pastclass p INNER JOIN student s ON s.ssn = p.studentssn " +
		    "INNER JOIN grade_conversion g " +
		    "ON p.grade = g.letter_grade " +
		    "WHERE s.ssn ="+v+" AND p.quarter = 'fa' AND p.year = 2014");

                    // Iterate over the ResultSet
        
                    while ( rs1.next() ) {
        
            %>

                    <tr>
                        <form action="query1c.jsp" method="get">
                            <td>
                                <input value="<%= rs1.getFloat("gpa") %>" 
                                    name="gpa">
                            </td>
                        </form>
                    </tr>
            <%
                    }
            %>


            <!-- Add an HTML table header row to format the results -->
                <table border="1">
                    <tr>
                        <th>wi2015</th>
                    </tr>

            <%-- -------- Iteration Code -------- --%>
            <%

                    ResultSet rs2 = statement.executeQuery
		    ("SELECT AVG(number_grade) AS gpa " +
		    "FROM pastclass p INNER JOIN student s ON s.ssn = p.studentssn " +
		    "INNER JOIN grade_conversion g " +
		    "ON p.grade = g.letter_grade " +
		    "WHERE s.ssn ="+v+" AND p.quarter = 'wi' AND p.year = 2015");

                    // Iterate over the ResultSet
        
                    while ( rs2.next() ) {
        
            %>

                    <tr>
                        <form action="query1c.jsp" method="get">
                            <td>
                                <input value="<%= rs2.getFloat("gpa") %>" 
                                    name="gpa">
                            </td>
                        </form>
                    </tr>
            <%
                    }
            %>

            <!-- Add an HTML table header row to format the results -->
                <table border="1">
                    <tr>
                        <th>sp2015</th>
                    </tr>

            <%-- -------- Iteration Code -------- --%>
            <%

                    ResultSet rs3 = statement.executeQuery
		    ("SELECT AVG(number_grade) AS gpa " +
		    "FROM pastclass p INNER JOIN student s ON s.ssn = p.studentssn " +
		    "INNER JOIN grade_conversion g " +
		    "ON p.grade = g.letter_grade " +
		    "WHERE s.ssn ="+v+" AND p.quarter = 'sp' AND p.year = 2015");

                    // Iterate over the ResultSet
        
                    while ( rs3.next() ) {
        
            %>

                    <tr>
                        <form action="query1c.jsp" method="get">
                            <td>
                                <input value="<%= rs3.getFloat("gpa") %>" 
                                    name="gpa">
                            </td>
                        </form>
                    </tr>
            <%
                    }
            %>

            <!-- Add an HTML table header row to format the results -->
                <table border="1">
                    <tr>
                        <th>fa2015</th>
                    </tr>

            <%-- -------- Iteration Code -------- --%>
            <%

                    ResultSet rs4 = statement.executeQuery
		    ("SELECT AVG(number_grade) AS gpa " +
		    "FROM pastclass p INNER JOIN student s ON s.ssn = p.studentssn " +
		    "INNER JOIN grade_conversion g " +
		    "ON p.grade = g.letter_grade " +
		    "WHERE s.ssn ="+v+" AND p.quarter = 'fa' AND p.year = 2015");

                    // Iterate over the ResultSet
        
                    while ( rs4.next() ) {
        
            %>

                    <tr>
                        <form action="query1c.jsp" method="get">
                            <td>
                                <input value="<%= rs4.getFloat("gpa") %>" 
                                    name="gpa">
                            </td>
                        </form>
                    </tr>
            <%
                    }
            %>

            <!-- Add an HTML table header row to format the results -->
                <table border="1">
                    <tr>
                        <th>Cumulative GPA</th>
                    </tr>

            <%-- -------- Iteration Code -------- --%>
            <%

                    ResultSet rs5 = statement.executeQuery
		    ("SELECT AVG(number_grade) AS gpa " +
		    "FROM pastclass p INNER JOIN student s ON s.ssn = p.studentssn " +
		    "INNER JOIN grade_conversion g " +
		    "ON p.grade = g.letter_grade " +
		    "WHERE s.ssn ="+v);

                    // Iterate over the ResultSet
        
                    while ( rs5.next() ) {
        
            %>

                    <tr>
                        <form action="query1c.jsp" method="get">
                            <td>
                                <input value="<%= rs5.getFloat("gpa") %>" 
                                    name="gpa">
                            </td>
                        </form>
                    </tr>
            <%
                    }
            %>


            <%-- -------- Close Connection Code -------- --%>
            <%
                    // Close the ResultSet
                    rs.close();
    
                    // Close the Statement
                    statement.close();
    
                    // Close the Connection
                    conn.close();
                } catch (SQLException sqle) {
                    out.println(sqle.getMessage());
                } catch (Exception e) {
                    out.println(e.getMessage());
                }
            %>
                </table>
            </td>
        </tr>
    </table>
</body>

</html>
