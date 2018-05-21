
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
			<th>Course Number</th>
			<th>Professor</th>
			<th>Quarter</th>
			<th>Year</th>
			<th>Grade</th>
		    </tr
                    <tr>
                        <form action="cpqg.jsp" method="get">
			    <th>
				<input list="courses" name="coursetype">
			            <datalist id="courses">
				        <option value="CSE8A">
				        <option value="CSE105">
				        <option value="CSE123">
				        <option value="CS250A">
				        <option value="CSE250B">
				        <option value="CSE255">
				        <option value="CSE232A">
				        <option value="CSE221">
				        <option value="MAE3">
				        <option value="MAE107">
				        <option value="MAE108">
				        <option value="PHIL10">
				        <option value="PHIL12">
				        <option value="PHIL165">
				        <option value="PHIL167">
			            </datalist>
			    </th>

			    <th>
				<input list="professors" name="profname">
			            <datalist id="professors">
				        <option value="Justin Bieber">
				        <option value="Flo Rida">
				        <option value="Selena Gomez">
				        <option value="Adele">
				        <option value="Taylor Swift">
				        <option value="Kelly Clarkson">
				        <option value="Adam Levine">
				        <option value="Bjork">
			            </datalist>
			    </th>

			    <th>
				<input list="quarters" name="quartername">
			            <datalist id="quarters">
				        <option value="fa">
				        <option value="sp">
				        <option value="wi">
			            </datalist>
			    </th>

			    <th>
				<input list="years" name="yearname">
			            <datalist id="years">
				        <option value="2014">
				        <option value="2015">
				        <option value="2016">
				        <option value="2017">
			            </datalist>
			    </th>
			    
			    <th>
				<input list="grades" name="gradename">
			            <datalist id="grades">
				        <option value="A">
				        <option value="B">
				        <option value="C">
				        <option value="D">
				        <option value="F">
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
                        <th>Number of students with selected grade</th>
                    </tr>

            <%-- -------- SELECT Button Code -------- --%>
            <%
                    String action = request.getParameter("action");

		    String v = request.getParameter("coursetype");
		    String w = request.getParameter("profname");
		    String x = request.getParameter("quartername");
		    String y = request.getParameter("yearname");
		    String z = request.getParameter("gradename");

                    ResultSet rs = statement.executeQuery
		    ("SELECT COUNT(pc.pcgrade) as gradeCount " +
		    "FROM course c, classes cl, faculty f, pastclass pc, facultyteaching ft " +
		    "WHERE c.coursenumber = '"+v+"' AND f.facultyname = '"+w+"' AND pc.pcquarter = '"+x+"' AND pc.pcyear = "+y+" AND pc.pcgrade LIKE '"+z+"%' " +
		    "AND c.coursenumber = pc.pccoursenumber AND ft.teachingsectionid = cl.sectionid " +
		    "AND ft.teachingfacultyname = f.facultyname AND cl.classquarter = pc.pcquarter AND cl.classyear = pc.pcyear " +
		    "GROUP BY c.coursenumber");

            %>

            <%-- -------- Iteration Code -------- --%>
            <%
                    // Iterate over the ResultSet
        
                    while ( rs.next() ) {
        
            %>

                    <tr>
                        <form action="querycpqg.jsp" method="get">

                            <td>
                                <input value="<%= rs.getInt("gradeCount") %>" 
                                    name="gradeCount">
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
