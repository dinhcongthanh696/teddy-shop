/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.UserDAO;
import entity.User;
import entity.UserRole;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author OS
 */
public class UserController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            String service = request.getParameter("service");
            HttpSession session = request.getSession();
            User user = (User) session.getAttribute("user");
            UserDAO userDao = new UserDAO();

            if (service.equalsIgnoreCase("userInfo")) {
                String nameError = "", emailError = "", phoneError = "";
                String name = request.getParameter("name");
                String email = request.getParameter("email");
                String phone = request.getParameter("phone");
                String location = request.getParameter("location");
                String currentUsername = user.getUserName();
                int currentUserId = user.getId();
                if (name == "") {
                    name = user.getUserName();
                } else {
                    if (!name.equals(user.getUserName())) {
                        if (isValidName(name) == false || userDao.isUsernameExist(name) == true) {
                            nameError = "Name Not Valid Or Already Used!!";
                            request.setAttribute("nameError", nameError);
                        }
                    }
                }

                if (email == "") {
                    email = user.getEmail();
                } else {
                    if (!email.equals(user.getEmail())) {
                        if (isValidEmail(email) == false || userDao.isEmailExist(email) == true) {
                            emailError = "Email Not Valid Or Already Used!";
                            request.setAttribute("emailError", emailError);
                        }
                    }
                }

                if (phone == "") {
                    phone = user.getPhoneNumber();
                } else {
                    if (!phone.equals(user.getPhoneNumber())) {
                        if (isValidPhone(phone) == false || userDao.isPhoneNumberExist(phone) == true) {
                            phoneError = "Phone Not Valid Or Already Used!";
                            request.setAttribute("phoneError", phoneError);
                        }
                    }
                }
                if (location == "") {
                    location = user.getLocation();
                }

                if (nameError != "" || emailError != "" || phoneError != "") {
                    request.getRequestDispatcher("jsp/userDetail.jsp").forward(request, response);
                } else {
                    userDao.changeUserInformation(currentUsername, name, email, phone, location);
                    user.setUserName(name);
                    user.setEmail(email);
                    user.setPhoneNumber(phone);
                    user.setLocation(location);
                    session.setAttribute("user", user);
                    request.getRequestDispatcher("jsp/userProfile.jsp").forward(request, response);
                }
            }
            
            

        } catch (Exception ex) {
            Logger.getLogger(UserController.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    private boolean isValidName(String name) {
        if (name.length() > 12) {
            return false;
        }
        return true;
    }

    private boolean isValidEmail(String email) {
        // Sử dụng regex để kiểm tra email hợp lệ
        return email.matches("^[a-zA-Z0-9_+&*-]+(?:\\.[a-zA-Z0-9_+&*-]+)*@"
                + "(?:[a-zA-Z0-9-]+\\.)+[a-zA-Z]{2,7}$");
    }

    private boolean isValidPhone(String phone) {
        // Sử dụng regex để kiểm tra phone hợp lệ
        return phone.matches("^0\\d{9}$");
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
