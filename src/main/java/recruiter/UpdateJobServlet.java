package recruiter;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

public class UpdateJobServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        int jobId = Integer.parseInt(request.getParameter("job_id"));
        String title = request.getParameter("job_title");
        String desc = request.getParameter("job_description");
        String location = request.getParameter("job_location");
        float salary = Float.parseFloat(request.getParameter("salary"));
        String jobType = request.getParameter("job_type");
        int experience = Integer.parseInt(request.getParameter("experience_required"));

        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "ojps", "root");

            PreparedStatement ps = con.prepareStatement(
                "UPDATE jobs SET job_title=?, job_description=?, job_location=?, salary=?, job_type=?, experience_required=? WHERE job_id=?");

            ps.setString(1, title);
            ps.setString(2, desc);
            ps.setString(3, location);
            ps.setFloat(4, salary);
            ps.setString(5, jobType);
            ps.setInt(6, experience);
            ps.setInt(7, jobId);

            int i = ps.executeUpdate();
            con.close();

            if (i > 0) {
                response.sendRedirect("jsp/recruiterDashboard.jsp?view=myJobs");
            } else {
                response.getWriter().println("Error: Job not updated.");
            }
        } catch (Exception e) {
            response.getWriter().println("Error: " + e.getMessage());
        }
    }
}
