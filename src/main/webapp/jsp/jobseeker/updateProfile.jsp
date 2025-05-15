<%@ page import="java.sql.*, javax.servlet.http.*, javax.servlet.*" %>
<%
    Integer jobseekerId = (Integer) session.getAttribute("user_id");

    if (jobseekerId == null) {
        response.sendRedirect("../../html/login.html");
        return;
    }

    String fullName = "", gender = "", dob = "", education = "", skills = "", resumePath = "";
    int experience = 0;

    try {
        Class.forName("oracle.jdbc.driver.OracleDriver");
        Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "ojps", "root");

        PreparedStatement ps = con.prepareStatement("SELECT * FROM users WHERE user_id = ?");
        ps.setInt(1, jobseekerId);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            fullName = rs.getString("full_name");
            gender = rs.getString("gender");
            dob = rs.getString("date_of_birth");
            education = rs.getString("education");
            skills = rs.getString("skills");
            resumePath = rs.getString("resume_path");
            experience = rs.getInt("experience_years");
        }
        rs.close();
        ps.close();
        con.close();
    } catch (Exception e) {
        out.println("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
    }
%>

<html>
<head>
    <title>Update Profile - Jobseeker</title>
    <style>
/*         body {
            font-family: Arial, sans-serif;
            padding: 30px;
            background-color: #f2f2f2;
        } */

        #head {
            color: #004080;
            text-align: center;
        }

        form {
            background-color: white;
            padding: 25px;
            border-radius: 10px;
            max-width: 600px;
            margin: auto;
        }

        label {
            display: block;
            margin-top: 15px;
            font-weight: bold;
        }

        input[type="text"],
        input[type="date"],
        input[type="number"],
        textarea {
            width: 100%;
            padding: 8px;
            margin-top: 5px;
            border-radius: 5px;
            border: 1px solid #ccc;
        }

        input[type="submit"] {
            background-color: #007bff;
            color: white;
            padding: 10px 20px;
            margin-top: 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        input[type="submit"]:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>

<h2 id="head">Update Profile</h2>

<form action="/ojp/updateJobseekerProfile" method="post">
    <label>Full Name:</label>
    <input type="text" name="full_name" value="<%= fullName %>" required>

    <label>Gender:</label>
    <input type="text" name="gender" value="<%= gender %>" required>

    <label>Date of Birth:</label>
    <input type="date" name="dob" value="<%= dob %>" required>

    <label>Education:</label>
    <input type="text" name="education" value="<%= education %>">

    <label>Skills:</label>
    <textarea name="skills" rows="4"><%= skills %></textarea>

    <label>Years of Experience:</label>
    <input type="number" name="experience" value="<%= experience %>" min="0">

    <label>Resume Path (URL or file path):</label>
    <input type="text" name="resume_path" value="<%= resumePath %>">

    <input type="submit" value="Update Profile">
</form>

</body>
</html>
