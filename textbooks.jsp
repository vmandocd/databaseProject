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
                            "INSERT INTO Textbook VALUES (?, ?, ?, ?, ?)");

                        pstmt.setInt(
                            1, Integer.parseInt(request.getParameter("CLASSBOOKID")));
                        pstmt.setInt(
                            2, Integer.parseInt(request.getParameter("ISBN")));
                        pstmt.setString(3, request.getParameter("AUTHOR"));
                        pstmt.setString(4, request.getParameter("BOOKTITLE"));
                        pstmt.setInt(
                            5, Integer.parseInt(request.getParameter("TEXTBOOKSECTIONID")));
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
                            "UPDATE Textbook SET ISBN = ?, AUTHOR = ?," +
                            "BOOKTITLE = ?, TEXTBOOKSECTIONID = ? WHERE CLASSBOOKID = ?");

                        pstmt.setInt(
                            1, Integer.parseInt(request.getParameter("ISBN")));
                        pstmt.setString(2, request.getParameter("AUTHOR"));
                        pstmt.setString(3, request.getParameter("BOOKTITLE"));
                        pstmt.setInt(
                            4, Integer.parseInt(request.getParameter("TEXTBOOKSECTIONID")));
                        pstmt.setInt(
                            5, Integer.parseInt(request.getParameter("CLASSBOOKID")));
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
                            "DELETE FROM Textbook WHERE CLASSBOOKID = ?");

                        pstmt.setInt(
                            1, Integer.parseInt(request.getParameter("CLASSBOOKID")));
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
                        ("SELECT * FROM Textbook");
            %>

            <!-- Add an HTML table header row to format the results -->
                <table border="1">
                    <tr>
                        <th>Class Material ID</th>
                        <th>ISBN</th>
                        <th>Author</th>
                        <th>Book Title</th>
			<th>Section ID</th>
                        <th>Action</th>
                    </tr>
                    <tr>
                        <form action="textbooks.jsp" method="get">
                            <input type="hidden" value="insert" name="action">
                            <th><input value="" name="CLASSBOOKID" size="10"></th>
                            <th><input value="" name="ISBN" size="20"></th>
                            <th><input value="" name="AUTHOR" size="40"></th>
                            <th><input value="" name="BOOKTITLE" size="40"></th>
			    <th><input value="" name="TEXTBOOKSECTIONID" size="10"></th>
                            <th><input type="submit" value="Insert"></th>
                        </form>
                    </tr>

            <%-- -------- Iteration Code -------- --%>
            <%
                    // Iterate over the ResultSet
        
                    while ( rs.next() ) {
        
            %>

                    <tr>
                        <form action="textbooks.jsp" method="get">
                            <input type="hidden" value="update" name="action">

                            <%-- Get the CLASSBOOKID, which is a number --%>
                            <td>
                                <input value="<%= rs.getInt("CLASSBOOKID") %>" 
                                    name="CLASSBOOKID" size="10">
                            </td>
    
                            <%-- Get the ISBN, which is a number --%>
                            <td>
                                <input value="<%= rs.getInt("ISBN") %>" 
                                    name="ISBN" size="20">
                            </td>
    
                            <%-- Get the Author --%>
                            <td>
                                <input value="<%= rs.getString("AUTHOR") %>" 
                                    name="AUTHOR" size="40">
                            </td>
    
                            <%-- Get the BOOKTITLE --%>
                            <td>
                                <input value="<%= rs.getString("BOOKTITLE") %>"
                                    name="BOOKTITLE" size="40">
                            </td>
    
                            <%-- Get the SECTIONID --%>
                            <td>
                                <input value="<%= rs.getInt("TEXTBOOKSECTIONID") %>"
                                    name="TEXTBOOKSECTIONID" size="10">
                            </td>
    
                            <%-- Button --%>
                            <td>
                                <input type="submit" value="Update">
                            </td>
                        </form>
                        <form action="textbooks.jsp" method="get">
                            <input type="hidden" value="delete" name="action">
                            <input type="hidden" 
                                value="<%= rs.getInt("CLASSBOOKID") %>" name="CLASSBOOKID">
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
