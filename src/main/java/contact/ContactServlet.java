package contact; 

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.http.*;


public class ContactServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String role = request.getParameter("role");
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String message = request.getParameter("message");

        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "ojps", "root");

            String sql = "INSERT INTO CONTACT_MESSAGES (message_id, role, name, email, message, submitted_at) VALUES (contact_msg_seq.NEXTVAL, ?, ?, ?, ?, SYSDATE)";

            stmt = conn.prepareStatement(sql);
            stmt.setString(1, role);
            stmt.setString(2, name);
            stmt.setString(3, email);
            stmt.setString(4, message);

            int result=stmt.executeUpdate();
            response.setContentType("text/html");
            PrintWriter out = response.getWriter();
            if (result > 0) {
                out.println("<p align=\"center\">Message Submitted</p>");
                out.println("<p align=\"center\"><a href=\"/ojp/html/index.html\">Click to go home</a></p>");
            } else {
                out.println("<h3>Message not submitted</h3>");
            }

            
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        } finally {
            try { if (stmt != null) stmt.close(); } catch (Exception e) {}
            try { if (conn != null) conn.close(); } catch (Exception e) {}
        }
    }
}
