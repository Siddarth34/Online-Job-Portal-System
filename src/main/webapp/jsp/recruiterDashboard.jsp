<%@ page import="java.sql.*"%>
<%@ page import="javax.servlet.http.HttpSession"%>
<%
    Integer recruiterId = (Integer) session.getAttribute("user_id");
    if (recruiterId == null) {
        response.sendRedirect("../html/login.html");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
<title>Recruiter Dashboard</title>
<link rel="stylesheet" href="../css/style.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
<script src="../js/script.js"></script>
<style>

footer {
    bottom: 0;
    width: 100%;
    height: 60px;
}
        
html, body {
    height: 100%;
    margin: 0;
    display: flex;
    flex-direction: column;
}

.main-content {
    flex: 1;
    padding: 20px;
    overflow-y: auto;
}

footer {
    height: 60px;
    background-color: #007bff; /* or your footer color */
    color: white;
    text-align: center;
    line-height: 60px;
}
        

.dashboard-container {
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
	margin-top: 0;
	font-size: 20px;
	border-bottom: 1px solid #ffffff66;
	padding-bottom: 10px;
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
	transition: background-color 0.3s;
	padding: 8px;
	border-radius: 4px;
}

.sidebar ul li a:hover {
	background-color: #0059b3;
}

.main-content {
	flex: 1;
	padding: 20px;
	background-color: #f0f8ff;
	box-sizing: border-box;
}

.main-content h2 {
	color: #004080;
}

@media ( max-width : 768px) {
	.dashboard-container {
		flex-direction: column;
	}
	.sidebar {
		width: 100%;
		display: flex;
		flex-direction: row;
		flex-wrap: wrap;
		justify-content: space-around;
	}
	.sidebar ul {
		display: flex;
		flex-wrap: wrap;
		gap: 10px;
	}
	.sidebar ul li {
		margin: 5px;
	}
	.sidebar ul li a {
		font-size: 14px;
		padding: 6px 10px;
	}
	.main-content {
		padding: 10px;
	}
}
</style>
</head>
<body>

	<!-- Header -->
	<header>
		<div class="header-row">
			<a href="../html/recruiter/index.html"><img src="../images/HirezyLogo.png" alt="Hirezy Logo" class="logo"></a>
			<div class="menu-toggle" id="menu-toggle">&#9776;</div>
		</div>

		<nav id="nav-menu">
            <a href="../html/recruiter/index.html">Home</a>
            <a href="../html/recruiter/about.html">About Us</a>
            <a href="../html/login.html">Logout</a>
        </nav>
		
	</header>

	<div class="dashboard-container">
		<!-- Sidebar (25%) -->
		<div class="sidebar">
			<h2>Recruiter Dashboard</h2>
			<ul>
				<li><a href="recruiterDashboard.jsp?view=myJobs">My Jobs</a></li>
				<li><a href="recruiterDashboard.jsp?view=createJob">Create
						Job</a></li>
				<li><a href="recruiterDashboard.jsp?view=updateJob">Update
						Job</a></li>
				<li><a href="recruiterDashboard.jsp?view=deleteJob">Delete
						Job</a></li>
			</ul>
		</div>

		<!-- Main Content (75%) -->
		<div class="main-content">
			<%
            String msg = request.getParameter("msg");
            if (msg != null) {
            %>
            <div class="message-box">
                <%= msg %>
            </div>
           <% 
            }			
			
			String view = request.getParameter("view");
			if (view != null) {
				switch (view) {
				case "myJobs":
			%>
            <jsp:include page="recruiter/viewRecruiterJobs.jsp" />
			<%
			break;
			case "createJob":
			%>
 			<jsp:include page="recruiter/createJob.jsp" />
			<%
			break;
			case "updateJob":
			%>
     		<jsp:include page="recruiter/updateJob.jsp" />
			<%
			break;
			case "deleteJob":
			%>
            <jsp:include page="recruiter/deleteJob.jsp" />
			<%
			break;
			}
			} else {
			%>
			<jsp:include page="recruiter/viewRecruiterJobs.jsp" />
			<%
			}
			%>
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
