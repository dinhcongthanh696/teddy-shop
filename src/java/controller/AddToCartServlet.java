package controller;

import dao.CartDAO;
import entity.Cart;
import entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/add-to-cart")
public class AddToCartServlet extends HttpServlet {

    private final CartDAO cartDAO = new CartDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            HttpSession session = request.getSession();
            User user = (User) session.getAttribute("user");
            if (user == null) {
                response.sendRedirect("login.jsp");
                return;
            }

            int productId = Integer.parseInt(request.getParameter("productId"));

            Cart cart = cartDAO.getCartByUserId(user.getId());
            if (cart == null) {
                int cartId = cartDAO.createCart(user.getId());
                cart = new Cart();
                cart.setId(cartId);
                cart.setUserId(user.getId());
            }

            cartDAO.addCartDetail(cart.getId(), productId, 1);
            int newCartCount = cartDAO.getCartItemCount(user.getId());
            session.setAttribute("cartCount", newCartCount);
            // Redirect to the cart list page.
            response.sendRedirect("cart-list");
        } catch (Exception ex) {
            response.sendRedirect("cart-list");
            System.out.println(ex);
        }
    }
}
