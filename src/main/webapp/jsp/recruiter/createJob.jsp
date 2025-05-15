<%@ page import="javax.servlet.http.HttpSession" %>
<%
    Integer recruiterId = (Integer) session.getAttribute("user_id");
    if (recruiterId == null) {
        response.sendRedirect("../../html/login.html");
        return;
    }
%>


<style>
    .form-wrapper {
        padding-bottom: 60px; /* ensures space above footer */
    }

    .form-container {
        max-width: 900px;
        margin: auto;
        background: #fff;
        padding: 25px;
        box-shadow: 0 0 10px rgba(0,0,0,0.1);
        font-family: Arial, sans-serif;
        border-radius: 10px;
    }

    .form-container h2 {
        text-align: center;
        color: #004080;
        margin-bottom: 20px;
    }

    .form-grid {
        display: grid;
        grid-template-columns: 1fr 1fr;
        gap: 20px;
    }

    .form-group {
        display: flex;
        flex-direction: column;
    }

    .form-group.full-width {
        grid-column: 1 / -1;
    }

    .form-group label {
        margin-bottom: 5px;
        font-weight: bold;
        color: #333;
    }

    .form-group input[type="text"],
    .form-group input[type="number"],
    .form-group input[type="date"],
    .form-group textarea {
        padding: 10px;
        border: 1px solid #ccc;
        border-radius: 4px;
        font-size: 14px;
    }

    .form-group textarea {
        resize: vertical;
    }

    .form-container input[type="submit"] {
        grid-column: 1 / -1;
        background-color: #007bff;
        color: #fff;
        border: none;
        padding: 12px;
        border-radius: 4px;
        font-size: 16px;
        cursor: pointer;
    }

    .form-container input[type="submit"]:hover {
        background-color: #0056b3;
    }

    @media (max-width: 768px) {
        .form-grid {
            grid-template-columns: 1fr;
        }
    }
</style>



<div class="form-container">
    <h2>Create New Job</h2>
    <div class="form-wrapper">
        <form action="/ojp/createJob" method="post" class="form-grid">

            <div class="form-group">
                <label>Job Title:</label>
                <input type="text" name="job_title" required>
            </div>

            <div class="form-group">
                <label>Company:</label>
                <input type="text" name="company" required>
            </div>

            <div class="form-group">
                <label>Industry:</label>
                <input type="text" name="industry" required>
            </div>

            <div class="form-group">
                <label>Location:</label>
                <input type="text" name="job_location" required>
            </div>

            <div class="form-group">
                <label>Salary:</label>
                <input type="number" step="0.01" name="salary" required>
            </div>

            <div class="form-group">
                <label>Job Type:</label>
                <input type="text" name="job_type" required>
            </div>

            <div class="form-group">
                <label>Experience Required (Years):</label>
                <input type="number" name="experience_required">
            </div>

            <div class="form-group">
                <label>Last Date to Apply:</label>
                <input type="date" name="last_date_to_apply" required>
            </div>

            <div class="form-group">
                <label>Job Role:</label>
                <input type="text" name="job_role" required>
            </div>

            <div class="form-group full-width">
                <label>Job Description:</label>
                <textarea name="job_description" rows="4" cols="50"></textarea>
            </div>

            <input type="submit" value="Create Job">
        </form>
    </div>
</div>
