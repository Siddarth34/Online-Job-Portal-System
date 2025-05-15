<%@ page import="java.sql.*" %>
<%
    int userId = Integer.parseInt(request.getParameter("user_id"));
    
    try {
        // Load the JDBC driver and establish a connection to the database
        Class.forName("oracle.jdbc.driver.OracleDriver");
        Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "ojps", "root");
        
        // SQL query to update the is_active column to 0 (deactivate)
        String sql = "UPDATE users SET is_active = 0 WHERE user_id = ?";
        PreparedStatement ps = con.prepareStatement(sql);
        ps.setInt(1, userId);
        
        // Execute the update query
        int rowsUpdated = ps.executeUpdate();
        
        if (rowsUpdated > 0) {
            // If the deactivation was successful, redirect to the recruiters list page with a success message
            response.sendRedirect("../adminDashboard.jsp?msg=User deactivated successfully");
        } else {
            // If there was an issue, show an error message
            response.sendRedirect("../adminDashboard.jsp?msg=Error deactivating user");
        }
        
        // Close the connection
        con.close();
    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("../adminDashboard.jsp?msg=Error deactivating user");
    }
%>
