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
        
        out.println("username retrieved is "+userName);
        
        out.println(passWordHash);

        User user = UserDAO.retrieve(userName);
        
        /*if (user == null) {
            // TODO: include error messages before redirecting
            
            //out.println("User is null (loginUility.java)");
            
            request.setAttribute("errorMsg", "Invalid Username/password");

            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }*/
        if("".equals(userName)||"".equals(passWord)){
            request.setAttribute("errorMsg", "Please enter username and/or password 请填写用户名和/或密码");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;           
        }
        if (user == null || !user.authenticate(passWordHash)) {
            // TODO: include error messages before redirecting
            request.setAttribute("errorMsg", "Invalid username and/or password 用户名和/或密码错误");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }
        
        out.println("The result of authentication is :"+user.authenticate(passWordHash));
        
        //String passwordSha256 = loginUtility.getSha256(passWord);
        
        HttpSession session = request.getSession();
        
        session.setAttribute("username", userName);
        
        //session.setAttribute("password", passwordSha256);
        out.println("Before redirection");
        request.getRequestDispatcher("dashboard.jsp").forward(request, response);
        out.println("After redirection");
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
