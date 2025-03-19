/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.CategoryDAO;
import dao.ProductDAO;
import dao.ProductTypeDAO;
import entity.Category;
import entity.Product;
import entity.ProductType;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author OS
 */
public class MenuController extends HttpServlet {

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
            CategoryDAO categoryDAO = new CategoryDAO();
            ProductDAO productDAO = new ProductDAO();
            ProductTypeDAO typeDAO = new ProductTypeDAO();

            if (service.equalsIgnoreCase("productInformation")) {
                ArrayList<Category> categoryList = categoryDAO.getAllCategory();
                ArrayList<Product> productList = productDAO.getAllProduct();
                ArrayList<Product> products = new ArrayList<>();
                for (int i = 0; i < categoryList.size(); i++) {
                    for (int j = 0; j < productList.size(); j++) {
                        if(categoryList.get(i).getId() == productList.get(j).getCategory().getId()){
                            products.add(productList.get(j));
                        }
                    }
                }
                request.setAttribute("categoryList", categoryList);
                request.setAttribute("productList", products);
                request.getRequestDispatcher("jsp/menu.jsp").forward(request, response);
            }

            if (service.equalsIgnoreCase("allProduct")) {
                String categoryName = request.getParameter("name");

                if (categoryName == null) {
                    ArrayList<Product> productList = productDAO.getAllProduct();
                    request.setAttribute("categoryName", "Tất cả sản phẩm");
                    request.setAttribute("productList", productList);
                    request.getRequestDispatcher("jsp/allProduct.jsp").forward(request, response);
                } else if (categoryName.equals("1")) {
                    int typeId = Integer.parseInt(categoryName);
                    ArrayList<Product> productList = productDAO.getProductByType(typeId);
                    ProductType productType = typeDAO.getProductTypeById(typeId);
                    request.setAttribute("categoryName", productType.getName());
                    request.setAttribute("productList", productList);
                    request.getRequestDispatcher("jsp/allProduct.jsp").forward(request, response);
                } else if (categoryName.equals("2")) {
                    int typeId = Integer.parseInt(categoryName);
                    ArrayList<Product> productList = productDAO.getProductByType(typeId);
                    ProductType productType = typeDAO.getProductTypeById(typeId);
                    request.setAttribute("categoryName", productType.getName());
                    request.setAttribute("productList", productList);
                    request.getRequestDispatcher("jsp/allProduct.jsp").forward(request, response);
                } else if (categoryName.equals("3")) {
                    int typeId = Integer.parseInt(categoryName);
                    ArrayList<Product> productList = productDAO.getProductByType(typeId);
                    ProductType productType = typeDAO.getProductTypeById(typeId);
                    request.setAttribute("categoryName", productType.getName());
                    request.setAttribute("productList", productList);
                    request.getRequestDispatcher("jsp/allProduct.jsp").forward(request, response);
                } else {
                    int categoryId = Integer.parseInt(request.getParameter("categoryId"));
                    ArrayList<Product> productList = productDAO.getProductByCategory(categoryId);
                    request.setAttribute("productList", productList);
                    request.setAttribute("categoryName", categoryName);
                    request.getRequestDispatcher("jsp/allProduct.jsp").forward(request, response);
                }
            }

            if (service.equalsIgnoreCase("searchProduct")) {
                String text = request.getParameter("searchValue");
                if(text.equalsIgnoreCase("Gấu")){
                    text = "Gau";
                } else if(text.equalsIgnoreCase("Chó")){
                    text = "Cho";
                } else if(text.equalsIgnoreCase("Mèo")){
                    text = "Meo";
                }
                ArrayList<Product> productList = productDAO.getProductByText(text);
                String message = "Đã tìm thấy " + productList.size() + " sản phẩm";
                request.setAttribute("productList", productList);
                request.setAttribute("categoryName", message);
                request.getRequestDispatcher("jsp/allProduct.jsp").forward(request, response);
            }
            
            if(service.equalsIgnoreCase("productView")){
                
            }

        } catch (Exception ex) {
            Logger.getLogger(MenuController.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    public static void main(String[] args) throws Exception {
        CategoryDAO categoryDAO = new CategoryDAO();
        ProductDAO productDAO = new ProductDAO();
        ArrayList<Category> categoryList = categoryDAO.getAllCategory();
        ArrayList<Product> productList = productDAO.getAllProduct();
//        for (int i = 0; i < productList.size(); i++) {
//            System.out.println(productList.get(i).getCategory().getName());
//        }
        for (int i = 0; i < categoryList.size(); i++) {
            System.out.println(categoryList.get(i).getName());
        }
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
