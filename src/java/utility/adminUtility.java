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
            
            String sql = "SELECT Username, HashPassword, IsMaster,Status From `user`";

            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();
            
            System.out.println("Passed connection");

            while (rs.next()) {
                
                String name = rs.getString("Username");
                String hashPassword = rs.getString("HashPassword");
                String isMaster = rs.getString("IsMaster");
                int isMasterInt = Integer.parseInt(isMaster);
                String status = rs.getString("Status");

                User user = new User(name, hashPassword, isMasterInt, status);

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
        String adminID = request.getParameter("adminID");
        int adminIDInt = Integer.parseInt(adminID);
        
        if(newPassword1.equals("") || newPassword2.equals("") || newPassword1.equals("") && newPassword2.equals("")){           
            request.setAttribute("status", "Blank fields detected. Please enter all fields");
            request.getRequestDispatcher("newAdmin.jsp").forward(request, response);   
        } else if (!(newPassword1.equals(newPassword2))){           
            request.setAttribute("status", "Passwords do not match! Please re-enter passwords.");
            request.getRequestDispatcher("newAdmin.jsp").forward(request, response);
        }else{
            String newPasswordHash = loginUtility.getSha256(newPassword2);
        
        
            try {

                Connection conn = ConnectionManager.getConnection();
                out.println("passes conn");

                String sql = "INSERT INTO user " + "VALUES('"+ adminIDInt+"','"+userName+"','"+newPasswordHash+"',"
                        + "'"+isMasterAdminInt+"','"+status+"')";

                PreparedStatement stmt = conn.prepareStatement(sql);
                out.println("passes stmt");

                stmt.executeUpdate();
                out.println("passes rs");
         
            }catch (SQLException ex) {

                if(ex instanceof MySQLIntegrityConstraintViolationException){
                    request.setAttribute("status", "Please enter a unique ID!");
                    request.getRequestDispatcher("admin.jsp").forward(request, response);
                }else{
                    Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
                    request.setAttribute("status", "Error updating!");
                }
            }

            request.setAttribute("status", "Record inserted successfully!");

            request.getRequestDispatcher("admin.jsp").forward(request, response);
        
        }
    }
    
    public static void editAdmin(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String usernameRetrived = request.getParameter("userName");
        String isMasterAdminRetrieved = request.getParameter("isMasterAdmin");
        String adminIDRetrieved = request.getParameter("adminID");
        String statusRetrieved = request.getParameter("status");
        int isMasterAdminInt = Integer.parseInt(isMasterAdminRetrieved);
        int adminIDInt = Integer.parseInt(adminIDRetrieved);
        String passwordRetrieved = request.getParameter("hashPassword");
        
        out.println(usernameRetrived);
        out.println(isMasterAdminRetrieved);
        out.println(adminIDRetrieved);
        out.println(statusRetrieved);
        out.println(passwordRetrieved);
        
        String newPassword1 = request.getParameter("newPass1");
        String newPassword2 = request.getParameter("newPass2");
        
        if (!(newPassword1.equals(newPassword2))){   
            
            request.setAttribute("serial", adminIDRetrieved);
            request.setAttribute("status", "Passwords do not match! Please re-enter passwords.");
            request.getRequestDispatcher("editAdmin.jsp?serial="+adminIDRetrieved).forward(request, response); 
            
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

                String sql = "UPDATE `user` SET Username='" + usernameRetrived 
                        + "', HashPassword = '" +passwordUsed + "', "
                        + " IsMaster = '" + isMasterAdminInt + "', Status = '" +statusRetrieved + "'"
                        + "WHERE ID = '" + adminIDInt + "'";

                PreparedStatement stmt = conn.prepareStatement(sql);
                out.println("passes stmt");

                stmt.executeUpdate();
                out.println("passes rs");

            } catch (SQLException ex) {
                Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
                request.setAttribute("updateSuccess", "Record updated unsuccessfully!");

            }

            request.setAttribute("updateSuccess", "Record updated successfully!");

            request.getRequestDispatcher("admin.jsp").forward(request, response);

        }
    }
}
