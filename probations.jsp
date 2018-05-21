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
                        // INSERT the student attributes INTO the Probation table.
                        PreparedStatement pstmt = conn.prepareStatement(
                            "INSERT INTO Probation VALUES (?, ?, ?, ?)");

                        pstmt.setInt(
                            1, Integer.parseInt(request.getParameter("PROBATIONID")));
                        pstmt.setInt(
                            2, Integer.parseInt(request.getParameter("PROBATIONSSN")));
                        pstmt.setString(3, request.getParameter("REASON"));
                       pstmt.setString(4, request.getParameter("PROBATIONPERIOD"));
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
                        // UPDATE the student attributes in the Probation table.
                        PreparedStatement pstmt = conn.prepareStatement(
                            "UPDATE Probation SET PROBATIONSSN = ?, REASON = ?, " +
			    " PROBATIONPERIOD = ? WHERE PROBATIONID = ?");

                        pstmt.setInt(
                            1, Integer.parseInt(request.getParameter("PROBATIONSSN")));
                        pstmt.setString(2, request.getParameter("REASON"));
                        pstmt.setString(3, request.getParameter("PROBATIONPERIOD"));
                        pstmt.setInt(
                            4, Integer.parseInt(request.getParameter("PROBATIONID")));
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
                        // DELETE the student FROM the Probation table.
                        PreparedStatement pstmt = conn.prepareStatement(
                            "DELETE FROM Probation WHERE PROBATIONID = ?");

                        pstmt.setInt(
                            1, Integer.parseInt(request.getParameter("PROBATIONID")));
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
                    // the student attributes FROM the Probation table.
                    ResultSet rs = statement.executeQuery
                        ("SELECT * FROM Probation");
            %>

            <!-- Add an HTML table header row to format the results -->
                <table border="1">
                    <tr>
                        <th>Probation ID</th>
                        <th>Student SSN</th>
                        <th>Reason</th>
                        <th>Probation Period</th>
                        <th>Action</th>
                    </tr>
                    <tr>
                        <form action="probations.jsp" method="get">
                            <input type="hidden" value="insert" name="action">
                            <th><input value="" name="PROBATIONID" size="10"></th>
                            <th><input value="" name="PROBATIONSSN" size="10"></th>
                            <th><input value="" name="REASON" size="30"></th>
                            <th><input value="" name="PROBATIONPERIOD" size="30"></th>
                            <th><input type="submit" value="Insert"></th>
                        </form>
                    </tr>

            <%-- -------- Iteration Code -------- --%>
            <%
                    // Iterate over the ResultSet
        
                    while ( rs.next() ) {
        
            %>

                    <tr>
                        <form action="probations.jsp" method="get">
                            <input type="hidden" value="update" name="action">

                            <%-- Get the PROBATIONID, which is a number --%>
                            <td>
                                <input value="<%= rs.getInt("PROBATIONID") %>" 
                                    name="PROBATIONID" size="10">
                            </td>
    
                            <%-- Get the STUDENTSSN, which is a number --%>
                            <td>
                                <input value="<%= rs.getInt("PROBATIONSSN") %>" 
                                    name="PROBATIONSSN" size="10">
                            </td>
    
                            <%-- Get the REASON --%>
                            <td>
                                <input value="<%= rs.getString("REASON") %>" 
                                    name="REASON" size="30">
                            </td>
    
                            <%-- Get the PROBATIONPERIOD --%>
                            <td>
                                <input value="<%= rs.getString("PROBATIONPERIOD") %>"
                                    name="PROBATIONPERIOD" size="30">
                            </td>
    
                            <%-- Button --%>
                            <td>
                                <input type="submit" value="Update">
                            </td>
                        </form>
                        <form action="probations.jsp" method="get">
                            <input type="hidden" value="delete" name="action">
                            <input type="hidden" 
                                value="<%= rs.getInt("PROBATIONID") %>" name="PROBATIONID">
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
