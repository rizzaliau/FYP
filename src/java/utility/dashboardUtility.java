/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package utility;

import dao.ConnectionManager;
import entity.BreakdownItem;
import entity.ItemDetails;
import entity.OrderItem;
import entity.SalesOrder;
import entity.SalesOrderDetails;
import entity.User;
import static java.lang.System.out;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

/**
 *
 * @author Rizza
 */
public class dashboardUtility {
    
    //Key Month, Value Revenue for a particular month
    public static Map<Integer, Double> getSalesRevenueByMonth(int year){
        
        Map<Integer, Double> salesRevenueByMonthMap = new HashMap<>();
        
        for(int month = 1; month<=12 ; month++){
        
            Map<Integer, SalesOrder> allSalesOrderRevenueMap = getAllRevenueSalesOrderMapByMonth(month,year);
            
            double totalForMonth = 0;
            
            for (Integer number : allSalesOrderRevenueMap.keySet()) {

                SalesOrder salesOrder = allSalesOrderRevenueMap.get(number);

                SalesOrderDetails salesOrderdetails = salesOrderUtility.getAllSalesOrderDetails(salesOrder.getOrderID());

                Map<Integer, ItemDetails> itemDetailsMap = salesOrderUtility.getItemDetailsMap(salesOrder.getOrderID(), salesOrderdetails.getStatus());
                
                for (Integer itemNumber : itemDetailsMap.keySet()) {

                    ItemDetails itemDetail = itemDetailsMap.get(itemNumber);

                    double qtyDouble = Double.parseDouble(itemDetail.getQty());
                    double unitPriceDouble = Double.parseDouble(itemDetail.getUnitPrice());

                    totalForMonth += qtyDouble *  unitPriceDouble;

                }

            }
            double totalForMonthRounded =  (int)Math.rint(totalForMonth);
            
            salesRevenueByMonthMap.put(month, totalForMonthRounded);
        }   

        return salesRevenueByMonthMap;
    }
    
    
    //Key Month, Value Revenue for a particular month using new SQL
    public static Map<Integer, Double> getSalesRevenueByMonthTest(int year){
        
        Map<Integer, Double> salesRevenueByMonthMap = new HashMap<>();

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        int count = 1;
        
        try {
            conn = ConnectionManager.getConnection();
            
            String populateMap = "select month(sod.DeliveryDate) as monthSpecific,sum(round(sod.SubTotal*1.07,2)-(soq.ReturnedQty*oi.RetailPrice)-(soq.ReducedQty*oi.RetailPrice)) as revenue \n" +
"                from sales_order so\n" +
"                inner join sales_order_detail sod on so.OrderID = sod.OrderID\n" +
"                inner join sales_order_quantity soq on soq.OrderID = so.OrderID\n" +
"                inner join order_item oi on soq.ItemCode = oi.ItemCode \n" +
"                where (so.Status = 'Pending Delivery' and YEAR(`CreatedTimeStamp`) = '"+year+"') OR \n" +
"                (so.Status = 'Delivered' and YEAR(`CreatedTimeStamp`) = '"+year+"')\n" +
"                group by month(DeliveryDate)";

            pstmt = conn.prepareStatement(populateMap);
            rs = pstmt.executeQuery();
            
            System.out.println("Passed connection");

            while (rs.next()) {
                
                String month = checkForNull(rs.getString("monthSpecific"));
                String revenueForMonth = checkForNull(rs.getString("revenue"));
                
                if(month != null || revenueForMonth!= null){
                    int monthInt = Integer.parseInt(month);
                    Double revenueDouble = Double.parseDouble(revenueForMonth);
                    
                    salesRevenueByMonthMap.put(monthInt, revenueDouble);
                }

                count++;
            }
            
        }catch(SQLException e){
            
            System.out.println("SQLException thrown by getSalesOrderMap method");
            System.out.println(e.getMessage());
            
        }finally{
            ConnectionManager.close(conn, pstmt, rs);
        }
        
        for(int month = salesRevenueByMonthMap.size(); month<12 ; month++){
            
            salesRevenueByMonthMap.put(month+1, 0.0);
            
        }   

        return salesRevenueByMonthMap;
    }
    
