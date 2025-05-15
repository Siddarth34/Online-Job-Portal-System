<%@ page import="java.sql.*, javax.servlet.http.HttpSession" %>
<%
    HttpSession s = request.getSession();
    Integer jobseekerId = (Integer) s.getAttribute("user_id");

    if (jobseekerId == null) {
        response.sendRedirect("../../html/login.html");
        return;
    }
%>

<style>
    .job-container {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(350px, 1fr));
        gap: 20px;
        padding: 20px;
        font-family: Arial, sans-serif;
    }

    .job-card {
        border: 1px solid #ccc;
        border-radius: 10px;
        padding: 20px;
        background-color: #f9f9f9;
        box-shadow: 0 4px 8px rgba(0,0,0,0.1);
    }

    .job-title {
        font-size: 18px;
        font-weight: bold;
        color: #004080;
    }

    .job-details {
        margin-top: 10px;
        color: #333;
    }

    .apply-form {
        margin-top: 15px;
    }

    .apply-button {
        background-color: #007bff;
        color: white;
        padding: 10px 16px;
        border: none;
        border-radius: 4px;
        font-size: 14px;
        cursor: pointer;
    }

    .apply-button:hover {
        background-color: #0056b3;
    }
</style>

<div class="job-container">
<%
    try {
        Class.forName("oracle.jdbc.driver.OracleDriver");
        Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "ojps", "root");

        String query = "SELECT job_id, job_title, company,industry,job_description,job_role, job_location, salary, job_type, experience_required FROM jobs ORDER BY posted_on DESC";
        PreparedStatement ps = con.prepareStatement(query);
        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
%>
    <div class="job-card">
        <div class="job-title"><%= rs.getString("job_title") %></div>
        <div class="job-details">
            <p><strong>Company:</strong> <%= rs.getString("company") %></p>
            <p><strong>Location:</strong> <%= rs.getString("job_location") %></p>
            <p><strong>Industry:</strong> <%= rs.getString("industry") %></p>
            <p><strong>Job Description:</strong> <%= rs.getString("job_description") %></p>
            <p><strong>Salary:</strong> <%= rs.getFloat("salary") %></p>
            <p><strong>Job Role:</strong> <%= rs.getString("job_role") %></p>
            <p><strong>Job Type:</strong> <%= rs.getString("job_type") %></p>
            <p><strong>Experience:</strong> <%= rs.getInt("experience_required") %> years</p>
        </div>

        <form class="apply-form" method="post" action="/ojp/applyJob">
            <input type="hidden" name="job_id" value="<%= rs.getInt("job_id") %>">
            <input type="submit" class="apply-button" value="Apply for Job">
        </form>
    </div>
<%
        }
        con.close();
    } catch (Exception e) {
        out.println("<p>Error: " + e.getMessage() + "</p>");
    }
%>
</div>
