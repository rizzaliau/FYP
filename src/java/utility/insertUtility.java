/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package utility;
import com.mysql.jdbc.exceptions.jdbc4.MySQLIntegrityConstraintViolationException;
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
import java.net.URLConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
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
public class insertUtility {
    
    public static void insert(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        //Gets all the parameters from the form
        String debtorCode = request.getParameter("debtorCode");
        String companyCode = request.getParameter("companyCode");
        String hashPassword = request.getParameter("hashPassword");
        String companyName = request.getParameter("companyName");
        String debtorName = request.getParameter("debtorName");
        String deliverContact = request.getParameter("deliverContact");
        String deliverContact2 = request.getParameter("deliverContact2");
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
        String preferredLanguage = request.getParameter("language");
        String lastModifiedTimeStamp = request.getParameter("lastModifiedTimeStamp");
        String lastModifiedBy = request.getParameter("lastModifiedBy");
        
        HttpSession session = request.getSession();
        
        //Converts normal password to hashpassword
        String newPasswordHash = loginUtility.getSha256(hashPassword);
        
        try {

            Connection conn = ConnectionManager.getConnection();
            out.println("passes conn");

            String sql = "INSERT INTO debtor " + "VALUES('"+ debtorCode+"','"+companyCode+"','"+newPasswordHash+"',"
                    + "'"+companyName+"','"+debtorName+"','"+deliverContact+"','"+deliverContact2+"','"+inAddr1+"',"
                    + "'"+inAddr2+"','"+inAddr3+"','"+inAddr4+"','"+deliverAddr1+"','"+deliverAddr2+"',"
                    + "'"+deliverAddr3+"','"+deliverAddr4+"','"+displayTerm+"','"+status+"','"+routeNumber+"',"
                    + "'"+lastModifiedTimeStamp+"','"+lastModifiedBy+"','"+preferredLanguage+"')";
                    
            PreparedStatement stmt = conn.prepareStatement(sql);
            out.println("passes stmt");

            stmt.executeUpdate();
            out.println("passes rs");
            
            boolean createNewWallet = createNewWallet(debtorCode,0.0);
            
            out.println("Wallet is created: "+createNewWallet);
            
            if (debtorName != null && companyCode != null && preferredLanguage != null && deliverContact != null){
                    if (debtorName.length() > 0 && preferredLanguage.length() == 7 && deliverContact.length() == 8){
                        
                        //Need to change deliverContact
                        boolean smsSentToCustomer = sendSmsToNewCustomer(preferredLanguage, deliverContact, companyCode);

                        if(!smsSentToCustomer){
                            //show alert to inform admin sms not sent to customer
                            System.out.println("SMS is not send to " + debtorName  + " contact number at " + deliverContact + ".");
                        } else {
                            //inform admin sms is sent to customer 
                            System.out.println("SMS is send to " + debtorName  + " contact number at " + deliverContact + ".");
                        } 

                        if (!smsSentToCustomer){
                            //show alert to inform admin sms not sent to customer
                            System.out.println("SMS is not send to " + debtorName  + " contact number at " + deliverContact + ".");
                        } else {
                            //only chinese sms call additional SMS api to send google playstore url (seperate smses for chinese)
                           if (preferredLanguage.equals("Chinese")){
                                boolean appUrlSMS = sendGooglePlayURL(deliverContact);
                                if (!appUrlSMS){
                                    //show alert to inform admin sms not sent to customer
                                    System.out.println("SMS is not send to " + debtorName  + " contact number at " + deliverContact + ".");
                                } else {
                                    //inform admin sms is sent to customer 
                                    System.out.println("Google play address SMS is send to " + debtorName  + " contact number at " + deliverContact + ".");
                                }
                            } 
                        } 
                    } else {
                        System.out.println("Wrong length in preferred language / contact number.");
                    }
                } else {
                System.out.println("Null in preferred language / contact number.");
                }
            
                session.setAttribute("customerStatus", "Record inserted successfully!"); 
                response.sendRedirect("customer.jsp");
            
        }catch (SQLException ex) {
            
            if(ex instanceof MySQLIntegrityConstraintViolationException){

                session.setAttribute("customerStatus", "Please enter a unique customer code!"); 
                response.sendRedirect("newCustomer.jsp");
            }else{
                Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);

                session.setAttribute("customerStatus", "Error updating!"); 
                response.sendRedirect("newCustomer.jsp");
            }
        }
        
    }
    
        public static void newCatalogueItem(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String itemCodeRetrieved = catalogueCheckForNull(request.getParameter("itemCode"));
        String descriptionRetrieved = catalogueCheckForNull(request.getParameter("description"));
        String chineseDescriptionRetrieved = catalogueCheckForNull(new String (request.getParameter("descriptionChinese").getBytes ("iso-8859-1"), "UTF-8"));
        String unitPriceRetrieved = catalogueCheckForNull(request.getParameter("unitPrice"));
        String imageURLRetrieved = request.getParameter("imageURL");
        String defaultQuantityRetrieved = catalogueCheckForNull(request.getParameter("defaultQuantity"));
        String quantityMultiplesRetrieved = catalogueCheckForNull(request.getParameter("quantityMultiples"));  
        String unitofMetricRetrieved = catalogueCheckForNull(new String (request.getParameter("unitOfMetric").getBytes ("iso-8859-1"), "UTF-8"));
        String retailPriceRetrieved = catalogueCheckForNull(request.getParameter("retailPrice"));  
        String status = "Active";
        String lastModifiedTimeStamp = catalogueCheckForNull(request.getParameter("lastModifiedTimeStamp"));
        String lastModifiedBy = catalogueCheckForNull(request.getParameter("lastModifiedBy"));
        
        HttpSession session = request.getSession();
        
        if(imageURLRetrieved==null){
            
            session.setAttribute("catalogueStatus", "Error: Please upload an image! "); 
            response.sendRedirect("newCatalogueItem.jsp");
            
            
        }else{

            try {

                Connection conn = ConnectionManager.getConnection();
                out.println("passes conn");

                String sql = "INSERT INTO order_item " + "VALUES('"+ itemCodeRetrieved+"','"+descriptionRetrieved+"','"+chineseDescriptionRetrieved+"',"
                        + "'"+unitPriceRetrieved+"','"+retailPriceRetrieved+"','"+unitofMetricRetrieved+"','"
                        +imageURLRetrieved+"','"+defaultQuantityRetrieved
                        +"','"+quantityMultiplesRetrieved+"','"+status+"','"+lastModifiedTimeStamp+"','"+lastModifiedBy+"')";

                PreparedStatement stmt = conn.prepareStatement(sql);
                out.println("passes stmt");

                stmt.executeUpdate();
                out.println("passes rs");
                

                session.setAttribute("catalogueStatus", "Record inserted successfully!"); 
                response.sendRedirect("catalogue.jsp");
            

            } catch (SQLException ex) {

                if(ex instanceof MySQLIntegrityConstraintViolationException){
                    session.setAttribute("catalogueStatus", "Please enter a unique Item code!");
                    response.sendRedirect("newCatalogueItem.jsp");
                    
                }else{
                    Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);

                    session.setAttribute("catalogueStatus", "Error creating new catalogue Item!");
                    response.sendRedirect("catalogue.jsp");
                    
                }
                
                
            }
            
        }
    }
    
    private static String catalogueCheckForNull(String string){
       if(string == null || string.equals("null")){
           return "-";
       }
       return string;
   }

    public static String toUnicode(char ch) {
        String unicode = "";
        
        String code = String.format("\\u%04x", (int) ch);
        unicode = code.substring(2);
       
        return unicode;
    }    
    
    public static boolean sendSmsToNewCustomer(String language, String contactNumber, String username){
        boolean result = false;
           
       String toNumber = "65" + contactNumber;
       
        try{
            String data = "";
            String smsMsg = "";

            String api_key = "98060002"; 
            String api_secret = "Infoatlimkee1";  

            if (language.equals("English")){
                smsMsg = "Dear " +  username + ", your account is now activated! Download Lim Kee's app from https://play.google.com/store/apps/details?id=com.limkee to start ordering. Thank you!";
                    
                //use ascii content for type    
                data += "ID=" + api_key
                        + "&Password=" + api_secret
                        + "&Mobile=" + toNumber
                        + "&Type=" + "A"
                        + "&Message=" + smsMsg;
            } else {
                
                //get unicode for every character 
                String appUrl = "https://play.google.com/store/apps/details?id=com.limkee";

                String dlAddress = "";
                for(int i =0; i< appUrl.length();i++)
                {   
                    char c = appUrl.charAt(i);
                     dlAddress += toUnicode(c);
                } 
                
                String companyCode = "";
                for(int i =0; i< username.length();i++)
                {   
                    char c = username.charAt(i);
                     companyCode += toUnicode(c);
                }     
                    
                smsMsg = "60A8597d0020" + companyCode + "002C002060A876845E1053F75DF26FC06D3b002100208BF757286B644E0b8F0967978BB07684" + toUnicode('A') + toUnicode('P') + toUnicode('P') + "0020540e5F0059Cb4e0b5355002E00208C228C220021";

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
    
    public static boolean sendGooglePlayURL(String contactNumber) {
        boolean result = false;
        
        String toNumber = "65" + contactNumber;
       
        try{
            String data = "";
            String smsMsg = "";

            String api_key = "98060002"; 
            String api_secret = "Infoatlimkee1";  

            //get unicode for every character 
            String appUrl = "https://play.google.com/store/apps/details?id=com.limkee1";

            //get unicode of each string
            String dlAddress = "";
            for(int i =0; i< appUrl.length();i++)
            {   
                char c = appUrl.charAt(i);
                 dlAddress += toUnicode(c);
            } 
            
            smsMsg = dlAddress;

            //use unicode for type
            data += "ID=" + api_key
                    + "&Password=" + api_secret
                    + "&Mobile=" + toNumber
                    + "&Type=" + "U"
                    + "&Message=" + smsMsg;

        
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
    
    public static boolean createNewWallet(String debtorCode, Double refundAmt){
        
        boolean createNewWallet = false;
        
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        int countInt = 0;
        
        try {
            conn = ConnectionManager.getConnection();
            
            String populateMap = "select COUNT(ID) from wallet";

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
            //Connection conn = ConnectionManager.getConnection();
            out.println("passes conn");

            String sql = "INSERT INTO wallet " + "VALUES('"+ ++countInt +"','"+refundAmt+"',"
                    + "'"+debtorCode+"')";
                    
            PreparedStatement stmt = conn.prepareStatement(sql);
            out.println("passes stmt");

            stmt.executeUpdate();
            out.println("passes rs");
            
            createNewWallet = true;
            
        }catch(SQLException e){
            
            System.out.println("SQLException thrown by createNewWallet method");
            System.out.println(e.getMessage());
            
        }
        
        
        return createNewWallet;

    }
        
    

}
