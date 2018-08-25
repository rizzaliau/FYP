/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package utility;

import dao.ConnectionManager;
import entity.ItemDetails;
import entity.SalesOrder;
import entity.SalesOrderDetails;
import entity.User;
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
public class dashboardUtility {
    
    public static Map<Integer, Double> getSalesRevenueByMonth(){
        
        Map<Integer, Double> salesRevenueByMonthMap = new HashMap<>();
        
        for(int month = 1; month<=12 ; month++){
        
            Map<Integer, SalesOrder> allSalesOrderRevenueMap = getAllRevenueSalesOrderMapByMonth(month);
            
            double totalForMonth = 0;
            
            for (Integer number : allSalesOrderRevenueMap.keySet()) {

                SalesOrder salesOrder = allSalesOrderRevenueMap.get(number);

                SalesOrderDetails salesOrderdetails = salesOrderUtility.getAllSalesOrderDetails(salesOrder.getOrderID());

                Map<Integer, ItemDetails> itemDetailsMap = salesOrderUtility.getItemDetailsMap(salesOrder.getOrderID(), salesOrderdetails.getStatus());
                
                for (Integer itemNumber : itemDetailsMap.keySet()) {
                    //double subtotal = 0;

                    ItemDetails itemDetail = itemDetailsMap.get(itemNumber);
                    //OrderItem item = salesOrderUtility.getOrderItem(itemDetail.getItemCode());

                    double qtyDouble = Double.parseDouble(itemDetail.getQty());
                    double unitPriceDouble = Double.parseDouble(itemDetail.getUnitPrice());

                    totalForMonth += qtyDouble *  unitPriceDouble;

                }

            }
            
            salesRevenueByMonthMap.put(month, totalForMonth);
        }   

        return salesRevenueByMonthMap;
    }
    
    public static Map<Integer, SalesOrder> getAllRevenueSalesOrderMapByMonth(int month){
        Map<Integer, SalesOrder> salesOrderMap = new HashMap<>();
        
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        int count = 1;
        
        try {
            conn = ConnectionManager.getConnection();
            
            String populateMap = "select so.OrderID, d.DebtorCode, d.DebtorName, d.RouteNumber from sales_order so \n" +
                "inner join debtor d on so.DebtorCode = d.DebtorCode  \n" +
                "inner join sales_order_detail sod on so.OrderID = sod.OrderID \n" +
                "where (so.Status = 'Pending Delivery' and MONTH(`CreatedTimeStamp`) = '"+month+"') OR "
                    + "(so.Status = 'Delivered' and MONTH(`CreatedTimeStamp`) = '"+month+"') "+
                "order by sod.DeliveryDate ASC, d.RouteNumber ASC";

            pstmt = conn.prepareStatement(populateMap);
            rs = pstmt.executeQuery();
            
            System.out.println("Passed connection");

            while (rs.next()) {
                
                String orderID = checkForNull(rs.getString("OrderID"));
                String debtorCode = checkForNull(rs.getString("DebtorCode"));
                String debtorName = checkForNull(rs.getString("DebtorName"));
                String routeNumber = checkForNull(rs.getString("RouteNumber"));

                SalesOrder salesOrder = new SalesOrder (orderID,debtorCode,debtorName,routeNumber);
                
                salesOrderMap.put(count, salesOrder);
                count++;
            }
            
        }catch(SQLException e){
            
            System.out.println("SQLException thrown by getSalesOrderMap method");
            System.out.println(e.getMessage());
            
        }finally{
            ConnectionManager.close(conn, pstmt, rs);
        }
        
        return salesOrderMap;
    
    }

    private static String checkForNull(String string){
       if(string == null || string.equals("null")){
           return "-";
       }
       return string;
   }
    
    
    
}
