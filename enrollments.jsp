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
                            "INSERT INTO Enrollment VALUES (?, ?, ?, ?)");

                        pstmt.setInt(
                            1, Integer.parseInt(request.getParameter("ENROLLID")));
                        pstmt.setInt(
                            2, Integer.parseInt(request.getParameter("ENROLLSSN")));
                        pstmt.setInt(
                            3, Integer.parseInt(request.getParameter("ENROLLSECTIONID")));
                        pstmt.setString(4, request.getParameter("ENROLLGRADEOPT"));
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
                            "UPDATE Enrollment SET ENROLLSSN = ?, ENROLLSECTIONID = ?, " +
                            "ENROLLGRADEOPT WHERE ENROLLID = ?");

                        pstmt.setInt(
                            1, Integer.parseInt(request.getParameter("ENROLLSSN")));
                        pstmt.setInt(
                            2, Integer.parseInt(request.getParameter("ENROLLSECTIONID")));
                        pstmt.setString(3, request.getParameter("ENROLLGRADEOPT"));
                        pstmt.setInt(
                            4, Integer.parseInt(request.getParameter("ENROLLID")));
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
                            "DELETE FROM Enrollment WHERE ENROLLID = ?");

                        pstmt.setInt(
                            1, Integer.parseInt(request.getParameter("ENROLLID")));
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
                        ("SELECT * FROM Enrollment");
            %>

            <!-- Add an HTML table header row to format the results -->
                <table border="1">
                    <tr>
                        <th>Enrollment ID</th>
                        <th>Student SSN</th>
                        <th>Section ID</th>
                        <th>Grade Option</th>
                        <th>Action</th>
                    </tr>
                    <tr>
                        <form action="enrollments.jsp" method="get">
                            <input type="hidden" value="insert" name="action">
                            <th><input value="" name="ENROLLID" size="10"></th>
                            <th><input value="" name="ENROLLSSN" size="10"></th>
                            <th><input value="" name="ENROLLSECTIONID" size="10"></th>
                            <th><input value="" name="ENROLLGRADEOPT" size="20"></th>
                            <th><input type="submit" value="Insert"></th>
                        </form>
                    </tr>

            <%-- -------- Iteration Code -------- --%>
            <%
                    // Iterate over the ResultSet
        
                    while ( rs.next() ) {
        
            %>

                    <tr>
                        <form action="enrollments.jsp" method="get">
                            <input type="hidden" value="update" name="action">

                            <%-- Get the ENROLLID, which is a number --%>
                            <td>
                                <input value="<%= rs.getInt("ENROLLID") %>" 
                                    name="ENROLLID" size="10">
                            </td>

                            <%-- Get the STUDENTSSN, which is a number --%>
                            <td>
                                <input value="<%= rs.getInt("ENROLLSSN") %>" 
                                    name="ENROLLSSN" size="10">
                            </td>
    
                            <%-- Get the SECTIONID, which is a number --%>
                            <td>
                                <input value="<%= rs.getInt("ENROLLSECTIONID") %>" 
                                    name="ENROLLSECTIONID" size="10">
                            </td>

                            <%-- Get the GRADEOPT --%>
                            <td>
                                <input value="<%= rs.getString("ENROLLGRADEOPT") %>"
                                    name="ENROLLGRADEOPT" size="20">
                            </td>
    
                            <%-- Button --%>
                            <td>
                                <input type="submit" value="Update">
                            </td>
                        </form>
                        <form action="enrollments.jsp" method="get">
                            <input type="hidden" value="delete" name="action">
                            <input type="hidden" 
                                value="<%= rs.getInt("ENROLLID") %>" name="ENROLLID">
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
