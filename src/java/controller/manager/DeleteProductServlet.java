package controller.manager;

import dao.ProductDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "DeleteProductServlet", urlPatterns = {"/manager/delete-product"})
public class DeleteProductServlet extends HttpServlet {
    private final ProductDAO productDAO = new ProductDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        try {
            int productId = Integer.parseInt(request.getParameter("productId"));
            productDAO.setProductStatus(productId, false);
            session.setAttribute("notification", "Product deleted successfully!");
        } catch (Exception e) {
            session.setAttribute("notificationErr", "Error deleting product: " + e.getMessage());
        }
        response.sendRedirect("product-management");
    }
}