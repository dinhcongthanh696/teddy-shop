package controller;

import dao.CartDAO;
import entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet("/update-cart")
public class UpdateCartServlet extends HttpServlet {

    private final CartDAO cartDAO = new CartDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        int userId = user.getId();
        int productId = Integer.parseInt(request.getParameter("productId"));
        String action = request.getParameter("action"); // expected values: "increase", "decrease", "update", "remove"

        try {
            // Get current quantity of the item
            int currentQuantity = cartDAO.getCartItemQuantity(userId, productId);
            int newQuantity = currentQuantity;

            if ("increase".equalsIgnoreCase(action)) {
                newQuantity = currentQuantity + 1;
            } else if ("decrease".equalsIgnoreCase(action)) {
                newQuantity = currentQuantity - 1;
            } else if ("update".equalsIgnoreCase(action)) {
                try {
                    newQuantity = Integer.parseInt(request.getParameter("quantity"));
                } catch (NumberFormatException e) {
                    newQuantity = currentQuantity;
                }
            } else if ("remove".equalsIgnoreCase(action)) {
                cartDAO.removeCartItem(userId, productId);
                int newCartCount = cartDAO.getCartItemCount(user.getId());
                session.setAttribute("cartCount", newCartCount);
                response.sendRedirect(request.getContextPath() + "/cart-list");
                return;
            }

            // If new quantity is less than or equal to zero, remove the item
            if (newQuantity <= 0) {
                cartDAO.removeCartItem(userId, productId);
                int newCartCount = cartDAO.getCartItemCount(user.getId());
                session.setAttribute("cartCount", newCartCount);
            } else {
                cartDAO.updateCartItemQuantity(userId, productId, newQuantity);

            }
        } catch (Exception ex) {
            Logger.getLogger(UpdateCartServlet.class.getName()).log(Level.SEVERE, null, ex);
        }

        response.sendRedirect(request.getContextPath() + "/cart-list");
    }
}
