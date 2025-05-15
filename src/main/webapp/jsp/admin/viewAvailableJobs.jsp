<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Available Jobs</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #ffffff;
        }

        h2 {
            color: #004080;
            margin-bottom: 20px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            background-color: #f9f9f9;
            box-shadow: 0 2px 6px rgba(0,0,0,0.1);
        }

        th, td {
            padding: 12px 15px;
            text-align: left;
            border-bottom: 1px solid #ccc;
        }

        th {
            background-color: #cce0ff;
            color: #003366;
        }

        tr:hover {
            background-color: #e6f2ff;
        }
    </style>
</head>
<body>

<h2>Available Jobs</h2>
<table>
    <tr>
        <th>ID</th>
        <th>Job Title</th>
        <th>Company</th>
        <th>Location</th>
        <th>Industry</th>
        <th>Type</th>
        <th>Experience (Years)</th>
        <th>Salary</th>
        <th>Last Date to Apply</th>
    </tr>
<%
try {
    Class.forName("oracle.jdbc.driver.OracleDriver");
    Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "ojps", "root");
    PreparedStatement ps = con.prepareStatement(
        "SELECT * FROM jobs WHERE last_date_to_apply >= SYSDATE"
    );
    ResultSet rs = ps.executeQuery();
    while(rs.next()) {
%>
    <tr>
        <td><%= rs.getInt("job_id") %></td>
        <td><%= rs.getString("job_title") %></td>
        <td><%= rs.getString("company") %></td>
        <td><%= rs.getString("job_location") %></td>
        <td><%= rs.getString("industry") %></td>
        <td><%= rs.getString("job_type") %></td>
        <td><%= rs.getInt("experience_required") %></td>
        <td><%= rs.getFloat("salary") %></td>
        <td><%= rs.getDate("last_date_to_apply") %></td>
    </tr>
<%
    }
    con.close();
} catch(Exception e) {
    out.println("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
}
%>
</table>

</body>
</html>
