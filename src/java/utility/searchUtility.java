/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package utility;

import dao.ConnectionManager;
import dao.UserDAO;
import entity.Debtor;
import entity.OrderItem;
import entity.SalesOrder;
import java.io.IOException;
import static java.lang.System.out;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Rizza
 */
public class searchUtility {
    
    public static void search(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String searchType = (String)request.getParameter("searchField");
        String searchValue = request.getParameter("searchValue");
        
        if(searchValue.equals("")){
            request.setAttribute("searchStatus","Please enter a search value!");
            RequestDispatcher view = request.getRequestDispatcher("search.jsp");
            view.forward(request,response);
        }
        
        Map<Integer, Debtor> searchMap = new HashMap<>();

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        int count = 1;
        
        try {
            conn = ConnectionManager.getConnection();
            String query = "SELECT * FROM `debtor` WHERE "+searchType+" LIKE '%"+searchValue+"%'";
            pstmt = conn.prepareStatement(query);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                
                String debtorCode = rs.getString("DebtorCode");
                String companyCode = rs.getString("companyCode");
                String hashPassword = rs.getString("HashPassword");
                String companyName = rs.getString("CompanyName");
                String debtorName = rs.getString("DebtorName");
                String deliverContact = rs.getString("DeliverContact");
                String deliverFax1 = rs.getString("DeliverFax1");
                String invAddr1 = rs.getString("InvAddr1");
                String invAddr2 = rs.getString("InvAddr2");        
                String invAddr3 = rs.getString("InvAddr3");
                String invAddr4 = rs.getString("InvAddr4");
                String deliverAddr1 = rs.getString("DeliverAddr1");
                String deliverAddr2 = rs.getString("DeliverAddr2");
                String deliverAddr3 = rs.getString("DeliverAddr3");
                String deliverAddr4 = rs.getString("DeliverAddr4");
                String displayTerm = rs.getString("DisplayTerm");
                String status = rs.getString("Status");
                String routeNumber = rs.getString("RouteNumber");
                
                Debtor debtor = new Debtor (debtorCode,companyCode,hashPassword,companyName,debtorName,deliverContact,deliverFax1,
                    invAddr1,invAddr2,invAddr3,invAddr4,deliverAddr1,deliverAddr2,
                    deliverAddr3,deliverAddr4,displayTerm,status,routeNumber);
                
                searchMap.put(count, debtor);
                count++;
            }
            
        }catch(SQLException e){
            
            System.out.println("SQLException thrown by searchMap method");
            System.out.println(e.getMessage());
            
        }finally{
            ConnectionManager.close(conn, pstmt, rs);
        }
        
        request.setAttribute("searchMapResults",searchMap);
        
        HttpSession session = request.getSession();
        session.setAttribute("searchMapResults",searchMap);
        
