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
import javax.servlet.http.HttpSession;

/**
 *
 * @author Rizza
 */
public class editUtility {
    
    public static void update(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        //HttpSession session = request.getSession();
        //String userNameRetrieved = (String) session.getAttribute("username");

        //out.println("User retrieved is :"+userNameRetrieved);
        //String IDRetrieved = request.getParameter("ID");
        String debtorCodeRetrived = request.getParameter("debtorCode");
        String companyCodeRetrieved = request.getParameter("companyCode");
        String hashPasswordRetrieved = request.getParameter("hashPassword");
        String companyNameRetrieved = request.getParameter("companyName");
        String debtorNameRetrieved = request.getParameter("debtorName");
        String deliverContactRetrieved = request.getParameter("deliverContact");
        String deliverFax1Retrieved = request.getParameter("deliverFax1");
        String invAddr1Retrieved = request.getParameter("invAddr1");
        String invAddr2Retrieved = request.getParameter("invAddr2");
        String invAddr3Retrieved = request.getParameter("invAddr3");
        String invAddr4Retrieved = request.getParameter("invAddr4");
        String deliverAddr1Retrieved = request.getParameter("deliverAddr1");
        String deliverAddr2Retrieved = request.getParameter("deliverAddr2");
        String deliverAddr3Retrieved = request.getParameter("deliverAddr3");
        String deliverAddr4Retrieved = request.getParameter("deliverAddr4");
        String displayTermRetrieved = request.getParameter("displayTerm");
        String statusRetrieved = request.getParameter("status");
        String routeNumberRetrieved = request.getParameter("routeNumber");
        int routeNumber = Integer.parseInt(routeNumberRetrieved);
        
//        out.println(debtorCodeRetrived);
//        out.println(companyCodeRetrieved);
//        out.println(hashPasswordRetrieved);
//        out.println(companyNameRetrieved);
//        out.println(debtorNameRetrieved);
//        out.println(deliverContactRetrieved);
//        out.println(deliverFax1Retrieved);
//        out.println(invAddr1Retrieved);
//        out.println(invAddr2Retrieved);
//        out.println(invAddr2Retrieved);
//        out.println(invAddr3Retrieved);
//        out.println(invAddr4Retrieved);
//        out.println(deliverAddr1Retrieved);
//        out.println(deliverAddr2Retrieved);
//        out.println(deliverAddr3Retrieved);
//        out.println(deliverAddr4Retrieved);
//        out.println(displayTermRetrieved);
//        out.println(statusRetrieved);
//        out.println(routeNumberRetrieved);
        

        try {

            Connection conn = ConnectionManager.getConnection();
            out.println("passes conn");

            String sql = "UPDATE `debtor` SET CompanyCode='" + companyCodeRetrieved + "',"
                    + " HashPassword = '" + hashPasswordRetrieved + "', DebtorName = '" +debtorNameRetrieved + "', "
                    + " CompanyName = '" + companyNameRetrieved + "', DeliverContact = '" +deliverContactRetrieved + "', "
                    + " DeliverFax1 = '" + deliverFax1Retrieved + "', invAddr1 = '" +invAddr1Retrieved + "', "
                    + " invAddr2 = '" + invAddr2Retrieved + "', invAddr3 = '" +invAddr3Retrieved + "', "
                    + " invAddr4 = '" + invAddr4Retrieved + "', deliverAddr1 = '" +deliverAddr1Retrieved + "', "
                    + " deliverAddr2 = '" + deliverAddr2Retrieved + "', deliverAddr3 = '" +deliverAddr3Retrieved + "', "
                    + " deliverAddr4 = '" + deliverAddr4Retrieved + "', DisplayTerm = '" +displayTermRetrieved + "', "
                    + " Status = '" + statusRetrieved + "', RouteNumber = '" +routeNumber + "' "
                    + "WHERE DebtorCode = '" + debtorCodeRetrived + "'";


//            String sql = "UPDATE `debtor` SET CompanyCode='" + companyCodeRetrieved + "'"
//                    + "WHERE DebtorCode = '" + debtorCodeRetrived + "';";

            PreparedStatement stmt = conn.prepareStatement(sql);
            out.println("passes stmt");

            stmt.executeUpdate();
            out.println("passes rs");

        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
            request.setAttribute("updateSuccess", "Record updated unsuccessfully!");
            
        }
        
        request.setAttribute("updateSuccess", "Record updated successfully!");

        request.getRequestDispatcher("userMGMT.jsp").forward(request, response);
        
    }
    
    
    public static void updateSalesOrder(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        String orderIDRetrieved = request.getParameter("orderID");
        String statusRetrieved = request.getParameter("status");
        String deliveryDateRetrieved = request.getParameter("deliveryDate");
        String[] qtyItemCodeRetrieved = request.getParameterValues("qty"); 
        String[] itemCodeRetrieved = request.getParameterValues("itemCode");
        
        out.println("qtyRetrieved " + qtyItemCodeRetrieved.length);
        out.println("qtyRetrieved " + qtyItemCodeRetrieved[0]);
        out.println("qtyRetrieved " + qtyItemCodeRetrieved[1]);
        out.println("ItemCodeRetrieved " + itemCodeRetrieved.length);
        out.println("ItemCodeRetrieved " + itemCodeRetrieved[0]);
        out.println("ItemCodeRetrieved " + itemCodeRetrieved[1]);
//        out.println("itemCodeRetrieved " + itemCodeRetrieved.length);

        try {

            Connection conn = ConnectionManager.getConnection();
            out.println("passes conn");

            String salesOrderSql = "UPDATE `sales_order`\n" +
                "SET Status = '"+statusRetrieved+"'\n" +
                "WHERE OrderID = \""+orderIDRetrieved+"\"";
            
            String salesOrderDetailSql = "UPDATE `sales_order_detail`\n" +
                "SET DeliveryDate = '"+deliveryDateRetrieved+"'\n" +
                "WHERE OrderID = \""+orderIDRetrieved+"\"";

            PreparedStatement stmt = conn.prepareStatement(salesOrderSql);
            PreparedStatement stmt2 = conn.prepareStatement(salesOrderDetailSql);
            out.println("passes stmt");

            stmt.executeUpdate();
            stmt2.executeUpdate();
            out.println("passes rs");

            for(int i=0; i<qtyItemCodeRetrieved.length-1; i++){

                try {
                    
                    String itemCode = itemCodeRetrieved[i];
                    String qty = qtyItemCodeRetrieved[i];

                    String salesOrderQuantitySql = "UPDATE `sales_order_quantity` SET qty ='"+qty+"' WHERE orderID = '" + orderIDRetrieved + "' "
                            + "AND itemCode ='"+itemCode+"'";

                    PreparedStatement salesOrderQuantityStmt = conn.prepareStatement(salesOrderQuantitySql);
                    //out.println("passes stmt");

                    salesOrderQuantityStmt.executeUpdate();
                    //out.println("passes rs");

                } catch (SQLException ex) {
                    Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
                    request.setAttribute("status", "Error updating!");
                }

            }

            
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
            request.setAttribute("status", "Error updating!");
            
        }

        request.setAttribute("status", "Record updated successfully!");

        request.getRequestDispatcher("salesOrderMGMT.jsp").forward(request, response);
        
    }
    
    
    public static void updateCatalogue(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        
        String itemCodeRetrieved = request.getParameter("itemCode");
        String descriptionRetrieved = request.getParameter("description");
        //String chineseDescriptionRetrieved = request.getParameter("descriptionChinese");
        String unitPriceRetrieved = request.getParameter("unitPrice");
        String imageURLRetrieved = request.getParameter("imageURL");
        String defaultQuantityRetrieved = request.getParameter("defaultQuantity");
        String quantityMultiplesRetrieved = request.getParameter("quantityMultiples");
        
        //System.out.println("Debugging line: "+chineseDescriptionRetrieved);
        
        try {

            Connection conn = ConnectionManager.getConnection();
            out.println("passes conn");
            
            
            // Cannot edit chinese characters for now as the input becomes invalid when the data is parsed from one place
            //to the other
            
            
//            String sql = "UPDATE `order_item` SET ItemCode='" + itemCodeRetrieved + "',"
//                    + " Description = '" + descriptionRetrieved + "', Description2 = '" +chineseDescriptionRetrieved + "', "
//                    + " UnitPrice = '" + unitPriceRetrieved + "', ImageURL = '" +imageURLRetrieved + "', "
//                    + " DefaultQty = '" + defaultQuantityRetrieved + "', QtyMultiples = '" +quantityMultiplesRetrieved + "' "
//                    + "WHERE ItemCode = '" + itemCodeRetrieved + "'";
            
            String sql = "UPDATE `order_item` SET ItemCode='" + itemCodeRetrieved + "',"
                    + " Description = '" + descriptionRetrieved + "', "
                    + " UnitPrice = '" + unitPriceRetrieved + "', ImageURL = '" + imageURLRetrieved + "', "
                    + " DefaultQty = '" + defaultQuantityRetrieved + "', QtyMultiples = '" + quantityMultiplesRetrieved + "' "
                    + "WHERE ItemCode = '" + itemCodeRetrieved + "'";

            PreparedStatement stmt = conn.prepareStatement(sql);

            stmt.executeUpdate();

        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
            request.setAttribute("status", "Error updating!");
            
        }

        request.setAttribute("status", "Record updated successfully!");

        request.getRequestDispatcher("catalogue.jsp").forward(request, response);
        
    }
    
}
