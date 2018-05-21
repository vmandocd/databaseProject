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
                            "INSERT INTO Graduate VALUES (?, ?, ?, ?, ?, ?)");

                        pstmt.setInt(
                            1, Integer.parseInt(request.getParameter("GRADSSN")));
                        pstmt.setString(2, request.getParameter("PHD"));
                        pstmt.setString(3, request.getParameter("MASTERS"));
                        pstmt.setString(4, request.getParameter("PRECANDIDATE"));
                        pstmt.setString(5, request.getParameter("CANDIDATE"));
                        pstmt.setString(6, request.getParameter("ADVISOR"));
                        pstmt.setString(7, request.getParameter("GRADDEGREENAME"));
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
                            "UPDATE Graduate SET PHD = ?, MASTERS = ?, PRECANDIDATE = ? " +
				"CANDIDATE = ?, ADVISOR = ?, GRADDEGREENAME = ? WHERE GRADSSN = ?");

                        pstmt.setString(1, request.getParameter("PHD"));
                        pstmt.setString(2, request.getParameter("MASTERS"));
			pstmt.setString(3, request.getParameter("PRECANDIDATE"));
                        pstmt.setString(4, request.getParameter("CANDIDATE"));
                        pstmt.setString(5, request.getParameter("ADVISOR"));
                        pstmt.setString(6, request.getParameter("GRADDEGREENAME"));
                        pstmt.setInt(
                            7, Integer.parseInt(request.getParameter("GRADSSN")));
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
                            "DELETE FROM Graduate WHERE GRADSSN = ?");

                        pstmt.setInt(
                            1, Integer.parseInt(request.getParameter("GRADSSN")));
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
                        ("SELECT * FROM Graduate");
            %>

            <!-- Add an HTML table header row to format the results -->
                <table border="1">
                    <tr>
                        <th>Student SSN</th>
                        <th>PhD (Yes/No)</th>
                        <th>Masters (Yes/No)</th>
			<th>Pre-Candidate (Yes/No)</th>
                        <th>Candidate (Yes/No)</th>
			<th>Advisor</th>
			<th>Degree</th>
                        <th>Action</th>
                    </tr>
                    <tr>
                        <form action="graduates.jsp" method="get">
                            <input type="hidden" value="insert" name="action">
                            <th><input value="" name="GRADSSN" size="10"></th>
                            <th><input value="" name="PHD" size="10"></th>
                            <th><input value="" name="MASTERS" size="10"></th>
			    <th><input value="" name="PRECANDIDATE" size="10"></th>
                            <th><input value="" name="CANDIDATE" size="10"></th>
                            <th><input value="" name="ADVISOR" size="20"></th>
                            <th><input value="" name="GRADDEGREENAME" size="50"></th>
                            <th><input type="submit" value="Insert"></th>
                        </form>
                    </tr>

            <%-- -------- Iteration Code -------- --%>
            <%
                    // Iterate over the ResultSet
        
                    while ( rs.next() ) {
        
            %>

                    <tr>
                        <form action="graduates.jsp" method="get">
                            <input type="hidden" value="update" name="action">

                            <%-- Get the GRADSSN --%>
                            <td>
                                <input value="<%= rs.getInt("GRADSSN") %>" 
                                    name="GRADSSN" size="10">
                            </td>
    
                            <%-- Get the PHD --%>
                            <td>
                                <input value="<%= rs.getString("PHD") %>" 
                                    name="PHD" size="10">
                            </td>
    
                            <%-- Get the MASTERS --%>
                            <td>
                                <input value="<%= rs.getString("MASTERS") %>" 
                                    name="MASTERS" size="10">
                            </td>
    
                            <%-- Get the PRECANDIDATE --%>
                            <td>
                                <input value="<%= rs.getString("PRECANDIDATE") %>" 
                                    name="PRECANDIDATE" size="10">
                            </td>
    
			    <%-- Get the CANDIDATE --%>
                            <td>
                                <input value="<%= rs.getString("CANDIDATE") %>" 
                                    name="CANDIDATE" size="10">
                            </td>

			    <%-- Get the ADVISOR --%>
                            <td>
                                <input value="<%= rs.getString("ADVISOR") %>" 
                                    name="ADVISOR" size="20">
                            </td>

			    <%-- Get the GRADDEGREENAME --%>
                            <td>
                                <input value="<%= rs.getString("GRADDEGREENAME") %>" 
                                    name="GRADDEGREENAME" size="50">
                            </td>

                            <%-- Button --%>
                            <td>
                                <input type="submit" value="Update">
                            </td>
                        </form>
                        <form action="graduates.jsp" method="get">
                            <input type="hidden" value="delete" name="action">
                            <input type="hidden" 
                                value="<%= rs.getInt("GRADSSN") %>" name="GRADSSN">
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
