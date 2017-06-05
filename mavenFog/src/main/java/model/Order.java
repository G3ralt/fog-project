package model;

import java.sql.Date;
import java.util.ArrayList;

public class Order {
    private final String orderID, productID, salesRepID, deliveryID, invoiceID, customerID;
    private final int orderStatus;
    private final Date date;

    public Order(String orderID, Date date, String customerID, String productID, String salesRepID,  String deliveryID, String invoiceID, int orderStatus) {
        this.orderID = orderID;
        this.customerID = customerID;
        this.productID = productID;
        this.salesRepID = salesRepID;
        this.deliveryID = deliveryID;
        this.invoiceID = invoiceID;
        this.date = date;
        this.orderStatus = orderStatus;
    }

    public static int findOrderStatus(String deliveryID, ArrayList<Order> orders) {
        int orderStatus = 0;
        for (Order order : orders) {
            if (order.getDeliveryID().equals(deliveryID)) {
                orderStatus = order.getOrderStatus();
                break;
            }
        }
        return orderStatus;
    }
    
    public int getOrderStatus() {
        return orderStatus;
    }

    public String getOrderID() {
        return orderID;
    }

    public Date getDate() {
        return date;
    }

    public String getCustomerID() {
        return customerID;
    }

    public String getProductID() {
        return productID;
    }

    public String getSalesRepID() {
        return salesRepID;
    }

    public String getDeliveryID() {
        return deliveryID;
    }

    public String getInvoiceID() {
        return invoiceID;
    }

    @Override
    public String toString() {
        return "Order{" + "orderID=" + orderID + ", customerID=" + customerID + ", productID=" + productID + ", salesRepID=" + salesRepID + ", deliveryID=" + deliveryID + ", invoiceID=" + invoiceID + ", orderStatus=" + orderStatus + ", date=" + date + '}';
    }

    

    
    
    
    
}
