<%@page contentType="text/html" pageEncoding="UTF-8"%> <%@ taglib
uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>Content Management</title>
    <link
      rel="stylesheet"
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
    />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <link
      rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-colorpicker/3.4.0/css/bootstrap-colorpicker.min.css"
    />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-colorpicker/3.4.0/js/bootstrap-colorpicker.min.js"></script>
    <link
      href="https://cdn.jsdelivr.net/npm/@simonwep/pickr/dist/themes/classic.min.css"
      rel="stylesheet"
    />
    <script src="https://cdn.jsdelivr.net/npm/@simonwep/pickr/dist/pickr.min.js"></script>
    <style>
      .color-picker-wrapper {
        display: flex;
        align-items: center;
        gap: 10px;
      }
      .color-preview {
        width: 40px;
        height: 40px;
        border-radius: 4px;
        border: 1px solid #ddd;
      }

      .pcr-button {
        border: 1px solid #ccc;
        border-style: dashed;
      }
    </style>
  </head>

  <body style="margin-top: 80px">
    <jsp:include page="${contextPath}/gui/header.jsp"></jsp:include>

    <div class="container mt-5" style="margin-bottom: 10px">
      <div class="card">
        <div class="card-header">
          <h2 class="mb-0">Website Content Management</h2>
        </div>
        <div class="card-body">
          <form
            action="${pageContext.request.contextPath}/manager/content-management"
            method="POST"
          >
            <!-- Website Name Section -->
            <div class="mb-4">
              <h4>Website Name</h4>
              <input
                type="text"
                class="form-control"
                name="webName"
                value="${content.webName}"
                required
              />
            </div>

            <!-- Header Settings Section -->
            <div class="row mb-4">
              <h4>Header Settings</h4>
              <div class="col-md-6 mb-3">
                <label>Text Color</label>
                <div class="color-picker-wrapper">
                  <input
                    type="text"
                    class="form-control"
                    name="headerTextColor"
                    id="headerTextColor"
                    value="${content.headerTextColor}"
                    required
                  />
                  <div class="color-preview" id="headerTextColorPicker"></div>
                </div>
              </div>
              <div class="col-md-6 mb-3">
                <label>Background Color</label>
                <div class="color-picker-wrapper">
                  <input
                    type="text"
                    class="form-control"
                    name="headerBackgroundColor"
                    id="headerBackgroundColor"
                    value="${content.headerBackgroundColor}"
                    required
                  />
                  <div
                    class="color-preview"
                    id="headerBackgroundColorPicker"
                  ></div>
                </div>
              </div>
            </div>

            <!-- Footer Settings Section -->
            <div class="row mb-4">
              <h4>Footer Settings</h4>
              <div class="col-md-6 mb-3">
                <label>Text Color</label>
                <div class="color-picker-wrapper">
                  <input
                    type="text"
                    class="form-control"
                    name="footerTextColor"
                    id="footerTextColor"
                    value="${content.footerTextColor}"
                    required
                  />
                  <div class="color-preview" id="footerTextColorPicker"></div>
                </div>
              </div>
              <div class="col-md-6 mb-3">
                <label>Background Color</label>
                <div class="color-picker-wrapper">
                  <input
                    type="text"
                    class="form-control"
                    name="footerBackgroundColor"
                    id="footerBackgroundColor"
                    value="${content.footerBackgroundColor}"
                    required
                  />
                  <div
                    class="color-preview"
                    id="footerBackgroundColorPicker"
                  ></div>
                </div>
              </div>
            </div>

            <!-- Submit Button -->
            <div class="text-end">
              <button type="submit" class="btn btn-primary">
                <i class="bi bi-save"></i> Save Changes
              </button>
            </div>
          </form>
        </div>
      </div>

      <!-- Success/Error Messages -->
      <c:if test="${not empty sessionScope.notification}">
        <div
          class="alert alert-success alert-dismissible fade show mt-3"
          role="alert"
        >
          ${sessionScope.notification}
          <button
            type="button"
            class="btn-close"
            data-bs-dismiss="alert"
            aria-label="Close"
          ></button>
        </div>
        <% session.removeAttribute("notification"); %>
      </c:if>

      <c:if test="${not empty sessionScope.notificationErr}">
        <div
          class="alert alert-danger alert-dismissible fade show mt-3"
          role="alert"
        >
          ${sessionScope.notificationErr}
          <button
            type="button"
            class="btn-close"
            data-bs-dismiss="alert"
            aria-label="Close"
          ></button>
        </div>
        <% session.removeAttribute("notificationErr"); %>
      </c:if>
    </div>

    <!-- Add this script before closing body tag -->
    <script>
      const createPicker = (element, input) => {
        return Pickr.create({
          el: element,
          theme: "classic",
          default: input.value || "#000000",
          components: {
            preview: true,
            opacity: true,
            hue: true,
            interaction: {
              hex: true,
              rgba: true,
              hsla: true,
              input: true,
              save: true,
            },
          },
        }).on("save", (color) => {
          const hexColor = color ? color.toHEXA().toString() : "";
          input.value = hexColor;
          element.style.backgroundColor = hexColor;
        });
      };

      document.addEventListener("DOMContentLoaded", () => {
        const colorInputs = [
          { picker: "#headerTextColorPicker", input: "#headerTextColor" },
          {
            picker: "#headerBackgroundColorPicker",
            input: "#headerBackgroundColor",
          },
          { picker: "#footerTextColorPicker", input: "#footerTextColor" },
          {
            picker: "#footerBackgroundColorPicker",
            input: "#footerBackgroundColor",
          },
        ];

        colorInputs.forEach(({ picker, input }) => {
          const pickerElement = document.querySelector(picker);
          const inputElement = document.querySelector(input);
          pickerElement.style.backgroundColor = inputElement.value;
          createPicker(pickerElement, inputElement);
        });
      });
    </script>

    <script>
      document.addEventListener("DOMContentLoaded", function () {
        $(".colorpicker-component").colorpicker();
      });
    </script>

    <jsp:include page="${contextPath}/gui/footer.jsp"></jsp:include>
  </body>
</html>