    //Key Month, Value SalesOrder for a particular month
    public static Map<Integer, SalesOrder> getAllRevenueSalesOrderMapByMonth(int month,int year){
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
                "where (so.Status = 'Pending Delivery' and MONTH(`CreatedTimeStamp`) = '"+month+"') and YEAR(`CreatedTimeStamp`) = '"+year+"' OR "
                    + "(so.Status = 'Delivered' and MONTH(`CreatedTimeStamp`) = '"+month+"') and YEAR(`CreatedTimeStamp`) = '"+year+"' "+
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
    
    //Key Rank, Value OrderItem Description
    public static Map<Integer, String> getTop5ProductsByMonthOriginal(int month,int year){
        
        //return map 
        Map<Integer, String> top5ProductsByMonth = new HashMap<>();
        
        //all sales orders for a particular month
        Map<Integer, SalesOrder> allSalesOrderMap = getAllRevenueSalesOrderMapByMonth(month,year);
        
        //List of all available order item (description)
        List<String> orderItemDiscriptionList = getOrderItemList();
        
        //key orderitem description, value quantiy of product ordered
        Map<String, Integer> getProductQtyForMonth = new HashMap<>();
        
        //Populate the getProductQtyForMonth Map for all the order items with 0 Quantity
        for (int i = 0; i< orderItemDiscriptionList.size(); i++) {
            getProductQtyForMonth.put(orderItemDiscriptionList.get(i), 0);
        }
        
        //loop through the all the sales order for a particular month
        for (Integer number : allSalesOrderMap.keySet()) {

            SalesOrder salesOrder = allSalesOrderMap.get(number);

            SalesOrderDetails salesOrderdetails = salesOrderUtility.getAllSalesOrderDetails(salesOrder.getOrderID());

            Map<Integer, ItemDetails> itemDetailsMap = salesOrderUtility.getItemDetailsMap(salesOrder.getOrderID(), salesOrderdetails.getStatus());
            
                for (Integer itemNumber : itemDetailsMap.keySet()) {

                    ItemDetails itemDetail = itemDetailsMap.get(itemNumber);
                    OrderItem item = salesOrderUtility.getOrderItem(itemDetail.getItemCode());
                    
                    String description = item.getDescription();
                    int qtyInt = Integer.parseInt(itemDetail.getQty());
                    
                    int newQuantity = getProductQtyForMonth.get(description)+qtyInt;
                    
                    getProductQtyForMonth.put(description, newQuantity);

                }
            
            
        }
        
        List<Entry<String, Integer>> list = new LinkedList<Entry<String, Integer>>(getProductQtyForMonth.entrySet());
        
        Collections.sort(list,new Comparator<Entry<String, Integer>>(){
            public int compare(Entry<String,Integer> o1, Entry<String, Integer> o2){
                return o1.getValue().compareTo(o2.getValue());
            }
        });
        
        int rank = 1;
        
        int rank5Value = 0;

        for (int k = list.size()-1; k>=list.size()-6; k--){    
            
            Entry<String, Integer> entry = list.get(k);
            
            String key = entry.getKey();
            int value = entry.getValue();
            
            System.out.println(entry);
            System.out.println("Key is "+key);
            
            if(k==list.size()-5){
                rank5Value = value;
            }
            
            if(rank5Value == value){
                top5ProductsByMonth.put(rank,key);
            }
            
            top5ProductsByMonth.put(rank,key);
            rank++;
            
        }

        return top5ProductsByMonth;
    }
    
    public static Map<Integer, String> getTop5ProductsByMonth(int month,int year){
        
        //return map 
        Map<Integer, String> top5ProductsByMonth = new HashMap<>();
        
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        int count = 1;
        
        try {
            conn = ConnectionManager.getConnection();
            
            String populateMap = "Select distinct t1.itemcode,t1.qty from "
                    + "(SELECT soq.itemcode,SUM(soq.`Qty`) as qty FROM sales_order_quantity soq ,"
                    + "`sales_order_detail` sod where soq.`OrderID` = sod.`OrderId` "
                    + "and month(sod.deliveryDate) = "+month+" and "
                    + "year(sod.deliveryDate) = "+year+" "
                    + "group by soq.ItemCode order by SUM(soq.`Qty`) desc limit 6) "
                    + "as t1 inner join (SELECT soq.itemcode,SUM(soq.`Qty`) "
                    + "as qty FROM sales_order_quantity soq ,`sales_order_detail` sod "
                    + "where soq.`OrderID` = sod.`OrderId` and month(sod.deliveryDate) = "+month+" "
                    + "and year(sod.deliveryDate) = "+year+" "
                    + "group by soq.ItemCode order by SUM(soq.`Qty`) desc) as t2 on t1.qty = t2.qty";

            pstmt = conn.prepareStatement(populateMap);
            rs = pstmt.executeQuery();
            
            System.out.println("Passed connection");

            while (rs.next()) {
                
                String itemCode = checkForNull(rs.getString("t1.itemcode"));
                
                if(itemCode != null){
                    OrderItem orderItem = salesOrderUtility.getOrderItem(itemCode);
                    String orderDescription = orderItem.getDescription();
                    
                    top5ProductsByMonth.put(count, orderDescription);
                }

                count++;
            }
            
        }catch(SQLException e){
            
            System.out.println("SQLException thrown by top5ProductsByMonth method");
            System.out.println(e.getMessage());
            
        }finally{
            ConnectionManager.close(conn, pstmt, rs);
        }
        
        return top5ProductsByMonth;
    }
    

    //Get list of all availabe orderitems
    public static List<String> getOrderItemList(){
        
        List<String> orderItemsList = new ArrayList<>();
        
        Map<Integer, OrderItem> catalogueMap = salesOrderUtility.getCatalogueMap();
        
        for (Integer number : catalogueMap.keySet()) {
            OrderItem orderItem = catalogueMap.get(number);
            orderItemsList.add(orderItem.getDescription());

        }

        return orderItemsList;
    }
    
    //Key order description, Value qty for that particular month
    public static Map<String, Integer> getQtyForItemDescriptionMonthOriginal(int month, int year){
        
        //key orderitem description, value quantiy of product ordered
        Map<String, Integer> getProductQtyForMonth = new HashMap<>();
        
        //all sales orders for a particular month
        Map<Integer, SalesOrder> allSalesOrderMap = getAllRevenueSalesOrderMapByMonth(month,year);
        
        //List of all available order item (description)
        List<String> orderItemDiscriptionList = getOrderItemList();
        

        //Populate the getProductQtyForMonth Map for all the order items with 0 Quantity
        for (int i = 0; i< orderItemDiscriptionList.size(); i++) {
            getProductQtyForMonth.put(orderItemDiscriptionList.get(i), 0);
        }
        
        //loop through the all the sales order for a particular month
        for (Integer number : allSalesOrderMap.keySet()) {

            SalesOrder salesOrder = allSalesOrderMap.get(number);

            SalesOrderDetails salesOrderdetails = salesOrderUtility.getAllSalesOrderDetails(salesOrder.getOrderID());

            Map<Integer, ItemDetails> itemDetailsMap = salesOrderUtility.getItemDetailsMap(salesOrder.getOrderID(), salesOrderdetails.getStatus());
            
                for (Integer itemNumber : itemDetailsMap.keySet()) {

                    ItemDetails itemDetail = itemDetailsMap.get(itemNumber);
                    OrderItem item = salesOrderUtility.getOrderItem(itemDetail.getItemCode());
                    
                    String description = item.getDescription();
                    int qtyInt = Integer.parseInt(itemDetail.getQty());
                    
                    int newQuantity = getProductQtyForMonth.get(description)+qtyInt;
                    
                    getProductQtyForMonth.put(description, newQuantity);

                }
            
            
        }
        
        return getProductQtyForMonth;
    }

    //Key order description, Value qty for that particular month
    public static Map<String, Integer> getQtyForItemDescriptionMonth(int month, int year){
        
        //key orderitem description, value quantiy of product ordered
        Map<String, Integer> getProductQtyForMonth = new HashMap<>();

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        int count = 1;
        
        try {
            conn = ConnectionManager.getConnection();
            
            String populateMap = "Select distinct t1.itemcode,t1.qty from "
                    + "(SELECT soq.itemcode,SUM(soq.`Qty`) as qty FROM sales_order_quantity soq ,"
                    + "`sales_order_detail` sod where soq.`OrderID` = sod.`OrderId` "
                    + "and month(sod.deliveryDate) = "+month+" and "
                    + "year(sod.deliveryDate) = "+year+" "
                    + "group by soq.ItemCode order by SUM(soq.`Qty`) desc limit 6) "
                    + "as t1 inner join (SELECT soq.itemcode,SUM(soq.`Qty`) "
                    + "as qty FROM sales_order_quantity soq ,`sales_order_detail` sod "
                    + "where soq.`OrderID` = sod.`OrderId` and month(sod.deliveryDate) = "+month+" "
                    + "and year(sod.deliveryDate) = "+year+" "
                    + "group by soq.ItemCode order by SUM(soq.`Qty`) desc) as t2 on t1.qty = t2.qty";

            pstmt = conn.prepareStatement(populateMap);
            rs = pstmt.executeQuery();
            
            System.out.println("Passed connection");

            while (rs.next()) {
                
                String itemCode = checkForNull(rs.getString("t1.itemcode"));
                String qty = checkForNull(rs.getString("t1.qty"));
                
                if(qty != null){
                    
                    OrderItem orderItem = salesOrderUtility.getOrderItem(itemCode);
                    String orderDescription = orderItem.getDescription();
                    
                    int qtyInt = Integer.parseInt(qty);
                    
                    getProductQtyForMonth.put(orderDescription,qtyInt);

                }

                count++;
            }
            
        }catch(SQLException e){
            
            System.out.println("SQLException thrown by top5ProductsByMonth method");
            System.out.println(e.getMessage());
            
        }finally{
            ConnectionManager.close(conn, pstmt, rs);
        }
        
        return getProductQtyForMonth;
    }
    
    
    
    
    //Key Rank, Value, Top Return product name
    public static Map<Integer, String> getMostReturnedProductsByMonthOriginal(int month,int year){
        
        //return map 
        Map<Integer, String> mostReturnedProductsByMonth = new HashMap<>();
        
        //all sales orders for a particular month
        Map<Integer, SalesOrder> allSalesOrderMap = getAllRevenueSalesOrderMapByMonth(month,year);
        
        //List of all available order item (description)
        List<String> orderItemDiscriptionList = getOrderItemList();
        
        //key orderitem description, value quantity of product ordered
        Map<String, Integer> getProductQtyForMonth = new HashMap<>();
        
        //key orderitem description, value returned quantity of product ordered
        Map<String, Integer> getReturnedProductQtyForMonth = new HashMap<>();
        
        //key orderitem description, value % returned quantity of product ordered
        Map<String, Double> getPercentageReturnedProductMap = new HashMap<>();
        
        //Populate the getProductQtyForMonth Map for all the order items with 0 Quantity
        for (int i = 0; i< orderItemDiscriptionList.size(); i++) {
            getProductQtyForMonth.put(orderItemDiscriptionList.get(i), 0);
        }
        
        for (int i = 0; i< orderItemDiscriptionList.size(); i++) {
            getReturnedProductQtyForMonth.put(orderItemDiscriptionList.get(i), 0);
        }
        
        //loop through the all the sales order for a particular month
        for (Integer number : allSalesOrderMap.keySet()) {

            SalesOrder salesOrder = allSalesOrderMap.get(number);

            SalesOrderDetails salesOrderdetails = salesOrderUtility.getAllSalesOrderDetails(salesOrder.getOrderID());

            Map<Integer, ItemDetails> itemDetailsMap = salesOrderUtility.getItemDetailsMap(salesOrder.getOrderID(), salesOrderdetails.getStatus());
            
                for (Integer itemNumber : itemDetailsMap.keySet()) {

                    ItemDetails itemDetail = itemDetailsMap.get(itemNumber);
                    OrderItem item = salesOrderUtility.getOrderItem(itemDetail.getItemCode());
                    
                    String description = item.getDescription();
                    int qtyInt = Integer.parseInt(itemDetail.getQty());
                    int returnedQtyInt = Integer.parseInt(itemDetail.getReturnedQty());
                    
                    int newQuantity = getProductQtyForMonth.get(description)+qtyInt;
                    int newReturnedQuantity = getReturnedProductQtyForMonth.get(description)+returnedQtyInt;
                    
                    getReturnedProductQtyForMonth.put(description, newReturnedQuantity);
                    getProductQtyForMonth.put(description, newQuantity);

                }
            
            
        }
        
        //Loop to calculate percentage of returned items
        for (String itemDescription : getProductQtyForMonth.keySet() ){
            double percentageReturned = 0;
            
            int qty = getProductQtyForMonth.get(itemDescription);
                    
            double returnedQty = getReturnedProductQtyForMonth.get(itemDescription);
            
            if(qty==0 && returnedQty ==0){
                getPercentageReturnedProductMap.put(itemDescription, 0.0);
            }else{
            
                percentageReturned = (returnedQty/(qty+returnedQty))*100;

                getPercentageReturnedProductMap.put(itemDescription, percentageReturned);
                
            }
        }
        
        List<Entry<String, Double>> list = new LinkedList<Entry<String, Double>>(getPercentageReturnedProductMap.entrySet());
        
        Collections.sort(list,new Comparator<Entry<String, Double>>(){
            public int compare(Entry<String,Double> o1, Entry<String, Double> o2){
                return o1.getValue().compareTo(o2.getValue());
            }
        });
        
        int rank = 1;

        for (int k = list.size()-1; k>=list.size()-5; k--){    
            
            Entry<String, Double> entry = list.get(k);
            
            String key = entry.getKey();
            double value = entry.getValue();
            
            System.out.println(entry);
            System.out.println("Key is "+key);
            
            mostReturnedProductsByMonth.put(rank,key);
            rank++;
            
        }

        return mostReturnedProductsByMonth;
    }
    
    //Key Rank, Value, Top Return product name
    public static Map<Integer, String> getMostReturnedProductsByMonth(int month,int year){
        
        //return map 
        Map<Integer, String> mostReturnedProductsByMonth = new HashMap<>();
        
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        int count = 1;
        
        out.println("test 1");
        
        try {
            conn = ConnectionManager.getConnection();
            
            String populateMap = "select temp1.* from (select itemCode,sum(qty),sum(returnedQty),sum(returnedQty)/sum(Qty)*100 as ReturnedRate from sales_order_quantity\n" +
            "inner join sales_order \n" +
            "inner join sales_order_detail\n" +
            "on sales_order_quantity.OrderID = sales_order.OrderID\n" +
            "and sales_order.OrderID = sales_order_detail.OrderID\n" +
            "where month(sales_order_detail.DeliveryDate) = "+month+" \n" +
            "and year(sales_order_detail.DeliveryDate) = "+year+" \n" +
            "group by itemCode order by ReturnedRate desc limit 5)temp1\n" +
            "inner JOIN\n" +
            "(select itemCode,sum(qty),sum(returnedQty),sum(returnedQty)/sum(Qty)*100 as ReturnedRate from sales_order_quantity\n" +
            "inner join sales_order \n" +
            "inner join sales_order_detail\n" +
            "on sales_order_quantity.OrderID = sales_order.OrderID\n" +
            "and sales_order.OrderID = sales_order_detail.OrderID\n" +
            "where month(sales_order_detail.DeliveryDate) = "+month+" \n" +
            "and year(sales_order_detail.DeliveryDate) = "+year+" \n" +
            "group by itemCode order by ReturnedRate desc)temp2\n" +
            "on temp1.itemCode = temp2.itemCode";

            pstmt = conn.prepareStatement(populateMap);
            rs = pstmt.executeQuery();
            
            System.out.println("Passed connection");
            
            out.println("test 2 before while loop");

            while (rs.next()) {

                String itemCode = checkForNull(rs.getString("itemcode"));

                if(itemCode != null){
                    
                    OrderItem orderItem = salesOrderUtility.getOrderItem(itemCode);
                    String orderDescription = orderItem.getDescription();
 
                    mostReturnedProductsByMonth.put(count,orderDescription);

                }

                count++;
            }

            
        }catch(SQLException e){
            
            System.out.println("SQLException thrown by mostReturnedProductsByMonth method");
            System.out.println(e.getMessage());
            
        }finally{
            ConnectionManager.close(conn, pstmt, rs);
        }

        return mostReturnedProductsByMonth;
    }
    
    // key item name, value returned qty percentage for a particular month and year
    public static Map<String, Double> getReturnedQtyPercentageForItemDescriptionMonthOriginal(int month, int year){
        
        //key orderitem description, value % returned quantity of product ordered
        Map<String, Double> getPercentageReturnedProductMap = new HashMap<>();
        
        //all sales orders for a particular month
        Map<Integer, SalesOrder> allSalesOrderMap = getAllRevenueSalesOrderMapByMonth(month,year);
        
        //List of all available order item (description)
        List<String> orderItemDiscriptionList = getOrderItemList();
        
        //key orderitem description, value quantity of product ordered
        Map<String, Integer> getProductQtyForMonth = new HashMap<>();
        
        //key orderitem description, value returned quantity of product ordered
        Map<String, Integer> getReturnedProductQtyForMonth = new HashMap<>();
        

        //Populate the getProductQtyForMonth Map for all the order items with 0 Quantity
        for (int i = 0; i< orderItemDiscriptionList.size(); i++) {
            getProductQtyForMonth.put(orderItemDiscriptionList.get(i), 0);
        }
        
        for (int i = 0; i< orderItemDiscriptionList.size(); i++) {
            getReturnedProductQtyForMonth.put(orderItemDiscriptionList.get(i), 0);
        }
        
        //loop through the all the sales order for a particular month
        for (Integer number : allSalesOrderMap.keySet()) {

            SalesOrder salesOrder = allSalesOrderMap.get(number);

            SalesOrderDetails salesOrderdetails = salesOrderUtility.getAllSalesOrderDetails(salesOrder.getOrderID());

            Map<Integer, ItemDetails> itemDetailsMap = salesOrderUtility.getItemDetailsMap(salesOrder.getOrderID(), salesOrderdetails.getStatus());
            
                for (Integer itemNumber : itemDetailsMap.keySet()) {

                    ItemDetails itemDetail = itemDetailsMap.get(itemNumber);
                    OrderItem item = salesOrderUtility.getOrderItem(itemDetail.getItemCode());
                    
                    String description = item.getDescription();
                    int qtyInt = Integer.parseInt(itemDetail.getQty());
                    int returnedQtyInt = Integer.parseInt(itemDetail.getReturnedQty());
                    
                    int newQuantity = getProductQtyForMonth.get(description)+qtyInt;
                    int newReturnedQuantity = getReturnedProductQtyForMonth.get(description)+returnedQtyInt;
                    
                    getReturnedProductQtyForMonth.put(description, newReturnedQuantity);
                    getProductQtyForMonth.put(description, newQuantity);

                }
            
            
        }
        
        //Loop to calculate percentage of returned items
        for (String itemDescription : getProductQtyForMonth.keySet() ){
            double percentageReturned = 0;
            
            int qty = getProductQtyForMonth.get(itemDescription);
                    
            double returnedQty = getReturnedProductQtyForMonth.get(itemDescription);
            
            if(qty==0 && returnedQty ==0){
                getPercentageReturnedProductMap.put(itemDescription, 0.0);
            }else{
            
                percentageReturned = (returnedQty/(qty+returnedQty))*100;
                
                double percentageReturnedRounded =  (int)Math.rint(percentageReturned);

                getPercentageReturnedProductMap.put(itemDescription, percentageReturnedRounded);

            }
        }
        
        return getPercentageReturnedProductMap;
    }
    
    
    // key item name, value returned qty percentage for a particular month and year
    public static Map<String, Double> getReturnedQtyPercentageForItemDescriptionMonth(int month, int year){
        
        //key orderitem description, value % returned quantity of product ordered
        Map<String, Double> getPercentageReturnedProductMap = new HashMap<>();
        
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = ConnectionManager.getConnection();
            
            String populateMap = "select temp1.* from (select itemCode,sum(qty),sum(returnedQty),sum(returnedQty)/sum(Qty)*100 as ReturnedRate from sales_order_quantity\n" +
            "inner join sales_order \n" +
            "inner join sales_order_detail\n" +
            "on sales_order_quantity.OrderID = sales_order.OrderID\n" +
            "and sales_order.OrderID = sales_order_detail.OrderID\n" +
            "where month(sales_order_detail.DeliveryDate) = "+month+"\n" +
            "and year(sales_order_detail.DeliveryDate) = "+year+"\n" +
            "group by itemCode order by ReturnedRate desc limit 5)temp1\n" +
            "inner JOIN\n" +
            "(select itemCode,sum(qty),sum(returnedQty),sum(returnedQty)/sum(Qty)*100 as ReturnedRate from sales_order_quantity\n" +
            "inner join sales_order \n" +
            "inner join sales_order_detail\n" +
            "on sales_order_quantity.OrderID = sales_order.OrderID\n" +
            "and sales_order.OrderID = sales_order_detail.OrderID\n" +
            "where month(sales_order_detail.DeliveryDate) = "+month+"\n" +
            "and year(sales_order_detail.DeliveryDate) = "+year+"\n" +
            "group by itemCode order by ReturnedRate desc)temp2\n" +
            "on temp1.itemCode = temp2.itemCode";

            pstmt = conn.prepareStatement(populateMap);
            rs = pstmt.executeQuery();
            
            System.out.println("Passed connection");

            while (rs.next()) {
                
                String itemCode = checkForNull(rs.getString("itemcode"));
                String returnedRate = checkForNull(rs.getString("ReturnedRate"));

                if(itemCode != null && returnedRate!=null){
                    
                    OrderItem orderItem = salesOrderUtility.getOrderItem(itemCode);
                    String orderDescription = orderItem.getDescription();
                    
                    out.println("Percentage added to map"+returnedRate);
                    
                    Double returnedRateDouble = Double.parseDouble(returnedRate);

                    getPercentageReturnedProductMap.put(orderDescription,returnedRateDouble);

                }
                
                

            }
            getPercentageReturnedProductMap.put(null,0.0);
            
        }catch(SQLException e){
            
            System.out.println("SQLException thrown by getPercentageReturnedProductMap method");
            System.out.println(e.getMessage());
            
        }finally{
            ConnectionManager.close(conn, pstmt, rs);
        }


        return getPercentageReturnedProductMap;
    }
    
    
    //Key index, Value Year
    public static Map<Integer, Integer> getAvailableSalesOrderYears(){    

        Map<Integer,Integer> availableSalesOrderYears = new HashMap<>();
        
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        int count = 1;
        
        try {
            conn = ConnectionManager.getConnection();
            
            String populateMap = "select DISTINCT YEAR(CreatedTimeStamp) from sales_order so \n" +
                "inner join debtor d on so.DebtorCode = d.DebtorCode  \n" +
                "inner join sales_order_detail sod on so.OrderID = sod.OrderID \n" +
                "where so.Status = 'Pending Delivery' OR so.Status = 'Delivered'";

            pstmt = conn.prepareStatement(populateMap);
            rs = pstmt.executeQuery();
            
            System.out.println("Passed connection");

            while (rs.next()) {
                
                String year = checkForNull(rs.getString("YEAR(CreatedTimeStamp)"));
                int yearInt = Integer.parseInt(year);
                System.out.println(yearInt);
                
                availableSalesOrderYears.put(count, yearInt);
                count++;
            }
            
        }catch(SQLException e){
            
            System.out.println("SQLException thrown by getSalesOrderMap method");
            System.out.println(e.getMessage());
            
        }finally{
            ConnectionManager.close(conn, pstmt, rs);
        }
        
        return availableSalesOrderYears;
    }
    
