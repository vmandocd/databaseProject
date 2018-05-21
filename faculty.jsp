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
                            "INSERT INTO Faculty VALUES (?, ?, ?)");

                        pstmt.setString(1, request.getParameter("FACULTYNAME"));
                        pstmt.setString(2, request.getParameter("FACULTYTITLE"));
                        pstmt.setString(3, request.getParameter("FACDEPARTMENTNAME"));
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
                            "UPDATE Faculty SET FACULTYTITLE = ?, FACDEPARTMENTNAME = ? " +
                            "WHERE FACULTYNAME = ?");

                        pstmt.setString(1, request.getParameter("FACULTYNAME"));
                        pstmt.setString(2, request.getParameter("FACDEPARTMENTNAME"));
                        pstmt.setString(3, request.getParameter("FACULTYTITLE"));
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
                            "DELETE FROM Faculty WHERE FACULTYNAME = ?");

                        pstmt.setString(1, request.getParameter("FACULTYNAME"));
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
                        ("SELECT * FROM Faculty");
            %>

            <!-- Add an HTML table header row to format the results -->
                <table border="1">
                    <tr>
                        <th>Faculty Name</th>
                        <th>Faculty Title</th>
                        <th>Department Name</th>
                        <th>Action</th>
                    </tr>
                    <tr>
                        <form action="faculty.jsp" method="get">
                            <input type="hidden" value="insert" name="action">
                            <th><input value="" name="FACULTYNAME" size="20"></th>
                            <th><input value="" name="FACULTYTITLE" size="20"></th>
                            <th><input value="" name="FACDEPARTMENTNAME" size="50"></th>
                            <th><input type="submit" value="Insert"></th>
                        </form>
                    </tr>

            <%-- -------- Iteration Code -------- --%>
            <%
                    // Iterate over the ResultSet
        
                    while ( rs.next() ) {
        
            %>

                    <tr>
                        <form action="faculty.jsp" method="get">
                            <input type="hidden" value="update" name="action">

                            <%-- Get the FACULTYNAME--%>
                            <td>
                                <input value="<%= rs.getString("FACULTYNAME") %>" 
                                    name="FACULTYNAME" size="20">
                            </td>
    
                            <%-- Get the FACULTYTITLE --%>
                            <td>
                                <input value="<%= rs.getString("FACULTYTITLE") %>" 
                                    name="FACULTYTITLE" size="20">
                            </td>
    
                            <%-- Get the FACDEPARTMENTNAME --%>
                            <td>
                                <input value="<%= rs.getString("FACDEPARTMENTNAME") %>" 
                                    name="FACDEPARTMENTNAME" size="50">
                            </td>
    
                            <%-- Button --%>
                            <td>
                                <input type="submit" value="Update">
                            </td>
                        </form>
                        <form action="faculty.jsp" method="get">
                            <input type="hidden" value="delete" name="action">
                            <input type="hidden" 
                                value="<%= rs.getString("FACULTYNAME") %>" name="FACULTYNAME">
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
