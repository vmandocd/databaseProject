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
                            "INSERT INTO Classes VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");

                        pstmt.setString(1, request.getParameter("CLASSCOURSENUMBER"));
                        pstmt.setInt(2, Integer.parseInt(request.getParameter("SECTIONID")));
                        pstmt.setString(3, request.getParameter("CLASSTITLE"));
                        pstmt.setString(4, request.getParameter("CLASSQUARTER"));
                        pstmt.setInt(5, Integer.parseInt(request.getParameter("CLASSYEAR")));
                        pstmt.setString(6, request.getParameter("CLASSCURRENTLY"));
                        pstmt.setString(7, request.getParameter("CLASSNEXTQUARTER"));
                        pstmt.setInt(8, Integer.parseInt(request.getParameter("CLASSNEXTYEAR")));
                        pstmt.setInt(9, Integer.parseInt(request.getParameter("CLASSSECTIONLIMIT")));
                        pstmt.setInt(10, Integer.parseInt(request.getParameter("CLASSCURRENTENROLL")));
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
                            "UPDATE Classes SET CLASSCOURSENUMBER = ?, CLASSTITLE = ?, CLASSQUARTER = ?, " +
                            "CLASSYEAR = ?, CLASSCURRENTLY = ?, CLASSNEXTQUARTER = ?, CLASSNEXTYEAR = ?, " +
			    "CLASSSECTIONLIMIT = ?, CLASSCURRENTENROLL = ? WHERE SECTIONID = ?");

                        pstmt.setString(1, request.getParameter("CLASSCOURSENUMBER"));
                        pstmt.setString(2, request.getParameter("CLASSTITLE"));
                        pstmt.setString(3, request.getParameter("CLASSQUARTER"));
                        pstmt.setInt(4, Integer.parseInt(request.getParameter("CLASSYEAR")));
                        pstmt.setString(5, request.getParameter("CLASSCURRENTLY"));
                        pstmt.setString(6, request.getParameter("CLASSNEXTQUARTER"));
                        pstmt.setInt(7, Integer.parseInt(request.getParameter("CLASSNEXTYEAR")));
                        pstmt.setInt(8, Integer.parseInt(request.getParameter("CLASSSECTIONLIMIT")));
                        pstmt.setInt(9, Integer.parseInt(request.getParameter("CLASSCURRENTENROLL")));
                        pstmt.setInt(10, Integer.parseInt(request.getParameter("SECTIONID")));
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
                            "DELETE FROM Classes WHERE SECTIONID = ?");

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
                    // the student attributes FROM the Student table.
                    ResultSet rs = statement.executeQuery
                        ("SELECT * FROM Classes");
            %>

            <!-- Add an HTML table header row to format the results -->
                <table border="1">
                    <tr>
                        <th>Course Number</th>
                        <th>Section ID</th>
			<th>Class Title</th>
                        <th>Quarter Offered</th>
                        <th>Year Offered</th>
                        <th>Currently Offered</th>
                        <th>Next Quarter Offered</th>
                        <th>Next Year Offered</th>
                        <th>Enrollment limit</th>
                        <th>Current Enrolled</th>
                        <th>Action</th>
                    </tr>
                    <tr>
                        <form action="classes.jsp" method="get">
                            <input type="hidden" value="insert" name="action">
                            <th><input value="" name="CLASSCOURSENUMBER" size="20"></th>
                            <th><input value="" name="SECTIONID" size="10"></th>
                            <th><input value="" name="CLASSTITLE" size="50"></th>
                            <th><input value="" name="CLASSQUARTER" size="10"></th>
                            <th><input value="" name="CLASSYEAR" size="10"></th>
                            <th><input value="" name="CLASSCURRENTLY" size="10"></th>
                            <th><input value="" name="CLASSNEXTQUARTER" size="10"></th>
                            <th><input value="" name="CLASSNEXTYEAR" size="10"></th>
                            <th><input value="" name="CLASSSECTIONLIMIT" size="10"></th>
                            <th><input value="" name="CLASSCURRENTENROLL" size="10"></th>
                            <th><input type="submit" value="Insert"></th>
                        </form>
                    </tr>

            <%-- -------- Iteration Code -------- --%>
            <%
                    // Iterate over the ResultSet
        
                    while ( rs.next() ) {
        
            %>

                    <tr>
                        <form action="classes.jsp" method="get">
                            <input type="hidden" value="update" name="action">

                            <%-- Get the COURSENUMBER --%>
                            <td>
                                <input value="<%= rs.getString("CLASSCOURSENUMBER") %>" 
                                    name="CLASSCOURSENUMBER" size="20">
                            </td>
    
                            <%-- Get the SECTIONID, which is a number --%>
                            <td>
                                <input value="<%= rs.getInt("SECTIONID") %>" 
                                    name="SECTIONID" size="10">
                            </td>
    
                            <%-- Get the CLASSTITLE --%>
                            <td>
                                <input value="<%= rs.getString("CLASSTITLE") %>" 
                                    name="CLASSTITLE" size="50">
                            </td>
    
                            <%-- Get the CLASSQUARTER --%>
                            <td>
                                <input value="<%= rs.getString("CLASSQUARTER") %>"
                                    name="CLASSQUARTER" size="10">
                            </td>
    
                            <%-- Get the CLASSYEAR --%>
                            <td>
                                <input value="<%= rs.getInt("CLASSYEAR") %>"
                                    name="CLASSYEAR" size="10">
                            </td>
    
                            <%-- Get the CLASSCURRENTLY --%>
                            <td>
                                <input value="<%= rs.getString("CLASSCURRENTLY") %>"
                                    name="CLASSCURRENTLY" size="10">
                            </td>
    
                            <%-- Get the CLASSNEXTQUARTER --%>
                            <td>
                                <input value="<%= rs.getString("CLASSNEXTQUARTER") %>"
                                    name="CLASSNEXTQUARTER" size="10">
                            </td>
    
                            <%-- Get the CLASSNEXTYEAR --%>
                            <td>
                                <input value="<%= rs.getInt("CLASSNEXTYEAR") %>"
                                    name="CLASSNEXTYEAR" size="10">
                            </td>
    
                            <%-- Get the CLASSSECTIONLIMIT --%>
                            <td>
                                <input value="<%= rs.getInt("CLASSSECTIONLIMIT") %>"
                                    name="CLASSSECTIONLIMIT" size="10">
                            </td>
    
                            <%-- Get the CLASSCURRENTENROLL --%>
                            <td>
                                <input value="<%= rs.getInt("CLASSCURRENTENROLL") %>"
                                    name="CLASSCURRENTENROLL" size="10">
                            </td>
    
                            <%-- Button --%>
                            <td>
                                <input type="submit" value="Update">
                            </td>
                        </form>
                        <form action="classes.jsp" method="get">
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
