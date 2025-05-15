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
    #form-wrapper {
        padding-bottom: 60px; /* ensures space above footer */
    }

    #form-container {
        max-width: 700px;
        margin: auto;
        background: #fff;
        padding: 20px;
        box-shadow: 0 0 10px rgba(0,0,0,0.1);
        font-family: Arial, sans-serif;
        border-radius: 5px;
    }

    #form-container h2 {
        text-align: center;
        color: #004080;
        margin-bottom: 20px;
    }

    #form-container label {
        display: block;
        margin-bottom: 5px;
        font-weight: bold;
        color: #333;
    }

    #form-container select,
    #form-container input[type="submit"] {
        width: 100%;
        padding: 10px;
        margin-bottom: 15px;
        border: 1px solid #ccc;
        border-radius: 4px;
        font-size: 14px;
    }

    #form-container input[type="submit"] {
        background-color: #dc3545;
        color: #fff;
        border: none;
        cursor: pointer;
    }

    #form-container input[type="submit"]:hover {
        background-color: #c82333;
    }

    @media (max-width: 600px) {
        #form-container {
            padding: 15px;
        }

        #form-container input,
        #form-container select {
            font-size: 13px;
        }
    }
</style>

<h2>Delete Job Posting</h2>

<div id="form-container">
    <form method="post" action="/ojp/deleteJob">
        <div id="form-wrapper">
            <label>Select Job to Delete:</label><br>
            <select name="job_id" required>
                <%
                    try {
                        Class.forName("oracle.jdbc.driver.OracleDriver");
                        Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "ojps", "root");
                        PreparedStatement ps = con.prepareStatement("SELECT job_id, job_title FROM jobs WHERE recruiter_id = ?");
                        ps.setInt(1, recruiterId);
                        ResultSet rs = ps.executeQuery();
                        while (rs.next()) {
                %>
                <option value="<%= rs.getInt("job_id") %>"><%= rs.getString("job_title") %></option>
                <%
                    }
                    con.close();
                } catch (Exception e) {
                    out.println("Error: " + e.getMessage());
                }
                %>
            </select><br><br>

            <input type="submit" value="Delete Job">
        </div>
    </form>
</div>
