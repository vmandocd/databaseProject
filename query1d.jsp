
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
			<th>Degree Name</th>
			<th>Student SSN</th>
		    </tr
                    <tr>
                        <form action="query1d.jsp" method="get">
			    <th>
				<input list="degrees" name="degreetype">
			            <datalist id="degrees">
				        <option value="B.S. in Computer Science">
				        <option value="B.A. in Philosophy">
				        <option value="B.S. in Mechanical Engineering">
				        <option value="M.S. in Computer Science">
			            </datalist>
			    </th>

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

                    ResultSet rsDeg = statement.executeQuery
                    ("SELECT * FROM Degree");
	    %>
	    
            <!-- Add an HTML table header row to format the results -->
                <table border="1">
                    <tr>
                        <th>Degree name</th>
                    </tr>

            <%-- -------- Iteration Code -------- --%>
            <%
                    // Iterate over the ResultSet
        
                    while ( rsDeg.next() ) {
        
            %>

                    <tr>
                        <form action="query1d.jsp" method="get">

                            <td>
                                <input value="<%= rsDeg.getString("DEGREENAME") %>" 
                                    name="DEGREENAME">
                            </td>

                        </form>
    
                    </tr>
            <%
                    }
            %>

	    <%
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
                        <form action="query1d.jsp" method="get">

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

                <table border="1">
                    <tr>
                        <th>Total Units Left</th>
                    </tr>

            <%-- -------- SELECT Button Code -------- --%>
            <%
                    String action = request.getParameter("action");

		    String u = request.getParameter("degreetype");
		    int v = Integer.parseInt(request.getParameter("SSN"));

                    ResultSet rs = statement.executeQuery
		    ("SELECT d.totalunits - SUM(totalunito) as totalLeft " +
		    "FROM (SELECT CASE WHEN NOT EXISTS (SELECT p1.units " +
		    "FROM undergraduate u1, pastclass p1, course c1, degree d1 " +
		    "WHERE u1.studentssn = "+v+" AND p1.coursenumber = c1.coursenumber AND u1.studentssn = p1.studentssn " +
		    "AND d1.degreename = '"+u+"' AND c1.departmentname = d1.departmentname) THEN 0 ELSE " +
		    "(SELECT SUM(p1.units) " +
		    "FROM undergraduate u1, pastclass p1, course c1, degree d1 " +
		    "WHERE u1.studentssn = "+v+" AND p1.coursenumber = c1.coursenumber AND u1.studentssn = p1.studentssn " +
		    "AND d1.degreename = '"+u+"' AND c1.departmentname = d1.departmentname) " +
		    "END) as totalunito, degree d " +
		    "WHERE d.degreename = '"+u+"' " +
		    "GROUP BY d.degreename, totalunito.sum");

            %>

            <%-- -------- Iteration Code -------- --%>
            <%
                    // Iterate over the ResultSet
        
                    while ( rs.next() ) {
        
            %>

                    <tr>
                        <form action="query1d.jsp" method="get">

                            <td>
                                <input value="<%= rs.getInt("totalLeft") %>" 
                                    name="totalLeft">
                            </td>
    
                        </form>
                    </tr>
            <%
                    }
            %>

            <!-- Add an HTML table header row to format the results -->
                <table border="1">
                    <tr>
                        <th>Lower Units Left</th>
                        <th>Upper Units Left</th>
                        <th>Tech Units Left</th>
                    </tr>

            <%-- -------- Iteration Code -------- --%>
            <%

                    ResultSet rs1 = statement.executeQuery
		    ("SELECT (d.lowerunits - SUM(lowerunito)) AS lower, " +
		    "(d.upperunits - SUM(upperunito)) AS upper,(d.techunits - SUM(techunito)) AS tech " +
		    "FROM (SELECT CASE WHEN NOT EXISTS (SELECT p2.units " +
		    "FROM  undergraduate u2, pastclass p2, course c2, degree d2 " +
		    "WHERE u2.studentssn = "+v+" AND p2.coursenumber = c2.coursenumber AND u2.studentssn = " + 
		    "p2.studentssn AND c2.division='lower' AND d2.degreename ='"+u+"' AND d2.departmentname = c2.departmentname) THEN 0 ELSE " +
		    "(SELECT SUM(p2.units) " +
		    "FROM  undergraduate u2, pastclass p2, course c2 " +
		    "WHERE u2.studentssn = "+v+" AND p2.coursenumber = c2.coursenumber AND u2.studentssn = " + 
		    "p2.studentssn AND c2.division='lower') " +
		    "END) AS lowerunito, " +

		    "(SELECT CASE WHEN NOT EXISTS (SELECT p3.units " +
		    "FROM  undergraduate u3, pastclass p3, course c3, degree d3 " +
		    "WHERE u3.studentssn = "+v+" AND p3.coursenumber = c3.coursenumber AND u3.studentssn = " + 
		    "p3.studentssn AND c3.division='lower' AND d3.degreename ='"+u+"' AND d3.departmentname = c3.departmentname) THEN 0 ELSE " +
		    "(SELECT SUM(p3.units) " +
		    "FROM  undergraduate u3, pastclass p3, course c3 " +
		    "WHERE u3.studentssn = "+v+" AND p3.coursenumber = c3.coursenumber AND u3.studentssn = " + 
		    "p3.studentssn AND c3.division='upper') " +
		    "END) AS upperunito, " +

		    "(SELECT CASE WHEN NOT EXISTS (SELECT p4.units " +
		    "FROM pastclass p4, undergraduate u4, technicals t, degree d4, course c4 " +
		    "WHERE u4.studentssn = "+v+" AND u4.studentssn = p4.studentssn AND p4.coursenumber = t.coursenumber " +
		    "AND d4.departmentname = c4.departmentname AND p4.coursenumber = c4.coursenumber AND d4.degreename='"+u+"') " +
		    "THEN 0 ELSE (SELECT SUM(p4.units) " +
		    "FROM pastclass p4, undergraduate u4, technicals t, degree d4, course c4 " +
		    "WHERE u4.studentssn = "+v+" AND u4.studentssn = p4.studentssn AND p4.coursenumber = t.coursenumber " +
		    "AND d4.departmentname = c4.departmentname AND p4.coursenumber = c4.coursenumber AND d4.degreename='"+u+"') END) AS techunito, degree d " +
		    "WHERE d.degreename = '"+u+"' " +
		    "GROUP BY d.degreename, lowerunito.sum, upperunito.sum, techunito.sum");

                    // Iterate over the ResultSet
        
                    while ( rs1.next() ) {
        
            %>

                    <tr>
                        <form action="query1d.jsp" method="get">

                            <td>
                                <input value="<%= rs1.getInt("lower") %>" 
                                    name="lower">
                            </td>

                            <td>
                                <input value="<%= rs1.getInt("upper") %>" 
                                    name="lower">
                            </td>

                            <td>
                                <input value="<%= rs1.getInt("tech") %>" 
                                    name="lower">
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
