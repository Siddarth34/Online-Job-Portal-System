<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%
    Integer recruiterId = (Integer) session.getAttribute("user_id");
    if (recruiterId == null) {
        response.sendRedirect("../html/login.html");
        return;
    }

    String jobIdParam = request.getParameter("jobId");
    int jobId = 0;

    if (jobIdParam != null) {
        jobId = Integer.parseInt(jobIdParam);
    } else {
        out.println("<h3 style='color:red; text-align:center;'>Invalid Job ID</h3>");
        return;
    }
%>

<html>
<head>
    <title>Applications for Job ID: <%= jobId %></title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f8ff;
            padding: 20px;
        }

        h2 {
            color: #004080;
            text-align: center;
            margin-bottom: 20px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 15px;
        }

        th, td {
            border: 1px solid #ccc;
            padding: 10px;
            text-align: center;
            font-size: 14px;
        }

        th {
            background-color: #e6f0ff;
            color: #003366;
        }

        tr:nth-child(even) {
            background-color: #f9f9f9;
        }

        .no-apps {
            text-align: center;
            color: #888;
            font-style: italic;
            margin-top: 20px;
        }

        a.download-link {
            color: #004080;
            text-decoration: underline;
        }

        .status-dropdown {
            padding: 5px;
            font-size: 14px;
        }
        
        .update-btn {
            background-color: #4CAF50;
            color: white;
            padding: 5px 10px;
            font-size: 14px;
            cursor: pointer;
            border: none;
        }

        .update-btn:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>

<h2>Applications for Job ID: <%= jobId %></h2>

<%
    try {
        Class.forName("oracle.jdbc.driver.OracleDriver");
        Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "ojps", "root");

        String query = "SELECT a.application_id, u.full_name, u.email, u.resume_path, a.jobseeker_status " +
                       "FROM applications a " +
                       "JOIN users u ON a.jobseeker_id = u.user_id " +
                       "WHERE a.recruiter_id = ? AND a.job_id = ?";

        PreparedStatement ps = con.prepareStatement(query);
        ps.setInt(1, recruiterId);
        ps.setInt(2, jobId);

        ResultSet rs = ps.executeQuery();

        boolean hasResults = false;
%>

<table>
    <tr>
        <th>Full Name</th>
        <th>Email</th>
        <th>Resume</th>
        <th>Status</th>
        <th>Update Status</th>
    </tr>

<%
        while (rs.next()) {
            hasResults = true;
            int applicationId = rs.getInt("application_id");
            String currentStatus = rs.getString("jobseeker_status");
%>
    <tr>
        <td><%= rs.getString("full_name") %></td>
        <td><%= rs.getString("email") %></td>
        <td>
            <% String resumePath = rs.getString("resume_path"); %>
            <a class="download-link" href="<%= resumePath %>" target="_blank">View Resume</a>
        </td>
        <td><%= currentStatus %></td>
        <td>
            <form method="post" action="/ojp/UpdateApplicationStatusServlet">
            	 <input type="hidden" name="jobId" value="<%= jobId %>" />
                <input type="hidden" name="applicationId" value="<%= applicationId %>">
                <select name="newStatus" class="status-dropdown">
                    <option value="Pending" <%= currentStatus.equals("Pending") ? "selected" : "" %>>Pending</option>
                    <option value="Accepted" <%= currentStatus.equals("Accepted") ? "selected" : "" %>>Accepted</option>
                    <option value="Rejected" <%= currentStatus.equals("Rejected") ? "selected" : "" %>>Rejected</option>
                </select>
                <button type="submit" class="update-btn">Update Status</button>
            </form>
        </td>
    </tr>
<%
        }

        if (!hasResults) {
%>
    <tr>
        <td colspan="5" class="no-apps">No applications found for this job.</td>
    </tr>
<%
        }

        con.close();
    } catch (Exception e) {
        out.println("<h3 style='color:red; text-align:center;'>Error: " + e.getMessage() + "</h3>");
    }
%>

</table>

</body>
</html>
