<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard</title>
    <link rel="stylesheet" href="../css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <script src="../js/script.js"></script>
    <style>
        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background-color: #ffffff;
        }

        h2, h3 {
            color: #004080;
        }

        .container {
            display: flex;
            height: 100vh;
        }

        .sidebar {
            width: 250px;
            background-color: #004080;
            color: white;
            padding: 20px;
            box-sizing: border-box;
        }


        
        .sidebar h2 {
		    margin: 0 0 20px 0;
    		font-size: 22px;
    		padding-bottom: 10px;
    		text-align: center;
    		color: #ffffff;
    		border-bottom: 2px solid #ffffff66;
        }
        

        .sidebar ul {
            list-style: none;
            padding: 0;
        }

        .sidebar ul li {
            margin: 15px 0;
        }

        .sidebar ul li a {
            color: white;
            text-decoration: none;
            font-size: 16px;
            display: block;
            padding: 8px;
            border-radius: 4px;
            transition: background-color 0.3s;
        }

        .sidebar ul li a:hover {
            background-color: #0059b3;
        }

        .content {
            flex: 1;
            padding: 30px;
            background-color: #f0f8ff;
            box-sizing: border-box;
            overflow-y: auto;
        }

        @media (max-width: 768px) {
            .container {
                flex-direction: column;
                height: auto;
            }

            .sidebar {
                width: 100%;
                display: flex;
                flex-direction: row;
                flex-wrap: wrap;
                justify-content: space-around;
                padding: 15px;
            }

            .sidebar ul {
                display: flex;
                flex-wrap: wrap;
                gap: 10px;
                padding: 0;
            }

            .sidebar ul li {
                margin: 5px;
            }

            .sidebar ul li a {
                font-size: 14px;
                padding: 6px 10px;
            }

            .content {
                padding: 20px;
            }
            
            .message-box {
            background-color: #dff0d8;
            color: #3c763d;
            padding: 10px;
            border-radius: 5px;
            margin-bottom: 20px;
        }
            
        }
    </style>
</head>
<body>
    <!-- Header -->
    <header>
        <div class="header-row">
            <a href="../html/admin/index.html"><img src="../images/HirezyLogo.png" alt="Hirezy Logo" class="logo"></a>
            <div class="menu-toggle" id="menu-toggle">&#9776;</div>
        </div>

        <nav id="nav-menu">
            <a href="../html/admin/index.html">Home</a>
            <a href="../html/admin/about.html">About Us</a>
            <a href="../html/login.html">Logout</a>
        </nav>
    </header>

    <!-- Dashboard Container -->
    <div class="container">
        <!-- Sidebar Menu -->
        <div class="sidebar">
            <h2>Admin Dashboard</h2>
            <ul>
                <li><a href="adminDashboard.jsp?view=recruiters">Recruiters</a></li>
                <li><a href="adminDashboard.jsp?view=jobseekers">Jobseekers</a></li>
                <li><a href="adminDashboard.jsp?view=availableJobs">Available Jobs</a></li>
                <li><a href="adminDashboard.jsp?view=closedJobs">Closed Jobs</a></li>
            </ul>
        </div>

        <!-- Content Area -->
        <div class="content">
        	
<%-- Display Message Box if a message is passed --%>
<%
    String msg = request.getParameter("msg");
    if (msg != null) {
%>
    <div class="message-box">
        <%= msg %>
    </div>
<%
    }
%>
            <%
                String view = request.getParameter("view");
                if (view != null) {
                    switch (view) {
                        case "recruiters": %>
                            <jsp:include page="admin/viewRecruiters.jsp" />
                        <% break;
                        case "jobseekers": %>
                            <jsp:include page="admin/viewJobseekers.jsp" />
                        <% break;
                        case "availableJobs": %>
                            <jsp:include page="admin/viewAvailableJobs.jsp" />
                        <% break;
                        case "closedJobs": %>
                            <jsp:include page="admin/viewClosedJobs.jsp" />
                        <% break;
                    }
                } else {
            %>
            <jsp:include page="admin/viewRecruiters.jsp" />
            <% } %>
        </div>
    </div>

    <!-- Footer -->
    <footer>
        <p>&copy; Hirezy. All rights reserved.</p>
    <div class="footer-links">
        <a href="../html//links/privacy.html" target="_blank">Privacy Policy</a> |
        <a href="../html/links/terms.html" target="_blank">Terms of Service</a> |
        <a href="../html/links/faq.html" target="_blank">FAQs</a>
    </div>
    </footer>
</body>
</html>
