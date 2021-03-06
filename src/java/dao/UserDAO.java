/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import entity.User;
import static java.lang.System.out;

/**
 *
 * @author Rizza
 */
public class UserDAO {
    
    public static User retrieve(String username) {
        try {
            Connection conn = ConnectionManager.getConnection();
            out.println("username inputed is :" + username);
            out.println("passes conn");
            
            String sql = "SELECT Username, HashPassword, IsMaster,Status,LastModifiedTimestamp,LastModifiedBy From `user` WHERE Username = '"+username+"'";
            PreparedStatement stmt = conn.prepareStatement(sql);
            out.println("passes stmt");
            
            ResultSet rs = stmt.executeQuery();
            out.println("passes rs");
            User user = null;

            out.println("enters user retrived method");

            while (rs.next()) {

                String name = rs.getString("Username");
                out.println(name + " is printed out in userDAO ");
                String password = rs.getString("HashPassword");
                out.println(password + " is printed out in userDAO ");
                String isMaster = rs.getString("IsMaster");
                int isMasterInt = Integer.parseInt(isMaster);
                out.println(isMasterInt + " is printed out in userDAO ");
                String status = rs.getString("Status");
                String lastModifiedTimestamp = checkForNull(rs.getString("LastModifiedTimestamp"));
                String lastModifiedBy = checkForNull(rs.getString("LastModifiedBy"));
                
                user = new User(name, password, isMasterInt,status,lastModifiedTimestamp,lastModifiedBy);
                return user;
            }

            return null;

        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public static void update(String username, String password) {
        try {
            
            Connection conn = ConnectionManager.getConnection();
            out.println("passes conn");
            
            String sql = "UPDATE `user` SET HashPassword = '" + password + "' WHERE Username = '" + username + "'";

            PreparedStatement stmt = conn.prepareStatement(sql);
            out.println("passes stmt");
            
            stmt.executeUpdate();
            out.println("passes rs");

        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    private static String checkForNull(String string){
       if(string == null || string.equals("null")){
           return "-";
       }
       return string;
    }
    
}
