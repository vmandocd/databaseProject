
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
                    </tr>
                    <tr>
                        <form action="query1.jsp" method="get">
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
                        <form action="query1.jsp" method="get">

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
			<th>Student's current enrollment</th>
		    </tr>

                    <tr>
                        <th>Student SSN</th>
                        <th>First</th>
                        <th>Middle</th>
                        <th>Last</th>
                        <th>Course</th>
                        <th>Section</th>
                        <th>Class title</th>
                        <th>Quarter</th>
                        <th>Year</th>
                        <th>Currently Offered</th>
                        <th>Next Quarter</th>
                        <th>Next Year</th>
                        <th>Units</th>
                    </tr>

            <%-- -------- SELECT Button Code -------- --%>
            <%
                    String action = request.getParameter("action");

		    int v = Integer.parseInt(request.getParameter("SSN"));

                    ResultSet rs = statement.executeQuery
                            ("SELECT * " +
			     "FROM student s, classes cl, enrollment e, course co " +
			     "WHERE s.ssn = "+v+" AND s.ssn = e.studentssn AND e.sectionid = cl.sectionid AND cl.coursenumber = co.coursenumber");
		    
            %>

            <%-- -------- Iteration Code -------- --%>
            <%
                    // Iterate over the ResultSet
        
                    while ( rs.next() ) {
        
            %>

                    <tr>
                        <form action="query1.jsp" method="get">

                            <%-- Get the SSN --%>
                            <td>
                                <input value="<%= rs.getInt("SSN") %>" 
                                    name="SSN">
                            </td>
    
                            <%-- Get the name --%>
                            <td>
                                <input value="<%= rs.getString("firstname") %>" 
                                    name="firstname">
                            </td>
    
                            <td>
                                <input value="<%= rs.getString("middlename") %>" 
                                    name="middlename">
                            </td>
    
                            <td>
                                <input value="<%= rs.getString("lastname") %>" 
                                    name="lastname">
                            </td>
    
                            <%-- Get the class attributes --%>
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
                                <input value="<%= rs.getInt("units") %>" 
                                    name="units">
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
