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
            
            String sql = "SELECT Username, HashPassword From `user` WHERE Username = '"+username+"'";
            PreparedStatement stmt = conn.prepareStatement(sql);
            out.println("passes stmt");
            
            ResultSet rs = stmt.executeQuery();
            out.println("passes rs");
            User user = null;

            out.println("enters user retrived method");

            while (rs.next()) {
                String name = rs.getString(1);
                out.println(name + " is printed out in userDAO ");
                String password = rs.getString(2);
                out.println(password + " is printed out in userDAO ");

                user = new User(name, password);
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
            //String sql = "UPDATE `user` SET Id='3', Password = '123456' WHERE Username = 'admin3'";
            PreparedStatement stmt = conn.prepareStatement(sql);
            out.println("passes stmt");
            
            stmt.executeUpdate();
            out.println("passes rs");

        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
}
