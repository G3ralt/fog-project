package servlets;

import data.DB;
import data.DeliveryMapper;
import data.InvoiceMapper;
import data.OrderMapper;
import data.ProductMapper;
import data.UserMapper;
import exceptions.ConnectionException;
import exceptions.ConnectionException.CreateInvoiceException;
import exceptions.ConnectionException.DeleteOrderException;
import exceptions.ConnectionException.QueryException;
import exceptions.ConnectionException.UpdateOrderDetailsException;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Delivery;
import model.Order;
import model.Product;
import model.User;

/**
 * Admin Servlet is used for all the salesRep functions. The Servlet handles the
 * information exchange from DB to JSP for finalising an order. The Servlet
 * deletes orders. The Servlet completes deliveries and updates delivery dates.
 */
@WebServlet(name = "Admin", urlPatterns = {"/Admin"})
public class Admin extends HttpServlet {

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
        HttpSession session = request.getSession();
        double totalPrice;
        String form, orderID, deliveryID, deliveryDate;
        Order order;
        User user, salesRep;
        Product product;
        Delivery delivery;
        try {
            //Create connections to the DB
            InvoiceMapper.setConnection();
            OrderMapper.setConnection();
            DeliveryMapper.setConnection();
            UserMapper.setConnection();
            ProductMapper.setConnection();

            //Take the hidden input
            form = request.getParameter("admin");
            switch (form) {
                case "finaliseOrder":
                    //Get the orderID from hidden input
                    orderID = request.getParameter("orderID");
                    
                    //Extract the info for this order from DB
                    order = OrderMapper.getOrder(orderID);
                    
                    //Get the user who created this order
                    user = UserMapper.getUserByID(order.getCustomerID());
                    
                    //Get the product corresponding to the order
                    product = ProductMapper.getProduct(order.getProductID());
                    
                    //Get the delivery for this order
                    delivery = DeliveryMapper.getDelivery(order.getOrderID());
                    
                    //Calculate the totalprice of the invoice
                    totalPrice = product.getPrice() + delivery.getPrice();

                    //Set the objects for the finilise order popup
                    session.setAttribute("userOrder", (Object) user);
                    session.setAttribute("order", (Object) order);
                    session.setAttribute("product", (Object) product);
                    session.setAttribute("totalPrice", (Object) totalPrice);
                    session.setAttribute("popupFinalise", "yes");
                    response.sendRedirect("admin/admin.jsp");
                    return;
                case "deleteOrder":
                    //get the order object from the popup
                    order = (Order) session.getAttribute("order");
                    
                    //delete the order from DB
                    OrderMapper.deleteOrder(order.getOrderID());
                    
                    break;

                case "createInvoice":
                    //Get the order object from the session set by the finalise button
                    order = (Order) session.getAttribute("order");
                    
                    //Get the salesRep object currently working with the program
                    salesRep = (User) session.getAttribute("user");
                    
                    //Update the sales rep in order details
                    OrderMapper.updateSalesRep(salesRep.getAccountID(), order.getOrderID());
                    
                    //Get the date the sales rep chose 
                    deliveryDate = request.getParameter("deliveryDate");
                    
                    //Update the date in the DB
                    DeliveryMapper.updateDeliveryDate(deliveryDate, order.getDeliveryID());
                    
                    //Get the totalPrice of the invoice
                    totalPrice = (double) session.getAttribute("totalPrice");
                    
                    //Update the status to completed
                    OrderMapper.updateOrderStatus(1, order.getOrderID());
                    
                    //Create the invoice
                    InvoiceMapper.createInvoice(totalPrice, order.getOrderID());
                                       
                    break;

                case "completeDelivery":
                    //get the hidden input
                    deliveryID = request.getParameter("deliveryID");
                    
                    //Update the status in DB
                    DeliveryMapper.updateDeliveryStatus(1, deliveryID);
                    
                    //Set an attribute to make the Delivery Tab active
                    session.setAttribute("showDeliveryTab", "yes");
                    
                    break;
                    
                case "popupUpdateDelivery":
                    //Set the popup to show onclick
                    session.setAttribute("popupUpdateDelivery", "yes");
                    
                    //Get the deliveryID from the hidden input and set it to the session
                    session.setAttribute("deliveryID", request.getParameter("deliveryID"));
                    
                    response.sendRedirect("admin/admin.jsp");
                    return;

                case "updateDeliveryDate":
                    //Get the deliveryID from the session 
                    deliveryID = (String) session.getAttribute("deliveryID");
                    
                    //Get the updated Date from the session
                    deliveryDate = request.getParameter("deliveryDate");
                    
                    //Update the Date in DB
                    DeliveryMapper.updateDeliveryDate(deliveryDate, deliveryID);
                    
                    break;
            }
            //Redirect to Orders servlets in order to refresh the ArrayLists
            request.getRequestDispatcher("Orders").forward(request, response);
        } catch (DeleteOrderException ex) {
            ex.printStackTrace();
            session.setAttribute("error", "DeleteOrderException");
            response.sendRedirect("admin/admin.jsp");
        } catch (CreateInvoiceException ex) {
            ex.printStackTrace();
            session.setAttribute("error", "CreateInvoiceException");
            response.sendRedirect("admin/admin.jsp");
        } catch (ConnectionException ex) {
            ex.printStackTrace();
            session.setAttribute("error", "ConnectionException");
            response.sendRedirect("admin/admin.jsp");
        } catch (QueryException ex) {
            ex.printStackTrace();
            session.setAttribute("error", "QueryException");
            response.sendRedirect("admin/admin.jsp");
        } catch (UpdateOrderDetailsException ex) {
            ex.printStackTrace();
            session.setAttribute("error", "UpdateOrderDetailsException");
            response.sendRedirect("admin/admin.jsp");
        } finally {
            DB.releaseConnection(OrderMapper.getCon());
            DB.releaseConnection(InvoiceMapper.getCon());
            DB.releaseConnection(DeliveryMapper.getCon());
            DB.releaseConnection(ProductMapper.getCon());
            DB.releaseConnection(UserMapper.getCon());
        }
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
        try {
            processRequest(request, response);
        } catch (IOException | ServletException ex) {
            printServerFailure(response);
        }
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
        try {
            processRequest(request, response);
        } catch (IOException | ServletException ex) {
            printServerFailure(response);
        }
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

    private void printServerFailure(HttpServletResponse response) {
        response.setContentType("text/html;charset=UTF-8");
        try {
            PrintWriter out = response.getWriter();
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Server Failure</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Our servers can`t handle your request at the moment. We are trying to fix this as soon as possible. Please try again later.");
            out.println("</body>");
            out.println("</html>");
        } catch (IOException ex) {

        }
    }

}
