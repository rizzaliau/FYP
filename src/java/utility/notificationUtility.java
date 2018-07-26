/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package utility;

import dao.ConnectionManager;
import entity.Notification;
import entity.SalesOrder;
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
public class notificationUtility {
    
    public static Map<Integer, Notification> getNotificationsMap(){
        Map<Integer, Notification> notificationMap = new HashMap<>();
        
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        int count = 1;
        
        try {
            conn = ConnectionManager.getConnection();
            
            String populateMap = "select so.OrderID, d.DebtorName,d.CompanyName, so.CreatedTimeStamp, so.Flag from sales_order so \n" +
                "inner join debtor d on so.DebtorCode = d.DebtorCode  \n" +
                "inner join sales_order_detail sod on so.OrderID = sod.OrderID \n" +
                "where so.Flag = '1' \n" +
                "order by so.CreatedTimeStamp DESC";

            pstmt = conn.prepareStatement(populateMap);
            rs = pstmt.executeQuery();
            
            System.out.println("Passed connection");

            while (rs.next()) {
                
                String orderID = rs.getString("OrderID");
                String debtorName = rs.getString("DebtorName");
                String companyName = rs.getString("CompanyName");
                String createdTimeStamp = rs.getString("CreatedTimeStamp");
                String flag = rs.getString("Flag");
                int flagInt = Integer.parseInt(flag);
                
                Notification notification = new Notification (orderID,debtorName,companyName,createdTimeStamp, flagInt);
                
                notificationMap.put(count, notification);
                count++;
            }
            
        }catch(SQLException e){
            
            System.out.println("SQLException thrown by notificationUtility method");
            System.out.println(e.getMessage());
            
        }finally{
            ConnectionManager.close(conn, pstmt, rs);
        }
        
        return notificationMap;
    }
    
    public static void updateNotificationsMap(String orderID){
        //Map<Integer, Notification> notificationMap = new HashMap<>();
        
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try {
            conn = ConnectionManager.getConnection();
            
            String updateNotificationSQL = "UPDATE `sales_order`\n" +
                "SET Flag = '0'\n" +
                "WHERE OrderID = \""+orderID+"\"";

            pstmt = conn.prepareStatement(updateNotificationSQL);
                    //out.println("passes stmt");

            pstmt.executeUpdate();
            
            System.out.println("Passed connection");

            
        }catch(SQLException e){
            
            System.out.println("SQLException thrown by updateNotificationsMap method");
            System.out.println(e.getMessage());
            
        }finally{
            ConnectionManager.close(conn, pstmt, rs);
        }

    }
    
    public static void updateAllNotifications(){
        //Map<Integer, Notification> notificationMap = new HashMap<>();
        
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try {
            conn = ConnectionManager.getConnection();
            
            String updateNotificationSQL = "UPDATE sales_order SET flag = '0'";

            pstmt = conn.prepareStatement(updateNotificationSQL);
                    //out.println("passes stmt");

            pstmt.executeUpdate();
            
            System.out.println("Passed connection");

            
        }catch(SQLException e){
            
            System.out.println("SQLException thrown by updateAllNotifications method");
            System.out.println(e.getMessage());
            
        }finally{
            ConnectionManager.close(conn, pstmt, rs);
        }

    }

}
