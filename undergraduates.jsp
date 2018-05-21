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
                            "INSERT INTO Undergraduate VALUES (?, ?, ?, ?, ?)");

                        pstmt.setInt(
                            1, Integer.parseInt(request.getParameter("UNDERGRADSSN")));
                        pstmt.setString(2, request.getParameter("COLLEGE"));
                        pstmt.setString(3, request.getParameter("MAJOR"));
                        pstmt.setString(4, request.getParameter("MINOR"));
                        pstmt.setString(5, request.getParameter("MSPROGRAM"));
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
                            "UPDATE Undergraduate SET COLLEGE = ?, MAJOR = ?, " +
				"MINOR = ?, MSPROGRAM = ? WHERE UNDERGRADSSN = ?");

                        pstmt.setString(1, request.getParameter("COLLEGE"));
                        pstmt.setString(2, request.getParameter("MAJOR"));
			pstmt.setString(3, request.getParameter("MINOR"));
                        pstmt.setString(4, request.getParameter("MSPROGRAM"));
                        pstmt.setInt(
                            5, Integer.parseInt(request.getParameter("UNDERGRADSSN")));
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
                            "DELETE FROM Undergraduate WHERE UNDERGRADSSN = ?");

                        pstmt.setInt(
                            1, Integer.parseInt(request.getParameter("UNDERGRADSSN")));
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
                        ("SELECT * FROM Undergraduate");
            %>

            <!-- Add an HTML table header row to format the results -->
                <table border="1">
                    <tr>
                        <th>Student SSN</th>
                        <th>College</th>
                        <th>Major</th>
			<th>Minor</th>
                        <th>MS Program (Yes/No)</th>
                        <th>Action</th>
                    </tr>
                    <tr>
                        <form action="undergraduates.jsp" method="get">
                            <input type="hidden" value="insert" name="action">
                            <th><input value="" name="UNDERGRADSSN" size="10"></th>
                            <th><input value="" name="COLLEGE" size="10"></th>
                            <th><input value="" name="MAJOR" size="30"></th>
			    <th><input value="" name="MINOR" size="30"></th>
                            <th><input value="" name="MSPROGRAM" size="10"></th>
                            <th><input type="submit" value="Insert"></th>
                        </form>
                    </tr>

            <%-- -------- Iteration Code -------- --%>
            <%
                    // Iterate over the ResultSet
        
                    while ( rs.next() ) {
        
            %>

                    <tr>
                        <form action="undergraduates.jsp" method="get">
                            <input type="hidden" value="update" name="action">

                            <%-- Get the UNDERGRADSSN --%>
                            <td>
                                <input value="<%= rs.getInt("UNDERGRADSSN") %>" 
                                    name="STUDENTID" size="10">
                            </td>
    
                            <%-- Get the COLLEGE --%>
                            <td>
                                <input value="<%= rs.getString("COLLEGE") %>" 
                                    name="COLLEGE" size="10">
                            </td>
    
                            <%-- Get the MAJOR --%>
                            <td>
                                <input value="<%= rs.getString("MAJOR") %>" 
                                    name="MAJOR" size="30">
                            </td>
    
                            <%-- Get the MINOR --%>
                            <td>
                                <input value="<%= rs.getString("MINOR") %>" 
                                    name="MINOR" size="30">
                            </td>
    
			    <%-- Get the MSPROGRAM --%>
                            <td>
                                <input value="<%= rs.getString("MSPROGRAM") %>" 
                                    name="MSPROGRAM" size="10">
                            </td>

                            <%-- Button --%>
                            <td>
                                <input type="submit" value="Update">
                            </td>
                        </form>
                        <form action="undergraduates.jsp" method="get">
                            <input type="hidden" value="delete" name="action">
                            <input type="hidden" 
                                value="<%= rs.getInt("UNDERGRADSSN") %>" name="UNDERGRADSSN">
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
