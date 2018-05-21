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
                        // INSERT the student attributes INTO the Committee table.
                        PreparedStatement pstmt = conn.prepareStatement(
                            "INSERT INTO Committee VALUES (?, ?, ?, ?, ?, ?)");

                        pstmt.setInt(
                            1, Integer.parseInt(request.getParameter("COMMITTEEID")));
                        pstmt.setInt(
                            2, Integer.parseInt(request.getParameter("TCSSN")));
                        pstmt.setString(3, request.getParameter("TCFACULTYNAME1"));
                        pstmt.setString(4, request.getParameter("TCFACULTYNAME2"));
                        pstmt.setString(5, request.getParameter("TCFACULTYNAME3"));
                        pstmt.setString(6, request.getParameter("TCPHDADVISOR"));
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
                        // UPDATE the student attributes in the Committee table.
                        PreparedStatement pstmt = conn.prepareStatement(
                            "UPDATE Committee SET TCSSN = ?, TCFACULTYNAME1 = ?, TCFACULTYNAME2 = ?, " +
			    "TCFACULTYNAME3 = ?, TCPHDADVISOR = ? WHERE COMMITTEEID = ?");

                        pstmt.setInt(
                            1, Integer.parseInt(request.getParameter("TCSSN")));
                        pstmt.setString(2, request.getParameter("TCFACULTYNAME1"));
                        pstmt.setString(3, request.getParameter("TCFACULTYNAME2"));
                        pstmt.setString(4, request.getParameter("TCFACULTYNAME3"));
                        pstmt.setString(5, request.getParameter("TCPHDADVISOR"));
                        pstmt.setInt(
                            6, Integer.parseInt(request.getParameter("COMMITTEEID")));
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
                        // DELETE the student FROM the Committee table.
                        PreparedStatement pstmt = conn.prepareStatement(
                            "DELETE FROM Committee WHERE COMMITTEEID = ?");

                        pstmt.setInt(
                            1, Integer.parseInt(request.getParameter("COMMITTEEID")));
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
                    // the student attributes FROM the Committee table.
                    ResultSet rs = statement.executeQuery
                        ("SELECT * FROM Committee");
            %>

            <!-- Add an HTML table header row to format the results -->
                <table border="1">
                    <tr>
                        <th>Committee ID</th>
                        <th>Student SSN</th>
                        <th>Thesis Advisor 1</th>
                        <th>Thesis Advisor 2</th>
                        <th>Thesis Advisor 3</th>
                        <th>PhD Advisor</th>
                        <th>Action</th>
                    </tr>
                    <tr>
                        <form action="committees.jsp" method="get">
                            <input type="hidden" value="insert" name="action">
                            <th><input value="" name="COMMITTEEID" size="10"></th>
                            <th><input value="" name="TCSSN" size="10"></th>
                            <th><input value="" name="TCFACULTYNAME1" size="20"></th>
                            <th><input value="" name="TCFACULTYNAME2" size="20"></th>
                            <th><input value="" name="TCFACULTYNAME3" size="20"></th>
                            <th><input value="" name="TCPHDADVISOR" size="20"></th>
                            <th><input type="submit" value="Insert"></th>
                        </form>
                    </tr>

            <%-- -------- Iteration Code -------- --%>
            <%
                    // Iterate over the ResultSet
        
                    while ( rs.next() ) {
        
            %>

                    <tr>
                        <form action="committees.jsp" method="get">
                            <input type="hidden" value="update" name="action">

                            <%-- Get the COMMITTEEID, which is a number --%>
                            <td>
                                <input value="<%= rs.getInt("COMMITTEEID") %>" 
                                    name="COMMITTEEID" size="10">
                            </td>
    
                            <%-- Get the STUDENTSSN --%>
                            <td>
                                <input value="<%= rs.getString("TCSSN") %>" 
                                    name="TCSSN" size="10">
                            </td>
    
                            <%-- Get the FACULTYNAME --%>
                            <td>
                                <input value="<%= rs.getString("TCFACULTYNAME1") %>"
                                    name="TCFACULTYNAME1" size="20">
                            </td>
    
                            <%-- Get the FACULTYNAME --%>
                            <td>
                                <input value="<%= rs.getString("TCFACULTYNAME2") %>"
                                    name="TCFACULTYNAME2" size="20">
                            </td>
    
                            <%-- Get the FACULTYNAME --%>
                            <td>
                                <input value="<%= rs.getString("TCFACULTYNAME3") %>"
                                    name="TCFACULTYNAME3" size="20">
                            </td>
    
                            <%-- Get the PHDADVISOR --%>
                            <td>
                                <input value="<%= rs.getString("TCPHDADVISOR") %>"
                                    name="TCPHDADVISOR" size="20">
                            </td>
    
                            <%-- Button --%>
                            <td>
                                <input type="submit" value="Update">
                            </td>
                        </form>
                        <form action="committees.jsp" method="get">
                            <input type="hidden" value="delete" name="action">
                            <input type="hidden" 
                                value="<%= rs.getInt("COMMITTEEID") %>" name="COMMITTEEID">
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
