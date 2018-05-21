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
                        // INSERT the student attributes INTO the Degree table.
                        PreparedStatement pstmt = conn.prepareStatement(
                            "INSERT INTO Degree VALUES (?, ?, ?, ?, ?, ?, ?)");

                        pstmt.setString(1, request.getParameter("DEGREENAME"));
                        pstmt.setString(2, request.getParameter("DEGDEPARTMENTNAME"));
                        pstmt.setInt(3, Integer.parseInt(request.getParameter("TOTALUNITS")));
                        pstmt.setInt(4, Integer.parseInt(request.getParameter("LOWERUNITS")));
                        pstmt.setInt(5, Integer.parseInt(request.getParameter("UPPERUNITS")));
                        pstmt.setInt(6, Integer.parseInt(request.getParameter("TECHUNITS")));
                        pstmt.setInt(7, Integer.parseInt(request.getParameter("GRADUNITS")));
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
                        // UPDATE the student attributes in the Degree table.
                        PreparedStatement pstmt = conn.prepareStatement(
                            "UPDATE Degree SET DEGDEPARTMENTNAME = ?, TOTALUNITS = ?, LOWERUNITS = ?, " +
			    "UPPERUNITS = ?, TECHUNITS = ?, GRADUNITS = ? WHERE DEGREENAME = ?");

                        pstmt.setString(1, request.getParameter("DEGDEPARTMENTNAME"));
                        pstmt.setInt(2, Integer.parseInt(request.getParameter("TOTALUNITS")));
                        pstmt.setInt(3, Integer.parseInt(request.getParameter("LOWERUNITS")));
                        pstmt.setInt(4, Integer.parseInt(request.getParameter("UPPERUNITS")));
                        pstmt.setInt(5, Integer.parseInt(request.getParameter("TECHUNITS")));
                        pstmt.setInt(6, Integer.parseInt(request.getParameter("GRADUNITS")));
                        pstmt.setString(7, request.getParameter("DEGREENAME"));
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
                        // DELETE the student FROM the Degree table.
                        PreparedStatement pstmt = conn.prepareStatement(
                            "DELETE FROM Degree WHERE DEGREENAME = ?");

                        pstmt.setString(1, request.getParameter("DEGREENAME"));
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
                    // the student attributes FROM the Degree table.
                    ResultSet rs = statement.executeQuery
                        ("SELECT * FROM Degree");
            %>

            <!-- Add an HTML table header row to format the results -->
                <table border="1">
                    <tr>
                        <th>Degree Name</th>
			<th>Department</th>
                        <th>Total Units</th>
                        <th>Lower Units</th>
                        <th>Upper Units</th>
                        <th>Tech Units</th>
                        <th>Grad Units</th>
			<th>Action</th>
                    </tr>
                    <tr>
                        <form action="degrees.jsp" method="get">
                            <input type="hidden" value="insert" name="action">
                            <th><input value="" name="DEGREENAME" size="50"></th>
                            <th><input value="" name="DEGDEPARTMENTNAME" size="50"></th>
                            <th><input value="" name="TOTALUNITS" size="10"></th>
                            <th><input value="" name="LOWERUNITS" size="10"></th>
                            <th><input value="" name="UPPERUNITS" size="10"></th>
                            <th><input value="" name="TECHUNITS" size="10"></th>
                            <th><input value="" name="GRADUNITS" size="10"></th>
                            <th><input type="submit" value="Insert"></th>
                        </form>
                    </tr>

            <%-- -------- Iteration Code -------- --%>
            <%
                    // Iterate over the ResultSet
        
                    while ( rs.next() ) {
        
            %>

                    <tr>
                        <form action="degrees.jsp" method="get">
                            <input type="hidden" value="update" name="action">

                            <%-- Get the DEGREENAME --%>
                            <td>
                                <input value="<%= rs.getString("DEGREENAME") %>" 
                                    name="DEGREENAME" size="30">
                            </td>
    
                            <%-- Get the DEPARTMENTNAME --%>
                            <td>
                                <input value="<%= rs.getString("DEGDEPARTMENTNAME") %>" 
                                    name="DEGDEPARTMENTNAME" size="50">
                            </td>
    
                            <td>
                                <input value="<%= rs.getInt("TOTALUNITS") %>" 
                                    name="TOTALUNITS" size="10">
                            </td>
    
                            <td>
                                <input value="<%= rs.getInt("LOWERUNITS") %>" 
                                    name="LOWERUNITS" size="10">
                            </td>
    
                            <td>
                                <input value="<%= rs.getInt("UPPERUNITS") %>" 
                                    name="UPPERUNITS" size="10">
                            </td>
    
                            <td>
                                <input value="<%= rs.getInt("TECHUNITS") %>" 
                                    name="TECHUNITS" size="10">
                            </td>
    
                            <td>
                                <input value="<%= rs.getInt("GRADUNITS") %>" 
                                    name="GRADUNITS" size="10">
                            </td>
    
                            <%-- Button --%>
                            <td>
                                <input type="submit" value="Update">
                            </td>
                        </form>
                        <form action="degrees.jsp" method="get">
                            <input type="hidden" value="delete" name="action">
                            <input type="hidden" 
                                value="<%= rs.getString("DEGREENAME") %>" name="DEGREENAME">
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
