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
                        // INSERT the student attributes INTO the Review table.
                        PreparedStatement pstmt = conn.prepareStatement(
                            "INSERT INTO Review VALUES (?, ?, ?, ?)");

                        pstmt.setInt(
                            1, Integer.parseInt(request.getParameter("SECTIONID")));
                        pstmt.setString(2, request.getParameter("CLASSTYPE"));
                        pstmt.setString(3, request.getParameter("CLASSTIME"));
                       pstmt.setString(4, request.getParameter("CLASSDATE"));
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
                        // UPDATE the student attributes in the Review table.
                        PreparedStatement pstmt = conn.prepareStatement(
                            "UPDATE Review SET CLASSTYPE = ?, CLASSTIME = ?, " +
                            "CLASSDATE = ? WHERE SECTIONID = ?");

                        pstmt.setString(1, request.getParameter("CLASSTYPE"));
                        pstmt.setString(2, request.getParameter("CLASSTIME"));
                        pstmt.setString(3, request.getParameter("CLASSDATE"));
                        pstmt.setInt(
                            6, Integer.parseInt(request.getParameter("SECTIONID")));
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
                        // DELETE the student FROM the Review table.
                        PreparedStatement pstmt = conn.prepareStatement(
                            "DELETE FROM Review WHERE SECTIONID = ?");

                        pstmt.setInt(
                            1, Integer.parseInt(request.getParameter("SECTIONID")));
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
                    // the student attributes FROM the Review table.
                    ResultSet rs = statement.executeQuery
                        ("SELECT * FROM Review");
            %>

            <!-- Add an HTML table header row to format the results -->
                <table border="1">
                    <tr>
                        <th>SECTIONID</th>
                        <th>CLASSTYPE</th>
                        <th>CLASSTIME</th>
			            <th>CLASSDATE</th>
                        <th>Action</th>
                    </tr>
                    <tr>
                        <form action="reviews.jsp" method="get">
                            <input type="hidden" value="insert" name="action">
                            <th><input value="" name="SECTIONID" size="10"></th>
                            <th><input value="" name="CLASSTYPE" size="20"></th>
                            <th><input value="" name="CLASSTIME" size="10"></th>
			                <th><input value="" name="CLASSDATE" size="10"></th>
                            <th><input type="submit" value="Insert"></th>
                        </form>
                    </tr>

            <%-- -------- Iteration Code -------- --%>
            <%
                    // Iterate over the ResultSet
        
                    while ( rs.next() ) {
        
            %>

                    <tr>
                        <form action="reviews.jsp" method="get">
                            <input type="hidden" value="update" name="action">

                            <%-- Get the SECTIONID, which is a number --%>
                            <td>
                                <input value="<%= rs.getInt("SECTIONID") %>" 
                                    name="SECTIONID" size="10">
                            </td>
    
                            <%-- Get the CLASSTYPE --%>
                            <td>
                                <input value="<%= rs.getString("CLASSTYPE") %>" 
                                    name="CLASSTYPE" size="20">
                            </td>
    
                            <%-- Get the CLASSTIME --%>
                            <td>
                                <input value="<%= rs.getString("CLASSTIME") %>"
                                    name="CLASSTIME" size="10">
                            </td>
    
                            <%-- Get the CLASSDATE --%>
                            <td>
                                <input value="<%= rs.getString("CLASSDATE") %>" 
                                    name="CLASSDATE" size="10">
                            </td>
    
                            <%-- Button --%>
                            <td>
                                <input type="submit" value="Update">
                            </td>
                        </form>
                        <form action="reviews.jsp" method="get">
                            <input type="hidden" value="delete" name="action">
                            <input type="hidden" 
                                value="<%= rs.getInt("SECTIONID") %>" name="SECTIONID">
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
