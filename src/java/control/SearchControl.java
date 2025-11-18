/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package control;

import dao.DAO;
import entity.Category;
import entity.Product;
import entity.Color;
import entity.Size;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;

/**
 *
 * @author This PC
 */
@WebServlet(name = "SearchControl", urlPatterns = {"/search"})
public class SearchControl extends HttpServlet {

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
        request.setCharacterEncoding("UTF-8");
        String txtSearch = request.getParameter("txt");
        DAO dao = new DAO();

        int page = 1;
        int pageSize = 5;
        try {
            String pageParam = request.getParameter("page");
            if (pageParam != null) page = Integer.parseInt(pageParam);
        } catch (Exception e) {
            page = 1;
        }

        int totalProducts = dao.getTotalProductsCountBySearch(txtSearch == null ? "" : txtSearch);
        int totalPage = (int) Math.ceil((double) totalProducts / pageSize);
        if (totalPage <= 0) totalPage = 1;
        if (page < 1) page = 1;
        if (page > totalPage) page = totalPage;

        int offset = (page - 1) * pageSize;
    String sort = request.getParameter("sort");
    List<Product> list = dao.searchByNamePaginatedSorted(txtSearch == null ? "" : txtSearch, offset, pageSize, sort);
        List<Category> listC = dao.getAllCategory();
        Product last = dao.getLast();

        // colors and sizes for Left.jsp
        List<Color> colors = dao.getAllColors();
        List<Size> sizes = dao.getAllSizes();

        request.setAttribute("listP", list);
        request.setAttribute("p", last);
        request.setAttribute("listCC", listC);
        request.setAttribute("colorsList", colors);
        request.setAttribute("sizesList", sizes);
        request.setAttribute("txtS", txtSearch);
    request.setAttribute("sort", sort);
        request.setAttribute("page", page);
        request.setAttribute("totalPage", totalPage);
        request.setAttribute("url", "search");
        request.getRequestDispatcher("Home.jsp").forward(request, response);
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
