package model;

public class Delivery {
    private final String deliveryID, moreInfo, orderID, customerID, salesRepID, deliveryDate;
    private final int deliveryStatus;
    private final double price;
    
    public Delivery(String deliveryID, int deliveryStatus, String orderID, String customerID, String salesRepID, String deliveryDate, double price, String moreInfo) {
        this.deliveryID = deliveryID;
        this.deliveryStatus = deliveryStatus;
        this.orderID = orderID;
        this.customerID = customerID;
        this.salesRepID = salesRepID;
        this.deliveryDate = deliveryDate;
        this.price = price;
        this.moreInfo = moreInfo;
    }

    public String getDeliveryID() {
        return deliveryID;
    }

    public int getDeliveryStatus() {
        return deliveryStatus;
    }

    public String getOrderID() {
        return orderID;
    }

    public String getCustomerID() {
        return customerID;
    }

    public String getSalesRepID() {
        return salesRepID;
    }

    public String getDeliveryDate() {
        return deliveryDate;
    }

    public double getPrice() {
        return price;
    }

    public String getMoreInfo() {
        return moreInfo;
    }
}
