/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package utility;
import com.mysql.jdbc.exceptions.jdbc4.MySQLIntegrityConstraintViolationException;
//import com.mysql.jdbc.exceptions.MySQLIntegrityConstraintViolationException;
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
        String preferredLanguage = request.getParameter("preferredLanguage");
        String lastModifiedTimeStamp = request.getParameter("lastModifiedTimeStamp");
        String lastModifiedBy = request.getParameter("lastModifiedBy");
        
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
            
            //boolean smsSentToCustomer = sendSmsToNewCustomer(preferredLanguage, "97597790", companyCode);
            //System.out.println("New account SMS Sent is " + smsSentToCustomer);

//        }catch (final ConstraintViolationException e) {
//            
//            request.setAttribute("status", "Please enter a unique customer code!");
//            request.getRequestDispatcher("newCustomer.jsp").forward(request, response);
//            
        }catch (SQLException ex) {
            
            if(ex instanceof MySQLIntegrityConstraintViolationException){
                request.setAttribute("status", "Please enter a unique customer code!");
                request.getRequestDispatcher("newCustomer.jsp").forward(request, response);
            }else{
                Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
                request.setAttribute("status", "Error updating!");
            }
        }

        request.setAttribute("status", "Record inserted successfully!");

        request.getRequestDispatcher("customer.jsp").forward(request, response);
        
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
        
        if(imageURLRetrieved==null){
            request.setAttribute("status", "Error: Please upload an image! ");

            request.getRequestDispatcher("newCatalogueItem.jsp").forward(request, response);
        }else{
        
//        out.println(itemCodeRetrieved);
//        out.println(descriptionRetrieved);
//        out.println(chineseDescriptionRetrieved);
//        out.println(unitPriceRetrieved);
//        out.println(imageURLRetrieved);
//        out.println(defaultQuantityRetrieved);
//        out.println(quantityMultiplesRetrieved);
//        out.println(unitofMetricRetrieved);
//        out.println(retailPriceRetrieved);
        
        
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
                    +"','"+quantityMultiplesRetrieved+"','"+status+"','"+lastModifiedTimeStamp+"','"+lastModifiedBy+"')";

            PreparedStatement stmt = conn.prepareStatement(sql);
            out.println("passes stmt");

            stmt.executeUpdate();
            out.println("passes rs");

        } catch (SQLException ex) {
            
            if(ex instanceof MySQLIntegrityConstraintViolationException){
                request.setAttribute("status", "Please enter a unique Item code!");
                request.getRequestDispatcher("newCatalogueItem.jsp").forward(request, response);
            }else{
                Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
                request.setAttribute("status", "Error creating new catalogue Item!");
            }
        }
        
        request.setAttribute("status", "Record inserted successfully! ");

        request.getRequestDispatcher("catalogue.jsp").forward(request, response);
        }
    }
    
    private static String catalogueCheckForNull(String string){
       if(string == null || string.equals("null")){
           return "-";
       }
       return string;
   }    
        
public static boolean sendSmsToNewCustomer(String language, String contactNumber, String username){
    boolean result = false;
    String myData = "";
    
    //check if parameters is valid (not null and length not = 0)
    if (language != null && contactNumber != null && username != null & language.length() > 0 && contactNumber.length() >0 && username.length() > 0){
    
        try {
        // This URL is used for sending messages
        String myURI = "https://api.bulksms.com/v1/messages";

        String myUsername = "F89898B66F9C4AA2A051176711AE05AE-02-C";
        String myPassword = "aeaIP2IprPZa89K!!PWo!UQQlemgd";
        
        String toNumber = "+65" + contactNumber;
         
        if (language.equals("English")){
            myData = "{to: \"" + toNumber + "\", encoding: \"UNICODE\", body: \"Dear " + username 
           +  ", your account is now active! Download Lim Kee's app from https://play.google.com/store/apps/details?id=com.limkee to start ordering! Thank you!"  +  "\"}";              
        } else {
            myData = "{to: \"" + toNumber + "\", encoding: \"UNICODE\", body: \"您好 " + username 
           +  ", 您的帐号已激活！请在此下载林记的APP https://play.google.com/store/apps/details?id=com.limkee 后开始下单。谢谢!"  +  "\"}";              
        }

        //build the request based on the supplied settings
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
