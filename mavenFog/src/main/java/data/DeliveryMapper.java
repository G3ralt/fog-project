package data;

import exceptions.ConnectionException;
import exceptions.ConnectionException.CreateDeliveryException;
import exceptions.ConnectionException.GetAllDeliveryException;
import exceptions.ConnectionException.QueryException;
import exceptions.ConnectionException.UpdateOrderDetailsException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import model.Delivery;

public class DeliveryMapper {

    private static Connection con;

    /**
     * Creates a connection to DB
     * @throws ConnectionException if connection can`t be established
     */
    public static void setConnection() throws ConnectionException {
        con = DB.createConnection();
    }

    public static Connection getCon() {
        return con;
    }

    /**
     * Creates new delivery in the Database
     * @param orderID String
     * @param moreInfo String/null
     * @param price double
     * @return the deliveryID of the newly created delivery
     * @throws CreateDeliveryException if we cant execute the query
     */
    public static String createDelivery(String orderID, String moreInfo, double price) throws CreateDeliveryException {
        String sql = "INSERT into delivery (delivery_id, delivery_status, more_info, price) VALUES (? , 0, ?, ?);";
        PreparedStatement stmt = null;
        String deliveryID = null;
        try {
            deliveryID = DB.generateID("delivery", "delivery_id", con);
            stmt = con.prepareStatement(sql);
            stmt.setString(1, deliveryID);
            stmt.setString(2, moreInfo);
            stmt.setDouble(3, price);
            stmt.executeUpdate();

            //Updates the delivery_id in orderDetails throws UpdateOrderDetailsException or QueryException
            OrderMapper.setConnection();
            OrderMapper.updateDeliveryID(deliveryID, orderID);
        } catch (SQLException | QueryException e) {
            throw new CreateDeliveryException();
        } catch (UpdateOrderDetailsException | ConnectionException ee) {
            //Deletes the delivery if the first part of the second part of the try bloack fails
            deleteDelivery(deliveryID);
            throw new CreateDeliveryException();
        } finally {
            DB.closeStmt(stmt);
            DB.releaseConnection(OrderMapper.getCon());
        }
        return deliveryID;
    }//createDelivery

    /**
     * Deletes a delivery input from the Database in case of failure in the createDelivery() method
     * @param deliveryID String
     */
    private static void deleteDelivery(String deliveryID) {
        String sql = "DELETE FROM delivery WHERE delivery_id = '" + deliveryID + "';";
        String set = "SET SQL_SAFE_UPDATES = 0;";
        String reset = "SET SQL_SAFE_UPDATES = 1;";
        PreparedStatement stmt = null;
        try {
            stmt = con.prepareStatement(set);
            stmt.executeUpdate();
            stmt = con.prepareStatement(sql);
            stmt.executeUpdate();
            stmt = con.prepareStatement(reset);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DB.closeStmt(stmt);
        }
    }//deleteDelivery

    /**
     * @return an ArrayList with all the deliveries in the Database
     * @throws GetAllDeliveryException if the method is not executable or the list is empty
     */
    public static ArrayList<Delivery> getAllDelivery() throws GetAllDeliveryException {
        ArrayList<Delivery> deliveries = new ArrayList<>();
        String sql = "SELECT * FROM delivery,orders NATURAL JOIN order_details WHERE delivery.delivery_id = order_details.delivery_id;";
        int deliveryStatus;
        double price;
        String deliveryID, moreInfo, orderID, customerID, salesRepID, deliveryDate;
        Delivery delivery;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        try {
            stmt = con.prepareStatement(sql);
            rs = stmt.executeQuery();
            while (rs.next()) {
                deliveryID = rs.getString("delivery_id");
                deliveryDate = rs.getString("delivery_date");
                deliveryStatus = rs.getInt("delivery_status");
                moreInfo = rs.getString("more_info");
                price = rs.getDouble("price");
                orderID = rs.getString("order_id");
                salesRepID = rs.getString("sales_rep_id");
                customerID = rs.getString("customer_id");
                delivery = new Delivery(deliveryID, deliveryStatus, orderID, customerID, salesRepID, deliveryDate, price, moreInfo);
                deliveries.add(delivery);
            }
        } catch (SQLException x) {
            throw new GetAllDeliveryException();
        } finally {
            DB.closeRs(rs);
            DB.closeStmt(stmt);
        }
        if (deliveries.isEmpty()) {
            throw new GetAllDeliveryException();
        }
        return deliveries;
    }//getAllDelivery

