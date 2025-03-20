document.addEventListener("DOMContentLoaded", function () {
  // Helper function to show an error message immediately after an input element
  function showError(inputElement, message) {
    const errorElem = document.createElement("div");
    errorElem.classList.add("error-message");
    errorElem.style.color = "red";
    errorElem.style.fontSize = "0.9em";
    errorElem.style.marginTop = "5px";
    errorElem.textContent = message;
    inputElement.insertAdjacentElement("afterend", errorElem);
  }

  // Helper function to remove existing error messages within a form
  function clearErrors(form) {
    form.querySelectorAll(".error-message").forEach((el) => el.remove());
  }

  // Change Password Form Validation
  // Make sure the form’s action matches the URL mapping (here we use "change-password")
  const form = document.querySelector("form[action='change-password']");
  if (form) {
    form.addEventListener("submit", function (e) {
      let isValid = true;
      clearErrors(form);

      // Validate Old Password (just check that it’s not empty; the BE will verify it)
      const oldPasswordInput = form.querySelector("input[name='oldPassword']");
      if (!oldPasswordInput.value.trim()) {
        showError(oldPasswordInput, "Old password is required.");
        isValid = false;
      }

      // Validate New Password
      const newPasswordInput = form.querySelector("input[name='newPassword']");
      const newPassword = newPasswordInput.value;
      // Regex: 6-50 characters, at least one uppercase letter, and at least one special character.
      const newPasswordRegex = /^(?=.*[A-Z])(?=.*[^a-zA-Z0-9]).{6,50}$/;
      if (!newPasswordRegex.test(newPassword)) {
        showError(
          newPasswordInput,
          "New password must be 6-50 characters and include at least one uppercase letter and one special character."
        );
        isValid = false;
      }

      // Validate Confirm Password matches New Password
      const confirmPasswordInput = form.querySelector("input[name='confirmPassword']");
      if (newPassword !== confirmPasswordInput.value) {
        showError(confirmPasswordInput, "Confirm password does not match new password.");
        isValid = false;
      }

      if (!isValid) {
        e.preventDefault();
      }
    });
  }
});
