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
        

        try {

            Connection conn = ConnectionManager.getConnection();
            out.println("passes conn");

            String sql = "INSERT INTO debtor " + "VALUES('"+ debtorCode+"','"+companyCode+"','"+hashPassword+"',"
                    + "'"+companyName+"','"+debtorName+"','"+deliverContact+"','"+deliverFax1+"','"+inAddr1+"',"
                    + "'"+inAddr2+"','"+inAddr3+"','"+inAddr4+"','"+deliverAddr1+"','"+deliverAddr2+"',"
                    + "'"+deliverAddr3+"','"+deliverAddr4+"','"+displayTerm+"','"+status+"','"+routeNumber+"')";
                    
            //String sql2 ="INSERT INTO Customers " + "VALUES (1002, 'McBeal', 'Ms.', 'Boston', 2004)";

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

        String itemCodeRetrieved = request.getParameter("itemCode");
        String descriptionRetrieved = request.getParameter("description");
        String descriptionChineseRetrieved = request.getParameter("descriptionChinese");
        String unitPriceRetrieved = request.getParameter("unitPrice");
        String imageURLRetrieved = request.getParameter("imageURL");
        String defaultQuantityRetrieved = request.getParameter("defaultQuantity");
        String quantityMultiplesRetrieved = request.getParameter("quantityMultiples");  
        
        
        if(itemCodeRetrieved.equals("")||descriptionRetrieved.equals("")||descriptionChineseRetrieved.equals("")
            ||unitPriceRetrieved.equals("")||imageURLRetrieved.equals("")||defaultQuantityRetrieved.equals("")
            ||quantityMultiplesRetrieved.equals("")){
            
            request.setAttribute("status", "Fields cannot be left blank!");
            request.getRequestDispatcher("newCatalogueItem.jsp").forward(request, response);
        }

        try {

            Connection conn = ConnectionManager.getConnection();
            out.println("passes conn");

            String sql = "INSERT INTO order_item " + "VALUES('"+ itemCodeRetrieved+"','"+descriptionRetrieved+"','"+descriptionChineseRetrieved+"',"
                    + "'"+unitPriceRetrieved+"','"+imageURLRetrieved+"','"+defaultQuantityRetrieved+"','"+quantityMultiplesRetrieved+"')";

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
    
}
