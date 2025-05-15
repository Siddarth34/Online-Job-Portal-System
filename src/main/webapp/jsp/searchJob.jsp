<%@ page import="java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Job Search Results</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <link rel="stylesheet" href="/ojp/css/style.css">
    <script src="/ojp/js/script.js"></script>
    <style>
    	/* Job Search Results Container */
.Result {
    max-width: 1000px;
    margin: 30px auto;
    padding: 20px;
    background-color: #ffffff;
    border-radius: 10px;
    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
}

.Result h2 {
    text-align: center;
    margin-bottom: 30px;
    color: #007BFF;
    font-size: 28px;
}

/* Job Card Styling */
.job-card {
    background-color: #f9f9f9;
    border: 1px solid #ddd;
    border-radius: 8px;
    padding: 20px;
    margin-bottom: 20px;
    box-shadow: 0 2px 6px rgba(0, 0, 0, 0.05);
    transition: transform 0.2s, box-shadow 0.3s;
}

.job-card:hover {
    transform: translateY(-3px);
    box-shadow: 0 4px 12px rgba(0, 123, 255, 0.2);
}

.job-card h3 {
    margin: 0 0 10px 0;
    font-size: 20px;
    color: #222;
}

.job-card p {
    margin: 6px 0;
    font-size: 15px;
    color: #444;
}

/* Apply Button */
.job-card form button {
    margin-top: 12px;
    background-color: #28a745;
    color: white;
    border: none;
    padding: 10px 20px;
    border-radius: 20px;
    cursor: pointer;
    font-weight: bold;
    transition: background-color 0.3s;
}

.job-card form button:hover {
    background-color: #218838;
}

/* Responsive Design for Job Cards */
@media (max-width: 768px) {
    .Result {
        padding: 15px;
    }

    .job-card {
        padding: 15px;
    }

    .job-card h3 {
        font-size: 18px;
    }

    .job-card p {
        font-size: 14px;
    }

    .job-card form button {
        width: 100%;
        padding: 10px;
        font-size: 15px;
    }
}

@media (max-width: 480px) {
    .Result h2 {
        font-size: 22px;
    }

    .job-card h3 {
        font-size: 16px;
    }

    .job-card p {
        font-size: 13px;
    }

    .job-card {
        padding: 12px;
    }
}
    	
    </style>
</head>
<body>

<header>
		<div class="header-row">
			<a href="ojp/html/index.html"><img src="/ojp/images/HirezyLogo.png" alt="Hirezy Logo" class="logo"></a>
			<div class="menu-toggle" id="menu-toggle">&#9776;</div>
		</div>

		<!-- Navigation placed ABOVE search bar -->
		<nav id="nav-menu">
			<a href="/ojp/html/index.html">Home</a>
			<a href="/ojp/html/about.html">About Us</a>
			<a href="/ojp/html/contact.html">Contact Us</a> 
			<a href="/ojp/html/signup.html">Sign up</a>
			<a href="/ojp/html/login.html">Login</a>
		</nav>

		<form class="search-bar" action="/ojp/searchJob" method="GET">
			<div class="search-field">
				<i class="fas fa-search"></i> <input type="text" name="keyword"
					placeholder="Search by Company/Job Title">
			</div>
			<div class="search-field">
				<i class="fas fa-map-marker-alt"></i> <input type="text"
					name="location" placeholder="Location">
			</div>
			<div class="search-field">
				<i class="fas fa-briefcase"></i> <input type="text"
					name="experience" placeholder="Experience">
			</div>
			<button type="submit">Search</button>
		</form>
	</header>

<div class="Result">
	    <h2>Search Results</h2>
    <%
        List<Map<String, String>> jobs = (List<Map<String, String>>) request.getAttribute("jobs");
        if (jobs == null || jobs.isEmpty()) {
    %>
        <p>No jobs found.</p>
    <%
        } else {
            for (Map<String, String> job : jobs) {
    %>
        <div class="job-card">
            <h3><%= job.get("job_title") %></h3>
            <p><strong>Company:</strong> <%= job.get("company") %></p>
            <p><strong>Location:</strong> <%= job.get("location") %></p>
            <p><strong>Industry:</strong> <%= job.get("industry") %></p>
            <p><strong>Role:</strong> <%= job.get("job_role") %></p>
            <p><strong>Job Description:</strong> <%= job.get("job_description") %></p>
            <p><strong>Salary:</strong> ₹<%= job.get("salary") %></p>
            <p><strong>Type:</strong> <%= job.get("type") %></p>
            <p><strong>Experience:</strong> <%= job.get("experience") %> years</p>
            <p><strong>Posted On:</strong> <%= job.get("posted_on") %></p>
            <form action="/ojp/html/login.html" method="get">
                <input type="hidden" name="job_id" value="<%= job.get("job_id") %>">
                <button type="submit">Apply</button>
            </form>
        </div>
    <%
            }
        }
    %>
</div>

    <!-- Footer -->
    <footer>
    <p>&copy; Hirezy. All rights reserved.</p>

    <div class="footer-links">
    <div class="footer-links">
        <a href="../html//links/privacy.html" target="_blank">Privacy Policy</a> |
        <a href="../html/links/terms.html" target="_blank">Terms of Service</a> |
        <a href="../html/links/faq.html" target="_blank">FAQs</a> |
        <a href="../html/contact.html">Contact Us</a>
    </div>
    </div>
</footer>


</body>
</html>
