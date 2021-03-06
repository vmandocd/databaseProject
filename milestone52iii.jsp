
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
			<th>Course</th>
			<th>Professor</th>
		    </tr
                    <tr>
                        <form action="milestone52iii.jsp" method="get">
			    <th>
				<input list="courses" name="coursetype">
			            <datalist id="courses">
                        		<option value="CSE8A">
				        <option value="CSE105">
                        		<option value="CSE123">
                        		<option value="CSE221">
                        		<option value="CSE232A">
                        		<option value="CSE250A">
                        		<option value="CSE250B">
                        		<option value="CSE255">
                        		<option value="MAE107">
                        		<option value="MAE108">
                       			 <option value="MAE3">
                        		<option value="PHIL10">
                        		<option value="PHIL12">
                        		<option value="PHIL165">
                        		<option value="PHIL167">

			            </datalist>
			    </th>

			    <th>
				<input list="professors" name="profname">
			            <datalist id="professors">
				        <option value="Adam Levine">
                        		<option value="Adele">
                        		<option value="Bjork">
                        		<option value="Flo Rida">
                        		<option value="Justin Bieber">
                        		<option value="Kelly Clarkson">
                        		<option value="Selena Gomez">
                        		<option value="Taylor Swift">

			            </datalist>
			    </th>

                            <th><input type="submit" value="Select"></th>
                        </form>
                    </tr>

	    <%
                    // Create the statement
                    Statement statement = conn.createStatement();
	    %>
	    
          
                <table border="1">
                    <tr>
                        <th>Number of students with A</th>
                    </tr>

            <%-- -------- SELECT Button Code -------- --%>
            <%
                    String action = request.getParameter("action");
		    String v = request.getParameter("coursetype");
		    String w = request.getParameter("profname");


                    ResultSet rsA = statement.executeQuery
            		("SELECT COUNT(cpg.cpggrade) AS Atotal " +
           		 "FROM cpg " +
           		 "WHERE cpg.cpgcoursenumber = '"+v+"' AND cpg.cpgfacultyname = '"+w+"' " +
            		 "AND cpg.cpggrade LIKE 'A%'");

            %>

            <%-- -------- Iteration Code -------- --%>
            <%
                    // Iterate over the ResultSet
        
                    while ( rsA.next() ) {
        
            %>

                    <tr>
                        <form action="milestone52iii.jsp" method="get">

                            <td>
                                <input value="<%= rsA.getInt("Atotal") %>" 
                                    name="Atotal">
                            </td>
    
                        </form>
                    </tr>
            <%
                    }
            %>

                <table border="1">
                    <tr>
                        <th>Number of students with B</th>
                    </tr>


            <%-- -------- Iteration Code -------- --%>
            <%
                    ResultSet rsB = statement.executeQuery
            		("SELECT COUNT(cpg.cpggrade) AS Btotal " +
           		 "FROM cpg " +
           		 "WHERE cpg.cpgcoursenumber = '"+v+"' AND cpg.cpgfacultyname = '"+w+"' " +
            		 "AND cpg.cpggrade LIKE 'B%'");

                    // Iterate over the ResultSet
        
                    while ( rsB.next() ) {
        
            %>

                    <tr>
                        <form action="milestone52iii.jsp" method="get">

                            <td>
                                <input value="<%= rsB.getInt("Btotal") %>" 
                                    name="Btotal">
                            </td>
    
                        </form>
                    </tr>
            <%
                    }
            %>


                <table border="1">
                    <tr>
                        <th>Number of students with C</th>
                    </tr>


            <%-- -------- Iteration Code -------- --%>
            <%
                    ResultSet rsC = statement.executeQuery
            		("SELECT COUNT(cpg.cpggrade) AS Ctotal " +
           		 "FROM cpg " +
           		 "WHERE cpg.cpgcoursenumber = '"+v+"' AND cpg.cpgfacultyname = '"+w+"' " +
            		 "AND cpg.cpggrade LIKE 'C%'");

                    // Iterate over the ResultSet
        
                    while ( rsC.next() ) {
        
            %>

                    <tr>
                        <form action="milestone52iii.jsp" method="get">

                            <td>
                                <input value="<%= rsC.getInt("Ctotal") %>" 
                                    name="Ctotal">
                            </td>
    
                        </form>
                    </tr>
            <%
                    }
            %>

                <table border="1">
                    <tr>
                        <th>Number of students with D</th>
                    </tr>


            <%-- -------- Iteration Code -------- --%>
            <%
                    ResultSet rsD = statement.executeQuery
            		("SELECT COUNT(cpg.cpggrade) AS Dtotal " +
           		 "FROM cpg " +
           		 "WHERE cpg.cpgcoursenumber = '"+v+"' AND cpg.cpgfacultyname = '"+w+"' " +
            		 "AND cpg.cpggrade LIKE 'D%'");

                    // Iterate over the ResultSet
        
                    while ( rsD.next() ) {
        
            %>

                    <tr>
                        <form action="milestone52iii.jsp" method="get">

                            <td>
                                <input value="<%= rsD.getInt("Dtotal") %>" 
                                    name="Dtotal">
                            </td>
    
                        </form>
                    </tr>
            <%
                    }
            %>

                <table border="1">
                    <tr>
                        <th>Number of students with F</th>
                    </tr>


            <%-- -------- Iteration Code -------- --%>
            <%
                    ResultSet rsF = statement.executeQuery
            		("SELECT COUNT(cpg.cpggrade) AS Ftotal " +
           		 "FROM cpg " +
           		 "WHERE cpg.cpgcoursenumber = '"+v+"' AND cpg.cpgfacultyname = '"+w+"' " +
            		 "AND cpg.cpggrade LIKE 'F%'");

                    // Iterate over the ResultSet
        
                    while ( rsF.next() ) {
        
            %>

                    <tr>
                        <form action="milestone52iii.jsp" method="get">

                            <td>
                                <input value="<%= rsF.getInt("Ftotal") %>" 
                                    name="Ftotal">
                            </td>
    
                        </form>
                    </tr>
            <%
                    }
            %>



            <%-- -------- Close Connection Code -------- --%>
            <%
                    // Close the ResultSet
                    rsA.close();
                    rsB.close();
                    rsC.close();
                    rsD.close();
                    rsF.close();
    
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