    //Key Index, Value Month
    public static Map<Integer, String> getAllMonths(){    

        Map<Integer,String> allMonths = new HashMap<>();
        
        allMonths.put(1,"January");
        allMonths.put(2,"February");
        allMonths.put(3,"March");
        allMonths.put(4,"April");
        allMonths.put(5,"May");
        allMonths.put(6,"June");
        allMonths.put(7,"July");
        allMonths.put(8,"August");
        allMonths.put(9,"September");
        allMonths.put(10,"October");
        allMonths.put(11,"November");
        allMonths.put(12,"December");

        return allMonths;
    }
    
    //Key Index, Value Top 10 Customer for a particular month and year
    public static Map<Integer, String> getTop10CustomersByYearMonth(int year,int month){
        
        Map<Integer, String> top10CustomersByYearMonth = new HashMap<>();
        
        //Key Customer Code, Value Sales for a particular month and year
        Map<String, Double> allCustomerSalesByYearMonth = new HashMap<>();
        
        //Get all the sales orders for a particular month and year
        Map<Integer, SalesOrder> allSalesOrderRevenueMap = getAllRevenueSalesOrderMapByMonth(month,year);

        //loop through each sales order
        for (Integer number : allSalesOrderRevenueMap.keySet()) {

            double salesOrdertotalForCustomer = 0;

            SalesOrder salesOrder = allSalesOrderRevenueMap.get(number);

            SalesOrderDetails salesOrderdetails = salesOrderUtility.getAllSalesOrderDetails(salesOrder.getOrderID());

            Map<Integer, ItemDetails> itemDetailsMap = salesOrderUtility.getItemDetailsMap(salesOrder.getOrderID(), salesOrderdetails.getStatus());

            String debtorCode = salesOrder.getDebtorCode();
            
            System.out.println("Debtor code retrieved is "+debtorCode);

            //for each item in the sales order
            for (Integer itemNumber : itemDetailsMap.keySet()) {

                ItemDetails itemDetail = itemDetailsMap.get(itemNumber);

                double qtyDouble = Double.parseDouble(itemDetail.getQty());
                double unitPriceDouble = Double.parseDouble(itemDetail.getUnitPrice());

                salesOrdertotalForCustomer += qtyDouble *  unitPriceDouble;

            }

            if(allCustomerSalesByYearMonth.get(debtorCode) == null){
                allCustomerSalesByYearMonth.put(debtorCode, salesOrdertotalForCustomer);
            }else{
                double newTotal = salesOrdertotalForCustomer + allCustomerSalesByYearMonth.get(debtorCode);
                allCustomerSalesByYearMonth.put(debtorCode, newTotal);
            }    

        }
        
        List<Entry<String, Double>> list = new LinkedList<Entry<String, Double>>(allCustomerSalesByYearMonth.entrySet());
        
        Collections.sort(list,new Comparator<Entry<String, Double>>(){
            public int compare(Entry<String,Double> o1, Entry<String, Double> o2){
                return o1.getValue().compareTo(o2.getValue());
            }
        });
        
        int rank = 1;

        System.out.println("list size is"+list.size());

        for (int k = list.size(); k >= 1; k--){  
            
            Entry<String, Double> entryRetrieved = list.get(k-1);
            
            String key = entryRetrieved.getKey();
            double value = entryRetrieved.getValue();
            
            System.out.println(entryRetrieved);
            System.out.println("Key is "+key);
            
            if(value>300){
                top10CustomersByYearMonth.put(rank,key);
                rank++;
            }
            
        }
        
        
        while(top10CustomersByYearMonth.size() < 10){
            
            top10CustomersByYearMonth.put(rank," ");
            rank++;
            
            System.out.println("Rank is "+rank);
        }
        
        return top10CustomersByYearMonth;
    }
    
