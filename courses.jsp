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

            <%-- -------- INSERT Code -------- --%>
            <%
                    String action = request.getParameter("action");
                    // Check if an insertion is requested
                    if (action != null && action.equals("insert")) {

                        // Begin transaction
                        conn.setAutoCommit(false);
                        
                        // Create the prepared statement and use it to
                        // INSERT the student attributes INTO the Student table.
                        PreparedStatement pstmt = conn.prepareStatement(
                            "INSERT INTO Course VALUES (?, ?, ?, ?, ?, ?)");

                        pstmt.setString(1, request.getParameter("COURSENUMBER"));
                        pstmt.setString(2, request.getParameter("COURSEDEPARTMENTNAME"));
                        pstmt.setString(3, request.getParameter("COURSEUNITS"));
                        pstmt.setString(5, request.getParameter("COURSEREQLAB"));
                        pstmt.setString(6, request.getParameter("COURSEDIVISION"));
                        pstmt.setString(7, request.getParameter("COURSETECHNICAL"));
                        int rowCount = pstmt.executeUpdate();

                        // Commit transaction
                        conn.commit();
                        conn.setAutoCommit(true);
                    }
            %>

            <%-- -------- UPDATE Code -------- --%>
            <%
                    // Check if an update is requested
                    if (action != null && action.equals("update")) {

                        // Begin transaction
                        conn.setAutoCommit(false);
                        
                        // Create the prepared statement and use it to
                        // UPDATE the student attributes in the Student table.
                        PreparedStatement pstmt = conn.prepareStatement(
                            "UPDATE Course SET COURSEDEPARTMENTNAME = ?, COURSEUNITS = ?, " +
				"COURSEREQLAB = ?, COURSEDIVISION = ?, COURSETECHNICAL = ? WHERE COURSENUMBER = ?");

                        pstmt.setString(1, request.getParameter("COURSEDEPARTMENTNAME"));
                        pstmt.setString(2, request.getParameter("COURSEUNITS"));
                        pstmt.setString(4, request.getParameter("COURSEREQLAB"));
                        pstmt.setString(5, request.getParameter("COURSEDIVISION"));
                        pstmt.setString(6, request.getParameter("COURSETECHNICAL"));
                        pstmt.setString(7, request.getParameter("COURSENUMBER"));
                        int rowCount = pstmt.executeUpdate();

                        // Commit transaction
                         conn.commit();
                        conn.setAutoCommit(true);
                    }
            %>

            <%-- -------- DELETE Code -------- --%>
            <%
                    // Check if a delete is requested
                    if (action != null && action.equals("delete")) {

                        // Begin transaction
                        conn.setAutoCommit(false);
                        
                        // Create the prepared statement and use it to
                        // DELETE the student FROM the Course table.
                        PreparedStatement pstmt = conn.prepareStatement(
                            "DELETE FROM Course WHERE COURSENUMBER = ?");

                        pstmt.setString(1, request.getParameter("COURSENUMBER"));
                        int rowCount = pstmt.executeUpdate();

                        // Commit transaction
                         conn.commit();
                        conn.setAutoCommit(true);
                    }
            %>

            <%-- -------- SELECT Statement Code -------- --%>
            <%
                    // Create the statement
                    Statement statement = conn.createStatement();

                    // Use the created statement to SELECT
                    // the student attributes FROM the Student table.
                    ResultSet rs = statement.executeQuery
                        ("SELECT * FROM Course");
            %>

            <!-- Add an HTML table header row to format the results -->
                <table border="1">
                    <tr>
                        <th>Course Number</th>
                        <th>Department Name</th>
                        <th>Units</th>
                        <th>Required Lab (Yes/No)</th>
			<th>Division</th>
			<th>Technical</th>
                        <th>Action</th>
                    </tr>
                    <tr>
                        <form action="courses.jsp" method="get">
                            <input type="hidden" value="insert" name="action">
                            <th><input value="" name="COURSENUMBER" size="20"></th>
                            <th><input value="" name="COURSEDEPARTMENTNAME" size="50"></th>
                            <th><input value="" name="COURSEUNITS" size="10"></th>
                            <th><input value="" name="COURSEREQLAB" size="10"></th>
                            <th><input value="" name="COURSEDIVISION" size="10"></th>
                            <th><input value="" name="COURSETECHNICAL" size="10"></th>
                            <th><input type="submit" value="Insert"></th>
                        </form>
                    </tr>

            <%-- -------- Iteration Code -------- --%>
            <%
                    // Iterate over the ResultSet
        
                    while ( rs.next() ) {
        
            %>

                    <tr>
                        <form action="courses.jsp" method="get">
                            <input type="hidden" value="update" name="action">

                            <%-- Get the COURSENUMBER --%>
                            <td>
                                <input value="<%= rs.getString("COURSENUMBER") %>" 
                                    name="COURSENUMBER" size="20">
                            </td>
    
                            <%-- Get the DEPARTMENTNAME --%>
                            <td>
                                <input value="<%= rs.getString("COURSEDEPARTMENTNAME") %>" 
                                    name="COURSEDEPARTMENTNAME" size="50">
                            </td>
    
                            <%-- Get the UNITS --%>
                            <td>
                                <input value="<%= rs.getString("COURSEUNITS") %>" 
                                    name="COURSEUNITS" size="10">
                            </td>
    
			    <%-- Get the REQLAB --%>
                            <td>
                                <input value="<%= rs.getString("COURSEREQLAB") %>" 
                                    name="COURSEREQLAB" size="10">
                            </td>

			    <%-- Get the DIVISION --%>
                            <td>
                                <input value="<%= rs.getString("COURSEDIVISION") %>" 
                                    name="COURSEDIVISION" size="10">
                            </td>

			    <%-- Get the TECHNICAL --%>
                            <td>
                                <input value="<%= rs.getString("COURSETECHNICAL") %>" 
                                    name="COURSETECHNICAL" size="10">
                            </td>

                            <%-- Button --%>
                            <td>
                                <input type="submit" value="Update">
                            </td>
                        </form>
                        <form action="courses.jsp" method="get">
                            <input type="hidden" value="delete" name="action">
                            <input type="hidden" 
                                value="<%= rs.getString("COURSENUMBER") %>" name="COURSENUMBER">
                            <%-- Button --%>
                            <td>
                                <input type="submit" value="Delete">
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
