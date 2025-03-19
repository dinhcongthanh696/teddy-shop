package controller.seller;

import dao.OrderDAO;
import dao.UserDAO;
import entity.Order;
import entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet("/seller/order-list")
public class ManagerOrderServlet extends HttpServlet {

    private final OrderDAO orderDAO = new OrderDAO();
    private final UserDAO userDAO = new UserDAO();
    private final int pageSize = 10; // orders per page

    // Check access: only allow Manager role
    private boolean isManager(User user) {
        return user != null && user.getRole() != null
                && "Seller".equalsIgnoreCase(user.getRole().getUserRole());
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null || !isManager(user)) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        // Retrieve search and paging parameters
        String search = request.getParameter("search");
        String pageStr = request.getParameter("page");
        int page = 1;
        if (pageStr != null) {
            try {
                page = Integer.parseInt(pageStr);
            } catch (NumberFormatException e) {
                page = 1;
            }
        }

        try {
            // Get total orders count and calculate pages
            int totalOrders = orderDAO.countAllOrdersWithSearch(search);
            int totalPages = (int) Math.ceil((double) totalOrders / pageSize);
            int offset = (page - 1) * pageSize;

            // Retrieve a paged list of orders (for all users) filtered by search criteria (username or product name)
            List<Order> orderList = orderDAO.getOrdersWithSearch(search, offset, pageSize);
            // For each order, load its details (including product info)
            for (Order order : orderList) {
                order.setDetails(orderDAO.getOrderDetails(order.getId()));
            }

            // Also load list of customers for the "Add Order" modal
            List<User> userList = userDAO.getAllCustomers();

            request.setAttribute("orderList", orderList);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("search", search);
            request.setAttribute("userList", userList);

            request.getRequestDispatcher("/seller/order-list.jsp").forward(request, response);
        } catch (Exception ex) {
            Logger.getLogger(ManagerOrderServlet.class.getName()).log(Level.SEVERE, null, ex);
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error retrieving orders.");
        }
    }

    // Handle update actions: cancel, accept, delivered, and add new order.
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null || !isManager(user)) {
            session.setAttribute("notificationErr", "Access Denined!");
            response.sendRedirect(request.getContextPath() + "/loginjsp");
            return;
        }

        String action = request.getParameter("action");
        try {
            if ("cancel".equalsIgnoreCase(action)) {
                int orderId = Integer.parseInt(request.getParameter("orderId"));
                orderDAO.cancelOrder(orderId);
            } else if ("accept".equalsIgnoreCase(action)) {
                int orderId = Integer.parseInt(request.getParameter("orderId"));
                orderDAO.acceptOrder(orderId);
            } else if ("delivered".equalsIgnoreCase(action)) {
                int orderId = Integer.parseInt(request.getParameter("orderId"));
                orderDAO.markDelivered(orderId);
            } else if ("add".equalsIgnoreCase(action)) {
                // Process adding a new order from the modal
                int newUserId = Integer.parseInt(request.getParameter("newUserId"));
                String newAddress = request.getParameter("newAddress");
                int newTotalCost = Integer.parseInt(request.getParameter("newTotalCost"));

                Order newOrder = new Order();
                newOrder.setUserId(newUserId);
                newOrder.setAddress(newAddress);
                newOrder.setTotalCost(newTotalCost);
                newOrder.setStatus(0); // pending

                orderDAO.createOrder(newOrder);
            }
        } catch (Exception ex) {
            Logger.getLogger(ManagerOrderServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
        response.sendRedirect(request.getContextPath() + "/seller/order-list");
    }
}
