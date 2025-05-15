package recruiter;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

public class DeleteJobServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get the job ID from the form submission
        String jobId = request.getParameter("job_id");
        
        if (jobId != null && !jobId.isEmpty()) {
            Connection con = null;
            PreparedStatement ps = null;
            
            try {
                // Get database connection
                Class.forName("oracle.jdbc.driver.OracleDriver");
                con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "ojps", "root");
                
                // Delete the job from the database
                String sql = "DELETE FROM jobs WHERE job_id = ?";
                ps = con.prepareStatement(sql);
                ps.setInt(1, Integer.parseInt(jobId));
                
                int rowsAffected = ps.executeUpdate();
                
                if (rowsAffected > 0) {
                    // If the job was deleted successfully, redirect to a confirmation page
                    response.sendRedirect("jsp/recruiterDashboard.jsp?msg=Job+deleted+successfully");
                } else {
                    // If no job was deleted, show an error message
                    response.sendRedirect("jsp/recruiter/deleteJob.jsp?msg=Error:+Job+not+found+or+could+not+be+deleted");
                }
            } catch (Exception e) {
                e.printStackTrace();
                response.sendRedirect("jsp/recruiter/deleteJob.jsp?msg=Error:+Database+connection+failed");
            } finally {
                // Close resources
                try {
                    if (ps != null) ps.close();
                    if (con != null) con.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        } else {
            // If no job ID was selected, show an error message
            response.sendRedirect("jsp/recruiter/deleteJob.jsp?msg=Please+select+a+job+to+delete");
        }
    }
}
