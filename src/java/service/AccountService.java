package service;

import dao.AccountDAO;
import entity.Account;

public class AccountService {
    private final AccountDAO accountDAO = new AccountDAO();

    public Account login(String username, String password) {
        return accountDAO.login(username, password);
    }

    public void changePasswordById(int accountId, String newPassword) {
        accountDAO.updatePasswordById(accountId, newPassword);
    }

    public void signup(String user, String phone, String email, String pass) {
        accountDAO.signup(user, phone, email, pass);
    }

    public Account checkAccountExist(String user) { return accountDAO.checkAccountExist(user); }
    public Account checkEmailExist(String email) { return accountDAO.checkEmailExist(email); }
    public Account checkPhoneExist(String phone) { return accountDAO.checkPhoneExist(phone); }
}
