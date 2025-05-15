package recruiter;

import java.io.IOException;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class CreateJobServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user_id") == null) {
            response.sendRedirect("html/login.html");
            return;
        }

        int recruiterId = (int) session.getAttribute("user_id");

        String jobTitle = request.getParameter("job_title");
        String company = request.getParameter("company");
        String industry = request.getParameter("industry");
        String location = request.getParameter("job_location");
        float salary = Float.parseFloat(request.getParameter("salary"));
        String jobType = request.getParameter("job_type");
        int experience = Integer.parseInt(request.getParameter("experience_required"));
        String lastDate = request.getParameter("last_date_to_apply");
        String jobRole = request.getParameter("job_role");
        String jobDescription = request.getParameter("job_description");

        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "ojps", "root");

            PreparedStatement ps = con.prepareStatement(
                "INSERT INTO jobs (job_id, company, posted_on, last_date_to_apply, recruiter_id, job_role, job_description, job_title, industry, job_location, salary, job_type, experience_required) " +
                "VALUES (JOB_SEQ.NEXTVAL, ?, SYSDATE, TO_DATE(?, 'YYYY-MM-DD'), ?, ?, ?, ?, ?, ?, ?, ?, ?)");

            ps.setString(1, company);
            ps.setString(2, lastDate);
            ps.setInt(3, recruiterId);
            ps.setString(4, jobRole);
            ps.setString(5, jobDescription);
            ps.setString(6, jobTitle);
            ps.setString(7, industry);
            ps.setString(8, location);
            ps.setFloat(9, salary);
            ps.setString(10, jobType);
            ps.setInt(11, experience);

            int rows = ps.executeUpdate();

            con.close();
            response.sendRedirect("jsp/recruiterDashboard.jsp?view=myJobs");
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        }
    }
}

