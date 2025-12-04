package entity;

public class WeeklyRevenue {
    private int weekNumber;
    private double revenue;

    public WeeklyRevenue() {
    }

    public WeeklyRevenue(int weekNumber, double revenue) {
        this.weekNumber = weekNumber;
        this.revenue = revenue;
    }

    public int getWeekNumber() {
        return weekNumber;
    }

    public void setWeekNumber(int weekNumber) {
        this.weekNumber = weekNumber;
    }

    public double getRevenue() {
        return revenue;
    }

    public void setRevenue(double revenue) {
        this.revenue = revenue;
    }

    @Override
    public String toString() {
        return "WeeklyRevenue{" +
                "weekNumber=" + weekNumber +
                ", revenue=" + revenue +
                '}';
    }
}

