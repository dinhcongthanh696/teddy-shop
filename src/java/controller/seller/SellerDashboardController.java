package controller.seller;

import entity.User;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "SellerDashboardController", urlPatterns = {"/seller/dashboard"})
public class SellerDashboardController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            session.setAttribute("notificationErr", "Please login first!");
            response.sendRedirect(request.getContextPath() + "/login");
        } else if (!user.getRole().getUserRole().equalsIgnoreCase("seller")) {
            session.setAttribute("notificationErr", "Access Denied!");
            response.sendRedirect(request.getContextPath() + "/login");
        } else {
            request.getRequestDispatcher("/seller/dashboard.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }
}
