/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package utility;

import dao.ConnectionManager;
import entity.Transaction;
import entity.Wallet;
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
public class transactionUtility {
    
    public static Map<Integer, Transaction> getAllTransactionsCustomer(String customerCode){
        
        Map<Integer, Transaction> allTransactionsCustomerMap = new HashMap<>();
        
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        int count = 1;
        
        try {
            conn = ConnectionManager.getConnection();
            
            String sql = "select t.ID, t.Status, t.CreatedTimeStamp, t.Amount,t.OrderID from transaction t \n" +
                "inner join sales_order so on so.OrderID = t.OrderID \n" +
                "where so.DebtorCode ='"+customerCode+"' "
                +"order by t.CreatedTimeStamp DESC ";

            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();
            
            System.out.println("Passed connection");

            while (rs.next()) {
                
                String id = rs.getString("ID");
                String status = rs.getString("Status");
                String createdTimeStamp = rs.getString("CreatedTimeStamp");
                String amount = rs.getString("Amount");
                String orderID = rs.getString("OrderID");
                
                Transaction transaction = new Transaction(id, status, createdTimeStamp,amount,orderID);

                allTransactionsCustomerMap.put(count, transaction);
                count++;
            }
            
        }catch(SQLException e){
            
            System.out.println("SQLException thrown by getAllTransactions method");
            System.out.println(e.getMessage());
            
        }finally{
            ConnectionManager.close(conn, pstmt, rs);
        }
        
        return allTransactionsCustomerMap;
    }
    
    
}
