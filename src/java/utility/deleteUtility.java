/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package utility;

import dao.ConnectionManager;
import dao.UserDAO;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import static java.lang.System.out;
import java.net.HttpURLConnection;
import java.net.URL;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.Base64;
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
        
        request.setAttribute("status", "Record deleted successfully!");

        request.getRequestDispatcher("customer.jsp").forward(request, response);
        
    }
    
    public static void deleteMultiple(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        //String debtorCodeRetrived = request.getParameter("recordToBeDeleted");
        String[] debtorCodesRetrived = request.getParameterValues("recordsToBeDeleted"); 
        //System.out.println("length of string array is : "+debtorCodesRetrived.length);
        
        if(debtorCodesRetrived==null){
            request.getRequestDispatcher("customer.jsp").forward(request, response);
        }else{ 
            
            int stringArrayCount = getActualSize(debtorCodesRetrived);
            int count = 0;

            //System.out.println("debtorCodeRetrived is : "+debtorCodesRetrived);
            for(int i=0; i<stringArrayCount; i++){

                try {
                    String debtorCode = debtorCodesRetrived[count];

                    Connection conn = ConnectionManager.getConnection();
                    out.println("passes conn");

                    //String sql = "DELETE FROM `debtor` WHERE DebtorCode = '" + debtorCode + "'";
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
        
        System.out.println("Last modified timestamp is: "+lastModifiedTimeStampRetrieved);
        System.out.println(lastModifiedByRetrieved);
        
        if(cancelledReasonRetrieved.equals("")||cancelledReasonRetrieved==null||cancelledReasonRetrieved.equals("null")){
            request.setAttribute("msgStatus", "Please enter a cancelled reason!");
            request.getRequestDispatcher("cancelSalesOrderConfirmation.jsp").forward(request, response);
        }else{

            try {

                Connection conn = ConnectionManager.getConnection();
                out.println("passes conn");

                //String salesOrderDetailSql = "DELETE FROM `sales_order_detail` WHERE orderID = '" + orderIDRetrieved + "' "
                        //+ "AND DeliveryDate='"+deliveryDateRetrieved+"' ";

                //String salesOrderQtySql = "DELETE FROM `sales_order_quantity` WHERE orderID = '" + orderIDRetrieved + "' ";

                //String salesOrderSql = "DELETE FROM `sales_order` WHERE orderID = '" + orderIDRetrieved + "' "
                        //+ "AND status='"+statusRetrieved+"' ";

                String cancelSalesOrderSQL = "UPDATE `sales_order` SET Status='Cancelled',"
                        + " CancelledReason = '" + cancelledReasonRetrieved + "',"
                        + " LastModifiedTimestamp = '" + lastModifiedTimeStampRetrieved + "',"
                        + " LastModifiedBy = '" + lastModifiedByRetrieved + "'"
                        + "WHERE OrderID = '" + orderIDRetrieved + "'";


                PreparedStatement stmt1 = conn.prepareStatement(cancelSalesOrderSQL);
                //PreparedStatement stmt2 = conn.prepareStatement(salesOrderQtySql);
                //PreparedStatement stmt3 = conn.prepareStatement(salesOrderSql);
                out.println("passes stmt");

                stmt1.executeUpdate();
                //stmt2.executeUpdate();
                //stmt3.executeUpdate();
                out.println("passes rs");
                
                //boolean smsSentForCancelOrder = sendSmsForCancelOrder(preferredLanguageRetrieved, "97597790", orderIDRetrieved);    
                //System.out.println("Cancel Order SMS Sent is " + smsSentForCancelOrder);


            } catch (SQLException ex) {
                Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
                request.setAttribute("status", "Error updating record!");
            }

            request.setAttribute("status", "Record cancelled successfully!");

            request.getRequestDispatcher("salesOrder.jsp").forward(request, response);
        
        }
    }
    
    
    public static void deleteMultipleSalesOrder(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        //String[] orderIDsRetrived = (String[])request.getAttribute("orderIDArray");
        String[] orderIDsRetrived = (String[])session.getAttribute("orderIDArrayCancelled");
        
        String statusRetrieved = request.getParameter("status");
        String deliveryDateRetrieved = request.getParameter("deliveryDate");
        //System.out.println("testing"+orderIDsRetrived[0]);
        //String[] orderIDsRetrived = request.getParameterValues("recordsToBeDeleted"); 

        if(orderIDsRetrived == null){
            request.getRequestDispatcher("salesOrder.jsp").forward(request, response);
        }else{ 
            
            int stringArrayCount = getActualSize(orderIDsRetrived);
            //int count = 0;

            //System.out.println("debtorCodeRetrived is : "+debtorCodesRetrived);
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

                //count++;
            }
            
            request.setAttribute("status", "Records deleted successfully!");

            request.getRequestDispatcher("salesOrder.jsp").forward(request, response);
        }
    }
    
    public static void deleteCatalogue(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String itemCodeRetrieved = request.getParameter("recordToBeDeleted");
        String lastModifiedTimeStampRetrieved = request.getParameter("lastModifiedTimeStamp");
        String lastModifiedByRetrieved = request.getParameter("lastModifiedBy");
        
        //System.out.println("debtorCodeRetrived is : "+debtorCodeRetrived);

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

        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
            request.setAttribute("status", "Error deactivating catalogue item!");
        }
        
        request.setAttribute("status", "Catalogue item deactivated successfully!");

        request.getRequestDispatcher("catalogue.jsp").forward(request, response);
        
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
        
        //System.out.println("debtorCodeRetrived is : "+debtorCodeRetrived);

        try {

            Connection conn = ConnectionManager.getConnection();
            out.println("passes conn");

            //String sql = "DELETE FROM `order_item` WHERE itemCode = '" + itemCodeRetrieved + "'";
            String sql = "UPDATE `order_item` SET Status='Active'"
                + "WHERE ItemCode = '" + itemCodeRetrieved + "'";
            
            PreparedStatement stmt = conn.prepareStatement(sql);
            out.println("passes stmt");

            stmt.executeUpdate();
            out.println("passes rs");

        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
            request.setAttribute("status", "Error deactivating catalogue item!");
        }
        
        request.setAttribute("status", "Catalogue item activated successfully!");

        request.getRequestDispatcher("catalogue.jsp").forward(request, response);
        
    }
    
    public static boolean sendSmsForCancelOrder(String language, String contactNumber, String orderID){
        boolean result = false;
        String myData = "";

          //check if parameters is valid (not null and length not = 0)
        if (language != null && contactNumber != null && orderID != null & language.length() > 0 && contactNumber.length() >0 && orderID.length() > 0){

            try{
            // This URL is used for sending messages
            String myURI = "https://api.bulksms.com/v1/messages";

            String myUsername = "F89898B66F9C4AA2A051176711AE05AE-02-C";
            String myPassword = "aeaIP2IprPZa89K!!PWo!UQQlemgd";

             String toNumber = "+65" + contactNumber;

             if (language.equals("English")){
                myData = "{to: \"" + toNumber + "\", encoding: \"UNICODE\", body: \"[Lim Kee] Order #" + orderID 
                + "\n" + "Your order has been modified. If you did not authorize this change, please call +65 758 5858." + "\"}";
            } else {
                myData = "{to: \"" + toNumber + "\", encoding: \"UNICODE\", body: \"[林记] 订単 #"  + orderID + "\n" + "您的订单已经被取消。若非本人亲自操作，请拨打+65 6758 5858。" + "\"}";
            }
            // build the request based on the supplied settings
            URL url = new URL(myURI);
            HttpURLConnection request = (HttpURLConnection) url.openConnection();
            request.setDoOutput(true);

            // supply the credentials
            String authStr = myUsername + ":" + myPassword;
            String authEncoded = Base64.getEncoder().encodeToString(authStr.getBytes()); 
            request.setRequestProperty("Authorization", "Basic " + authEncoded);

            request.setRequestMethod("POST");
            request.setRequestProperty( "Content-Type", "application/json");

            // write the data to the request
            OutputStreamWriter out = new OutputStreamWriter(request.getOutputStream());
            out.write(myData);
            out.close();

            try {
              // make the call to the API
              InputStream response = request.getInputStream();
              BufferedReader in = new BufferedReader(new InputStreamReader(response));
              String replyText;
              while ((replyText = in.readLine()) != null) {
                System.out.println(replyText);
              }
              in.close();

              result = true;
            } catch (IOException ex) {
              System.out.println("An error occurred:" + ex.getMessage());
              BufferedReader in = new BufferedReader(new InputStreamReader(request.getErrorStream()));
              // print the detail that comes with the error
              String replyText;
              while ((replyText = in.readLine()) != null) {
                System.out.println(replyText);
              }
              in.close();
            }
            request.disconnect();
            } catch (Exception e){
                System.out.println(e);
            }
        } else {
            System.out.println("Parameters is null/blank");
        }
        return result;

    }
    
}
