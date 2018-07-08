/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package utility;

import dao.UserDAO;
import entity.User;
import java.io.IOException;
import static java.lang.System.out;
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
        //out.println("User retrieved is :"+userNameRetrieved);
        String currentPasswordEntered = request.getParameter("currentPass");
        String newPassword1 = request.getParameter("newPass1");
        out.println("Password is is :"+newPassword1);
        //out.println("User retrieved is :"+newUserName);
        String newPassword2 = request.getParameter("newPass2");
        //out.println("Password retrieved is :"+newPassword);
        out.println("Password is is :"+newPassword2);
        
  
        if(currentPasswordEntered.equals("") || newPassword1.equals("") || newPassword2.equals("") || newPassword1.equals("") && newPassword2.equals("")){           
            request.setAttribute("status", "Blank fields detected.Please enter all fields");
            request.getRequestDispatcher("accountSettings.jsp").forward(request, response);   
        }else if(!loginUtility.getSha256(currentPasswordEntered).equals(passwordRetrieved)){
            request.setAttribute("status", "Current password entered is invalid.Please re-enter.");
            request.getRequestDispatcher("accountSettings.jsp").forward(request, response);          
        } else if (!(newPassword1.equals(newPassword2))){           
            request.setAttribute("status", "Passwords do not match. Please re-enter passwords.");
            request.getRequestDispatcher("accountSettings.jsp").forward(request, response);
        }else{
            String newPasswordHash = loginUtility.getSha256(newPassword2);

            //out.println("Printed values in changePasswordUtility are "+newUserName+newPassword+newPasswordHash);

            UserDAO.update(userNameRetrieved,newPasswordHash);

            request.setAttribute("status", "Password updated successfully!");

            request.getRequestDispatcher("accountSettings.jsp").forward(request, response);
        }
    }
}
