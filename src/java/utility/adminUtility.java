/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package utility;

import dao.ConnectionManager;
import entity.User;
import static java.lang.System.out;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

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
    
    
    
}
