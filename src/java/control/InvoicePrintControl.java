package control;

import dao.DAO;
import entity.Account;
import entity.Order;
import entity.OrderDetail;
import entity.Product;
import entity.ProductVariant;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "InvoicePrintControl", urlPatterns = {"/invoiceprint"})
public class InvoicePrintControl extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        HttpSession session = request.getSession();
        Account a = (Account) session.getAttribute("acc");

        // Optional: only admin can view; follow same rule as OrderDetailControl
        if (a == null || a.getIsAdmin() != 1) {
            response.sendRedirect("Login.jsp");
            return;
        }

        String oid = request.getParameter("oid");
        if (oid != null) {
            try {
                int orderID = Integer.parseInt(oid);
                DAO dao = new DAO();
                List<OrderDetail> listOD = dao.getOrderDetailsByOrderID(orderID);

                // Get order
                List<Order> allOrders = dao.getAllOrders();
                Order order = null;
                for (Order o : allOrders) {
                    if (o.getId() == orderID) {
                        order = o;
                        break;
                    }
                }

                List<Product> listProducts = new ArrayList<>();
                List<ProductVariant> listVariants = new ArrayList<>();
                for (OrderDetail od : listOD) {
                    Product p = dao.getProductByID(od.getProductID());
                    ProductVariant pv = null;
                    if (p == null) {
                        pv = dao.getVariantById(od.getProductID());
                        if (pv != null) {
                            String cName = dao.getColorNameById(pv.getColorId());
                            String sName = dao.getSizeNameById(pv.getSizeId());
                            try { pv.setColorName(cName); } catch (Exception ignore) {}
                            try { pv.setSizeName(sName); } catch (Exception ignore) {}
                            p = dao.getProductByID(pv.getProductId());
                        }
                    }
                    if (p == null) {
                        p = new Product(0, "Unknown product", request.getContextPath() + "/images/placeholder-80.svg", 0, "", "");
                    }
                    listProducts.add(p);
                    listVariants.add(pv);
                }

                request.setAttribute("listOD", listOD);
                request.setAttribute("listProducts", listProducts);
                request.setAttribute("listVariants", listVariants);
                request.setAttribute("orderID", orderID);
                request.setAttribute("order", order);

                request.getRequestDispatcher("InvoicePrint.jsp").forward(request, response);
                return;
            } catch (NumberFormatException e) {
                // fall through
            }
        }

        response.sendRedirect("adminorders");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
}
