package controller.manager;

import dao.ContentManagementDAO;
import entity.ContentManagement;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "ContentManagementController", urlPatterns = {"/manager/content-management"})
public class ContentManagementController extends HttpServlet {
    private final ContentManagementDAO contentDAO = new ContentManagementDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        ContentManagement content = contentDAO.getContent();
        request.setAttribute("content", content);
        request.getRequestDispatcher("/manager/content-management.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        try {
            ContentManagement content = new ContentManagement();
            content.setId(1); // Assuming we only have one record
            content.setWebName(request.getParameter("webName"));
            content.setHeaderTextColor(request.getParameter("headerTextColor"));
            content.setHeaderBackgroundColor(request.getParameter("headerBackgroundColor"));
            content.setFooterTextColor(request.getParameter("footerTextColor"));
            content.setFooterBackgroundColor(request.getParameter("footerBackgroundColor"));
            
            contentDAO.updateContent(content);
            session.setAttribute("notification", "Content updated successfully!");
        } catch (Exception e) {
            session.setAttribute("notificationErr", "Error updating content: " + e.getMessage());
        }
        response.sendRedirect("content-management");
    }
}