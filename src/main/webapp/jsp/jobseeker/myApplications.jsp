<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%
    Integer jobseekerId = (Integer) session.getAttribute("user_id");

    if (jobseekerId == null) {
        response.sendRedirect("../../html/login.html");
        return;
    }
%>

<style>
    .jobs-container {
        padding: 20px;
        font-family: Arial, sans-serif;
    }

    .jobs-container h2 {
        color: #004080;
        text-align: center;
        margin-bottom: 20px;
    }

    .jobs-table {
        width: 100%;
        border-collapse: collapse;
    }

    .jobs-table th,
    .jobs-table td {
        border: 1px solid #ccc;
        padding: 10px;
        text-align: center;
        font-size: 14px;
    }

    .jobs-table th {
        background-color: #e6f0ff;
        color: #003366;
    }

    .jobs-table tr:nth-child(even) {
        background-color: #f9f9f9;
    }

    .no-jobs {
        text-align: center;
        padding: 20px;
        font-style: italic;
        color: #888;
    }

    @media (max-width: 768px) {
        .jobs-table th,
        .jobs-table td {
            font-size: 12px;
            padding: 8px;
        }
    }
</style>

<div class="jobs-container">
    <h2>Applied Jobs</h2>
    <table class="jobs-table">
        <tr>
            <th>Job Title</th>
            <th>Company</th>
            <th>Role</th>
            <th>Status</th>
            <th>Applied On</th>
            <th>Resume</th>
        </tr>

        <%
            try {
                Class.forName("oracle.jdbc.driver.OracleDriver");
                Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "ojps", "root");

                String sql = "SELECT j.job_title, j.company, j.job_role, a.jobseeker_status, a.application_date, a.jobseeker_resume " +
                             "FROM applications a " +
                             "JOIN jobs j ON a.job_id = j.job_id " +
                             "WHERE a.jobseeker_id = ?";
                PreparedStatement ps = con.prepareStatement(sql);
                ps.setInt(1, jobseekerId);

                ResultSet rs = ps.executeQuery();
                boolean hasResults = false;
                while (rs.next()) {
                    hasResults = true;
        %>
        <tr>
            <td><%= rs.getString("job_title") %></td>
            <td><%= rs.getString("company") %></td>
            <td><%= rs.getString("job_role") %></td>
            <td><%= rs.getString("jobseeker_status") %></td>
            <td><%= rs.getDate("application_date") %></td>
            <td><a href="<%= rs.getString("jobseeker_resume") %>">Download Resume</a></td>
        </tr>
        <%
                }
                if (!hasResults) {
        %>
        <tr>
            <td colspan="6" class="no-jobs">No jobs applied for yet.</td>
        </tr>
        <%
                }

                con.close();
            } catch (Exception e) {
                out.println("<tr><td colspan='6'>Error: " + e.getMessage() + "</td></tr>");
            }
        %>
    </table>
</div>
