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
import java.security.MessageDigest;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


/**
 *
 * @author Rizza
 */
public class loginUtility {
    
    public static void loginProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{

        String userName = request.getParameter("user");
        String passWord = request.getParameter("password");
        String passWordHash = loginUtility.getSha256(passWord);
        
        HttpSession session = request.getSession();
        
        User user = UserDAO.retrieve(userName);
        
        if("".equals(userName)||"".equals(passWord)){

            session.setAttribute("loginStatus", "Please enter username and/or password"); 
            response.sendRedirect("login.jsp");
            return;           
        }
        if (user == null || !user.authenticate(passWordHash)) {

            session.setAttribute("loginStatus", "Invalid username and/or password"); 
            response.sendRedirect("login.jsp");
            return;
        }
        
        if (user.getStatus().equals("Inactive") ) {

            session.setAttribute("loginStatus", "Error: Inactive user"); 
            response.sendRedirect("login.jsp");
            
            return;
        }
        
        session.setAttribute("username", userName);        
        session.setAttribute("password", loginUtility.getSha256(passWord));
        session.setAttribute("isMaster", ""+user.getIsMaster());

        response.sendRedirect("customer.jsp");

    }
    
    public static String getSha256(String value) {
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            md.update(value.getBytes());
            return bytesToHex(md.digest());
        } catch (Exception ex) {
            throw new RuntimeException(ex);
        }
    }

    private static String bytesToHex(byte[] bytes) {
        StringBuffer result = new StringBuffer();
        for (byte b : bytes) {
            result.append(Integer.toString((b & 0xff) + 0x100, 16).substring(1));
        }
        return result.toString();
    }
    

}
