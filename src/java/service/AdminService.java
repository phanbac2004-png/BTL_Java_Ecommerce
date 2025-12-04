package service;

import dao.AnalyticsDAO;

public class AdminService {
    private final AnalyticsDAO analyticsDAO = new AnalyticsDAO();

    public int getNewOrdersCount() { return analyticsDAO.getNewOrdersCount(); }
    public double getMonthlyRevenue() { return analyticsDAO.getMonthlyRevenue(); }
    public int getTotalProductsCount() { return analyticsDAO.getTotalProductsCount(); }
    public int getTotalCustomersCount() { return analyticsDAO.getTotalCustomersCount(); }
}
