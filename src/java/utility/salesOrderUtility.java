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
                    "order by so.LastModifiedTimeStamp DESC";
                
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
                
                String orderID = checkForNull(rs.getString("OrderID"));
                String debtorCode = checkForNull(rs.getString("DebtorCode"));
                String debtorName = checkForNull(rs.getString("DebtorName"));
                String routeNumber = checkForNull(rs.getString("RouteNumber"));

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
            String populateMap = "SELECT * from order_item order by cast(`ItemCode` AS UNSIGNED)asc ";
            pstmt = conn.prepareStatement(populateMap);
            rs = pstmt.executeQuery();
            
            System.out.println("Passed connection");

            while (rs.next()) {
                
                String itemCode = catalogueCheckForNull(rs.getString("ItemCode"));
                String description = catalogueCheckForNull(rs.getString("Description"));
                String descriptionChinese = catalogueCheckForNull(rs.getString("Description2"));
                String unitPrice = catalogueCheckForNull(rs.getString("UnitPrice"));
                String retailPrice = catalogueCheckForNull(rs.getString("retailPrice"));
                String unitOfMetric = catalogueCheckForNull(rs.getString("UnitOfMetric"));
                String imageURL = catalogueCheckForNull(rs.getString("imageURL"));
                String defaultQty = catalogueCheckForNull(rs.getString("defaultQty"));
                String qtyMultiples = catalogueCheckForNull(rs.getString("qtyMultiples"));
                String status = catalogueCheckForNull(rs.getString("Status"));
                String lastModifiedTimeStamp= checkForNull(rs.getString("LastModifiedTimeStamp"));
                String lastModifiedBy= checkForNull(rs.getString("LastModifiedBy"));  
                
                OrderItem orderItem = new OrderItem (itemCode,description,descriptionChinese,unitPrice,retailPrice,
                        unitOfMetric,imageURL,defaultQty,qtyMultiples,status,lastModifiedTimeStamp,lastModifiedBy);
                
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
            String populateMap = "Select so.OrderID, so.CreatedTimeStamp, so.Status, so.LastModifiedTimeStamp, so.LastModifiedBy, so.PaperBagRequired, \n" +
                "sod.DeliveryDate, sod.SubTotal, sod.PaidAmt, \n" +
                "d.CompanyName, d.DebtorName, d.DeliverContact, d.DisplayTerm, d.RouteNumber,\n" +
                "d.DeliverAddr1, d.DeliverAddr2, d.DeliverAddr3, d.DeliverAddr4, d.PreferredLanguage \n" +
                "from sales_order so inner join sales_order_detail sod ON so.OrderID = sod.OrderID\n" +
                "inner join debtor d ON so.DebtorCode = d.DebtorCode \n" +
                "where so.Status = \""+statusInput+"\" and so.OrderID = \"" + orderID + "\"";
            
            pstmt = conn.prepareStatement(populateMap);
            rs = pstmt.executeQuery();
            
            System.out.println("Passed connection");

            while (rs.next()) {
                
                String orderIDRetrieved = checkForNull(rs.getString("OrderID"));
                String createTimeStamp= checkForNull(rs.getString("CreatedTimeStamp"));
                String status= checkForNull(rs.getString("Status"));
                String lastModifiedTimeStamp= checkForNull(rs.getString("LastModifiedTimeStamp"));
                String deliveryDate= checkForNull(rs.getString("DeliveryDate"));
                String subTotal= checkForNull(rs.getString("SubTotal"));
                String paidAmt = checkForNull(rs.getString("PaidAmt"));
                String companyName= checkForNull(rs.getString("CompanyName"));
                String debtorName= checkForNull(rs.getString("DebtorName"));
                String deliverContact= checkForNull(rs.getString("DeliverContact"));
                String displayTerm= checkForNull(rs.getString("DisplayTerm"));
                String routeNumber= checkForNull(rs.getString("RouteNumber"));
                String deliverAddr1= checkForNull(rs.getString("DeliverAddr1"));
                String deliverAddr2= checkForNull(rs.getString("DeliverAddr2"));
                String deliverAddr3= checkForNull(rs.getString("DeliverAddr3"));
                String deliverAddr4= checkForNull(rs.getString("DeliverAddr4"));
                String lastModifiedBy= checkForNull(rs.getString("LastModifiedBy"));  
                String paperBagRequired= checkForNull(rs.getString("PaperBagRequired")); 
                String preferredLanguage= checkForNull(rs.getString("PreferredLanguage")); 
                
                SalesOrderDetails salesOrderDetails = new SalesOrderDetails (orderIDRetrieved,createTimeStamp,
                        lastModifiedTimeStamp,status,deliveryDate,subTotal,paidAmt,companyName, debtorName,deliverContact, displayTerm,
                        routeNumber,deliverAddr1, deliverAddr2, deliverAddr3,deliverAddr4,lastModifiedBy,paperBagRequired,preferredLanguage);
                salesOrderDetailsReturn = salesOrderDetails;

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
            String populateMap = "Select soq.ItemCode, soq.Qty, soq.ReturnedQty, soq.ReducedQty, oi.UnitPrice from sales_order so \n" +
                    "inner join sales_order_quantity soq ON so.OrderID = soq.OrderID \n" +
                    "inner join order_item oi ON soq.ItemCode = oi.ItemCode\n" +
                    "where so.Status = \""+status+"\" and so.OrderID = \""+orderID+"\"";
            
            pstmt = conn.prepareStatement(populateMap);
            rs = pstmt.executeQuery();
            
            System.out.println("Passed connection");
            
            int count = 1;
            
            while (rs.next()) {
                
                String itemCode=checkForNull(rs.getString("ItemCode"));
                String qty=checkForNull(rs.getString("Qty"));
                String returnedQty=checkForNull(rs.getString("ReturnedQty"));
                String reducedQty=checkForNull(rs.getString("ReducedQty"));
                String unitPrice=checkForNull(rs.getString("UnitPrice"));

                ItemDetails itemDetails = new ItemDetails (itemCode,qty,returnedQty,reducedQty, unitPrice);
                
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
    
    public static Map<Integer, SalesOrder> getAllSalesOrderMap(String sourcePage){
        Map<Integer, SalesOrder> salesOrderMap = new HashMap<>();
        
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        int count = 1;
        
        try {
            conn = ConnectionManager.getConnection();
            
            String populateMap ="";
            if(sourcePage.equals("History")){
                populateMap = "select so.OrderID, d.DebtorCode, d.DebtorName, d.RouteNumber from sales_order so \n" +
                "inner join debtor d on so.DebtorCode = d.DebtorCode  \n" +
                "inner join sales_order_detail sod on so.OrderID = sod.OrderID \n" +
                "order by sod.DeliveryDate DESC, d.RouteNumber ASC";
            }else{
                populateMap = "select so.OrderID, d.DebtorCode, d.DebtorName, d.RouteNumber from sales_order so \n" +
                "inner join debtor d on so.DebtorCode = d.DebtorCode  \n" +
                "inner join sales_order_detail sod on so.OrderID = sod.OrderID \n" +
                "order by sod.DeliveryDate ASC, d.RouteNumber ASC";
            }

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
    

    private static String catalogueCheckForNull(String string){
       if(string == null || string.equals("null")){
           return "-";
       }
       return string;
   }
    private static String checkForNull(String string){
       if(string == null || string.equals("null")){
           return "-";
       }
       return string;
   }
    
  public static SalesOrderDetails getAllSalesOrderDetails(String orderID){
        //Map<Integer, SalesOrderDetails> salesOrderDetailsMap = new HashMap<>();
        
        SalesOrderDetails salesOrderDetailsReturn = null;
        
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        //int count = 1;
        
        try {
            conn = ConnectionManager.getConnection();
            String populateMap = "Select so.OrderID, so.CreatedTimeStamp, so.Status, so.LastModifiedTimeStamp, so.LastModifiedBy, so.PaperBagRequired, \n" +
                "sod.DeliveryDate, sod.SubTotal, sod.PaidAmt, \n" +
                "d.CompanyName, d.DebtorName, d.DeliverContact, d.DisplayTerm, d.RouteNumber,\n" +
                "d.DeliverAddr1, d.DeliverAddr2, d.DeliverAddr3, d.DeliverAddr4, d.PreferredLanguage \n" +
                "from sales_order so inner join sales_order_detail sod ON so.OrderID = sod.OrderID\n" +
                "inner join debtor d ON so.DebtorCode = d.DebtorCode \n" +
                "where so.OrderID = \"" + orderID + "\"" + 
                 "order by sod.DeliveryDate DESC";
            
            pstmt = conn.prepareStatement(populateMap);
            rs = pstmt.executeQuery();
            
            System.out.println("Passed connection");

            while (rs.next()) {
                
                String orderIDRetrieved = checkForNull(rs.getString("OrderID"));
                String createTimeStamp= checkForNull(rs.getString("CreatedTimeStamp"));
                String status= checkForNull(rs.getString("Status"));
                String lastModifiedTimeStamp= checkForNull(rs.getString("LastModifiedTimeStamp"));
                String deliveryDate= checkForNull(rs.getString("DeliveryDate"));
                String subTotal= checkForNull(rs.getString("SubTotal"));
                String paidAmt = checkForNull(rs.getString("PaidAmt"));
                String companyName= checkForNull(rs.getString("CompanyName"));
                String debtorName= checkForNull(rs.getString("DebtorName"));
                String deliverContact= checkForNull(rs.getString("DeliverContact"));
                String displayTerm= checkForNull(rs.getString("DisplayTerm"));
                String routeNumber= checkForNull(rs.getString("RouteNumber"));
                String deliverAddr1= checkForNull(rs.getString("DeliverAddr1"));
                String deliverAddr2= checkForNull(rs.getString("DeliverAddr2"));
                String deliverAddr3= checkForNull(rs.getString("DeliverAddr3"));
                String deliverAddr4= checkForNull(rs.getString("DeliverAddr4"));
                String lastModifiedBy= checkForNull(rs.getString("LastModifiedBy"));  
                String paperBagRequired= checkForNull(rs.getString("PaperBagRequired")); 
                String preferredLanguage= checkForNull(rs.getString("PreferredLanguage")); 
                
                SalesOrderDetails salesOrderDetails = new SalesOrderDetails (orderIDRetrieved,createTimeStamp,
                        lastModifiedTimeStamp,status,deliveryDate,subTotal,paidAmt,companyName, debtorName,deliverContact, displayTerm,
                        routeNumber,deliverAddr1, deliverAddr2, deliverAddr3,deliverAddr4,lastModifiedBy,paperBagRequired,preferredLanguage);
                salesOrderDetailsReturn = salesOrderDetails;

            }
            
        }catch(SQLException e){
            
            System.out.println("SQLException thrown by getSalesOrderDetails method");
            System.out.println(e.getMessage());
            
        }finally{
            ConnectionManager.close(conn, pstmt, rs);
        }
        
        return salesOrderDetailsReturn;
    } 
    public static SalesOrderDetails getAllSalesOrderDetailsDesc(String orderID){
        //Map<Integer, SalesOrderDetails> salesOrderDetailsMap = new HashMap<>();
        
        SalesOrderDetails salesOrderDetailsReturn = null;
        
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        //int count = 1;
        
        try {
            conn = ConnectionManager.getConnection();
            String populateMap = "Select so.OrderID, so.CreatedTimeStamp, so.Status, so.LastModifiedTimeStamp, so.LastModifiedBy, so.PaperBagRequired \n" +
                "sod.DeliveryDate, sod.SubTotal, sod.PaidAmt, \n" +
                "d.CompanyName, d.DebtorName, d.DeliverContact, d.DisplayTerm, d.RouteNumber,\n" +
                "d.DeliverAddr1, d.DeliverAddr2, d.DeliverAddr3, d.DeliverAddr4, d.PreferredLanguage \n" +
                "from sales_order so inner join sales_order_detail sod ON so.OrderID = sod.OrderID\n" +
                "inner join debtor d ON so.DebtorCode = d.DebtorCode \n" +
                "where so.OrderID = \"" + orderID + "\"\n" + 
                 "sod.DeliveryDate desc, so.CreatedTimeStamp asc, d.DebtorName";
            
            pstmt = conn.prepareStatement(populateMap);
            rs = pstmt.executeQuery();
            
            System.out.println("Passed connection");

            while (rs.next()) {
                
                String orderIDRetrieved = checkForNull(rs.getString("OrderID"));
                String createTimeStamp= checkForNull(rs.getString("CreatedTimeStamp"));
                String status= checkForNull(rs.getString("Status"));
                String lastModifiedTimeStamp= checkForNull(rs.getString("LastModifiedTimeStamp"));
                String deliveryDate= checkForNull(rs.getString("DeliveryDate"));
                String subTotal= checkForNull(rs.getString("SubTotal"));
                String paidAmt = checkForNull(rs.getString("PaidAmt"));
                String companyName= checkForNull(rs.getString("CompanyName"));
                String debtorName= checkForNull(rs.getString("DebtorName"));
                String deliverContact= checkForNull(rs.getString("DeliverContact"));
                String displayTerm= checkForNull(rs.getString("DisplayTerm"));
                String routeNumber= checkForNull(rs.getString("RouteNumber"));
                String deliverAddr1= checkForNull(rs.getString("DeliverAddr1"));
                String deliverAddr2= checkForNull(rs.getString("DeliverAddr2"));
                String deliverAddr3= checkForNull(rs.getString("DeliverAddr3"));
                String deliverAddr4= checkForNull(rs.getString("DeliverAddr4"));
                String lastModifiedBy= checkForNull(rs.getString("LastModifiedBy"));  
                String paperBagRequired= checkForNull(rs.getString("PaperBagRequired")); 
                String preferredLanguage= checkForNull(rs.getString("PreferredLanguage")); 
                
                SalesOrderDetails salesOrderDetails = new SalesOrderDetails (orderIDRetrieved,createTimeStamp,
                        lastModifiedTimeStamp,status,deliveryDate,subTotal,paidAmt,companyName, debtorName,deliverContact, displayTerm,
                        routeNumber,deliverAddr1, deliverAddr2, deliverAddr3,deliverAddr4,lastModifiedBy,paperBagRequired,preferredLanguage);
                salesOrderDetailsReturn = salesOrderDetails;

            }
            
        }catch(SQLException e){
            
            System.out.println("SQLException thrown by getSalesOrderDetails method");
            System.out.println(e.getMessage());
            
        }finally{
            ConnectionManager.close(conn, pstmt, rs);
        }
        
        return salesOrderDetailsReturn;
    }
    
        public static Map<Integer,ItemDetails> getRefundedItemDetailsMap(String orderID){
        
        Map<Integer,ItemDetails> itemDetailsMap = new HashMap<>();
        
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try {
            conn = ConnectionManager.getConnection();
            String populateMap = "Select soq.ItemCode, soq.Qty, soq.ReturnedQty, soq.ReducedQty, oi.UnitPrice from sales_order so \n" +
                    "inner join sales_order_quantity soq ON so.OrderID = soq.OrderID \n" +
                    "inner join order_item oi ON soq.ItemCode = oi.ItemCode\n" +
                    "where soq.ReturnedQty > 0 and so.OrderID = \""+orderID+"\"";
            
            pstmt = conn.prepareStatement(populateMap);
            rs = pstmt.executeQuery();
            
            System.out.println("Passed connection");
            
            int count = 1;
            
            while (rs.next()) {
                
                String itemCode=checkForNull(rs.getString("ItemCode"));
                String qty=checkForNull(rs.getString("Qty"));
                String returnedQty=checkForNull(rs.getString("ReturnedQty"));
                String reducedQty=checkForNull(rs.getString("ReducedQty"));
                String unitPrice=checkForNull(rs.getString("UnitPrice"));

                ItemDetails itemDetails = new ItemDetails (itemCode,qty,returnedQty,reducedQty,unitPrice);
                
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
   
    public static OrderItem getOrderItem(String itemCodeInput){
        
        OrderItem orderItemReturned = null;
        
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        int count = 1;
        
        try {
            conn = ConnectionManager.getConnection();
            String populateMap = "SELECT * from order_item WHERE ItemCode='"+itemCodeInput+"' ";
            pstmt = conn.prepareStatement(populateMap);
            rs = pstmt.executeQuery();
            
            System.out.println("Passed connection");

            while (rs.next()) {
                
                String itemCode = catalogueCheckForNull(rs.getString("ItemCode"));
                String description = catalogueCheckForNull(rs.getString("Description"));
                String descriptionChinese = catalogueCheckForNull(rs.getString("Description2"));
                String unitPrice = catalogueCheckForNull(rs.getString("UnitPrice"));
                String retailPrice = catalogueCheckForNull(rs.getString("retailPrice"));
                String unitOfMetric = catalogueCheckForNull(rs.getString("UnitOfMetric"));
                String imageURL = catalogueCheckForNull(rs.getString("imageURL"));
                String defaultQty = catalogueCheckForNull(rs.getString("defaultQty"));
                String qtyMultiples = catalogueCheckForNull(rs.getString("qtyMultiples"));
                String status = catalogueCheckForNull(rs.getString("Status"));
                String lastModifiedTimeStamp= checkForNull(rs.getString("LastModifiedTimeStamp"));
                String lastModifiedBy= checkForNull(rs.getString("LastModifiedBy"));  
                
                orderItemReturned = new OrderItem (itemCode,description,descriptionChinese,unitPrice,retailPrice,
                        unitOfMetric,imageURL,defaultQty,qtyMultiples,status,lastModifiedTimeStamp,lastModifiedBy);
                
            }
            
        }catch(SQLException e){
            
            System.out.println("SQLException thrown by getOrderItem method");
            System.out.println(e.getMessage());
            
        }finally{
            ConnectionManager.close(conn, pstmt, rs);
        }
        
        return orderItemReturned;
    }
    
    public static String getCustomerCode(String orderID,String status){
        
        String customerCode = null;
        
        if(orderID== null || status==null){
            return "none";
        }else{
            Connection conn = null;
            PreparedStatement pstmt = null;
            ResultSet rs = null;

            //int count = 1;

            try {
                conn = ConnectionManager.getConnection();
                String populateMap = "Select d.DebtorCode " +
                    "from sales_order so inner join sales_order_detail sod ON so.OrderID = sod.OrderID\n" +
                    "inner join debtor d ON so.DebtorCode = d.DebtorCode \n" +
                    "where so.Status = \""+status+"\" and so.OrderID = \"" + orderID + "\"";

                pstmt = conn.prepareStatement(populateMap);
                rs = pstmt.executeQuery();

                System.out.println("Passed connection");

                while (rs.next()) {
                    customerCode = checkForNull(rs.getString("DebtorCode"));
                }

            }catch(SQLException e){

                System.out.println("SQLException thrown by getCustomerCode method");
                System.out.println(e.getMessage());

            }finally{
                ConnectionManager.close(conn, pstmt, rs);
            }

            return customerCode;
        }
    }
    
}
