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
                        // INSERT the degreereq attributes INTO the Student table.
                        PreparedStatement pstmt = conn.prepareStatement(
                            "INSERT INTO Degreereq VALUES (?, ?, ?, ?, ?, ?)");

                        pstmt.setInt(1, Integer.parseInt(request.getParameter("CONCID")));
                        pstmt.setString(2, request.getParameter("DEGREQDEGREENAME"));
                        pstmt.setString(3, request.getParameter("DEGREQCOURSE"));
                        pstmt.setString(4, request.getParameter("CONCENTRATION"));
                        pstmt.setDouble(5, Double.parseDouble(request.getParameter("MINGPA")));
                        pstmt.setInt(6, Integer.parseInt(request.getParameter("MINUNITS")));
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
                        // UPDATE the degreereq attributes in the Student table.
                        PreparedStatement pstmt = conn.prepareStatement(
                            "UPDATE Degreereq SET DEGREQDEGREENAME = ?, DEGREQCOURSE = ?, " +
                            "CONCENTRATION = ?, MINGPA = ?, MINUNITS = ? WHERE CONCID = ?");

                        pstmt.setString(1, request.getParameter("DEGREQDEGREENAME"));
                        pstmt.setString(2, request.getParameter("DEGREQCOURSE"));
                        pstmt.setString(3, request.getParameter("CONCENTRATION"));
                        pstmt.setDouble(4, Double.parseDouble(request.getParameter("MINGPA")));
                        pstmt.setInt(5, Integer.parseInt(request.getParameter("MINUNITS")));
                        pstmt.setInt(
                            6, Integer.parseInt(request.getParameter("CONCID")));
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
                        // DELETE the degreereq FROM the Student table.
                        PreparedStatement pstmt = conn.prepareStatement(
                            "DELETE FROM Degreereq WHERE CONCID = ?");

                        pstmt.setInt(
                            1, Integer.parseInt(request.getParameter("CONCID")));
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
                    // the degreereq attributes FROM the Student table.
                    ResultSet rs = statement.executeQuery
                        ("SELECT * FROM Degreereq");
            %>

            <!-- Add an HTML table header row to format the results -->
                <table border="1">
                    <tr>
                        <th>Concentration ID</th>
                        <th>Degree Name</th>
                        <th>Required Course</th>
			<th>Concentration</th>
			<th>Min GPA</th>
			<th>Min Units</th>
                        <th>Action</th>
                    </tr>
                    <tr>
                        <form action="degreereqs.jsp" method="get">
                            <input type="hidden" value="insert" name="action">
                            <th><input value="" name="CONCID" size="10"></th>
                            <th><input value="" name="DEGREQDEGREENAME" size="50"></th>
                            <th><input value="" name="DEGREQCOURSE" size="20"></th>
			    <th><input value="" name="CONCENTRATION" size="20"></th>
                            <th><input value="" name="MINGPA" size="10"></th>
                            <th><input value="" name="MINUNITS" size="10"></th>
                            <th><input type="submit" value="Insert"></th>
                        </form>
                    </tr>

            <%-- -------- Iteration Code -------- --%>
            <%
                    // Iterate over the ResultSet
        
                    while ( rs.next() ) {
        
            %>

                    <tr>
                        <form action="degreereqs.jsp" method="get">
                            <input type="hidden" value="update" name="action">

                            <%-- Get the CONCID, which is a number --%>
                            <td>
                                <input value="<%= rs.getInt("CONCID") %>" 
                                    name="CONCID" size="10">
                            </td>
    
                            <%-- Get the DEGREENAME --%>
                            <td>
                                <input value="<%= rs.getString("DEGREQDEGREENAME") %>" 
                                    name="DEGREQDEGREENAME" size="50">
                            </td>
    
                            <%-- Get the REQCOURSE --%>
                            <td>
                                <input value="<%= rs.getString("DEGREQCOURSE") %>"
                                    name="DEGREQCOURSE" size="20">
                            </td>
    
                            <%-- Get the CONCENTRATION --%>
                            <td>
                                <input value="<%= rs.getString("CONCENTRATION") %>" 
                                    name="CONCENTRATION" size="20">
                            </td>
    
                            <%-- Get the MINGPA, which is a double --%>
                            <td>
                                <input value="<%= rs.getDouble("MINGPA") %>" 
                                    name="MINGPA" size="10">
                            </td>
    
                            <%-- Get the MINUNITS, which is a number --%>
                            <td>
                                <input value="<%= rs.getInt("MINUNITS") %>" 
                                    name="MINUNITS" size="10">
                            </td>
    
                            <%-- Button --%>
                            <td>
                                <input type="submit" value="Update">
                            </td>
                        </form>
                        <form action="degreereqs.jsp" method="get">
                            <input type="hidden" value="delete" name="action">
                            <input type="hidden" 
                                value="<%= rs.getInt("CONCID") %>" name="CONCID">
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
