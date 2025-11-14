/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package control;

import dao.DAO;
import entity.Account;
import entity.Category;
import entity.Product;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;

/**
 *
 * @author This PC
 */
@WebServlet(name = "ManagerControl", urlPatterns = {"/manager"})
public class ManagerControl extends HttpServlet {

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
        HttpSession session = request.getSession();
        Account a = (Account) session.getAttribute("acc");
        
        // Kiểm tra null
        if (a == null) {
            response.sendRedirect("Login.jsp");
            return;
        }
        
        DAO dao = new DAO();
        List<Product> list;
        List<Category> listC = dao.getAllCategory();
        
        // Nếu là admin, hiển thị tất cả sản phẩm
        if (a.getIsAdmin() == 1) {
            list = dao.getAllProduct();
        } else {
            // Nếu là seller, chỉ hiển thị sản phẩm của mình
            int id = a.getId();
            list = dao.getProductBySellID(id);
        }
        
        request.setAttribute("listP", list);
        request.setAttribute("listCC", listC);
        
        // Lấy messages từ session nếu có
        if (session.getAttribute("successMsg") != null) {
            request.setAttribute("successMsg", session.getAttribute("successMsg"));
        }
        if (session.getAttribute("errorMsg") != null) {
            request.setAttribute("errorMsg", session.getAttribute("errorMsg"));
        }
        
        // Nếu là admin và có request từ admin dashboard, sử dụng layout
        if (a.getIsAdmin() == 1 && request.getParameter("fromAdmin") != null) {
            request.setAttribute("contentPage", "ManagerProductContent.jsp");
            request.getRequestDispatcher("AdminDashboardLayout.jsp").forward(request, response);
        } else {
            // Nếu không phải admin hoặc từ admin dashboard, dùng trang riêng
            request.getRequestDispatcher("ManagerProduct.jsp").forward(request, response);
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
