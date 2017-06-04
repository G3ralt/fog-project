package servlets;

import data.DB;
import data.UserMapper;
import exceptions.ConnectionException;
import exceptions.ConnectionException.QueryException;
import exceptions.ConnectionException.UpdateUserInfoException;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.User;

/**
 * Profile Servlet is used for updating the user info from the profile page
 */
@WebServlet(name = "Profile", urlPatterns = {"/Profile"})
public class Profile extends HttpServlet {

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
        String accountID, email, password, address, phone, zipCode;
        User user;
        try {
            //Create connection to DB
            UserMapper.setConnection();

            //Get the user from the current session
            user = (User) session.getAttribute("user");

            //Get the account of the current customer
            accountID = user.getAccountID();

            email = request.getParameter("email");
            password = request.getParameter("password");
            address = request.getParameter("address");
            phone = request.getParameter("phone");
            zipCode = request.getParameter("zipCode");

            //Update user info
            if (password!=null && password.length()>1) {
                UserMapper.updatePassword(password, accountID);
            }
            if (address!=null && address.length()>1) {
                UserMapper.updateAdress(address, accountID);
            }
            if (phone!=null && phone.length()>1) {
                UserMapper.updatePhone(phone, accountID);
            }
            if (zipCode!=null && zipCode.length()>1) {
                UserMapper.updateZipcode(zipCode, accountID);
            }
            if (email!=null && email.length()>1) {
                UserMapper.updateEmail(email, accountID);
                
                //Update the user object with the new email
                user = UserMapper.getUser(email);
            } else {
                //Update the user object with the old email
                user = UserMapper.getUser(user.getEmail());
            }
            //Set the user object into the session
            session.setAttribute("user", (Object) user);

            //Redirect back to profile page
            response.sendRedirect("profile/profile.jsp");

        } catch (UpdateUserInfoException ex) {
            ex.printStackTrace();
            session.setAttribute("error", "UpdateUserInfoException");
            response.sendRedirect("profile/profile.jsp");
        } catch (QueryException ex) {
            ex.printStackTrace();
            session.setAttribute("error", "QueryException");
            response.sendRedirect("profile/profile.jsp");
        } catch (ConnectionException ex) {
            ex.printStackTrace();
            session.setAttribute("error", "ConnectionException");
            response.sendRedirect("profile/profile.jsp");
        } finally {
            DB.releaseConnection(UserMapper.getCon());
        }
    }//servlet

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
        } catch (ServletException | IOException ex) {
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
        } catch (ServletException | IOException ex) {
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
            out.println("<h1>Our servers are down at the moment. We are trying to fix this as soon as possible. Please try again later.");
            out.println("</body>");
            out.println("</html>");
        } catch (IOException ex) {

        }
    }
}
