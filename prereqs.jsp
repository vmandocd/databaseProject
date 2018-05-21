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
                            "INSERT INTO Prereq VALUES (?, ?, ?)");

                        pstmt.setInt(
                            1, Integer.parseInt(request.getParameter("PREREQID")));
                        pstmt.setString(2, request.getParameter("PREREQCOURSENUMBER"));
                        pstmt.setString(3, request.getParameter("PREREQ"));
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
                            "UPDATE Prereq SET PREREQCOURSENUMBER = ?, PREREQ = ? " +
                            "WHERE PREREQID = ?");

                        pstmt.setString(1, request.getParameter("PREREQCOURSENUMBER"));
                        pstmt.setString(2, request.getParameter("PREREQ"));
                        pstmt.setInt(
                            3, Integer.parseInt(request.getParameter("PREREQID")));
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
                        // DELETE the student FROM the Student table.
                        PreparedStatement pstmt = conn.prepareStatement(
                            "DELETE FROM Prereq WHERE PREREQID = ?");

                        pstmt.setInt(
                            1, Integer.parseInt(request.getParameter("PREREQID")));
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
                        ("SELECT * FROM PreReq");
            %>

            <!-- Add an HTML table header row to format the results -->
                <table border="1">
                    <tr>
                        <th>Pre-Req ID</th>
                        <th>Course Number</th>
                        <th>Pre-Reqs</th>
                        <th>Action</th>
                    </tr>
                    <tr>
                        <form action="prereqs.jsp" method="get">
                            <input type="hidden" value="insert" name="action">
                            <th><input value="" name="PREREQID" size="10"></th>
                            <th><input value="" name="PREREQCOURSENUMBER" size="10"></th>
                            <th><input value="" name="PREREQ" size="10"></th>
                            <th><input type="submit" value="Insert"></th>
                        </form>
                    </tr>

            <%-- -------- Iteration Code -------- --%>
            <%
                    // Iterate over the ResultSet
        
                    while ( rs.next() ) {
        
            %>

                    <tr>
                        <form action="prereqs.jsp" method="get">
                            <input type="hidden" value="update" name="action">

                            <%-- Get the PREREQID --%>
                            <td>
                                <input value="<%= rs.getInt("PREREQID") %>" 
                                    name="PREREQID" size="10">
                            </td>
    
                            <%-- Get the COURSENUMBER --%>
                            <td>
                                <input value="<%= rs.getString("PREREQCOURSENUMBER") %>" 
                                    name="PREREQCOURSENUMBER" size="10">
                            </td>
    
                            <%-- Get the PREREQ --%>
                            <td>
                                <input value="<%= rs.getString("PREREQ") %>" 
                                    name="PREREQ" size="10">
                            </td>
    
                            <%-- Button --%>
                            <td>
                                <input type="submit" value="Update">
                            </td>
                        </form>
                        <form action="prereqs.jsp" method="get">
                            <input type="hidden" value="delete" name="action">
                            <input type="hidden" 
                                value="<%= rs.getInt("PREREQID") %>" name="PREREQID">
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