        RequestDispatcher view = request.getRequestDispatcher("searchDisplay.jsp");
        view.forward(request,response);
        
    }
        
    public static void searchSalesOrder(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        //Get Parameters
        String searchType = (String)request.getParameter("searchField");
        String searchValue = request.getParameter("searchValue");
        String deliveryDateRetrieved = request.getParameter("deliveryDate");
        String statusRetrieved = request.getParameter("status");
        
        if(searchValue.equals("")){
            request.setAttribute("searchStatus","Please enter a search value!");
            RequestDispatcher view = request.getRequestDispatcher("searchSalesOrder.jsp");
            view.forward(request,response);
        }
        
        //To search orderID for Sales Order
        if(searchType.equals("orderID")){
            searchType = "so.orderID";
        }
        
        Map<Integer, SalesOrder> searchSalesOrderMap = new HashMap<>();

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        int count = 1;
        
        try {
            conn = ConnectionManager.getConnection();
            //String query = "SELECT * FROM `debtor` WHERE "+searchType+" LIKE '%"+searchValue+"%'";
            String query = "";
            
            if(deliveryDateRetrieved.equals("none") && statusRetrieved.equals("Pending Delivery")){
                
                query = "select so.OrderID, d.DebtorCode, d.DebtorName, d.RouteNumber from sales_order so \n" +
                    "inner join debtor d on so.DebtorCode = d.DebtorCode  \n" +
                    "inner join sales_order_detail sod on so.OrderID = sod.OrderID \n" +
                    "where so.Status = \""+statusRetrieved+"\" and "+searchType+" LIKE '%"+searchValue+"%' \n" +
                    "order by d.RouteNumber ASC";
                
            }else if(deliveryDateRetrieved.equals("none") && statusRetrieved.equals("Cancelled")){
                
                query = "select so.OrderID, d.DebtorCode, d.DebtorName, d.RouteNumber from sales_order so \n" +
                    "inner join debtor d on so.DebtorCode = d.DebtorCode  \n" +
                    "inner join sales_order_detail sod on so.OrderID = sod.OrderID \n" +
                    "where so.Status = \""+statusRetrieved+"\" and "+searchType+" LIKE '%"+searchValue+"%' \n" +
                    "order by sod.DeliveryDate DESC";
            
            }else if(deliveryDateRetrieved.equals("none") && statusRetrieved.equals("Delivered")){
                
                query = "select so.OrderID, d.DebtorCode, d.DebtorName, d.RouteNumber from sales_order so \n" +
                    "inner join debtor d on so.DebtorCode = d.DebtorCode  \n" +
                    "inner join sales_order_detail sod on so.OrderID = sod.OrderID \n" +
                    "where so.Status = \""+statusRetrieved+"\" and "+searchType+" LIKE '%"+searchValue+"%' \n" +
                    "order by sod.DeliveryDate DESC";    
                
            }else{

                query = "select so.OrderID, d.DebtorCode, d.DebtorName, d.RouteNumber from sales_order so \n" +
                    "inner join debtor d on so.DebtorCode = d.DebtorCode  \n" +
                    "inner join sales_order_detail sod on so.OrderID = sod.OrderID \n" +
                    "where so.Status = \""+statusRetrieved+"\" and sod.DeliveryDate = \""+deliveryDateRetrieved+"\" and "+searchType+" LIKE '%"+searchValue+"%' \n" +
                    "order by d.RouteNumber ASC";
            }
            
            pstmt = conn.prepareStatement(query);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                
                String orderID = rs.getString("OrderID");
                String debtorCode = rs.getString("DebtorCode");
                String debtorName = rs.getString("DebtorName");
                String routeNumber = rs.getString("RouteNumber");

                SalesOrder salesOrder = new SalesOrder (orderID,debtorCode,debtorName,routeNumber);
                
                searchSalesOrderMap.put(count, salesOrder);
                count++;
            }
            
        }catch(SQLException e){
            
            System.out.println("SQLException thrown by searchMap method");
            System.out.println(e.getMessage());
            
        }finally{
            ConnectionManager.close(conn, pstmt, rs);
        }
        
        request.setAttribute("searchMapResults",searchSalesOrderMap);
        request.setAttribute("status",statusRetrieved);
        request.setAttribute("deliveryDate",deliveryDateRetrieved);
        
        request.setAttribute("searchStatus","Search conducted successfully!");
        
        //HttpSession session = request.getSession();
        //session.setAttribute("searchMapResults",searchSalesOrderMap);
        
        RequestDispatcher view = request.getRequestDispatcher("searchSalesOrderDisplay.jsp");
        view.forward(request,response);
        
    }
        
    
    public static void searchCatalogue(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String searchType = (String)request.getParameter("searchField");
        String searchValue = request.getParameter("searchValue");
        
        if (searchValue.equals("")) {
            request.setAttribute("searchStatus", "Please enter a search value!");
            RequestDispatcher view = request.getRequestDispatcher("searchCatalogueItem.jsp");
            view.forward(request, response);
        }
        
        
        Map<Integer, OrderItem> searchMap = new HashMap<>();

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        int count = 1;
        
        try {
            conn = ConnectionManager.getConnection();
            String query = "SELECT * FROM `order_item` WHERE "+searchType+" LIKE '%"+searchValue+"%'";
            pstmt = conn.prepareStatement(query);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                
                String itemCodeRetrieved = rs.getString("itemCode");
                String descriptionRetrieved = rs.getString("description");
                String descriptionChineseRetrieved = rs.getString("description2");
                String unitPriceRetrieved = rs.getString("unitPrice");
                String imageURLRetrieved = rs.getString("imageURL");
                String defaultQuantityRetrieved = rs.getString("defaultQty");
                String quantityMultiplesRetrieved = rs.getString("qtyMultiples");

                OrderItem orderItem = new OrderItem (itemCodeRetrieved,descriptionRetrieved,descriptionChineseRetrieved,
                    unitPriceRetrieved,imageURLRetrieved,defaultQuantityRetrieved,quantityMultiplesRetrieved);
                
                searchMap.put(count, orderItem);
                count++;
            }
            
        }catch(SQLException e){
            
            System.out.println("SQLException thrown by searchMap method");
            System.out.println(e.getMessage());
            
        }finally{
            ConnectionManager.close(conn, pstmt, rs);
        }
        
        request.setAttribute("searchMapResultsCatalogue",searchMap);
        
        HttpSession session = request.getSession();
        session.setAttribute("searchMapResultsCatalogue",searchMap);
        
        RequestDispatcher view = request.getRequestDispatcher("searchCatalogueDisplay.jsp");
        view.forward(request,response);
        
    }
    
    
}
