<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>All Recruiters</title>
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

<h2>All Recruiters</h2>
<table>
    <tr>
        <th>ID</th>
        <th>Name</th>
        <th>Email</th>
        <th>Company</th>
        <th>Action</th>
    </tr>
<%
try {
    Class.forName("oracle.jdbc.driver.OracleDriver");
    Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "ojps", "root");
    PreparedStatement ps = con.prepareStatement("SELECT * FROM users WHERE role='recruiter' AND is_active = 1");
    ResultSet rs = ps.executeQuery();
    while(rs.next()) {
%>
    <tr>
        <td><%= rs.getInt("user_id") %></td>
        <td><%= rs.getString("full_name") %></td>
        <td><%= rs.getString("email") %></td>
        <td><%= rs.getString("company_name") %></td>
        <td>
            <a href="admin/deactivateUser.jsp?user_id=<%= rs.getInt("user_id") %>">Deactivate</a>
        </td>
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



