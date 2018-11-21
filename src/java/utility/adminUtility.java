/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package utility;

import com.mysql.jdbc.exceptions.jdbc4.MySQLIntegrityConstraintViolationException;
import dao.ConnectionManager;
import dao.UserDAO;
import entity.User;
import java.io.IOException;
import static java.lang.System.out;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;
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
public class adminUtility {
    
    public static Map<Integer, User> getAllAdmins(){
        Map<Integer, User> adminsMap = new HashMap<>();
        
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        int count = 1;
        
        try {
            conn = ConnectionManager.getConnection();
            
            String sql = "SELECT Username, HashPassword, IsMaster,Status,LastModifiedTimestamp,LastModifiedBy From `user`";

            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();
            
            System.out.println("Passed connection");

            while (rs.next()) {
                
                String name = rs.getString("Username");
                String hashPassword = rs.getString("HashPassword");
                String isMaster = rs.getString("IsMaster");
                int isMasterInt = Integer.parseInt(isMaster);
                String status = rs.getString("Status");
                String lastModifiedTimestamp = checkForNull(rs.getString("LastModifiedTimestamp"));
                String lastModifiedBy = checkForNull(rs.getString("LastModifiedBy"));
                
                User user = new User(name, hashPassword, isMasterInt, status,lastModifiedTimestamp,lastModifiedBy);

                adminsMap.put(count, user);
                count++;
            }
            
        }catch(SQLException e){
            
            System.out.println("SQLException thrown by getAllAdmins method");
            System.out.println(e.getMessage());
            
        }finally{
            ConnectionManager.close(conn, pstmt, rs);
        }
        
        return adminsMap;
    }
    
