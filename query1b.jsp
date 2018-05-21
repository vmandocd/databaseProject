
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
			<th>Course Title</th>
		    </tr>
		    <tr>
                        <form action="query1b.jsp" method="get">
			    <th>
				<input list="students" name="title">
			            <datalist id="students">
				        <option value="Introduction to Computer Science: Java">
				        <option value="Intro to Theory">
				        <option value="Probabilistic Reasoning">
				        <option value="Machine Learning">
				        <option value="Data Mining and Predictive Analytics">
				        <option value="Databases">
				        <option value="Operating Systems">
				        <option value="Computational Methods">
				        <option value="Probability and Statistics">
				        <option value="Intro to Logic">
				        <option value="Scientific Reasoning">
				        <option value="Freedom, Equality, and the Law">
			            </datalist>
			    </th>
                            <th><input type="submit" value="Select"></th>
                        </form>
                    </tr>

		    

	    <%
                    // Create the statement
                    Statement statement = conn.createStatement();

                    ResultSet rs0 = statement.executeQuery
                    ("SELECT * FROM Classes");
	    %>
	    
            <!-- Add an HTML table header row to format the results -->
                <table border="1">
		    <tr>
			<th>Class List</th>
		    </tr>
                    <tr>
                        <th>Course</th>
                        <th>Quarter</th>
			<th>Year</th>
                    </tr>

            <%-- -------- Iteration Code -------- --%>
            <%
                    // Iterate over the ResultSet
        
                    while ( rs0.next() ) {
        
            %>

                    <tr>
                        <form action="query1b.jsp" method="get">

                            <td>
                                <input value="<%= rs0.getString("coursenumber") %>" 
                                    name="coursenumber">
                            </td>
    
                            <td>
                                <input value="<%= rs0.getString("quarteroffered") %>" 
                                    name="quarteroffered">
                            </td>
    
                            <td>
                                <input value="<%= rs0.getInt("year") %>" 
                                    name="year">
                            </td>
    
                        </form>
                    </tr>
            <%
                    }
            %>


                <table border="1">
		    <tr>
			<th>Undergraduates</th>
		    </tr>
                    <tr>
                        <th>Student SSN</th>
                        <th>First</th>
                        <th>Middle</th>
                        <th>Last</th>
			<th>Degree</th>
                        <th>Units</th>
                        <th>Grade Option</th>
                    </tr>

            <%-- -------- SELECT Button Code -------- --%>
            <%
                    String action = request.getParameter("action");

		    String v = request.getParameter("title");

                    ResultSet rs = statement.executeQuery
                            ("SELECT * " +
			    "FROM student s, classes cl, enrollment e, course co, undergraduate u " +
			    "WHERE cl.classtitle = '"+v+"' AND co.coursenumber = cl.coursenumber AND cl.sectionid = e.sectionid " +
			    "AND e.studentssn = s.ssn AND e.studentssn = u.studentssn"
                    );
		    
            %>

            <%-- -------- Iteration Code -------- --%>
            <%
                    // Iterate over the ResultSet
        
                    while ( rs.next() ) {
        
            %>

                    <tr>
                        <form action="query1b.jsp" method="get">

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

                            <td>
                                <input value="<%= rs.getString("major") %>" 
                                    name="major">
                            </td>

                            <td>
                                <input value="<%= rs.getInt("units") %>" 
                                    name="units">
                            </td>
    
                            <td>
                                <input value="<%= rs.getString("gradeopt") %>" 
                                    name="gradeopt">
                            </td>
    
                        </form>
                    </tr>
            <%
                    }
            %>

            <!-- Add an HTML table header row to format the results -->
                <table border="1">
		    <tr>
			<th>Graduates</th>
		    </tr>
                    <tr>
                        <th>Student SSN</th>
                        <th>First</th>
                        <th>Middle</th>
                        <th>Last</th>
			<th>Degree</th>
                        <th>Units</th>
                        <th>Grade Option</th>
                    </tr>

            <%-- -------- Iteration Code -------- --%>
            <%

                    ResultSet rs1 = statement.executeQuery
                            ("SELECT * " +
			    "FROM student s, classes cl, enrollment e, course co, graduate g " +
			    "WHERE cl.classtitle = '"+v+"' AND co.coursenumber = cl.coursenumber AND cl.sectionid = e.sectionid " +
			    "AND e.studentssn = s.ssn AND e.studentssn = g.studentssn"
			    );

                    // Iterate over the ResultSet
        
                    while ( rs1.next() ) {
        
            %>

                    <tr>
                        <form action="query1b.jsp" method="get">

                            <%-- Get the SSN --%>
                            <td>
                                <input value="<%= rs1.getInt("SSN") %>" 
                                    name="SSN">
                            </td>
    
                            <%-- Get the name --%>
                            <td>
                                <input value="<%= rs1.getString("firstname") %>" 
                                    name="firstname">
                            </td>
    
                            <td>
                                <input value="<%= rs1.getString("middlename") %>" 
                                    name="middlename">
                            </td>
    
                            <td>
                                <input value="<%= rs1.getString("lastname") %>" 
                                    name="lastname">
                            </td>

                            <td>
                                <input value="<%= rs1.getString("degree") %>" 
                                    name="degree">
                            </td>

                            <td>
                                <input value="<%= rs1.getInt("units") %>" 
                                    name="units">
                            </td>
    
                            <td>
                                <input value="<%= rs1.getString("gradeopt") %>" 
                                    name="gradeopt">
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
