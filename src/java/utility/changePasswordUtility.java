/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package utility;

import dao.ConnectionManager;
import dao.UserDAO;
import entity.User;
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
public class changePasswordUtility {
    
    public static void changePassword(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
        
        HttpSession session = request.getSession();
        
        String userNameRetrieved = (String)session.getAttribute("username");
        String passwordRetrieved = (String)session.getAttribute("password");
        String currentPasswordEntered = request.getParameter("currentPass");
        String newPassword1 = request.getParameter("newPass1");
        String newPassword2 = request.getParameter("newPass2");
  
        if(currentPasswordEntered.equals("") || newPassword1.equals("") || newPassword2.equals("") || newPassword1.equals("") && newPassword2.equals("")){           

            session.setAttribute("passwordStatus", "Blank fields detected. Please enter all fields");
            response.sendRedirect("accountSettings.jsp");
            
        }else if(!loginUtility.getSha256(currentPasswordEntered).equals(passwordRetrieved)){

            session.setAttribute("passwordStatus", "Current password entered is invalid. Please re-enter.");
            response.sendRedirect("accountSettings.jsp");
        } else if (!(newPassword1.equals(newPassword2))){           

            session.setAttribute("passwordStatus", "Passwords do not match! Please re-enter passwords.");
            response.sendRedirect("accountSettings.jsp");
            
        }else{
            String newPasswordHash = loginUtility.getSha256(newPassword2);

            UserDAO.update(userNameRetrieved,newPasswordHash);

            session.setAttribute("passwordStatus", "Password updated successfully!");
            response.sendRedirect("accountSettings.jsp");
        }
    }
    
    public static void changeCustomerPassword(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
        
        String hashPasswordRetrieved = request.getParameter("hashPassword");
        String debtorCodeRetrieved = request.getParameter("debtorCode");
        String companyNameRetrieved = request.getParameter("companyName");

        String newPassword1 = request.getParameter("newPass1");
        String newPassword2 = request.getParameter("newPass2");
        
        HttpSession session = request.getSession();

        if(newPassword1.equals("") || newPassword2.equals("") || newPassword1.equals("") && newPassword2.equals("")){           
            
            session.setAttribute("customerPasswordStatus", "Blank fields detected.Please enter all fields"); 
            response.sendRedirect("changeCustomerPassword.jsp");
            
        } else if (!(newPassword1.equals(newPassword2))){           
            
            session.setAttribute("customerPasswordStatus", "Passwords do not match. Please re-enter passwords."); 
            response.sendRedirect("changeCustomerPassword.jsp");
            
        }else{
            
            String newPasswordHash = loginUtility.getSha256(newPassword2);

            changePasswordUtility.UpdateCustomerPassword(debtorCodeRetrieved,newPasswordHash);

            session.setAttribute("customerPasswordStatus", "Password updated successfully!"); 
            session.setAttribute("companyName", companyNameRetrieved); 
            response.sendRedirect("changeCustomerPassword.jsp");
        }
    }
    
    public static void UpdateCustomerPassword(String debtorCodeRetrieved, String newPasswordHash) {
        
        try {
            
            Connection conn = ConnectionManager.getConnection();
            out.println("passes conn");
            
            String sql = "UPDATE `Debtor` SET HashPassword = '" + newPasswordHash + "' WHERE DebtorCode = '" + debtorCodeRetrieved + "'";

            PreparedStatement stmt = conn.prepareStatement(sql);
            out.println("passes stmt");
            
            stmt.executeUpdate();
            out.println("passes rs");

        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    
        
    }
    
}
