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
import java.net.URL;
import java.nio.charset.StandardCharsets;
import static java.nio.charset.StandardCharsets.ISO_8859_1;
import static java.nio.charset.StandardCharsets.UTF_8;
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
public class editUtility {
    
    public static void update(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        //HttpSession session = request.getSession();
        //String userNameRetrieved = (String) session.getAttribute("username");

        //out.println("User retrieved is :"+userNameRetrieved);
        //String IDRetrieved = request.getParameter("ID");
        
        String debtorCodeRetrived = checkForNull(request.getParameter("debtorCode"));
        String companyCodeRetrieved = checkForNull(request.getParameter("companyCode"));
        //String newPasswordRetrieved = request.getParameter("hashPassword");
        String companyNameRetrieved = checkForNull(request.getParameter("companyName"));
        String debtorNameRetrieved = checkForNull(request.getParameter("debtorName"));
        String deliverContactRetrieved = checkForNull(request.getParameter("deliverContact"));
        String deliverContact2Retrieved = checkForNull(request.getParameter("deliverContact2"));
        String invAddr1Retrieved = checkForNull(request.getParameter("invAddr1"));
        String invAddr2Retrieved = checkForNull(request.getParameter("invAddr2"));
        String invAddr3Retrieved = checkForNull(request.getParameter("invAddr3"));
        String invAddr4Retrieved = checkForNull(request.getParameter("invAddr4"));
        String deliverAddr1Retrieved = checkForNull(request.getParameter("deliverAddr1"));
        String deliverAddr2Retrieved = checkForNull(request.getParameter("deliverAddr2"));
        String deliverAddr3Retrieved = checkForNull(request.getParameter("deliverAddr3"));
        String deliverAddr4Retrieved = checkForNull(request.getParameter("deliverAddr4"));
        String displayTermRetrieved = checkForNull(request.getParameter("displayTerm"));
        String statusRetrieved = checkForNull(request.getParameter("status"));
        String routeNumberRetrieved = checkForNull(request.getParameter("routeNumber"));
        int routeNumber = Integer.parseInt(routeNumberRetrieved);
        
        //Converts normal password to hashpassword
        //String newPasswordHash = loginUtility.getSha256(newPasswordRetrieved);
        
//        out.println(debtorCodeRetrived);
//        out.println(companyCodeRetrieved);
//        out.println(companyNameRetrieved);
//        out.println(debtorNameRetrieved);
//        out.println(deliverContactRetrieved);
//        out.println(deliverContact2Retrieved);
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

            String sql = "UPDATE `debtor` SET CompanyCode='" + companyCodeRetrieved 
                    + "', DebtorName = '" +debtorNameRetrieved + "', "
                    + " CompanyName = '" + companyNameRetrieved + "', DeliverContact = '" +deliverContactRetrieved + "', "
                    + " DeliverContact2 = '" + deliverContact2Retrieved + "', invAddr1 = '" +invAddr1Retrieved + "', "
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

            for(int i=0; i<qtyItemCodeRetrieved.length; i++){

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
        
        String itemCodeRetrieved = request.getParameter("itemCode");
        String descriptionRetrieved = request.getParameter("description");
        String chineseDescriptionRetrieved = new String (request.getParameter("descriptionChinese").getBytes ("iso-8859-1"), "UTF-8");
        String unitOfMetricRetrieved = new String (request.getParameter("unitOfMetric").getBytes ("iso-8859-1"), "UTF-8");
        String unitPriceRetrieved = request.getParameter("unitPrice");
        String retailPriceRetrieved = request.getParameter("retailPrice");
        String imageURLRetrieved = request.getParameter("imageURL");
        String defaultQuantityRetrieved = request.getParameter("defaultQuantity");
        String quantityMultiplesRetrieved = request.getParameter("quantityMultiples");
        
        //System.out.println("Debugging line: "+chineseDescriptionRetrieved+str+test);
        
        try {

            Connection conn = ConnectionManager.getConnection();
            out.println("passes conn");
            
            
            String sql = "UPDATE `order_item` SET ItemCode='" + itemCodeRetrieved + "',"
                    + " Description = '" + descriptionRetrieved + "', Description2 = '" +chineseDescriptionRetrieved + "', "
                    + " UnitPrice = '" + unitPriceRetrieved + "', RetailPrice = '" +retailPriceRetrieved 
                    + "' , UnitOfMetric = '" +unitOfMetricRetrieved + "', ImageURL = '" +imageURLRetrieved + "', "
                    + " DefaultQty = '" + defaultQuantityRetrieved + "', QtyMultiples = '" +quantityMultiplesRetrieved + "' "
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
    
    private static String checkForNull(String string){
       if(string == null || string.equals("null")){
           return "";
       }
       return string;
   }
    
    
}
