package controller;

import dao.CartDAO;
import dao.UserDAO;
import entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;

public class LoginController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        // Retrieve form parameters
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        // Check login using DAO
        UserDAO dao = new UserDAO();
        User user = dao.checkLogin(username, password);

        if (user != null) {
            // Store user in session
            session.setAttribute("user", user);
            if (user.getRole().getUserRole().equalsIgnoreCase("Customer")) {
                CartDAO cartDAO = new CartDAO();
                int cartCount;
                try {
                    cartCount = cartDAO.getCartItemCount(user.getId());
                    session.setAttribute("cartCount", cartCount);
                } catch (Exception ex) {
                    Logger.getLogger(LoginController.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
            // Get the role name
            String role = user.getRole().getUserRole();

            // Redirect based on role
            if (role.equalsIgnoreCase("admin")) {
                response.sendRedirect(request.getContextPath() + "/admin/dashboard");
            } else if (role.equalsIgnoreCase("manager")) {
                response.sendRedirect(request.getContextPath() + "/manager/dashboard");
            } else if (role.equalsIgnoreCase("seller") || role.equalsIgnoreCase("sale")) {
                response.sendRedirect(request.getContextPath() + "/seller/dashboard");
            } else if (role.equalsIgnoreCase("customer")) {
                response.sendRedirect(request.getContextPath() + "/MenuController?service=productInformation");
            } else {
                // Other roles can be handled here
                response.sendRedirect(request.getContextPath() + "/MenuController?service=productInformation");
            }
        } else {
            // Login failed: set error message and forward back to login page.
            session.setAttribute("notificationErr", "Invalid username or password.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}
