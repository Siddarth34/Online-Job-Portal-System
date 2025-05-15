package registration;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

public class RecruiterSignupServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String fullName = request.getParameter("full_name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String gender = request.getParameter("gender");
        String dob = request.getParameter("date_of_birth");
        String companyName = request.getParameter("company_name");
        String contactPerson = request.getParameter("contact_person");
        String phone = request.getParameter("phone_number");
        String website = request.getParameter("company_website");
        String location = request.getParameter("location");
        String role = request.getParameter("role");

        try (Connection conn = DBConnection.getConnection()) {
            String query = "INSERT INTO USERS (user_id, full_name, email, password, role, gender, date_of_birth, company_name, contact_person, phone_number, company_website, location) VALUES (USERS_SEQ.NEXTVAL, ?, ?, ?, ?, ?, TO_DATE(?, 'YYYY-MM-DD'), ?, ?, ?, ?, ?)";

            PreparedStatement ps = conn.prepareStatement(query);
            ps.setString(1, fullName);
            ps.setString(2, email);
            ps.setString(3, password);
            ps.setString(4, role);
            ps.setString(5, gender);
            ps.setString(6, dob);
            ps.setString(7, companyName);
            ps.setString(8, contactPerson);
            ps.setString(9, phone);
            ps.setString(10, website);
            ps.setString(11, location);

            int result = ps.executeUpdate();
            response.setContentType("text/html");
            PrintWriter out = response.getWriter();
            if (result > 0) {
                out.println("<p align=\"center\">Recruiter Registration Successful</p>");
                out.println("<p align=\"center\"><a href=\"/ojp/html/login.html\">Go to login</a></p>");
            } else {
                out.println("<h3>Error occurred</h3>");
            }

        } 

        catch (Exception e) {
       	 PrintWriter out = response.getWriter();
       	 response.setContentType("text/html");
                out.println("<p align=\"center\">Duplicate value detected. Please use different email or phone.</p>");
                out.println("<p align=\"center\"><a href=\"/ojp/html/signup.html\">Back to registration</a></p>");   	     
        }

        

    }
}