    public static void newAdmin(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        //Gets all the parameters from the form
        String userName = request.getParameter("userName");
        String isMasterAdmin = request.getParameter("isMasterAdmin");
        int isMasterAdminInt = Integer.parseInt(isMasterAdmin);
        String newPassword1 = request.getParameter("newPass1");
        String newPassword2 = request.getParameter("newPass2");
        String status = "Active";
        String lastTimeStamp = request.getParameter("lastModifiedTimeStamp");
        String lastModifiedBy = request.getParameter("lastModifiedBy");
        HttpSession session = request.getSession();
        
        //Validation for password
        if(newPassword1.equals("") || newPassword2.equals("") || newPassword1.equals("") && newPassword2.equals("")){  
            session.setAttribute("adminStatus", "Blank fields detected. Please enter all fields"); 
            response.sendRedirect("newAdmin.jsp");

        } else if (!(newPassword1.equals(newPassword2))){           

            session.setAttribute("adminStatus", "Passwords do not match! Please re-enter passwords."); 
            response.sendRedirect("newAdmin.jsp");
        }else{
            String newPasswordHash = loginUtility.getSha256(newPassword2);
        
            try {

                Connection conn = ConnectionManager.getConnection();
                out.println("passes conn");

                String sql = "INSERT INTO user " + "VALUES('"+userName+"','"+newPasswordHash+"',"
                        + "'"+isMasterAdminInt+"','"+status+"','"+lastTimeStamp+"','"+lastModifiedBy+"')";

                PreparedStatement stmt = conn.prepareStatement(sql);
                out.println("passes stmt");

                stmt.executeUpdate();
                out.println("passes rs");
                
                session.setAttribute("adminStatus", "Record inserted successfully!"); 
                response.sendRedirect("admin.jsp");
         
            }catch (SQLException ex) {

                if(ex instanceof MySQLIntegrityConstraintViolationException){

                    session.setAttribute("adminStatus", "Please enter a unique Username!"); 
                    response.sendRedirect("admin.jsp");
                }else{
                    Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);

                    session.setAttribute("adminStatus", "Error updating!"); 
                    response.sendRedirect("admin.jsp");
                }
            }
        
        }
    }
    
    public static void editAdmin(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        //Get all Parameters
        String usernameRetrived = request.getParameter("userName");
        String isMasterAdminRetrieved = request.getParameter("isMasterAdmin");
        String serialRetrieved = request.getParameter("serial");
        String statusRetrieved = request.getParameter("status");
        int isMasterAdminInt = Integer.parseInt(isMasterAdminRetrieved);
        int serialInt = Integer.parseInt(serialRetrieved);
        String passwordRetrieved = request.getParameter("hashPassword");
        
        String lastTimeStampRetrieved = request.getParameter("lastModifiedTimeStamp");
        String lastModifiedBy = request.getParameter("lastModifiedBy");
        
        String newPassword1 = request.getParameter("newPass1");
        String newPassword2 = request.getParameter("newPass2");
        
        HttpSession session = request.getSession();
        
        //Validation for Password
        if (!(newPassword1.equals(newPassword2))){   
            
            if(newPassword1.equals("") || newPassword2.equals("")){

                session.setAttribute("adminStatus", "Blank fields detected. Please enter all fields."); 
                session.setAttribute("serial", serialInt); 
                response.sendRedirect("editAdmin.jsp?serial="+serialInt);
                
            }else{

                session.setAttribute("adminStatus", "Passwords do not match! Please re-enter passwords."); 
                session.setAttribute("serial", serialInt); 
                response.sendRedirect("editAdmin.jsp?serial="+serialInt);
            }
            
        }else{
            
            String passwordUsed = "";
            
            if(newPassword1.equals("") || newPassword2.equals("") || newPassword1.equals("") && newPassword2.equals("")){
                passwordUsed = passwordRetrieved;
            }else{
                passwordUsed = loginUtility.getSha256(newPassword2);
            }
            
            try {

                Connection conn = ConnectionManager.getConnection();
                out.println("passes conn");

                String sql = "UPDATE `user` SET HashPassword = '" +passwordUsed + "', "
                        + " IsMaster = '" + isMasterAdminInt + "', Status = '" +statusRetrieved + "', "
                        + " LastModifiedTimeStamp = '" + lastTimeStampRetrieved + "', LastModifiedBy = '" +lastModifiedBy + "' "
                        + "WHERE Username = '" + usernameRetrived + "'";

                PreparedStatement stmt = conn.prepareStatement(sql);
                out.println("passes stmt");

                stmt.executeUpdate();
                out.println("passes rs");
                
                session.setAttribute("adminStatus", "Record updated successfully!"); 
                response.sendRedirect("admin.jsp");

            } catch (SQLException ex) {
                Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
                request.setAttribute("updateSuccess", "Record updated unsuccessfully!");

            }

        }
    }
    
    private static String checkForNull(String string){
       if(string == null || string.equals("null")){
           return "-";
       }
       return string;
    }
    
    //Format date from 
    public static String formatDate(String date){
        
       String formattedDate = "";
       
       if(date.equals("-")||date == null){
           return "-";
       }
       
       //2018-08-31 23:44:58.0
       
       String yyyy = date.substring(0,4);
       String MM = date.substring(5,7);
       String dd = date.substring(8,10);
       String HH = date.substring(11,13);
       String mm = date.substring(14,16);
       String ss = date.substring(17,19);
       
       formattedDate = dd+"-"+MM+"-"+yyyy+" "+HH+":"+mm+":"+ss;
               
       return formattedDate;
    }
    
    //returns month, single digit from 1-9 and double digit for 10-12
    public static String getMonthTimestamp(String date){
        
       if(date.equals("-")||date == null){
           return "-";
       }

       String MM = date.substring(5,7);
       
       if(MM.charAt(0)=='0'){
           return MM.charAt(1)+"";
       }

       return MM;
    }
    
    public static String getYearTimestamp(String date){
        
       if(date.equals("-")||date == null){
           return "-";
       }

       String yyyy = date.substring(0,4);

     
       return yyyy;
    }
    
    
}
