/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package utility;

import dao.ConnectionManager;
import dao.UserDAO;
import entity.SalesOrderDetails;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import static java.lang.System.out;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLConnection;
import java.nio.charset.StandardCharsets;
import static java.nio.charset.StandardCharsets.ISO_8859_1;
import static java.nio.charset.StandardCharsets.UTF_8;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Base64;
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
        String debtorCodeRetrieved = request.getParameter("debtorCode");
        String statusRetrieved = request.getParameter("status");
        String deliveryDateRetrieved = request.getParameter("deliveryDate");
        String[] qtyItemCodeRetrieved = request.getParameterValues("qty"); 
        String[] itemCodeRetrieved = request.getParameterValues("itemCode");
        String[] originalQtyRetrieved = request.getParameterValues("originalQty");
        String[] unitPriceRetrieved = request.getParameterValues("unitPrice");
        String lastTimeStampRetrieved = request.getParameter("lastModifiedTimeStamp");
        String lastModifiedByRetrieved = request.getParameter("lastModifiedBy");
        String paperBagRequiredRetrieved = request.getParameter("paperBagRequired");
        int paperBagRequiredInt = Integer.parseInt(paperBagRequiredRetrieved);
        String preferredLanguageRetrieved = request.getParameter("preferredLanguage");

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
                    String unitPrice = unitPriceRetrieved[i];
                    
                    int qtyToRefund = Integer.parseInt(originalQty)-Integer.parseInt(qty);
                    String qtyToRefundString = ""+qtyToRefund;
                    
                    double unitPriceDouble = Double.parseDouble(unitPrice);
                    
                    String salesOrderQuantitySql = "";
                    
                    
                    if(statusRetrieved.equals("Delivered")){
                        
                        //Update Returned Quantity
                        if(qtyToRefund > 0){
                            //update item code qty for each item
                            salesOrderQuantitySql = "UPDATE `sales_order_quantity` SET qty ='"+qty+"', ReturnedQty = ReturnedQty + '"+qtyToRefundString+"' WHERE orderID = '" + orderIDRetrieved + "' "
                            + "AND itemCode ='"+itemCode+"'";
                            
                            double subtotal = qtyToRefund*unitPriceDouble;
                            
                            double totalAmount = subtotal*1.07;
                            
                            increaseCustomerWalletAmount(debtorCodeRetrieved, totalAmount);
                            
                            boolean createdNewTransaction = createNewTransaction(statusRetrieved,totalAmount,orderIDRetrieved);
                            
                            out.println("created new transaction: "+createdNewTransaction);
                            
                        }else if(qtyToRefund == 0){
                            salesOrderQuantitySql = "UPDATE `sales_order_quantity` SET qty ='"+qty+"' WHERE orderID = '" + orderIDRetrieved + "' "
                            + "AND itemCode ='"+itemCode+"'";
                        }else{
                            request.setAttribute("status", "Error updating! Please enter a quanty that is lower than the current quantity for item "+itemCode);

                            request.getRequestDispatcher("salesOrder.jsp").forward(request, response);
                        } 
                    
                    }else{
                        
                        //Update Reduced Quantity
                        if(qtyToRefund > 0){
                            //update item code qty for each item
                            salesOrderQuantitySql = "UPDATE `sales_order_quantity` SET qty ='"+qty+"', ReducedQty = ReducedQty + '"+qtyToRefundString+"' WHERE orderID = '" + orderIDRetrieved + "' "
                            + "AND itemCode ='"+itemCode+"'";
                            
                        double subtotal = qtyToRefund*unitPriceDouble;
                            
                        double totalAmount = subtotal*1.07;
                            
                        increaseCustomerWalletAmount(debtorCodeRetrieved, totalAmount);
                        
                        boolean createdNewTransaction = createNewTransaction(statusRetrieved,totalAmount,orderIDRetrieved);

                        out.println("created new transaction: "+createdNewTransaction);
                        
                        }else if(qtyToRefund == 0){
                            salesOrderQuantitySql = "UPDATE `sales_order_quantity` SET qty ='"+qty+"' WHERE orderID = '" + orderIDRetrieved + "' "
                            + "AND itemCode ='"+itemCode+"'";
                        }else{
                            request.setAttribute("status", "Error updating! Please enter a quanty that is lower than the current quantity for item "+itemCode);

                            request.getRequestDispatcher("salesOrder.jsp").forward(request, response);
                        } 
                        
                    }

                    PreparedStatement salesOrderQuantityStmt = conn.prepareStatement(salesOrderQuantitySql);

                    salesOrderQuantityStmt.executeUpdate();
                    
                    out.println("The Preferred language retrieved is"+preferredLanguageRetrieved);
                    
                    SalesOrderDetails salesOrderdetails = salesOrderUtility.getSalesOrderDetails(orderIDRetrieved, statusRetrieved);
                    String deliverContact = salesOrderdetails.getDeliverContact();                 
                    String debtorName = salesOrderdetails.getDebtorName();
                    
                    // SMS Notification
                    if (orderIDRetrieved != null && preferredLanguageRetrieved != null && deliverContact != null){
                        if (orderIDRetrieved.length() == 11 &&  preferredLanguageRetrieved.length() == 7 && deliverContact.length() == 8){

                            boolean smsSentForEditOrder = sendSmsForEditOrder(preferredLanguageRetrieved, deliverContact, orderIDRetrieved);

                            if(!smsSentForEditOrder){
                                //show alert to inform admin sms not sent to customer
                                System.out.println("SMS is not send to " + debtorName  + " contact number at " + deliverContact + ".");
                            } else {
                                //inform admin sms is sent to customer 
                                System.out.println("SMS is send to " + debtorName  + " contact number at " + deliverContact + ".");

                            } 
                        } else {
                            System.out.println("Wrong length in preferred language / orderID / contact number.");
                        }
                    } else {
                         System.out.println("Null in preferred language / orderID / contact number.");
                    }

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
        String lastTimeStampRetrieved = request.getParameter("lastModifiedTimeStamp");
        String lastModifiedBy = request.getParameter("lastModifiedBy");
        
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
                    + " DefaultQty = '" + defaultQuantityRetrieved + "', QtyMultiples = '" +quantityMultiplesRetrieved + "', "
                    + " LastModifiedTimestamp = '" + lastTimeStampRetrieved + "', LastModifiedBy = '" +lastModifiedBy + "' "
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
    
    public static boolean sendSmsForEditOrder(String language, String contactNumber, String orderID){
        boolean result = false;

        String toNumber = "65" + contactNumber;
        String limkeeNum = "6758 5858";
        
        try{
            String data = "";
            String smsMsg = "";

            String api_key = "98060002"; 
            String api_secret = "Infoatlimkee1";  

            if (language.equals("English")){
                smsMsg = "(Lim Kee) Order #" + orderID + "\n" + "Your order has been modified. If you did not authorize this change, please call 6758 5858.";
                    
                //use ascii content for type    
                data += "ID=" + api_key
                        + "&Password=" + api_secret
                        + "&Mobile=" + toNumber
                        + "&Type=" + "A"
                        + "&Message=" + smsMsg;
            } else {
                
                   
                orderID = "#" + orderID;

                //get unicode of each string
                String orderNo = "";
                for(int i =0; i < orderID.length();i++)
                {
                    char c = orderID.charAt(i);
                    orderNo += toUnicode(c);
                }
                
                String num = "";
                for(int i =0; i< limkeeNum.length();i++)
                {
                    char c = limkeeNum.charAt(i);
                    num += toUnicode(c);
                }
              
                smsMsg = "FF0867978BB0FF0900208BA2535553F70020" + orderNo + "000A60A876848BA253555DF24FEe65395B8c6BD5002E002082E5975e672c4EBa4EB281Ea64Cd4F5c002C8BF762E862530020" + num + "002E";

                //use unicode for type
                data += "ID=" + api_key
                        + "&Password=" + api_secret
                        + "&Mobile=" + toNumber
                        + "&Type=" + "U"
                        + "&Message=" + smsMsg;

            }

            URL url = new URL("https://www.commzgate.net/gateway/SendMsg");

            URLConnection conn = url.openConnection();
            conn.setDoOutput(true);
            OutputStreamWriter wr = new OutputStreamWriter(conn.getOutputStream());
            wr.write(data);
            wr.flush();

            // Get the response
            BufferedReader rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
            String line;
            while ((line = rd.readLine()) != null) {
                // Print the response output...
                System.out.println(line);
                  if ((line.substring(0,5)).equals("01010")){
                    //sms is sent
                    result = true;
                } 
            }
            wr.close();
            rd.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
          
    
    return result;  
      
    }
    
    public static String toUnicode(char ch) {
        String unicode = "";
        
        String code = String.format("\\u%04x", (int) ch);
        unicode = code.substring(2);
       
        return unicode;
    }
    
    
    public static double getCustomerWallet(String debtorCode) {
        double walletAmt = 0;
        DecimalFormat df = new DecimalFormat("#0.00");
                  
        try {
            Connection conn = ConnectionManager.getConnection();
        
            PreparedStatement stmt = conn.prepareStatement("select RefundAmt from wallet where DebtorCode = ?");
            
            stmt.setString(1, debtorCode);

            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                walletAmt = rs.getDouble(1);
                walletAmt = Double.parseDouble(df.format(walletAmt));
            }
                        
            ConnectionManager.close(conn, stmt, rs);
        } catch (Exception e) {
            return 0;
        }
        return walletAmt;
    }
    
    public static boolean increaseCustomerWalletAmount(String debtorCode, double totalAmt) {
        boolean result = false;

        double walletAmt = getCustomerWallet(debtorCode);
        double newAmt = walletAmt + totalAmt;
        DecimalFormat df = new DecimalFormat("#0.00");

        
        try {
            Connection conn = ConnectionManager.getConnection();
            
            PreparedStatement stmt = conn.prepareStatement("update wallet set RefundAmt = ? where DebtorCode = ?");
                 
            stmt.setDouble(1, Double.parseDouble(df.format(newAmt)));
            stmt.setString(2, debtorCode);
            
            
            stmt.executeUpdate();            
            result = true;
            
        } catch (Exception e) {
            return false;
        }

        return result;
    }
    
    
    public static boolean createNewTransaction(String status,Double amount,String orderID){

        boolean createNewTransaction = false;
        
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        int countInt = 0;
        
        String createdTimeStamp = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date());
        
        String str = String.format("%1.2f", amount);
        double amount2DP = Double.valueOf(str);

        try {
            conn = ConnectionManager.getConnection();
            
            String populateMap = "select COUNT(ID) from transaction";

            pstmt = conn.prepareStatement(populateMap);
            rs = pstmt.executeQuery();
            
            System.out.println("Passed connection");

            while (rs.next()) {
                
                String count = rs.getString("COUNT(ID)");
                countInt = Integer.parseInt(count);

            }
        }catch(SQLException e){
            
            System.out.println("SQLException thrown by createNewWallet method");
            System.out.println(e.getMessage());
            
        }
        
        
        try{
            out.println("passes conn");

            String sql = "INSERT INTO transaction " + "VALUES('"+ ++countInt +"','"+status+"','"+createdTimeStamp+"','"+amount2DP+"',"
                    + "'"+orderID+"')";
                    
            PreparedStatement stmt = conn.prepareStatement(sql);
            out.println("passes stmt");

            stmt.executeUpdate();
            out.println("passes rs");
            
            createNewTransaction = true;
            
        }catch(SQLException e){
            
            System.out.println("SQLException thrown by createNewTransaction method");
            System.out.println(e.getMessage());
            
        }
        
        
        return createNewTransaction;

    }
    
    
}