    // Key Customer code, value sales for a particular month and year
    public static Map<String, Double> getAllCustomerSalesByYearMonth(int year, int month){
        
        //Key Customer Code, Value Sales for a particular month and year
        Map<String, Double> allCustomerSalesByYearMonth = new HashMap<>();
        
        //Get all the sales orders for a particular month and year
        Map<Integer, SalesOrder> allSalesOrderRevenueMap = getAllRevenueSalesOrderMapByMonth(month,year);

        //loop through each sales order
        for (Integer number : allSalesOrderRevenueMap.keySet()) {

            double salesOrdertotalForCustomer = 0;

            SalesOrder salesOrder = allSalesOrderRevenueMap.get(number);

            SalesOrderDetails salesOrderdetails = salesOrderUtility.getAllSalesOrderDetails(salesOrder.getOrderID());

            Map<Integer, ItemDetails> itemDetailsMap = salesOrderUtility.getItemDetailsMap(salesOrder.getOrderID(), salesOrderdetails.getStatus());

            String debtorCode = salesOrder.getDebtorCode();
            
            System.out.println("Debtor code retrieved is "+debtorCode);

            //for each item in the sales order
            for (Integer itemNumber : itemDetailsMap.keySet()) {

                ItemDetails itemDetail = itemDetailsMap.get(itemNumber);

                double qtyDouble = Double.parseDouble(itemDetail.getQty());
                double unitPriceDouble = Double.parseDouble(itemDetail.getUnitPrice());

                salesOrdertotalForCustomer += qtyDouble *  unitPriceDouble;

            }

            double salesOrdertotalForCustomerRounded =  (int)Math.rint(salesOrdertotalForCustomer);

            if(allCustomerSalesByYearMonth.get(debtorCode) == null){
                allCustomerSalesByYearMonth.put(debtorCode, salesOrdertotalForCustomerRounded);
            }else{
                double newTotal = salesOrdertotalForCustomerRounded + allCustomerSalesByYearMonth.get(debtorCode);
                allCustomerSalesByYearMonth.put(debtorCode, newTotal);
            }    

        }
        
        return allCustomerSalesByYearMonth;
        
    }
    
    
 //Key Index, Value Customers Who Do not meet the requirement for a particular month and year
    public static Map<Integer, String> getCustomersWhoDoNotMeetRequirementByYearMonth(int year,int month){
        
        //Key Rank, Value Sales for a particular month and year
        Map<Integer, String> customersWhoDoNotMeetRequirementByYearMonth = new HashMap<>();
        
        //Key Customer Code, Value Sales for a particular month and year
        Map<String, Double> allCustomerSalesByYearMonth = new HashMap<>();
        
        //Get all the sales orders for a particular month and year
        Map<Integer, SalesOrder> allSalesOrderRevenueMap = getAllRevenueSalesOrderMapByMonth(month,year);

        //loop through each sales order
        for (Integer number : allSalesOrderRevenueMap.keySet()) {

            double salesOrdertotalForCustomer = 0;

            SalesOrder salesOrder = allSalesOrderRevenueMap.get(number);

            SalesOrderDetails salesOrderdetails = salesOrderUtility.getAllSalesOrderDetails(salesOrder.getOrderID());

            Map<Integer, ItemDetails> itemDetailsMap = salesOrderUtility.getItemDetailsMap(salesOrder.getOrderID(), salesOrderdetails.getStatus());

            String debtorCode = salesOrder.getDebtorCode();
            
            //for each item in the sales order
            for (Integer itemNumber : itemDetailsMap.keySet()) {

                ItemDetails itemDetail = itemDetailsMap.get(itemNumber);

                double qtyDouble = Double.parseDouble(itemDetail.getQty());
                double unitPriceDouble = Double.parseDouble(itemDetail.getUnitPrice());

                salesOrdertotalForCustomer += qtyDouble *  unitPriceDouble;

            }

            if(allCustomerSalesByYearMonth.get(debtorCode) == null){
                allCustomerSalesByYearMonth.put(debtorCode, salesOrdertotalForCustomer);
            }else{
                double newTotal = salesOrdertotalForCustomer + allCustomerSalesByYearMonth.get(debtorCode);
                allCustomerSalesByYearMonth.put(debtorCode, newTotal);
            }    

        }
        
        List<Entry<String, Double>> list = new LinkedList<Entry<String, Double>>(allCustomerSalesByYearMonth.entrySet());
        
        Collections.sort(list,new Comparator<Entry<String, Double>>(){
            public int compare(Entry<String,Double> o1, Entry<String, Double> o2){
                return o1.getValue().compareTo(o2.getValue());
            }
        });
        
        int rank = 1;

        for (int k = list.size(); k >= 1; k--){    
            
            Entry<String, Double> entryRetrieved = list.get(k-1);
            
            String key = entryRetrieved.getKey();
            double value = entryRetrieved.getValue();
            
            System.out.println(entryRetrieved);
            System.out.println("Key is "+key);
            
            double minimumRequirement = 300;
            
            if(value<=minimumRequirement){
                
                customersWhoDoNotMeetRequirementByYearMonth.put(rank,key);
                rank++;
                
            }
            
        }
        
        //To populate the map with blank values
        while(customersWhoDoNotMeetRequirementByYearMonth.size() < 10){
            
            customersWhoDoNotMeetRequirementByYearMonth.put(rank," ");
            rank++;
            
            System.out.println("Rank is "+rank);
        }
        
        return customersWhoDoNotMeetRequirementByYearMonth;
    }
    

