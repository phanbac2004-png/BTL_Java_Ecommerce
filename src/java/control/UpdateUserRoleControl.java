package control;

import dao.DAO;
import entity.Account;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "UpdateUserRoleControl", urlPatterns = {"/updateuserrole"})
public class UpdateUserRoleControl extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        HttpSession session = request.getSession();
        Account a = (Account) session.getAttribute("acc");
        
        if (a == null || a.getIsAdmin() != 1) {
            response.sendRedirect("Login.jsp");
            return;
        }
        
        String uid = request.getParameter("uid");
        String isAdmin = request.getParameter("isAdmin");
        
        if (uid != null) {
            try {
                int userID = Integer.parseInt(uid);
                int admin = (isAdmin != null && isAdmin.equals("1")) ? 1 : 0;
                
                // Nếu Role = User thì isSell phải = 0
                // Nếu Role = Admin thì giữ nguyên isSell hiện tại (hoặc set = 1 nếu là mới)
                int sell;
                if (admin == 0) {
                    // Role = User → isSell = 0
                    sell = 0;
                } else {
                    // Role = Admin → Lấy isSell hiện tại, hoặc mặc định = 1
                    DAO dao = new DAO();
                    List<Account> accounts = dao.getAllAccounts();
                    Account currentUser = null;
                    for (Account acc : accounts) {
                        if (acc.getId() == userID) {
                            currentUser = acc;
                            break;
                        }
                    }
                    sell = (currentUser != null && currentUser.getIsSell() == 1) ? 1 : 1; // Mặc định Admin = 1
                }
                
                DAO dao = new DAO();
                dao.updateUserRole(userID, sell, admin);
            } catch (NumberFormatException e) {
                e.printStackTrace();
            }
        }
        
        response.sendRedirect("adminusers");
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
