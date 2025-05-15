package jobseeker;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

public class ApplyJobServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        Integer jobseekerId = (Integer) session.getAttribute("user_id");

        if (jobseekerId == null) {
            response.sendRedirect("html/login.html");
            return;
        }

        String jobIdStr = request.getParameter("job_id");
        if (jobIdStr == null || jobIdStr.isEmpty()) {
            response.sendRedirect("jsp/jobseeker/jobsearch.jsp");
            return;
        }

        int jobId = Integer.parseInt(jobIdStr);
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "ojps", "root");

            // 1. Get recruiter_id from jobs table
            int recruiterId = -1;
            ps = con.prepareStatement("SELECT recruiter_id FROM jobs WHERE job_id = ?");
            ps.setInt(1, jobId);
            rs = ps.executeQuery();
            if (rs.next()) {
                recruiterId = rs.getInt("recruiter_id");
            } else {
                response.sendRedirect("jsp/jobseekerDashboard.jsp?status=invalidJob");
                return;
            }
            rs.close();
            ps.close();

            // 2. Get resume_path from users table
            String resumePath = null;
            ps = con.prepareStatement("SELECT resume_path FROM users WHERE user_id = ?");
            ps.setInt(1, jobseekerId);
            rs = ps.executeQuery();
            if (rs.next()) {
                resumePath = rs.getString("resume_path");
            }
            rs.close();
            ps.close();

            // 3. Check if already applied
            ps = con.prepareStatement("SELECT application_id FROM applications WHERE job_id = ? AND jobseeker_id = ?");
            ps.setInt(1, jobId);
            ps.setInt(2, jobseekerId);
            rs = ps.executeQuery();
            if (rs.next()) {
                // Already applied
                response.sendRedirect("jsp/jobseekerDashboard.jsp?status=alreadyApplied");
                return;
            }
            rs.close();
            ps.close();

            // 4. Insert new application
            ps = con.prepareStatement("INSERT INTO applications (application_id, jobseeker_id, recruiter_id, job_id, jobseeker_status, application_date, jobseeker_resume) VALUES (APPLICATION_SEQ.NEXTVAL, ?, ?, ?, 'Applied', SYSDATE, ?)");
            ps.setInt(1, jobseekerId);
            ps.setInt(2, recruiterId);
            ps.setInt(3, jobId);
            ps.setString(4, resumePath);

            int rows = ps.executeUpdate();
            if (rows > 0) {
                response.sendRedirect("jsp/jobseekerDashboard.jsp?status=success");
            } else {
                response.sendRedirect("jsp/jobseekerDashboard.jsp?status=failure");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("jsp/jobseekerDashboard.jsp?status=error");
        } finally {
            try { if (rs != null) rs.close(); } catch (Exception e) { e.printStackTrace(); }
            try { if (ps != null) ps.close(); } catch (Exception e) { e.printStackTrace(); }
            try { if (con != null) con.close(); } catch (Exception e) { e.printStackTrace(); }
        }
    }
}
