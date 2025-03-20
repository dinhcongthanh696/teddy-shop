document.addEventListener("DOMContentLoaded", function () {
  // Helper function to remove existing error messages within a form
  function clearErrors(form) {
    form.querySelectorAll(".error-message").forEach((el) => el.remove());
  }

  // Helper function to show an error message immediately after an input element
  function showError(inputElement, message) {
    const errorElem = document.createElement("div");
    errorElem.classList.add("error-message");
    errorElem.style.color = "red";
    errorElem.style.fontSize = "0.9em";
    errorElem.style.marginTop = "5px";
    errorElem.textContent = message;
    // Insert the error message directly after the input element
    inputElement.insertAdjacentElement("afterend", errorElem);
  }

  // ===== Registration Form Validation =====
  const regForm = document.getElementById("registrationForm");
  if (regForm) {
    regForm.addEventListener("submit", function (e) {
      let isValid = true;
      clearErrors(regForm);

      // Validate Email
      const emailInput = regForm.querySelector("input[name='email']");
      const email = emailInput.value.trim();
      const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
      if (!emailRegex.test(email)) {
        showError(emailInput, "Invalid email format.");
        isValid = false;
      }

      // Validate Username (only letters, numbers, underscore allowed)
      const usernameInput = regForm.querySelector("input[name='username']");
      const username = usernameInput.value.trim();
      const usernameRegex = /^[a-zA-Z0-9_]+$/;
      if (!username) {
        showError(usernameInput, "Username cannot be empty.");
        isValid = false;
      } else if (!usernameRegex.test(username)) {
        showError(usernameInput, "Username must contain only letters, numbers, and underscores.");
        isValid = false;
      }

      // Validate Phone (must start with 0 and be exactly 10 digits)
      const phoneInput = regForm.querySelector("input[name='phone']");
      const phone = phoneInput.value.trim();
      const phoneRegex = /^0\d{9}$/;
      if (!phoneRegex.test(phone)) {
        showError(phoneInput, "Phone number must start with 0 and have 10 digits.");
        isValid = false;
      }

      // Validate Location (cannot be empty and less than 100 characters)
      const locationInput = regForm.querySelector("input[name='location']");
      const location = locationInput.value.trim();
      if (!location) {
        showError(locationInput, "Location cannot be empty.");
        isValid = false;
      } else if (location.length >= 100) {
        showError(locationInput, "Location must be less than 100 characters.");
        isValid = false;
      }

      // Validate Password
      const passwordInput = regForm.querySelector("input[name='password']");
      const password = passwordInput.value;
      // Regex: At least one uppercase letter, one special character, and total length between 6 and 50
      const passwordRegex = /^(?=.*[A-Z])(?=.*[^a-zA-Z0-9]).{6,50}$/;
      if (!passwordRegex.test(password)) {
        showError(
          passwordInput,
          "Password must be 6-50 characters, contain at least one uppercase letter and one special character."
        );
        isValid = false;
      }

      // Validate Confirm Password
      const confirmPasswordInput = regForm.querySelector("input[name='confirm_password']");
      const confirmPassword = confirmPasswordInput.value;
      if (password !== confirmPassword) {
        showError(confirmPasswordInput, "Passwords do not match.");
        isValid = false;
      }

      if (!isValid) {
        e.preventDefault();
      }
    });
  }

  // ===== Login Form Validation =====
  const loginForm = document.getElementById("loginForm");
  if (loginForm) {
    loginForm.addEventListener("submit", function (e) {
      let isValid = true;
      clearErrors(loginForm);

      // Validate Username (if needed)
      const usernameInput = loginForm.querySelector("input[name='username']");
      const username = usernameInput.value.trim();
      if (!username) {
        showError(usernameInput, "Username cannot be empty.");
        isValid = false;
      }
      // (Optional) Add further username validation if desired.

      // Validate Password (ensure it's not empty)
      const passwordInput = loginForm.querySelector("input[name='password']");
      const password = passwordInput.value;
      if (!password) {
        showError(passwordInput, "Password cannot be empty.");
        isValid = false;
      }

      if (!isValid) {
        e.preventDefault();
      }
    });
  }
});
