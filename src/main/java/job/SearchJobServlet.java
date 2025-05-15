package job;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;
import java.util.*;

public class SearchJobServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String keyword = request.getParameter("keyword");
        String location = request.getParameter("location");
        String experienceStr = request.getParameter("experience");

        List<Map<String, String>> jobList = new ArrayList<>();
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "ojps", "root");

            String sql = "SELECT * FROM jobs WHERE 1=1";
            List<Object> params = new ArrayList<>();

            if (keyword != null && !keyword.trim().isEmpty()) {
                sql += " AND (LOWER(job_title) LIKE ? OR LOWER(company) LIKE ?)";
                String kw = "%" + keyword.toLowerCase() + "%";
                params.add(kw);
                params.add(kw);
            }

            if (location != null && !location.trim().isEmpty()) {
                sql += " AND LOWER(job_location) LIKE ?";
                params.add("%" + location.toLowerCase() + "%");
            }

            if (experienceStr != null && !experienceStr.trim().isEmpty()) {
                sql += " AND experience_required <= ?";
                params.add(Integer.parseInt(experienceStr));
            }

            ps = con.prepareStatement(sql);

            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }

            rs = ps.executeQuery();
            while (rs.next()) {
                Map<String, String> job = new HashMap<>();
                job.put("job_id", rs.getString("job_id"));
                job.put("job_title", rs.getString("job_title"));
                job.put("company", rs.getString("company"));
                job.put("location", rs.getString("job_location"));
                job.put("industry", rs.getString("industry"));
                job.put("job_role", rs.getString("job_role"));
                job.put("job_description", rs.getString("job_description"));
                job.put("salary", rs.getString("salary"));
                job.put("type", rs.getString("job_type"));
                job.put("experience", rs.getString("experience_required"));
                job.put("posted_on", rs.getString("posted_on"));
                jobList.add(job);
            }

            request.setAttribute("jobs", jobList);
            RequestDispatcher rd = request.getRequestDispatcher("jsp/searchJob.jsp");
            rd.forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.setContentType("text/html");
            PrintWriter out = response.getWriter();
            out.println("<html><head><title>Error</title></head><body>");
            out.println("<h3 style='color:red;'>An error occurred while searching for jobs.</h3>");
            out.println("<p>Please try again later.</p>");
            out.println("</body></html>");

        } finally {
            try { if (rs != null) rs.close(); } catch (Exception e) {}
            try { if (ps != null) ps.close(); } catch (Exception e) {}
            try { if (con != null) con.close(); } catch (Exception e) {}
        }
    }
}
