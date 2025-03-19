package controller;

import dao.UserDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "RegisterServlet", urlPatterns = {"/register"})
public class RegisterServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("registration.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Get user input from the form
        String email = request.getParameter("email");
        String username = request.getParameter("username");
        String phone = request.getParameter("phone");
        String location = request.getParameter("location");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirm_password");
        
        HttpSession session = request.getSession();
        
        // Store input values into session attributes so that they can be used to prepopulate the form.
        // (We do not store the password fields for security reasons.)
        session.setAttribute("regEmail", email);
        session.setAttribute("regUsername", username);
        session.setAttribute("regPhone", phone);
        session.setAttribute("regLocation", location);
        
        // 1. Check if password and confirm password match.
        if (!password.equals(confirmPassword)) {
            session.setAttribute("notificationErr", "Passwords do not match.");
            request.getRequestDispatcher("registration.jsp").forward(request, response);
            return;
        }
        
        UserDAO userDAO = new UserDAO();

        // 2. Check if username exists.
        if (userDAO.isUsernameExist(username)) {
            session.setAttribute("notificationErr", "Username already exists.");
            request.getRequestDispatcher("registration.jsp").forward(request, response);
            return;
        }

        // 3. Check if email exists.
        if (userDAO.isEmailExist(email)) {
            session.setAttribute("notificationErr", "Email already exists.");
            request.getRequestDispatcher("registration.jsp").forward(request, response);
            return;
        }

        // 4. Attempt to register the new user.
        boolean isRegistered = userDAO.registerUser(username, email, password, phone, location);
        
        if (isRegistered) {
            // Registration successful. Clear the stored input values.
            session.removeAttribute("regEmail");
            session.removeAttribute("regUsername");
            session.removeAttribute("regPhone");
            session.removeAttribute("regLocation");
            
            session.setAttribute("notification", "Registration successful. Please login.");
            response.sendRedirect(request.getContextPath() + "/login");
        } else {
            // Registration failed.
            session.setAttribute("notificationErr", "Registration failed. Please try again.");
            request.getRequestDispatcher("registration.jsp").forward(request, response);
        }
    }
}
