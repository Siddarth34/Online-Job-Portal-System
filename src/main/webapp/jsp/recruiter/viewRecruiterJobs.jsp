<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%
    Integer recruiterId = (Integer) session.getAttribute("user_id");

    if (recruiterId == null) {
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
        overflow-x: auto;
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

    .view-applications {
        color: #004080;
        text-decoration: underline;
        cursor: pointer;
    }

    @media (max-width: 768px) {
        .jobs-table th,
        .jobs-table td {
            font-size: 12px;
            padding: 8px;
        }
    }

    @media (max-width: 480px) {
        .jobs-table {
            font-size: 11px;
        }
        .jobs-table th,
        .jobs-table td {
            padding: 6px;
        }
    }
</style>

<div class="jobs-container">
    <h2>My Posted Jobs</h2>
<div style="overflow-x: auto;">
    <table class="jobs-table">
        <tr>
            <th>Job ID</th>
            <th>Job Title</th>
            <th>Company</th>
            <th>Role</th>
            <th>Industry</th>
            <th>Location</th>
            <th>Salary</th>
            <th>Type</th>
            <th>Experience</th>
            <th>Posted On</th>
            <th>Last Date</th>
            <th>Actions</th>
        </tr>

        <%
            try {
                Class.forName("oracle.jdbc.driver.OracleDriver");
                Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "ojps", "root");

                String sql = "SELECT * FROM jobs WHERE recruiter_id = ?";
                PreparedStatement ps = con.prepareStatement(sql);
                ps.setInt(1, recruiterId);

                ResultSet rs = ps.executeQuery();
                boolean hasResults = false;
                while (rs.next()) {
                    hasResults = true;
        %>
        <tr>
            <td><%= rs.getInt("job_id") %></td>
            <td><%= rs.getString("job_title") %></td>
            <td><%= rs.getString("company") %></td>
            <td><%= rs.getString("job_role") %></td>
            <td><%= rs.getString("industry") %></td>
            <td><%= rs.getString("job_location") %></td>
            <td><%= rs.getFloat("salary") %></td>
            <td><%= rs.getString("job_type") %></td>
            <td><%= rs.getInt("experience_required") %> yrs</td>
            <td><%= rs.getDate("posted_on") %></td>
            <td><%= rs.getDate("last_date_to_apply") %></td>
            <td>
                <a href="recruiter/applications.jsp?jobId=<%= rs.getInt("job_id") %>" target="_blank" class="view-applications">View Applications</a>
            </td>
        </tr>
        <%
                }
                if (!hasResults) {
        %>
        <tr>
            <td colspan="12" class="no-jobs">No jobs posted yet.</td>
        </tr>
        <%
                }

                con.close();
            } catch (Exception e) {
                out.println("<tr><td colspan='12'>Error: " + e.getMessage() + "</td></tr>");
            }
        %>
    </table>
</div>
</div>
