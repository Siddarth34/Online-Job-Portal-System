package registration;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

public class JobseekerSignupServlet extends HttpServlet {
 protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
     String fullName = request.getParameter("full_name");
     String email = request.getParameter("email");
     String password = request.getParameter("password");
     String gender = request.getParameter("gender");
     String dob = request.getParameter("date_of_birth");
     String education = request.getParameter("education");
     String skills = request.getParameter("skills");
     String experience = request.getParameter("experience_years");
     String resumePath = request.getParameter("resume_path");
     String phone = request.getParameter("phone_number");
     String location = request.getParameter("location");
     String role = request.getParameter("role");

     try (Connection conn = DBConnection.getConnection()) {
         String query = "INSERT INTO USERS (user_id, full_name, email, password, role, gender, date_of_birth, education, skills, experience_years, resume_path, phone_number, location) VALUES (USERS_SEQ.NEXTVAL, ?, ?, ?, ?, ?, TO_DATE(?, 'YYYY-MM-DD'), ?, ?, ?, ?, ?, ?)";

         PreparedStatement ps = conn.prepareStatement(query);
         ps.setString(1, fullName);
         ps.setString(2, email);
         ps.setString(3, password);
         ps.setString(4, role);
         ps.setString(5, gender);
         ps.setString(6, dob);
         ps.setString(7, education);
         ps.setString(8, skills);
         ps.setString(9, experience);
         ps.setString(10, resumePath);
         ps.setString(11, phone);
         ps.setString(12, location);

         int result = ps.executeUpdate();
         response.setContentType("text/html");
         PrintWriter out = response.getWriter();
         if (result > 0) {
             out.println("<p align=\"center\">Jobseeker Registration Successful</p>");
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