    /**
     * @param orderID String
     * @return a Delivery object 
     * @throws QueryException if the method is not executable
     */
    public static Delivery getDelivery(String orderID) throws QueryException {
        String sql = "SELECT * FROM delivery,orders NATURAL JOIN order_details WHERE delivery.delivery_id = order_details.delivery_id AND order_id = '" + orderID + "';";
        int deliveryStatus;
        double price;
        String deliveryID, moreInfo, customerID, salesRepID, deliveryDate;
        Delivery delivery = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        try {
            stmt = con.prepareStatement(sql);
            rs = stmt.executeQuery();
            while (rs.next()) {
                deliveryID = rs.getString("delivery_id");
                deliveryDate = rs.getString("delivery_date");
                deliveryStatus = rs.getInt("delivery_status");
                moreInfo = rs.getString("more_info");
                price = rs.getDouble("price");
                orderID = rs.getString("order_id");
                salesRepID = rs.getString("sales_rep_id");
                customerID = rs.getString("customer_id");
                delivery = new Delivery(deliveryID, deliveryStatus, orderID, customerID, salesRepID, deliveryDate, price, moreInfo);
            }
        } catch (SQLException x) {
            throw new QueryException();
        } finally {
            DB.closeRs(rs);
            DB.closeStmt(stmt);
        }
        return delivery;
    }//getDelivery

    /**
     * Updates the Delivery status when the delivery is cancelled or completed
     * @param delivery_status int
     * @param deliveryID String
     * @throws QueryException if the input is not the right data type or the querry is wrong
     */
    public static void updateDeliveryStatus(int delivery_status, String deliveryID) throws QueryException {
        String sql = "UPDATE delivery SET delivery_status = " + delivery_status + " WHERE delivery_id = '" + deliveryID + "';";
        String set = "SET SQL_SAFE_UPDATES = 0;";
        String reset = "SET SQL_SAFE_UPDATES = 1;";
        PreparedStatement stmt = null;
        try {
            stmt = con.prepareStatement(set);
            stmt.executeUpdate();
            stmt = con.prepareStatement(sql);
            stmt.executeUpdate();
            stmt = con.prepareStatement(reset);
            stmt.executeUpdate();
        } catch (SQLException e) {
            throw new QueryException();
        } finally {
            DB.closeStmt(stmt);
        }
    }//updateDeliveryStatus

    /**
     * /Updates the Delivery date 
     * @param date String
     * @param deliveryID String
     * @throws QueryException if the input is not the right data type or the querry is wrong
     */
    public static void updateDeliveryDate(String date, String deliveryID) throws QueryException {
        String sql = "UPDATE delivery SET delivery_date = '" + date + "' WHERE delivery_id = '" + deliveryID + "';";
        String set = "SET SQL_SAFE_UPDATES = 0;";
        String reset = "SET SQL_SAFE_UPDATES = 1;";
        PreparedStatement stmt = null;
        try {
            stmt = con.prepareStatement(set);
            stmt.executeUpdate();
            stmt = con.prepareStatement(sql);
            stmt.executeUpdate();
            stmt = con.prepareStatement(reset);
            stmt.executeUpdate();
        } catch (SQLException e) {
            throw new QueryException();
        } finally {
            DB.closeStmt(stmt);
        }
    }//updateDeliveryDate
}