    //Key Month, Value Return products qty for a particular month
    public static Map<Integer, Double> getReturnProductsByCustomerYearBreakdown(int year, String customerCodeInput){
        
        //return map 
        Map<Integer, Double> returnProductsByCustomerYearBreakdown = new HashMap<>();
        
        for(int month = 1; month<=12 ; month++){
        
            //all sales orders for a particular month
            Map<Integer, SalesOrder> allSalesOrderMap = getAllRevenueSalesOrderMapByMonth(month,year);
            
            //all returned qty for a particular month and particular customer
            double totalReturnedQty = 0;

            //loop through the all the sales order for a particular month
            for (Integer number : allSalesOrderMap.keySet()) {

                SalesOrder salesOrder = allSalesOrderMap.get(number);

                String customerCodeRetrieved = salesOrder.getDebtorCode();
                
                if(customerCodeRetrieved.equals(customerCodeInput)){
                    
                    SalesOrderDetails salesOrderdetails = salesOrderUtility.getAllSalesOrderDetails(salesOrder.getOrderID());

                    Map<Integer, ItemDetails> itemDetailsMap = salesOrderUtility.getItemDetailsMap(salesOrder.getOrderID(), salesOrderdetails.getStatus());

                    for (Integer itemNumber : itemDetailsMap.keySet()) {

                        ItemDetails itemDetail = itemDetailsMap.get(itemNumber);
                        OrderItem item = salesOrderUtility.getOrderItem(itemDetail.getItemCode());

                        int returnedQtyInt = Integer.parseInt(itemDetail.getReturnedQty());

                        totalReturnedQty += returnedQtyInt;

                    }
                    
                }


            }
            
            returnProductsByCustomerYearBreakdown.put(month,totalReturnedQty);
        
        }
        
        return returnProductsByCustomerYearBreakdown;
    }
    
