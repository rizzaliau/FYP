/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package utility;

import dao.ConnectionManager;
import entity.ItemDetails;
import entity.OrderItem;
import entity.SalesOrderDetails;
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
public class walletUtility {
    
    public static Map<Integer, Wallet> getAllWallets(){
        Map<Integer, Wallet> walletMap = new HashMap<>();
        
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        int count = 1;
        
        try {
            conn = ConnectionManager.getConnection();
            
            String sql = "SELECT ID, RefundAmt, RebateAmt,DebtorCode From `wallet`";

            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();
            
            System.out.println("Passed connection");

            while (rs.next()) {
                
                String id = rs.getString("ID");
                String refundAmount = checkForNullNumber(rs.getString("RefundAmt"));
                Double refundAmountDouble = Double.parseDouble(refundAmount);
                String rebateAmount = checkForNullNumber(rs.getString("RebateAmt"));
                Double rebateAmountDouble = Double.parseDouble(rebateAmount);
                String debtorCode = rs.getString("DebtorCode");
                
                Wallet wallet = new Wallet(id, refundAmountDouble, rebateAmountDouble, debtorCode);

                walletMap.put(count, wallet);
                count++;
            }
            
        }catch(SQLException e){
            
            System.out.println("SQLException thrown by getAllWallet method");
            System.out.println(e.getMessage());
            
        }finally{
            ConnectionManager.close(conn, pstmt, rs);
        }
        
        return walletMap;
    }
    
    
    private static String checkForNullNumber(String string){
       if(string == null || string.equals("null")){
           return "0.0";
       }
       return string;
   }
    
   public static Double findSalesOrderTotal(String orderID,String status){
       
       double salesOrderTotal=0.0;
       
       SalesOrderDetails salesOrderdetails = salesOrderUtility.getSalesOrderDetails(orderID, status);

       String customerCode = salesOrderUtility.getCustomerCode(orderID, status);

       Map<Integer, ItemDetails> itemDetailsMap = salesOrderUtility.getItemDetailsMap(orderID, status);
       

        for (Integer number : itemDetailsMap.keySet()) {
            double subtotal = 0;

            ItemDetails itemDetail = itemDetailsMap.get(number);
            OrderItem item = salesOrderUtility.getOrderItem(itemDetail.getItemCode());

            double qtyDouble = Double.parseDouble(itemDetail.getQty());
            double unitPriceDouble = Double.parseDouble(itemDetail.getUnitPrice());

            subtotal = qtyDouble * unitPriceDouble;
       
            salesOrderTotal += subtotal;
       
        }
        
        
       return salesOrderTotal*1.07;
   }
    
    
}
