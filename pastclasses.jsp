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
                        // INSERT the student attributes INTO the PastClass table.
                        PreparedStatement pstmt = conn.prepareStatement(
                            "INSERT INTO Pastclass VALUES (?, ?, ?, ?, ?, ?, ?)");

                        pstmt.setInt(
                            1, Integer.parseInt(request.getParameter("PASTCLASSID")));
                        pstmt.setInt(
                            2, Integer.parseInt(request.getParameter("PCSSN")));
                        pstmt.setString(3, request.getParameter("PCCOURSENUMBER"));
                        pstmt.setString(4, request.getParameter("PCQUARTER"));
                        pstmt.setInt(
                            5, Integer.parseInt(request.getParameter("PCYEAR")));
                        pstmt.setString(6, request.getParameter("PCGRADEOPT"));
                        pstmt.setString(7, request.getParameter("PCGRADE"));
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
                        // UPDATE the student attributes in the PastClass table.
                        PreparedStatement pstmt = conn.prepareStatement(
                            "UPDATE Pastclass SET PCSSN = ?, PCCOURSENUMBER = ?, " +
                            "PCQUARTER = ?, PCYEAR = ?, PCGRADEOPT = ?, PCGRADE = ? WHERE PASTCLASSID = ?");

                        pstmt.setInt(
                            1, Integer.parseInt(request.getParameter("PCSSN")));
                        pstmt.setString(2, request.getParameter("PCCOURSENUMBER"));
                        pstmt.setString(3, request.getParameter("PCQUARTER"));
                        pstmt.setInt(
                            4, Integer.parseInt(request.getParameter("PCYEAR")));
                        pstmt.setString(5, request.getParameter("PCGRADEOPT"));
                        pstmt.setString(6, request.getParameter("PCGRADE"));
                        pstmt.setInt(
                            7, Integer.parseInt(request.getParameter("PASTCLASSID")));
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
                        // DELETE the student FROM the PastClass table.
                        PreparedStatement pstmt = conn.prepareStatement(
                            "DELETE FROM Pastclass WHERE PASTCLASSID = ?");

                        pstmt.setInt(
                            1, Integer.parseInt(request.getParameter("PASTCLASSID")));
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
                    // the student attributes FROM the PastClass table.
                    ResultSet rs = statement.executeQuery
                        ("SELECT * FROM Pastclass");
            %>

            <!-- Add an HTML table header row to format the results -->
                <table border="1">
                    <tr>
                        <th>Past Class ID</th>
                        <th>Student ID</th>
                        <th>Course Number</th>
                        <th>Quarter Offered</th>
                        <th>Year Offered</th>
                        <th>Grade Option</th>
                        <th>Grade</th>
                        <th>Action</th>
                    </tr>
                    <tr>
                        <form action="pastclasses.jsp" method="get">
                            <input type="hidden" value="insert" name="action">
                            <th><input value="" name="PASTCLASSID" size="10"></th>
                            <th><input value="" name="PCSSN" size="10"></th>
                            <th><input value="" name="PCCOURSENUMBER" size="20"></th>
                            <th><input value="" name="PCQUARTER" size="10"></th>
                            <th><input value="" name="PCYEAR" size="10"></th>
                            <th><input value="" name="PCGRADEOPT" size="20"></th>
                            <th><input value="" name="PCGRADE" size="20"></th>
                            <th><input type="submit" value="Insert"></th>
                        </form>
                    </tr>

            <%-- -------- Iteration Code -------- --%>
            <%
                    // Iterate over the ResultSet
        
                    while ( rs.next() ) {
        
            %>

                    <tr>
                        <form action="pastclasses.jsp" method="get">
                            <input type="hidden" value="update" name="action">

                            <%-- Get the PASTCLASSID, which is a number --%>
                            <td>
                                <input value="<%= rs.getInt("PASTCLASSID") %>" 
                                    name="PASTCLASSID" size="10">
                            </td>

                            <%-- Get the STUDENTSSN, which is a number --%>
                            <td>
                                <input value="<%= rs.getInt("PCSSN") %>" 
                                    name="PCSSN" size="10">
                            </td>
    
                            <%-- Get the COURSENUMBER --%>
                            <td>
                                <input value="<%= rs.getString("PCCOURSENUMBER") %>" 
                                    name="PCCOURSENUMBER" size="20">
                            </td>
    
                            <%-- Get the QUARTER --%>
                            <td>
                                <input value="<%= rs.getString("PCQUARTER") %>"
                                    name="PCQUARTER" size="10">
                            </td>
    
                            <%-- Get the YEAR --%>
                            <td>
                                <input value="<%= rs.getInt("PCYEAR") %>" 
                                    name="PCYEAR" size="10">
                            </td>
    
			    <%-- Get the GRADEOPT --%>
                            <td>
                                <input value="<%= rs.getString("PCGRADEOPT") %>" 
                                    name="PCGRADEOPT" size="20">
                            </td>
    
			    <%-- Get the GRADE --%>
                            <td>
                                <input value="<%= rs.getString("PCGRADE") %>" 
                                    name="PCGRADE" size="20">
                            </td>
    
                            <%-- Button --%>
                            <td>
                                <input type="submit" value="Update">
                            </td>
                        </form>
                        <form action="pastclasses.jsp" method="get">
                            <input type="hidden" value="delete" name="action">
                            <input type="hidden" 
                                value="<%= rs.getInt("PASTCLASSID") %>" name="PASTCLASSID">
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