    //Key Index, Value CustomerCode
    public static Map<Integer, String> getAllAvailableCustomers(){    

        Map<Integer,String> allAvailableCustomers = new HashMap<>();
        
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        int count = 1;
        
        try {
            conn = ConnectionManager.getConnection();
            
            String populateMap = "select DISTINCT d.DebtorCode from sales_order so \n" +
                "inner join debtor d on so.DebtorCode = d.DebtorCode\n" +
                "inner join sales_order_detail sod on so.OrderID = sod.OrderID \n" +
                "where so.Status = 'Pending Delivery' OR so.Status = 'Delivered'";

            pstmt = conn.prepareStatement(populateMap);
            rs = pstmt.executeQuery();
            
            System.out.println("Passed connection");

            while (rs.next()) {
                
                String customerCode = checkForNull(rs.getString("DebtorCode"));
                
                allAvailableCustomers.put(count, customerCode);
                count++;
            }
            
        }catch(SQLException e){
            
            System.out.println("SQLException thrown by allAvailableCustomers method");
            System.out.println(e.getMessage());
            
        }finally{
            ConnectionManager.close(conn, pstmt, rs);
        }

        return allAvailableCustomers;
    }
    
    
    //Key Rank, Value, Top Return product name
    public static Map<Integer, BreakdownItem> getBreakdownProductsMap(int month,int year, String customerCodeInput){
        
        //return map 
        Map<Integer, BreakdownItem> breakdownProductsMap = new HashMap<>();
        
        //all sales orders for a particular month
        Map<Integer, SalesOrder> allSalesOrderMap = getAllRevenueSalesOrderMapByMonth(month,year);
        
        //List of all available order item (description)
        List<String> orderItemDiscriptionList = getOrderItemList();
        
        //key orderitem description, value quantity of product ordered
        Map<String, Integer> getProductQtyForMonth = new HashMap<>();
        
        //key orderitem description, value returned quantity of product ordered
        Map<String, Integer> getReturnedProductQtyForMonth = new HashMap<>();
        
        //key orderitem description, value % returned quantity of product ordered
        Map<String, Double> getPercentageReturnedProductMap = new HashMap<>();
        
        //Populate the getProductQtyForMonth Map for all the order items with 0 Quantity
        for (int i = 0; i< orderItemDiscriptionList.size(); i++) {
            getProductQtyForMonth.put(orderItemDiscriptionList.get(i), 0);
        }
        
        for (int i = 0; i< orderItemDiscriptionList.size(); i++) {
            getReturnedProductQtyForMonth.put(orderItemDiscriptionList.get(i), 0);
        }
        
        //loop through the all the sales order for a particular month
        for (Integer number : allSalesOrderMap.keySet()) {

            SalesOrder salesOrder = allSalesOrderMap.get(number);
            
            String customerCodeRetrieved = salesOrder.getDebtorCode();
                
            if(customerCodeRetrieved.equals(customerCodeInput)){

                SalesOrderDetails salesOrderdetails = salesOrderUtility.getAllSalesOrderDetails(salesOrder.getOrderID());

                Map<Integer, ItemDetails> itemDetailsMap = salesOrderUtility.getItemDetailsMap(salesOrder.getOrderID(), salesOrderdetails.getStatus());

                    for (Integer itemNumber : itemDetailsMap.keySet()) {

                        ItemDetails itemDetail = itemDetailsMap.get(itemNumber);
                        OrderItem item = salesOrderUtility.getOrderItem(itemDetail.getItemCode());

                        String description = item.getDescription();
                        int qtyInt = Integer.parseInt(itemDetail.getQty());
                        int returnedQtyInt = Integer.parseInt(itemDetail.getReturnedQty());

                        int newQuantity = getProductQtyForMonth.get(description)+qtyInt;
                        int newReturnedQuantity = getReturnedProductQtyForMonth.get(description)+returnedQtyInt;

                        getReturnedProductQtyForMonth.put(description, newReturnedQuantity);
                        getProductQtyForMonth.put(description, newQuantity);

                    }
            
            }
        }
        
        //Loop to calculate percentage of returned items
        int count = 1;
        
        for (String itemDescription : getProductQtyForMonth.keySet() ){
            //double percentageReturned = 0;
            
            double qty = getProductQtyForMonth.get(itemDescription);
                    
            double returnedQty = getReturnedProductQtyForMonth.get(itemDescription);
            
            double percentageReturned = (returnedQty/(returnedQty+qty))*100;
            
            if(returnedQty ==0){
                //getPercentageReturnedProductMap.put(itemDescription, 0.0);
            }else{
                BreakdownItem breakdownItem = new BreakdownItem(itemDescription,qty,returnedQty,percentageReturned);
                //percentageReturned = (returnedQty/(qty+returnedQty))*100;

                //getPercentageReturnedProductMap.put(itemDescription, percentageReturned);
                breakdownProductsMap.put(count,breakdownItem);
                count++;

            }
        }

        return breakdownProductsMap;
    }
    
