package controller;

import dao.OrderDAO;
import entity.Order;
import entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet("/order-list")
public class OrderListServlet extends HttpServlet {

    private final OrderDAO orderDAO = new OrderDAO();
    private final int pageSize = 5; // adjust page size as needed

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if(user == null){
            response.sendRedirect("login.jsp");
            return;
        }
        
        String search = request.getParameter("search");
        String pageStr = request.getParameter("page");
        int page = 1;
        if(pageStr != null){
            try {
                page = Integer.parseInt(pageStr);
            } catch(NumberFormatException e){
                page = 1;
            }
        }
        
        try {
            int totalOrders = orderDAO.countOrdersByUserSearch(user.getId(), search);
            int totalPages = (int) Math.ceil((double) totalOrders / pageSize);
            List<Order> orderList = orderDAO.getOrdersByUserSearch(user.getId(), search, (page-1)*pageSize, pageSize);
            
            // For each order, load its order details (with product info)
            for(Order order : orderList) {
                order.setDetails(orderDAO.getOrderDetails(order.getId()));
            }
            
            request.setAttribute("orderList", orderList);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("search", search);
            
            request.getRequestDispatcher("order-list.jsp").forward(request, response);
        } catch(Exception ex){
            Logger.getLogger(OrderListServlet.class.getName()).log(Level.SEVERE, null, ex);
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error retrieving orders.");
        }
    }
    
    // doPost to process cancel order action (see previous example)
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String cancelOrderIdStr = request.getParameter("cancelOrderId");
        if(cancelOrderIdStr != null){
            try {
                int orderId = Integer.parseInt(cancelOrderIdStr);
                orderDAO.cancelOrder(orderId);
            } catch(Exception ex){
                Logger.getLogger(OrderListServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        response.sendRedirect(request.getContextPath() + "/order-list");
    }
}
