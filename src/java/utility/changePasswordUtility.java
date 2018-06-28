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

        //out.println("User retrieved is :"+userNameRetrieved);
        
        String newPassword1 = request.getParameter("newPass1");
        //out.println("User retrieved is :"+newUserName);
        String newPassword2 = request.getParameter("newPass2");
        //out.println("Password retrieved is :"+newPassword);
        
        if (!(newPassword1.equals(newPassword2))){
            
            request.setAttribute("status", "Passwords do not match! Please re-enter password. 密码确认不符, 请重新输入密码");
            request.getRequestDispatcher("dashboard.jsp").forward(request, response);
            
        }else if(newPassword1.equals("") || newPassword2.equals("")){
            
            request.setAttribute("status", "Please fill in new password and/or re-enter password 请输入新密码");
            request.getRequestDispatcher("dashboard.jsp").forward(request, response);
        
        }else{
            String newPasswordHash = loginUtility.getSha256(newPassword2);

            //out.println("Printed values in changePasswordUtility are "+newUserName+newPassword+newPasswordHash);

            UserDAO.update(userNameRetrieved,newPasswordHash);

            request.setAttribute("status", "Password updated successfully!");

            request.getRequestDispatcher("dashboard.jsp").forward(request, response);
        }
    }
}
