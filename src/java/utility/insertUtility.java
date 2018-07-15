/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package utility;

import dao.ConnectionManager;
import dao.UserDAO;
import java.io.IOException;
import static java.lang.System.out;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Rizza
 */
public class insertUtility {
    
    public static void insert(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        //Gets all the parameters from the form
        String debtorCode = request.getParameter("debtorCode");
        String companyCode = request.getParameter("companyCode");
        String hashPassword = request.getParameter("hashPassword");
        String companyName = request.getParameter("companyName");
        String debtorName = request.getParameter("debtorName");
        String deliverContact = request.getParameter("deliverContact");
        String deliverFax1 = request.getParameter("deliverFax1");
        String inAddr1 = request.getParameter("inAddr1");
        String inAddr2 = request.getParameter("invAddr2");
        String inAddr3 = request.getParameter("invAddr3");
        String inAddr4 = request.getParameter("invAddr4d");
        String deliverAddr1 = request.getParameter("deliverAddr1");
        String deliverAddr2 = request.getParameter("deliverAddr2");
        String deliverAddr3 = request.getParameter("deliverAddr3");
        String deliverAddr4 = request.getParameter("deliverAddr4");
        String displayTerm = request.getParameter("displayTerm");
        String status = request.getParameter("status");
        String routeNumber = request.getParameter("routeNumber");
        
        //Converts normal password to hashpassword
        String newPasswordHash = loginUtility.getSha256(hashPassword);
        
        try {

            Connection conn = ConnectionManager.getConnection();
            out.println("passes conn");

            String sql = "INSERT INTO debtor " + "VALUES('"+ debtorCode+"','"+companyCode+"','"+newPasswordHash+"',"
                    + "'"+companyName+"','"+debtorName+"','"+deliverContact+"','"+deliverFax1+"','"+inAddr1+"',"
                    + "'"+inAddr2+"','"+inAddr3+"','"+inAddr4+"','"+deliverAddr1+"','"+deliverAddr2+"',"
                    + "'"+deliverAddr3+"','"+deliverAddr4+"','"+displayTerm+"','"+status+"','"+routeNumber+"')";
                    
            PreparedStatement stmt = conn.prepareStatement(sql);
            out.println("passes stmt");

            stmt.executeUpdate();
            out.println("passes rs");

        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
            request.setAttribute("status", "Error updating!");
        }
        
        request.setAttribute("status", "Record inserted successfully!");

        request.getRequestDispatcher("userMGMT.jsp").forward(request, response);
        
    }
    
        public static void newCatalogueItem(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String itemCodeRetrieved = catalogueCheckForNull(request.getParameter("itemCode"));
        String descriptionRetrieved = catalogueCheckForNull(request.getParameter("description"));
        String chineseDescriptionRetrieved = catalogueCheckForNull(new String (request.getParameter("descriptionChinese").getBytes ("iso-8859-1"), "UTF-8"));
        String unitPriceRetrieved = catalogueCheckForNull(request.getParameter("unitPrice"));
        String imageURLRetrieved = catalogueCheckForNull(request.getParameter("imageURL"));
        String defaultQuantityRetrieved = catalogueCheckForNull(request.getParameter("defaultQuantity"));
        String quantityMultiplesRetrieved = catalogueCheckForNull(request.getParameter("quantityMultiples"));  
        String unitofMetricRetrieved = catalogueCheckForNull(new String (request.getParameter("unitOfMetric").getBytes ("iso-8859-1"), "UTF-8"));
        String retailPriceRetrieved = catalogueCheckForNull(request.getParameter("retailPrice"));  
        
//        if(itemCodeRetrieved.equals("")||descriptionRetrieved.equals("")||descriptionChineseRetrieved.equals("")
//            ||unitPriceRetrieved.equals("")||imageURLRetrieved.equals("")||defaultQuantityRetrieved.equals("")
//            ||quantityMultiplesRetrieved.equals("")){
//            
//            request.setAttribute("status", "Fields cannot be left blank!");
//            request.getRequestDispatcher("newCatalogueItem.jsp").forward(request, response);
//        }

        try {

            Connection conn = ConnectionManager.getConnection();
            out.println("passes conn");

            String sql = "INSERT INTO order_item " + "VALUES('"+ itemCodeRetrieved+"','"+descriptionRetrieved+"','"+chineseDescriptionRetrieved+"',"
                    + "'"+unitPriceRetrieved+"','"+retailPriceRetrieved+"','"+unitofMetricRetrieved+"','"
                    +imageURLRetrieved+"','"+defaultQuantityRetrieved
                    +"','"+quantityMultiplesRetrieved+"')";

            PreparedStatement stmt = conn.prepareStatement(sql);
            out.println("passes stmt");

            stmt.executeUpdate();
            out.println("passes rs");

        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
            request.setAttribute("status", "Error updating!");
        }
        
        request.setAttribute("status", "Record inserted successfully!");

        request.getRequestDispatcher("catalogue.jsp").forward(request, response);
        
    }
    
    private static String catalogueCheckForNull(String string){
       if(string == null || string.equals("null")){
           return "-";
       }
       return string;
   }    
        
        
}
