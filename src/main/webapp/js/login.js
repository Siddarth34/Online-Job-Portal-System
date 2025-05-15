document.addEventListener("DOMContentLoaded", function () {
    const loginForm = document.querySelector("form");

    loginForm.addEventListener("submit", function (e) {
        const email = document.getElementById("email").value.trim();
        const password = document.getElementById("password").value.trim();

        // Basic email pattern
        const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

        // Clear any previous errors
        document.querySelectorAll(".error-msg").forEach(el => el.remove());
        document.querySelectorAll("input").forEach(el => el.classList.remove("error"));

        let isValid = true;

        if (!emailPattern.test(email)) {
            showError("email", "Please enter a valid email address.");
            isValid = false;
        }

        if (password.length < 6) {
            showError("password", "Password must be at least 6 characters.");
            isValid = false;
        }

        if (!isValid) {
            e.preventDefault(); // stop form submission
        }
    });

    function showError(fieldId, message) {
        const field = document.getElementById(fieldId);
        const error = document.createElement("div");
        error.classList.add("error-msg");  // Add a class for styling
        error.textContent = message;

        // Highlight the input field
        field.classList.add("error");

        field.parentNode.insertBefore(error, field.nextSibling);
    }

});
