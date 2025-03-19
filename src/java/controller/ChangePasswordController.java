/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.UserDAO;
import entity.User;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 *
 * @author ADMIN
 */
@WebServlet(name = "ChangePasswordController", urlPatterns = {"/change-password"})
public class ChangePasswordController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            session.setAttribute("notificationErr", "Please login first!");
            response.sendRedirect(request.getContextPath() + "/login");
        } else {
            request.getRequestDispatcher("changePassword.jsp").forward(request, response);
        }
    }


@Override
protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        // Ensure the user is logged in
        User currentUser = (User) session.getAttribute("user");
        if (currentUser == null) {
            session.setAttribute("notificationErr", "Please login first.");
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // Get form parameters
        String oldPassword = request.getParameter("oldPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        // Server-side check: new password and confirm password must match.
        if (!newPassword.equals(confirmPassword)) {
            session.setAttribute("notificationErr", "New password and confirm password do not match.");
            request.getRequestDispatcher("changePassword.jsp").forward(request, response);
            return;
        }

        // (Optional) Server-side new password format validation using regex.
        String passwordRegex = "^(?=.*[A-Z])(?=.*[^a-zA-Z0-9]).{6,50}$";
        if (!newPassword.matches(passwordRegex)) {
            session.setAttribute("notificationErr", "New password must be 6-50 characters, with at least one uppercase letter and one special character.");
            request.getRequestDispatcher("changePassword.jsp").forward(request, response);
            return;
        }

        // Verify that the provided old password matches what’s stored in the database.
        UserDAO userDAO = new UserDAO();
        boolean isChanged = userDAO.changePassword(currentUser.getId(), oldPassword, newPassword);

        if (isChanged) {
            session.setAttribute("notification", "Password changed successfully.");
            // Optionally, redirect to a profile or dashboard page.
            response.sendRedirect(request.getContextPath() + "/login");
        } else {
            session.setAttribute("notificationErr", "Old password is incorrect. Please try again.");
            request.getRequestDispatcher("changePassword.jsp").forward(request, response);
        }
    }
}
