package jobseeker;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

public class UpdateJobseekerProfileServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        Integer jobseekerId = (Integer) session.getAttribute("user_id");

        if (jobseekerId == null) {
            response.sendRedirect("../../html/login.html");
            return;
        }

        request.setCharacterEncoding("UTF-8");

        String fullName = request.getParameter("full_name");
        String gender = request.getParameter("gender");
        String dob = request.getParameter("dob");
        String education = request.getParameter("education");
        String skills = request.getParameter("skills");
        String resumePath = request.getParameter("resume_path");
        String expStr = request.getParameter("experience");

        int experienceYears = 0;
        try {
            experienceYears = Integer.parseInt(expStr);
        } catch (Exception e) {
            experienceYears = 0;
        }

        Connection con = null;
        PreparedStatement ps = null;

        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "ojps", "root");

            String sql = "UPDATE users SET full_name = ?, gender = ?, date_of_birth = TO_DATE(?, 'YYYY-MM-DD'), education = ?, skills = ?, experience_years = ?, resume_path = ?, updated_at = SYSTIMESTAMP WHERE user_id = ?";
            ps = con.prepareStatement(sql);
            ps.setString(1, fullName);
            ps.setString(2, gender);
            ps.setString(3, dob);
            ps.setString(4, education);
            ps.setString(5, skills);
            ps.setInt(6, experienceYears);
            ps.setString(7, resumePath);
            ps.setInt(8, jobseekerId);

            int rows = ps.executeUpdate();
            if (rows > 0) {
                response.sendRedirect("jsp/jobseekerDashboard.jsp?status=updateSuccess");
            } else {
                response.sendRedirect("jsp/jobseekerDashboard.jsp?status=updateFailed");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("jsp/jobseekerDashboard.jsp?status=error");
        } finally {
            try { if (ps != null) ps.close(); } catch (Exception e) {}
            try { if (con != null) con.close(); } catch (Exception e) {}
        }
    }
}
