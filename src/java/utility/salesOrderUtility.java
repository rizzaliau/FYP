/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package utility;

import dao.ConnectionManager;
import entity.Debtor;
import entity.ItemDetails;
import entity.OrderItem;
import entity.SalesOrder;
import entity.SalesOrderDetails;
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
public class salesOrderUtility {
    
    public static Map<Integer, SalesOrder> getSalesOrderMap(String status, String deliveryDate){
        Map<Integer, SalesOrder> salesOrderMap = new HashMap<>();
        
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        int count = 1;
        
        try {
            conn = ConnectionManager.getConnection();
            
            String populateMap = "";
            
            if(status.equals("Pending Delivery")){
                
                populateMap = "select so.OrderID, d.DebtorCode, d.DebtorName, d.RouteNumber from sales_order so \n" +
                    "inner join debtor d on so.DebtorCode = d.DebtorCode  \n" +
                    "inner join sales_order_detail sod on so.OrderID = sod.OrderID \n" +
                    "where so.Status = \""+status+"\" and sod.DeliveryDate = \""+deliveryDate+"\"\n" +
                    "order by d.RouteNumber ASC";
                
            }else if(status.equals("Delivered")){
                
                populateMap = "select so.OrderID, d.DebtorCode, d.DebtorName, d.RouteNumber from sales_order so \n" +
                    "inner join debtor d on so.DebtorCode = d.DebtorCode  \n" +
                    "inner join sales_order_detail sod on so.OrderID = sod.OrderID \n" +
                    "where so.Status = \""+status+"\" \n" +
                    "order by sod.DeliveryDate DESC";
                
            }else{
                
                 populateMap = "select so.OrderID, d.DebtorCode, d.DebtorName, d.RouteNumber from sales_order so \n" +
                    "inner join debtor d on so.DebtorCode = d.DebtorCode  \n" +
                    "inner join sales_order_detail sod on so.OrderID = sod.OrderID \n" +
                    "where so.Status = \""+status+"\" \n" +
                    "order by so.LastModified DESC";
                
            }
            

            pstmt = conn.prepareStatement(populateMap);
            rs = pstmt.executeQuery();
            
            System.out.println("Passed connection");

            while (rs.next()) {
                
                String orderID = rs.getString("OrderID");
                String debtorCode = rs.getString("DebtorCode");
                String debtorName = rs.getString("DebtorName");
                String routeNumber = rs.getString("RouteNumber");

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
    
    public static Map<Integer, SalesOrder> getSubsequentDaysSalesOrderMap(){
        Map<Integer, SalesOrder> subsequentDaysSalesOrderMap = new HashMap<>();
        
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        int count = 1;
        
        try {
            conn = ConnectionManager.getConnection();
            String populateMap = "select so.OrderID, d.DebtorCode, d.DebtorName, d.RouteNumber from sales_order so \n" +
                    "inner join debtor d on so.DebtorCode = d.DebtorCode  \n" +                 
                    "inner join sales_order_detail sod on so.OrderID = sod.OrderID \n" +
                    "where so.Status = \"Pending Delivery\" \n" +
                    "order by sod.DeliveryDate ASC, d.RouteNumber ASC";
            pstmt = conn.prepareStatement(populateMap);
            rs = pstmt.executeQuery();
            
            System.out.println("Passed connection");

            while (rs.next()) {
                
                String orderID = rs.getString("OrderID");
                String debtorCode = rs.getString("DebtorCode");
                String debtorName = rs.getString("DebtorName");
                String routeNumber = rs.getString("RouteNumber");

                SalesOrder salesOrder = new SalesOrder (orderID,debtorCode,debtorName,routeNumber);
                
                subsequentDaysSalesOrderMap.put(count, salesOrder);
                count++;
            }
            
        }catch(SQLException e){
            
            System.out.println("SQLException thrown by getSalesOrderMap method");
            System.out.println(e.getMessage());
            
        }finally{
            ConnectionManager.close(conn, pstmt, rs);
        }
        
        return subsequentDaysSalesOrderMap;
    }
    
    public static Map<Integer, OrderItem> getCatalogueMap(){
        Map<Integer, OrderItem> catalogueMap = new HashMap<>();
        
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        int count = 1;
        
        try {
            conn = ConnectionManager.getConnection();
            String populateMap = "SELECT * FROM `order_item`";
            pstmt = conn.prepareStatement(populateMap);
            rs = pstmt.executeQuery();
            
            System.out.println("Passed connection");

            while (rs.next()) {
                
                String itemCode = rs.getString("ItemCode");
                String description = rs.getString("Description");
                String descriptionChinese = rs.getString("Description2");
                String unitPrice = rs.getString("UnitPrice");
                String imageURL = rs.getString("imageURL");
                String defaultQty = rs.getString("defaultQty");
                String qtyMultiples = rs.getString("qtyMultiples");

                OrderItem orderItem = new OrderItem (itemCode,description,descriptionChinese,unitPrice,imageURL
                        ,defaultQty,qtyMultiples);
                
                catalogueMap.put(count, orderItem);
                count++;
            }
            
        }catch(SQLException e){
            
            System.out.println("SQLException thrown by catalogueMap method");
            System.out.println(e.getMessage());
            
        }finally{
            ConnectionManager.close(conn, pstmt, rs);
        }
        
        return catalogueMap;
    }
    
    public static SalesOrderDetails getSalesOrderDetails(String orderID,String statusInput){
        //Map<Integer, SalesOrderDetails> salesOrderDetailsMap = new HashMap<>();
        
        SalesOrderDetails salesOrderDetailsReturn = null;
        
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        //int count = 1;
        
        try {
            conn = ConnectionManager.getConnection();
            String populateMap = "Select so.OrderID, so.CreatedTimeStamp, so.Status, so.LastModified,\n" +
                "sod.DeliveryDate, sod.SubTotal,\n" +
                "d.CompanyName, d.DebtorName, d.DeliverContact, d.DisplayTerm, d.RouteNumber,\n" +
                "d.DeliverAddr1, d.DeliverAddr2, d.DeliverAddr3, d.DeliverAddr4\n" +
                "from sales_order so inner join sales_order_detail sod ON so.OrderID = sod.OrderID\n" +
                "inner join debtor d ON so.DebtorCode = d.DebtorCode \n" +
                "where so.Status = \""+statusInput+"\" and so.OrderID = \"" + orderID + "\"";
            
            pstmt = conn.prepareStatement(populateMap);
            rs = pstmt.executeQuery();
            
            System.out.println("Passed connection");

            while (rs.next()) {
                
                String orderIDRetrieved = rs.getString("OrderID");
                String createTimeStamp= rs.getString("CreatedTimeStamp");
                String status= rs.getString("Status");
                String lastModified= rs.getString("LastModified");
                String deliveryDate= rs.getString("DeliveryDate");
                String subTotal= rs.getString("SubTotal");
                String companyName= rs.getString("CompanyName");
                String debtorName= rs.getString("DebtorName");
                String deliverContact= rs.getString("DeliverContact");
                String displayTerm= rs.getString("DisplayTerm");
                String routeNumber= rs.getString("RouteNumber");
                String deliverAddr1= rs.getString("DeliverAddr1");
                String deliverAddr2= rs.getString("DeliverAddr2");
                String deliverAddr3= rs.getString("DeliverAddr3");
                String deliverAddr4= rs.getString("DeliverAddr4");   
                
                SalesOrderDetails salesOrderDetails = new SalesOrderDetails (orderIDRetrieved,createTimeStamp,status,
                        lastModified,deliveryDate,subTotal,companyName, debtorName,deliverContact, displayTerm,
                        routeNumber,deliverAddr1, deliverAddr2, deliverAddr3,deliverAddr4);
                salesOrderDetailsReturn = salesOrderDetails;
                //catalogueMap.put(count, orderItem);
                //count++;
            }
            
        }catch(SQLException e){
            
            System.out.println("SQLException thrown by getSalesOrderDetails method");
            System.out.println(e.getMessage());
            
        }finally{
            ConnectionManager.close(conn, pstmt, rs);
        }
        
        return salesOrderDetailsReturn;
    }
    
    public static Map<Integer,ItemDetails> getItemDetailsMap(String orderID, String status){
        
        Map<Integer,ItemDetails> itemDetailsMap = new HashMap<>();
        //ItemDetails itemDetailsReturn = null;
        
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try {
            conn = ConnectionManager.getConnection();
            String populateMap = "Select soq.ItemCode, soq.Qty, soq.ReturnedQty, oi.UnitPrice from sales_order so \n" +
                    "inner join sales_order_quantity soq ON so.OrderID = soq.OrderID \n" +
                    "inner join order_item oi ON soq.ItemCode = oi.ItemCode\n" +
                    "where so.Status = \""+status+"\" and so.OrderID = \""+orderID+"\"";
            
            pstmt = conn.prepareStatement(populateMap);
            rs = pstmt.executeQuery();
            
            System.out.println("Passed connection");
            
            int count = 1;
            
            while (rs.next()) {
                
                String itemCode=rs.getString("ItemCode");
                String qty=rs.getString("Qty");
                String returnedQty=rs.getString("ReturnedQty");
                String unitPrice=rs.getString("UnitPrice");

                ItemDetails itemDetails = new ItemDetails (itemCode,qty,returnedQty,unitPrice);
                
                //itemDetailsReturn = itemDetails;
                
                itemDetailsMap.put(count, itemDetails);
                count++;
                
            }
            
        }catch(SQLException e){
            
            System.out.println("SQLException thrown by getSalesOrderDetails method");
            System.out.println(e.getMessage());
            
        }finally{
            ConnectionManager.close(conn, pstmt, rs);
        }
        
        return itemDetailsMap;
    }

}
