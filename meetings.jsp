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
                        // INSERT the student attributes INTO the Meeting table.
                        PreparedStatement pstmt = conn.prepareStatement(
                            "INSERT INTO Meeting VALUES (?, ?, ?, ?, ?, ?, ?, ?)");

                        pstmt.setInt(1, Integer.parseInt(request.getParameter("MEETINGID")));
                        pstmt.setInt(2, Integer.parseInt(request.getParameter("MEETINGSECTIONID")));
                        pstmt.setString(3, request.getParameter("CLASSLECDATE"));
                        pstmt.setString(4, request.getParameter("CLASSLECTIME"));
                        pstmt.setString(5, request.getParameter("CLASSDISDATE"));
                        pstmt.setString(6, request.getParameter("CLASSDISTIME"));
                        pstmt.setString(7, request.getParameter("CLASSLABDATE"));
                        pstmt.setString(8, request.getParameter("CLASSLABTIME"));
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
                        // UPDATE the student attributes in the Meeting table.
                        PreparedStatement pstmt = conn.prepareStatement(
                            "UPDATE Meeting SET MEETINGSECTIONID = ?, CLASSLECDATE = ?, CLASSLECTIME = ? " +
                            "CLASSDISDATE = ?, CLASSDISTIME = ?, CLASSLABDATE = ?, CLASSLABTIME = ? WHERE MEETINGID = ?");

                        pstmt.setInt(1, Integer.parseInt(request.getParameter("MEETINGSECTIONID")));
                        pstmt.setString(2, request.getParameter("CLASSLECDATE"));
                        pstmt.setString(3, request.getParameter("CLASSLECTIME"));
                        pstmt.setString(4, request.getParameter("CLASSDISDATE"));
                        pstmt.setString(5, request.getParameter("CLASSDISTIME"));
                        pstmt.setString(6, request.getParameter("CLASSLABDATE"));
                        pstmt.setString(7, request.getParameter("CLASSLABTIME"));
                        pstmt.setInt(8, Integer.parseInt(request.getParameter("MEETINGID")));
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
                        // DELETE the student FROM the Meeting table.
                        PreparedStatement pstmt = conn.prepareStatement(
                            "DELETE FROM Meeting WHERE MEETINGID = ?"); 

                        pstmt.setInt(
                            1, Integer.parseInt(request.getParameter("MEETINGID")));
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
                    // the student attributes FROM the Meeting table.
                    ResultSet rs = statement.executeQuery
                        ("SELECT * FROM Meeting");
            %>

            <!-- Add an HTML table header row to format the results -->
                <table border="1">
                    <tr>
                        <th>Meeting ID</th>
                        <th>Section ID</th>
                        <th>Lecture Date</th>
                        <th>Lecture Time</th>
			<th>Discussion Date</th>
                        <th>Discussion Time</th>
			<th>Lab Date</th>
                        <th>Lab Time</th>
                        <th>Action</th>
                    </tr>
                    <tr>
                        <form action="meetings.jsp" method="get">
                            <input type="hidden" value="insert" name="action">
                            <th><input value="" name="MEETINGID" size="10"></th>
                            <th><input value="" name="MEETINGSECTIONID" size="10"></th>
                            <th><input value="" name="CLASSLECDATE" size="30"></th>
                            <th><input value="" name="CLASSLECTIME" size="30"></th>
			    <th><input value="" name="CLASSDISDATE" size="30"></th>
                            <th><input value="" name="CLASSDISTIME" size="30"></th>
                            <th><input value="" name="CLASSLABDATE" size="30"></th>
                            <th><input value="" name="CLASSLABTIME" size="30"></th>
                            <th><input type="submit" value="Insert"></th>
                        </form>
                    </tr>

            <%-- -------- Iteration Code -------- --%>
            <%
                    // Iterate over the ResultSet
        
                    while ( rs.next() ) {
        
            %>

                    <tr>
                        <form action="meetings.jsp" method="get">
                            <input type="hidden" value="update" name="action">

                            <%-- Get the MEETINGID, which is a number --%>
                            <td>
                                <input value="<%= rs.getInt("MEETINGID") %>" 
                                    name="MEETINGID" size="10">
                            </td>
    
                            <%-- Get the SECTIONID, which is a number --%>
                            <td>
                                <input value="<%= rs.getInt("MEETINGSECTIONID") %>" 
                                    name="MEETINGSECTIONID" size="10">
                            </td>
    
                            <%-- Get the CLASSLECDATE --%>
                            <td>
                                <input value="<%= rs.getString("CLASSLECDATE") %>" 
                                    name="CLASSLECDATE" size="30">
                            </td>
    
                            <%-- Get the CLASSLECTIME --%>
                            <td>
                                <input value="<%= rs.getString("CLASSLECTIME") %>"
                                    name="CLASSLECTIME" size="30">
                            </td>
    
                            <%-- Get the CLASSDISDATE --%>
                            <td>
                                <input value="<%= rs.getString("CLASSDISDATE") %>" 
                                    name="CLASSDISDATE" size="30">
                            </td>
    
                            <%-- Get the CLASSDISTIME --%>
                            <td>
                                <input value="<%= rs.getString("CLASSDISTIME") %>"
                                    name="CLASSDISTIME" size="30">
                            </td>
    
                            <%-- Get the CLASSLABDATE --%>
                            <td>
                                <input value="<%= rs.getString("CLASSLABDATE") %>" 
                                    name="CLASSLABDATE" size="30">
                            </td>
    
                            <%-- Get the CLASSLABTIME --%>
                            <td>
                                <input value="<%= rs.getString("CLASSLABTIME") %>"
                                    name="CLASSLABTIME" size="30">
                            </td>
    
                            <%-- Button --%>
                            <td>
                                <input type="submit" value="Update">
                            </td>
                        </form>
                        <form action="meetings.jsp" method="get">
                            <input type="hidden" value="delete" name="action">
                            <input type="hidden" 
                                value="<%= rs.getInt("MEETINGID") %>" name="MEETINGID">
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