    public static Map<String, BreakdownItem> getBreakdownItemForItemDescriptionMonthOriginal(int month, int year){
        
        //key orderitem description, value Breakdown Item for corresponding item description and date
        Map<String, BreakdownItem> breakdownItemForItemDescriptionMonth = new HashMap<>();
        
        //all sales orders for a particular month
        Map<Integer, SalesOrder> allSalesOrderMap = getAllRevenueSalesOrderMapByMonth(month,year);
        
        //List of all available order item (description)
        List<String> orderItemDiscriptionList = getOrderItemList();
        
        //key orderitem description, value quantity of product ordered
        Map<String, Integer> getProductQtyForMonth = new HashMap<>();
        
        //key orderitem description, value returned quantity of product ordered
        Map<String, Integer> getReturnedProductQtyForMonth = new HashMap<>();
        

        //Populate the getProductQtyForMonth Map for all the order items with 0 Quantity
        for (int i = 0; i< orderItemDiscriptionList.size(); i++) {
            getProductQtyForMonth.put(orderItemDiscriptionList.get(i), 0);
        }
        
        for (int i = 0; i< orderItemDiscriptionList.size(); i++) {
            getReturnedProductQtyForMonth.put(orderItemDiscriptionList.get(i), 0);
        }
        
        //loop through the all the sales order for a particular month
        for (Integer number : allSalesOrderMap.keySet()) {

            SalesOrder salesOrder = allSalesOrderMap.get(number);

            SalesOrderDetails salesOrderdetails = salesOrderUtility.getAllSalesOrderDetails(salesOrder.getOrderID());

            Map<Integer, ItemDetails> itemDetailsMap = salesOrderUtility.getItemDetailsMap(salesOrder.getOrderID(), salesOrderdetails.getStatus());
            
                for (Integer itemNumber : itemDetailsMap.keySet()) {

                    ItemDetails itemDetail = itemDetailsMap.get(itemNumber);
                    OrderItem item = salesOrderUtility.getOrderItem(itemDetail.getItemCode());
                    
                    String description = item.getDescription();
                    int qtyInt = Integer.parseInt(itemDetail.getQty());
                    int returnedQtyInt = Integer.parseInt(itemDetail.getReturnedQty());
                    
                    int newQuantity = getProductQtyForMonth.get(description)+qtyInt;
                    int newReturnedQuantity = getReturnedProductQtyForMonth.get(description)+returnedQtyInt;
                    
                    getReturnedProductQtyForMonth.put(description, newReturnedQuantity);
                    getProductQtyForMonth.put(description, newQuantity);

                }
            
            
        }
        
        //Loop to calculate percentage of returned items
        for (String itemDescription : getProductQtyForMonth.keySet() ){

            double qty = getProductQtyForMonth.get(itemDescription);
                    
            double returnedQty = getReturnedProductQtyForMonth.get(itemDescription);
            
            double percentageReturned = (returnedQty/(returnedQty+qty))*100;
            
            if(returnedQty!=0){
            
                BreakdownItem breakdownItem = new BreakdownItem(itemDescription,qty,returnedQty,percentageReturned);

                breakdownItemForItemDescriptionMonth.put(itemDescription, breakdownItem);
            
            }

        }
  
        
        return breakdownItemForItemDescriptionMonth;
    }
    
