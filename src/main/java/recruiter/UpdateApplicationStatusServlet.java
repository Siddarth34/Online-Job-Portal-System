package recruiter;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class UpdateApplicationStatusServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int applicationId = Integer.parseInt(request.getParameter("applicationId"));
        String status = request.getParameter("newStatus");
        int jobId = Integer.parseInt(request.getParameter("jobId"));

        try {
            // Database connection and update logic here
            Class.forName("oracle.jdbc.driver.OracleDriver");
            Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "ojps", "root");

            // Update status of the application
            String query = "UPDATE applications SET jobseeker_status = ? WHERE application_id = ? AND job_id = ?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1, status);
            ps.setInt(2, applicationId);
            ps.setInt(3, jobId);

            int rowsUpdated = ps.executeUpdate();

            if (rowsUpdated > 0) {
                // Redirect back to the applications page with the job ID
                response.sendRedirect("jsp/recruiter/applications.jsp?jobId=" + jobId);
            } else {
                // Handle case where no rows were updated
                response.sendRedirect("jsp/recruiter/applications.jsp?jobId=" + jobId + "&error=updateFailed");
            }

            con.close();
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("jsp/recruiter/applications.jsp?jobId=" + jobId + "&error=exception");
        }
    }
}
