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
        
        String debtorCodeRetrived = checkForNull(request.getParameter("debtorCode"));
        String companyCodeRetrieved = checkForNull(request.getParameter("companyCode"));
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
        String lastModifiedTimeStampRetrieved = checkForNull(request.getParameter("lastModifiedTimeStamp"));
        String lastModifiedByRetrieved = checkForNull(request.getParameter("lastModifiedBy"));
        String preferredLanguageRetrieved = checkForNull(request.getParameter("preferredLanguage"));
        
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
                    + " Status = '" + statusRetrieved + "', RouteNumber = '" +routeNumber + "', "
                    + " LastModifiedTimestamp = '" + lastModifiedTimeStampRetrieved + "', LastModifiedBy = '" +lastModifiedByRetrieved + "', "
                    + " PreferredLanguage = '" + preferredLanguageRetrieved + "' "
                    + "WHERE DebtorCode = '" + debtorCodeRetrived + "'";

            PreparedStatement stmt = conn.prepareStatement(sql);
            out.println("passes stmt");

            stmt.executeUpdate();
            out.println("passes rs");

        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
            request.setAttribute("updateSuccess", "Record updated unsuccessfully!");
            
        }
        
        request.setAttribute("updateSuccess", "Record updated successfully!");

        request.getRequestDispatcher("customer.jsp").forward(request, response);
        
    }
    
    
    public static void updateSalesOrder(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        String orderIDRetrieved = request.getParameter("orderID");
        String statusRetrieved = request.getParameter("status");
        String deliveryDateRetrieved = request.getParameter("deliveryDate");
        String[] qtyItemCodeRetrieved = request.getParameterValues("qty"); 
        String[] itemCodeRetrieved = request.getParameterValues("itemCode");
        String[] originalQtyRetrieved = request.getParameterValues("originalQty");
        String lastTimeStampRetrieved = request.getParameter("lastModifiedTimeStamp");
        String lastModifiedByRetrieved = request.getParameter("lastModifiedBy");
        String paperBagRequiredRetrieved = request.getParameter("paperBagRequired");
        int paperBagRequiredInt = Integer.parseInt(paperBagRequiredRetrieved);
        //out.println("qtyRetrieved " + qtyItemCodeRetrieved.length);
        //out.println("qtyRetrieved " + qtyItemCodeRetrieved[0]);
        //out.println("qtyRetrieved " + qtyItemCodeRetrieved[1]);
        //out.println("ItemCodeRetrieved " + itemCodeRetrieved.length);
        //out.println("ItemCodeRetrieved " + itemCodeRetrieved[0]);
        //out.println("ItemCodeRetrieved " + itemCodeRetrieved[1]);
        //out.println("itemCodeRetrieved " + itemCodeRetrieved.length);

        try {

            Connection conn = ConnectionManager.getConnection();
            out.println("passes conn");
            
            //update status,last modified timestamp, last modified by and paper bag required
            String salesOrderSql = "UPDATE `sales_order`\n" +
                "SET Status = '"+statusRetrieved+"', LastModifiedTimestamp ='"+lastTimeStampRetrieved+"' , LastModifiedBy ='"+lastModifiedByRetrieved+"' , PaperBagRequired ='"+paperBagRequiredInt+"'  \n" +
                "WHERE OrderID = \""+orderIDRetrieved+"\"";
            
            //update delivery date
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
                    String originalQty = originalQtyRetrieved[i];
                    int qtyToRefund = Integer.parseInt(originalQty)-Integer.parseInt(qty);
                    String qtyToRefundString = ""+qtyToRefund;
                    
                    //out.println(qty);
                    //out.println(originalQty);
                    //out.println(qtyToRefundString);
                    
                    String salesOrderQuantitySql = "";
                    
                    //Update Quantity
                    if(qtyToRefund >= 0){
                        //update item code qty for each item
                        salesOrderQuantitySql = "UPDATE `sales_order_quantity` SET qty ='"+qty+"', ReturnedQty = ReturnedQty + '"+qtyToRefundString+"' WHERE orderID = '" + orderIDRetrieved + "' "
                        + "AND itemCode ='"+itemCode+"'";
                    }else if(qtyToRefund == 0){
                        salesOrderQuantitySql = "UPDATE `sales_order_quantity` SET qty ='"+qty+"' WHERE orderID = '" + orderIDRetrieved + "' "
                        + "AND itemCode ='"+itemCode+"'";
                    }else{
                        request.setAttribute("status", "Error updating! Please enter a quanty that is lower than the current quantity for item "+itemCode);

                        request.getRequestDispatcher("salesOrder.jsp").forward(request, response);
                    }    

                    PreparedStatement salesOrderQuantityStmt = conn.prepareStatement(salesOrderQuantitySql);

                    salesOrderQuantityStmt.executeUpdate();

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

        request.getRequestDispatcher("salesOrder.jsp").forward(request, response);
        
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
        String newImageURLRetrieved = request.getParameter("newImageURL");
        String imageURLToUpdate = "";
        
// Debugging lines
//        System.out.println("Debugging line: "+itemCodeRetrieved);
//        System.out.println("Debugging line: "+descriptionRetrieved);
//        System.out.println("Debugging line: "+chineseDescriptionRetrieved);
//        System.out.println("Debugging line: "+unitOfMetricRetrieved);
//        System.out.println("Debugging line: "+unitPriceRetrieved);
//        System.out.println("Debugging line: "+retailPriceRetrieved);
//        System.out.println("Debugging line: "+imageURLRetrieved);
//        System.out.println("Debugging line: "+defaultQuantityRetrieved);
//        System.out.println("Debugging line: "+quantityMultiplesRetrieved);

        //to determine which image URL to use, current URL or New URL
        if(newImageURLRetrieved==null){
            imageURLToUpdate=imageURLRetrieved;
        }else{
            imageURLToUpdate=newImageURLRetrieved;
        }
        
        try {

            Connection conn = ConnectionManager.getConnection();
            out.println("passes conn");
            
            
            String sql = "UPDATE `order_item` SET ItemCode='" + itemCodeRetrieved + "',"
                    + " Description = '" + descriptionRetrieved + "', Description2 = '" +chineseDescriptionRetrieved + "', "
                    + " UnitPrice = '" + unitPriceRetrieved + "', RetailPrice = '" +retailPriceRetrieved 
                    + "' , UnitOfMetric = '" +unitOfMetricRetrieved + "', ImageURL = '" +imageURLToUpdate + "', "
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