    //key orderitem description, value Breakdown Item for corresponding item description and date
    public static Map<String, BreakdownItem> getBreakdownItemForItemDescriptionMonth(int month, int year){
        
        //key orderitem description, value Breakdown Item for corresponding item description and date
        Map<String, BreakdownItem> breakdownItemForItemDescriptionMonth = new HashMap<>();

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = ConnectionManager.getConnection();
            
            String populateMap = "select temp1.* from (select itemCode,sum(qty),sum(returnedQty),sum(returnedQty)/sum(Qty)*100 as ReturnedRate from sales_order_quantity\n" +
            "inner join sales_order \n" +
            "inner join sales_order_detail\n" +
            "on sales_order_quantity.OrderID = sales_order.OrderID\n" +
            "and sales_order.OrderID = sales_order_detail.OrderID\n" +
            "where month(sales_order_detail.DeliveryDate) = "+month+" \n" +
            "and year(sales_order_detail.DeliveryDate) = "+year+" \n" +
            "group by itemCode order by ReturnedRate desc limit 5)temp1\n" +
            "inner JOIN\n" +
            "(select itemCode,sum(qty),sum(returnedQty),sum(returnedQty)/sum(Qty)*100 as ReturnedRate from sales_order_quantity\n" +
            "inner join sales_order \n" +
            "inner join sales_order_detail\n" +
            "on sales_order_quantity.OrderID = sales_order.OrderID\n" +
            "and sales_order.OrderID = sales_order_detail.OrderID\n" +
            "where month(sales_order_detail.DeliveryDate) = "+month+" \n" +
            "and year(sales_order_detail.DeliveryDate) = "+year+" \n" +
            "group by itemCode order by ReturnedRate desc)temp2\n" +
            "on temp1.itemCode = temp2.itemCode";

            pstmt = conn.prepareStatement(populateMap);
            rs = pstmt.executeQuery();
            
            System.out.println("Passed connection");

            while (rs.next()) {

                String itemCode = checkForNull(rs.getString("itemcode"));
                String qty = checkForNull(rs.getString("sum(qty)"));
                String returnedQty = checkForNull(rs.getString("sum(returnedQty)"));
                String returnedRate = checkForNull(rs.getString("ReturnedRate"));

                if(itemCode != null && qty !=null && returnedQty != null && returnedRate != null){
                    
                    OrderItem orderItem = salesOrderUtility.getOrderItem(itemCode);
                    String itemDescription = orderItem.getDescription();
                    
                    Double qtyDouble = Double.parseDouble(qty);
                    Double returnedQtyDouble = Double.parseDouble(returnedQty);
                    Double returnedRateDouble = Double.parseDouble(returnedRate);
                    
                    BreakdownItem breakdownItem = new BreakdownItem(itemDescription,qtyDouble,returnedQtyDouble,returnedRateDouble);
                    
                    if(returnedRateDouble!=0){
                        breakdownItemForItemDescriptionMonth.put(itemDescription,breakdownItem);
                    }

                }

            }

            
        }catch(SQLException e){
            
            System.out.println("SQLException thrown by breakdownItemForItemDescriptionMonth method");
            System.out.println(e.getMessage());
            
        }finally{
            ConnectionManager.close(conn, pstmt, rs);
        }
        
        return breakdownItemForItemDescriptionMonth;
    }
    
    
    
}
