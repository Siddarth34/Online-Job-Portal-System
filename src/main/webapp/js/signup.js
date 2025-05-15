document.addEventListener("DOMContentLoaded", function () {
  function showForm(role) {
    document.getElementById("jobseekerForm").style.display = (role === "jobseeker") ? "block" : "none";
    document.getElementById("recruiterForm").style.display = (role === "recruiter") ? "block" : "none";
  }

  window.showForm = showForm;

  function clearErrors(prefix) {
    let errorFields = document.querySelectorAll(`[id^="${prefix}_"][id$="_error"]`);
    errorFields.forEach(el => el.textContent = '');
  }

  document.getElementById('jobseekerForm').addEventListener('submit', function (e) {
    clearErrors('js');

    let valid = true;

    let name = document.getElementById('js_fullname');
    let email = document.getElementById('js_email');
    let password = document.getElementById('js_password');
    let phone = document.getElementById('js_phone');
    let gender = document.getElementById('js_gender');
    let dob = document.getElementById('js_dob');
    let resume = document.getElementById('js_resume_path');
	let experience = document.getElementById('js_experience');

    if (name.value === '') {
      document.getElementById('js_fullname_error').textContent = "Full name is required.";
      valid = false;
    }

    if (email.value === '') {
      document.getElementById('js_email_error').textContent = "Email is required.";
      valid = false;
    }

    if (password.value === '') {
      document.getElementById('js_password_error').textContent = "Password is required.";
      valid = false;
    }

    if (password.value.length < 6) {
      document.getElementById('js_password_error').textContent = "Password must be atleast 6 characters";
      valid = false;
    }

    if (gender.value === '') {
      document.getElementById('js_gender_error').textContent = "Gender is required.";
      valid = false;
    }

    if (dob.value === '') {
      document.getElementById('js_dob_error').textContent = "Date of birth is required.";
      valid = false;
    }
	
	if (experience.value === '') {
	  document.getElementById('js_exp_error').textContent = "Experience is required.";
	  valid = false;
	}

    if (phone.value === '') {
      document.getElementById('js_phone_error').textContent = "Phone number is  required.";
      valid = false;
    }

    if (phone.value !== '' && phone.value.length !== 10) {
      document.getElementById('js_phone_error').textContent = "Phone number must be 10 digits.";
      valid = false;
    }

    if (resume.value === '') {
      document.getElementById('js_resume_path_error').textContent = "Resume is required.";
      valid = false;
    }

    if (resume.value !== '' && !/^https?:\/\/[^\s]+$/.test(resume.value)) {
      document.getElementById('js_resume_path_error').textContent = "Invalid URL format.";
      valid = false;
    }

    if (!valid) {
      e.preventDefault();
    }
  });

  document.getElementById('recruiterForm').addEventListener('submit', function (e) {
    clearErrors('rec');

    let valid = true;

    let name = document.getElementById('rec_fullname');
    let email = document.getElementById('rec_email');
    let password = document.getElementById('rec_password');
    let phone = document.getElementById('rec_phone');
    let gender = document.getElementById('rec_gender');
    let dob = document.getElementById('rec_dob');

    if (name.value === '') {
      document.getElementById('rec_fullname_error').textContent = "Full name is required.";
      valid = false;
    }

    if (email.value === '') {
      document.getElementById('rec_email_error').textContent = "Email is required.";
      valid = false;
    }

    if (password.value === '') {
      document.getElementById('rec_password_error').textContent = "Password is required.";
      valid = false;
    }

    if (gender.value === '') {
      document.getElementById('rec_gender_error').textContent = "Gender is required.";
      valid = false;
    }

    if (dob.value === '') {
      document.getElementById('rec_dob_error').textContent = "Date of birth is required.";
      valid = false;
    }

    if (phone.value === '') {
      document.getElementById('rec_phone_error').textContent = "Phone number is  required.";
      valid = false;
    }

    if (phone.value !== '' && phone.value.length !== 10) {
      document.getElementById('rec_phone_error').textContent = "Phone number must be 10 digits.";
      valid = false;
    }

    if (!valid) {
      e.preventDefault();
    }
  });
});
