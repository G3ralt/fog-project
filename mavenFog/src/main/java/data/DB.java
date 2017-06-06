package data;

import exceptions.ConnectionException;
import exceptions.ConnectionException.QueryException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Random;

public class DB {
    private final static String DRIVER = "com.mysql.jdbc.Driver";
    private final static String URL = "jdbc:mysql://localhost:3306/fog";
    private final static String ID = "fog";
    private final static String PASSWORD = "fog123";
    
    /**
     * Creates connection to the Database.
     * @return Connection con
     * @throws ConnectionException if the connection is not established. 
     */   
    public static Connection createConnection() throws ConnectionException {
        Connection con = null;
        try {
            Class.forName(DRIVER);
            con = DriverManager.getConnection(URL, ID, PASSWORD);
        } catch (SQLException | ClassNotFoundException e) {
            throw new ConnectionException();
        } 
        return con;
    }
    
    /**
     * Closes the connection to the Database
     * @param con from the Mapper classes
     */
    public static void releaseConnection(Connection con) {
        if (con!=null) {    
            try {
                con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }    
    }
    
    /**
     * Closes a given PreparedStatement
     * @param stmt from the Mapper classes
     */
    public static void closeStmt(PreparedStatement stmt) {
        if (stmt != null) {
            try {
                stmt.close();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
    }
    
    /**
     * Closes a given ResultSet
     * @param rs from the Mapper classes
     */
    public static void closeRs(ResultSet rs) {
        if (rs != null) {
            try {
                rs.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
    
    /**
     * Makes sure the ID is unique by seaching the Database
     * @param table in the Database
     * @param column in the Database
     * @param con from the Mapper classes
     * @return String uniqueID for the Mapper Classes to put into the Database
     * @throws QueryException if not executable
     */
    public static String generateID(String table, String column, Connection con) throws QueryException {
        String uniqueID = randomID();
        String sql = "SELECT " + column + " FROM " + table + " WHERE " + column + " = '" + uniqueID +"'";
        PreparedStatement stmt = null;
        ResultSet rs = null;
        try{
            stmt = con.prepareStatement(sql);
            rs = stmt.executeQuery();
            if (rs.next()) {
                generateID(table, column, con);
            } else {
                return uniqueID;
            }
        } catch (SQLException e) {
            throw new QueryException();
        
        } finally {
            closeRs(rs);
            closeStmt(stmt);
        }
        return uniqueID;
    }
    
    /**
     * Creates random String IDs with 10 integers
     * @return String uniqueID
     */
    private static String randomID() {
        String uniqueID = "";
        Random rand = new Random();
        while (uniqueID.length()<10) {
            uniqueID += Integer.toString(rand.nextInt(10) + 0);
        }
        return uniqueID;
    }
    
    
}
