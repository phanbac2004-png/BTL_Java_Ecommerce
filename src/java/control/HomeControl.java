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
        // b1: get data from dao with pagination and filters
        DAO dao = new DAO();
        int page = 1;
        int pageSize = 9;

        try {
            String pageParam = request.getParameter("page");
            if (pageParam != null) {
                page = Integer.parseInt(pageParam);
            }
        } catch (Exception e) {
            page = 1;
        }

        // Read filter params
        String colorParam = request.getParameter("color");
        String sizeParam = request.getParameter("size");
        String minParam = request.getParameter("min");
        String maxParam = request.getParameter("max");
        String cidParam = request.getParameter("cid");
        String txtParam = request.getParameter("txt");

        Integer colorId = null;
        Integer sizeId = null;
        Integer cid = null;
        double minPrice = 0;
        double maxPrice = 1000000;
        try { if (colorParam != null && !colorParam.isEmpty()) colorId = Integer.parseInt(colorParam); } catch (Exception ignore) {}
        try { if (sizeParam != null && !sizeParam.isEmpty()) sizeId = Integer.parseInt(sizeParam); } catch (Exception ignore) {}
        try { if (cidParam != null && !cidParam.isEmpty()) cid = Integer.parseInt(cidParam); } catch (Exception ignore) {}
        try { if (minParam != null && !minParam.isEmpty()) minPrice = Double.parseDouble(minParam); } catch (Exception ignore) {}
        try { if (maxParam != null && !maxParam.isEmpty()) maxPrice = Double.parseDouble(maxParam); } catch (Exception ignore) {}

        int totalProducts = dao.getTotalProductsCountFiltered(colorId, sizeId, minPrice, maxPrice, cid, txtParam);
        int totalPage = (int) Math.ceil((double) totalProducts / pageSize);
        if (totalPage <= 0) totalPage = 1;
        if (page < 1) page = 1;
        if (page > totalPage) page = totalPage;

        int offset = (page - 1) * pageSize;
        String sort = request.getParameter("sort");
        List<Product> list = dao.getProductsByFilter(offset, pageSize, sort, colorId, sizeId, minPrice, maxPrice, cid, txtParam);
        List<Category> listC = dao.getAllCategory();
        // Fetch colors and sizes for Left.jsp filter
        List<entity.Color> colors = dao.getAllColors();
        List<entity.Size> sizes = dao.getAllSizes();
        Product last = dao.getLast();

        // b2: set data to jsp
        request.setAttribute("listP", list);
        request.setAttribute("listCC", listC);
        request.setAttribute("colorsList", colors);
        request.setAttribute("sizesList", sizes);
        request.setAttribute("p", last);
        request.setAttribute("page", page);
        request.setAttribute("totalPage", totalPage);
        request.setAttribute("sort", sort);
        // Preserve filter values so JSPs can read them if needed
        request.setAttribute("filterColor", colorId);
        request.setAttribute("filterSize", sizeId);
        request.setAttribute("filterMin", minPrice);
        request.setAttribute("filterMax", maxPrice);
        request.setAttribute("filterCid", cid);
        request.setAttribute("filterTxt", txtParam);
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
