/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package control;

import dao.DAO;
import entity.Category;
import entity.Product;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author trinh
 */
@WebServlet(name = "HomeControl", urlPatterns = {"/home"})
public class HomeControl extends HttpServlet {

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
        // b1: get data from dao with pagination
        DAO dao = new DAO();
        int page = 1;
        int pageSize = 5;
        try {
            String pageParam = request.getParameter("page");
            if (pageParam != null) {
                page = Integer.parseInt(pageParam);
            }
        } catch (Exception e) {
            page = 1;
        }

        String color = request.getParameter("color");
        String size = request.getParameter("size");
        Double min = null, max = null;
        try { String s = request.getParameter("min"); if (s != null && !s.isEmpty()) min = Double.parseDouble(s); } catch (Exception ignore) {}
        try { String s = request.getParameter("max"); if (s != null && !s.isEmpty()) { double v = Double.parseDouble(s); max = (v <= 0) ? null : v; } } catch (Exception ignore) {}

        int totalProducts = dao.getTotalProductsCountFiltered(null, null, color, size, min, max);
        int totalPage = (int) Math.ceil((double) totalProducts / pageSize);
        if (totalPage <= 0) totalPage = 1;
        if (page < 1) page = 1;
        if (page > totalPage) page = totalPage;

        int offset = (page - 1) * pageSize;
    String sort = request.getParameter("sort");
    List<Product> list = dao.getProductsFiltered(null, null, color, size, min, max, offset, pageSize, sort);
        List<Category> listC = dao.getAllCategory();
        Product last = dao.getLast();

        // b2: set data to jsp
    request.setAttribute("listP", list);
        request.setAttribute("listCC", listC);
        request.setAttribute("p", last);
        request.setAttribute("page", page);
        request.setAttribute("totalPage", totalPage);
    request.setAttribute("sort", sort);
        request.setAttribute("url", "home");
        request.getRequestDispatcher("Home.jsp").forward(request, response);
        //404 -> url
        //500 -> jsp properties
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
