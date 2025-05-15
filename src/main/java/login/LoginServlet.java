package login;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "ojps", "root");
            PreparedStatement ps = con.prepareStatement("SELECT user_id,role FROM users WHERE email=? AND password=?");
            ps.setString(1, email);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();
            
            response.setContentType("text/html");
            PrintWriter out = response.getWriter();

            if (rs.next()) {
            	int userId = rs.getInt("user_id");
                String role = rs.getString("role");
                
                HttpSession session = request.getSession();
                session.setAttribute("user_id", userId);
                session.setAttribute("role", role);                

                switch(role) {
                    case "admin": response.sendRedirect("jsp/adminDashboard.jsp"); break;
                    case "recruiter": response.sendRedirect("jsp/recruiterDashboard.jsp"); break;
                    case "jobseeker": response.sendRedirect("jsp/jobseekerDashboard.jsp"); break;
                    default:out.println("<p align=\"center\">Invalid role.</p>");
                    out.println("<p align=\"center\"><a href=\"/ojp/html/login.html\">Back to login</a></p>");
                }
            } else {
                out.println("<p align=\"center\">Invalid Credentials.</p>");
                out.println("<p align=\"center\"><a href=\"/ojp/html/login.html\">Back to login</a></p>");
//                response.sendRedirect("login.jsp?error=Invalid credentials");
                
            }
        } catch (Exception e) {
            response.setContentType("text/html");
            PrintWriter out = response.getWriter();
            out.println("<p align=\"center\">Invalid Credentials.</p>");
            out.println("<p align=\"center\"><a href=\"/ojp/html/login.html\">Back to login</a></p>");
//            e.printStackTrace();
//            response.sendRedirect("login.jsp?error=Server error");
        }
    }
}
