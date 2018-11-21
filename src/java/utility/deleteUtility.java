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
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.text.DecimalFormat;
import java.util.Base64;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import static utility.editUtility.createNewTransaction;
import static utility.editUtility.getCustomerWallet;

/**
 *
 * @author Rizza
 */
public class deleteUtility {
    
    public static void delete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String debtorCodeRetrived = request.getParameter("recordToBeDeleted");
        
        System.out.println("debtorCodeRetrived is : "+debtorCodeRetrived);

        try {

            Connection conn = ConnectionManager.getConnection();
            out.println("passes conn");

            String sql = "UPDATE `debtor` SET Status='Inactive'"
                    + "WHERE DebtorCode = '" + debtorCodeRetrived + "'";

            PreparedStatement stmt = conn.prepareStatement(sql);
            out.println("passes stmt");

            stmt.executeUpdate();
            out.println("passes rs");

        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
            request.setAttribute("status", "Error updating!");
        }
        
        request.setAttribute("status", "Customer deactivated successfully!");

        request.getRequestDispatcher("customer.jsp").forward(request, response);
        
    }
    
    public static void deleteMultiple(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String[] debtorCodesRetrived = request.getParameterValues("recordsToBeDeleted"); 

        if(debtorCodesRetrived==null){
            request.getRequestDispatcher("customer.jsp").forward(request, response);
        }else{ 
            
            int stringArrayCount = getActualSize(debtorCodesRetrived);
            int count = 0;

            for(int i=0; i<stringArrayCount; i++){

                try {
                    String debtorCode = debtorCodesRetrived[count];

                    Connection conn = ConnectionManager.getConnection();
                    out.println("passes conn");

                    String sql = "UPDATE `debtor` SET Status='Inactive'"
                    + "WHERE DebtorCode = '" + debtorCode + "'";
                    
                    PreparedStatement stmt = conn.prepareStatement(sql);
                    out.println("passes stmt");

                    stmt.executeUpdate();
                    out.println("passes rs");

                } catch (SQLException ex) {
                    Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
                    request.setAttribute("status", "Error updating!");
                }

                count++;
            }
            request.setAttribute("status", "Record deleted successfully!");

            request.getRequestDispatcher("customer.jsp").forward(request, response);
        }
    }
    
    public static int getActualSize(String[] items){
        int size=0;
        
        for(int i=0;i<items.length;i++)
        {
            if(items[i]!=null)
            {
                size=size+1;
            }
        }
        return size;

    }

    
    public static void cancelSalesOrder(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String orderIDRetrieved = request.getParameter("orderIDRecordToBeDeleted");
        String cancelledReasonRetrieved = request.getParameter("cancelledReason");
        String preferredLanguageRetrieved = request.getParameter("preferredLanguage");
        String lastModifiedTimeStampRetrieved = request.getParameter("lastModifiedTimeStamp");
        String lastModifiedByRetrieved = request.getParameter("lastModifiedBy");
        String statusRetrieved = request.getParameter("statusConfirmation");
        String amountToBeAdded = request.getParameter("amountToBeAdded");
        
        HttpSession session = request.getSession();
        
        if(cancelledReasonRetrieved.equals("")||cancelledReasonRetrieved==null||cancelledReasonRetrieved.equals("null")){

            session.setAttribute("orderStatus", "Please enter a cancelled reason!"); 
            response.sendRedirect("cancelSalesOrderConfirmation.jsp");
        }else{

            try {

                Connection conn = ConnectionManager.getConnection();
                out.println("passes conn");

                String cancelSalesOrderSQL = "UPDATE `sales_order` SET Status='Cancelled',"
                        + " CancelledReason = '" + cancelledReasonRetrieved + "',"
                        + " LastModifiedTimestamp = '" + lastModifiedTimeStampRetrieved + "',"
                        + " LastModifiedBy = '" + lastModifiedByRetrieved + "'"
                        + "WHERE OrderID = '" + orderIDRetrieved + "'";


                PreparedStatement stmt1 = conn.prepareStatement(cancelSalesOrderSQL);

                out.println("passes stmt");

                stmt1.executeUpdate();

                out.println("passes rs");
                
                
                if(statusRetrieved.equals("pendingDelivery")){
                    statusRetrieved = "Pending Delivery";
                }
                
                
                SalesOrderDetails salesOrderdetails = salesOrderUtility.getSalesOrderDetails(orderIDRetrieved, "Cancelled");
                
                String deliverContact = salesOrderdetails.getDeliverContact();  
                String debtorName = salesOrderdetails.getDebtorName();
                
                double amountToBeAddedDouble = Double.parseDouble(amountToBeAdded);

                String customerCode = salesOrderUtility.getCustomerCode(orderIDRetrieved, "Cancelled");

                boolean increaseCustomerWallet = increaseCustomerWalletAmount(customerCode,amountToBeAddedDouble);
                
                out.print("Customer's wallet credited: "+increaseCustomerWallet);
                
                boolean createdNewTransaction = createNewTransaction("Cancelled",amountToBeAddedDouble,orderIDRetrieved);
                            
                out.println("created new transaction: "+createdNewTransaction);
                
                if (orderIDRetrieved != null && preferredLanguageRetrieved != null && deliverContact != null){
                    if (orderIDRetrieved.length() == 11 &&  preferredLanguageRetrieved.length() == 7 && deliverContact.length() == 8){

                        boolean smsSentForCancelOrder = sendSmsForCancelOrder(preferredLanguageRetrieved, deliverContact, orderIDRetrieved);

                        if(!smsSentForCancelOrder){
                            //show alert to inform admin sms not sent to customer
                            System.out.println("SMS is not send to " + debtorName  + "'s  contact number at " + deliverContact + ".");
                        } else {
                            //inform admin sms is sent to customer 
                            System.out.println("SMS is send to " + debtorName  + "'s contact number at +65 " + deliverContact + ".");

                        } 
                    } else {
                        System.out.println("Wrong length in preferred language / orderID / contact number.");
                    } 
                } else {
                    System.out.println("Null in preferred language / orderID / contact number.");
                }
                
                session.setAttribute("orderStatus", "Sales Order cancelled successfully!"); 
                response.sendRedirect("salesOrder.jsp");

            } catch (SQLException ex) {
                Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
                session.setAttribute("orderStatus", "Error updating Sales Order!"); 
                response.sendRedirect("salesOrder.jsp");
            }
        
        }
    }
    
    
    public static void deleteMultipleSalesOrder(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        HttpSession session = request.getSession();

        String[] orderIDsRetrived = (String[])session.getAttribute("orderIDArrayCancelled");
        
        String statusRetrieved = request.getParameter("status");
        String deliveryDateRetrieved = request.getParameter("deliveryDate");


        if(orderIDsRetrived == null){
            request.getRequestDispatcher("salesOrder.jsp").forward(request, response);
        }else{ 
            
            int stringArrayCount = getActualSize(orderIDsRetrived);

            for(int i=0; i<stringArrayCount; i++){

                try {

                    Connection conn = ConnectionManager.getConnection();
                    out.println("passes conn");
                    out.println("Test "+orderIDsRetrived[i]);
                    
                    String salesOrderDetailSql = "";
                    if(deliveryDateRetrieved.equals("None")){
                        salesOrderDetailSql = "DELETE FROM `sales_order_detail` WHERE orderID = '" + orderIDsRetrived[i] + "' ";
                    }else{
                        salesOrderDetailSql = "DELETE FROM `sales_order_detail` WHERE orderID = '" + orderIDsRetrived[i] + "' "
                            + "AND DeliveryDate='"+deliveryDateRetrieved+"' ";
                    }
                    
                    String salesOrderQtySql = "DELETE FROM `sales_order_quantity` WHERE orderID = '" + orderIDsRetrived[i] + "' ";

                    String salesOrderSql = "DELETE FROM `sales_order` WHERE orderID = '" + orderIDsRetrived[i] + "' "
                            + "AND status='"+statusRetrieved+"' ";

                    PreparedStatement stmt1 = conn.prepareStatement(salesOrderDetailSql);
                    PreparedStatement stmt2 = conn.prepareStatement(salesOrderQtySql);
                    PreparedStatement stmt3 = conn.prepareStatement(salesOrderSql);
                    out.println("passes stmt");

                    stmt1.executeUpdate();
                    stmt2.executeUpdate();
                    stmt3.executeUpdate();
                    out.println("passes rs");

                } catch (SQLException ex) {
                    Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
                    request.setAttribute("status", "Error updating!");
                }

            }
            
            request.setAttribute("status", "Records deleted successfully!");

            request.getRequestDispatcher("salesOrder.jsp").forward(request, response);
        }
    }
    
    public static void deleteCatalogue(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String itemCodeRetrieved = request.getParameter("recordToBeDeleted");
        String lastModifiedTimeStampRetrieved = request.getParameter("lastModifiedTimeStamp");
        String lastModifiedByRetrieved = request.getParameter("lastModifiedBy");
        HttpSession session = request.getSession();

        try {

            Connection conn = ConnectionManager.getConnection();
            out.println("passes conn");

            //String sql = "DELETE FROM `order_item` WHERE itemCode = '" + itemCodeRetrieved + "'";
            String sql = "UPDATE `order_item` SET Status='Inactive'," 
                + " LastModifiedTimestamp = '" + lastModifiedTimeStampRetrieved + "',"
                + " LastModifiedBy = '" + lastModifiedByRetrieved + "'"
                + "WHERE ItemCode = '" + itemCodeRetrieved + "'";
            
            PreparedStatement stmt = conn.prepareStatement(sql);
            out.println("passes stmt");

            stmt.executeUpdate();
            out.println("passes rs");
            
            session.setAttribute("catalogueStatus", "Catalogue item deactivated successfully!"); 
            response.sendRedirect("catalogue.jsp");

        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);

            session.setAttribute("catalogueStatus", "Error deactivating catalogue item!"); 
            response.sendRedirect("catalogue.jsp");
        }        
    }
    
    public static void deleteMultipleCatalogue(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        HttpSession session = request.getSession();
        String[] itemCodesRetrieved = (String[])session.getAttribute("itemCodesRetrieved");

        if(itemCodesRetrieved==null){
            
            request.getRequestDispatcher("catalogue.jsp").forward(request, response);
            
        }else{ 
            
            for(int i=0; i<itemCodesRetrieved.length; i++){

                try {
                    String itemCode = itemCodesRetrieved[i];

                    Connection conn = ConnectionManager.getConnection();
                    out.println("passes conn");

                    String sql = "DELETE FROM `order_item` WHERE ItemCode = '" + itemCode + "'";

                    PreparedStatement stmt = conn.prepareStatement(sql);
                    out.println("passes stmt");

                    stmt.executeUpdate();
                    out.println("passes rs");

                } catch (SQLException ex) {
                    Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
                    request.setAttribute("status", "Error updating!");
                }

            }
            request.setAttribute("status", "Records deleted successfully!");

            request.getRequestDispatcher("catalogue.jsp").forward(request, response);
        }
    }
    
    public static void activateCatalogue(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String itemCodeRetrieved = request.getParameter("recordToBeActivated");
        String lastModifiedTimeStampRetrieved = request.getParameter("lastModifiedTimeStamp");
        String lastModifiedByRetrieved = request.getParameter("lastModifiedBy");
        HttpSession session = request.getSession();

        try {

            Connection conn = ConnectionManager.getConnection();
            out.println("passes conn");

            String sql = "UPDATE `order_item` SET Status='Active'," 
                + " LastModifiedTimestamp = '" + lastModifiedTimeStampRetrieved + "',"
                + " LastModifiedBy = '" + lastModifiedByRetrieved + "'"
                + "WHERE ItemCode = '" + itemCodeRetrieved + "'";
            
            PreparedStatement stmt = conn.prepareStatement(sql);
            out.println("passes stmt");

            stmt.executeUpdate();
            out.println("passes rs");
            
            session.setAttribute("catalogueStatus", "Catalogue item activated successfully!"); 
            response.sendRedirect("catalogue.jsp");

        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);

            session.setAttribute("catalogueStatus", "Error deactivating catalogue item!"); 
            response.sendRedirect("catalogue.jsp");
        }
        
    }
    
    public static boolean sendSmsForCancelOrder(String language, String contactNumber, String orderID){
        boolean result = false;

       String toNumber = "65" + contactNumber;
       String limkeeNum = "6758 5858";

        try{
            String data = "";
            String smsMsg = "";

            String api_key = "98060002"; 
            String api_secret = "Infoatlimkee1";  

            if (language.equals("English")){
                smsMsg = "(Lim Kee) Order #" + orderID + "\n" + "Your order has been cancelled. If you did not authorize this change, please call 6758 5858.";
                    
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
                for(int i =0; i < orderID.length(); i++)
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
               
                smsMsg = "FF0867978BB0FF0900208BA2535553F70020" + orderNo + "000A60A876848BA253555DF27ECf88Ab53D66D88002E002082E5975e672c4EBa4EB281Ea64Cd4F5c002C8BF762E862530020" + num + "002E";

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
    
}
