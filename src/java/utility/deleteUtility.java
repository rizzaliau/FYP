/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package utility;

import dao.ConnectionManager;
import dao.UserDAO;
import java.io.IOException;
import static java.lang.System.out;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Rizza
 */
public class deleteUtility {
    
    public static void delete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String debtorCodeRetrived = request.getParameter("recordToBeDeleted");
        
        System.out.println("debtorCodeRetrived is : "+debtorCodeRetrived);

        try {

            Connection conn = ConnectionManager.getConnection();
            out.println("passes conn");

            String sql = "DELETE FROM `debtor` WHERE DebtorCode = '" + debtorCodeRetrived + "'";

            PreparedStatement stmt = conn.prepareStatement(sql);
            out.println("passes stmt");

            stmt.executeUpdate();
            out.println("passes rs");

        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
            request.setAttribute("status", "Error updating!");
        }
        
        request.setAttribute("status", "Record deleted successfully!");

        request.getRequestDispatcher("userMGMT.jsp").forward(request, response);
        
    }
    
    public static void deleteMultiple(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        //String debtorCodeRetrived = request.getParameter("recordToBeDeleted");
        String[] debtorCodesRetrived = request.getParameterValues("recordsToBeDeleted"); 
        //System.out.println("length of string array is : "+debtorCodesRetrived.length);
        
        if(debtorCodesRetrived==null){
            request.getRequestDispatcher("userMGMT.jsp").forward(request, response);
        }else{ 
            
            int stringArrayCount = getActualSize(debtorCodesRetrived);
            int count = 0;

            //System.out.println("debtorCodeRetrived is : "+debtorCodesRetrived);
            for(int i=0; i<stringArrayCount; i++){

                try {
                    String debtorCode = debtorCodesRetrived[count];

                    Connection conn = ConnectionManager.getConnection();
                    out.println("passes conn");

                    String sql = "DELETE FROM `debtor` WHERE DebtorCode = '" + debtorCode + "'";

                    PreparedStatement stmt = conn.prepareStatement(sql);
                    out.println("passes stmt");

                    stmt.executeUpdate();
                    out.println("passes rs");

                } catch (SQLException ex) {
                    Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
                    request.setAttribute("status", "Error updating!");
                }

                count++;
            }
            request.setAttribute("status", "Record deleted successfully!");

            request.getRequestDispatcher("userMGMT.jsp").forward(request, response);
        }
    }
    
    public static int getActualSize(String[] items){
        int size=0;
        
        for(int i=0;i<items.length;i++)
        {
            if(items[i]!=null)
            {
                size=size+1;
            }
        }
        return size;

    }

    
    public static void deleteSalesOrder(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String orderIDRetrieved = request.getParameter("orderIDRecordToBeDeleted");
        String statusRetrieved = request.getParameter("statusRecordToBeDeleted");
        String deliveryDateRetrieved = request.getParameter("deliveryDateRecordToBeDeleted");
        //String itemCodeRetrieved = "1";
        
        if(statusRetrieved.equals("pendingDelivery")){
            statusRetrieved = "Pending Delivery";
        }
        
        //System.out.println("inputs are  : "+orderIDRetrieved+statusRetrieved);
        
        try {
            
            Connection conn = ConnectionManager.getConnection();
            out.println("passes conn");
            
            String salesOrderDetailSql = "DELETE FROM `sales_order_detail` WHERE orderID = '" + orderIDRetrieved + "' "
                    + "AND DeliveryDate='"+deliveryDateRetrieved+"' ";
            
            String salesOrderQtySql = "DELETE FROM `sales_order_quantity` WHERE orderID = '" + orderIDRetrieved + "' ";

            String salesOrderSql = "DELETE FROM `sales_order` WHERE orderID = '" + orderIDRetrieved + "' "
                    + "AND status='"+statusRetrieved+"' ";

            PreparedStatement stmt1 = conn.prepareStatement(salesOrderDetailSql);
            PreparedStatement stmt2 = conn.prepareStatement(salesOrderQtySql);
            PreparedStatement stmt3 = conn.prepareStatement(salesOrderSql);
            out.println("passes stmt");

            stmt1.executeUpdate();
            stmt2.executeUpdate();
            stmt3.executeUpdate();
            out.println("passes rs");

        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
            request.setAttribute("status", "Error updating!");
        }
        
        request.setAttribute("status", "Record deleted successfully!");

        request.getRequestDispatcher("salesOrderMGMT.jsp").forward(request, response);
        
    }
    
    
    public static void deleteMultipleSalesOrder(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        //String[] orderIDsRetrived = (String[])request.getAttribute("orderIDArray");
        String[] orderIDsRetrived = (String[])session.getAttribute("orderIDArrayCancelled");
        
        String statusRetrieved = request.getParameter("status");
        String deliveryDateRetrieved = request.getParameter("deliveryDate");
        //System.out.println("testing"+orderIDsRetrived[0]);
        //String[] orderIDsRetrived = request.getParameterValues("recordsToBeDeleted"); 

        if(orderIDsRetrived == null){
            request.getRequestDispatcher("salesOrderMGMT.jsp").forward(request, response);
        }else{ 
            
            int stringArrayCount = getActualSize(orderIDsRetrived);
            //int count = 0;

            //System.out.println("debtorCodeRetrived is : "+debtorCodesRetrived);
            for(int i=0; i<stringArrayCount; i++){

                try {

                    Connection conn = ConnectionManager.getConnection();
                    out.println("passes conn");
                    out.println("Test "+orderIDsRetrived[i]);
                    
                    String salesOrderDetailSql = "";
                    if(deliveryDateRetrieved.equals("None")){
                        salesOrderDetailSql = "DELETE FROM `sales_order_detail` WHERE orderID = '" + orderIDsRetrived[i] + "' ";
                    }else{
                        salesOrderDetailSql = "DELETE FROM `sales_order_detail` WHERE orderID = '" + orderIDsRetrived[i] + "' "
                            + "AND DeliveryDate='"+deliveryDateRetrieved+"' ";
                    }
                    
                    String salesOrderQtySql = "DELETE FROM `sales_order_quantity` WHERE orderID = '" + orderIDsRetrived[i] + "' ";

                    String salesOrderSql = "DELETE FROM `sales_order` WHERE orderID = '" + orderIDsRetrived[i] + "' "
                            + "AND status='"+statusRetrieved+"' ";

                    PreparedStatement stmt1 = conn.prepareStatement(salesOrderDetailSql);
                    PreparedStatement stmt2 = conn.prepareStatement(salesOrderQtySql);
                    PreparedStatement stmt3 = conn.prepareStatement(salesOrderSql);
                    out.println("passes stmt");

                    stmt1.executeUpdate();
                    stmt2.executeUpdate();
                    stmt3.executeUpdate();
                    out.println("passes rs");

                } catch (SQLException ex) {
                    Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
                    request.setAttribute("status", "Error updating!");
                }

                //count++;
            }
            
            request.setAttribute("status", "Records deleted successfully!");

            request.getRequestDispatcher("salesOrderMGMT.jsp").forward(request, response);
        }
    }
    
    public static void deleteCatalogue(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String itemCodeRetrieved = request.getParameter("recordToBeDeleted");
        
        //System.out.println("debtorCodeRetrived is : "+debtorCodeRetrived);

        try {

            Connection conn = ConnectionManager.getConnection();
            out.println("passes conn");

            String sql = "DELETE FROM `order_item` WHERE itemCode = '" + itemCodeRetrieved + "'";

            PreparedStatement stmt = conn.prepareStatement(sql);
            out.println("passes stmt");

            stmt.executeUpdate();
            out.println("passes rs");

        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
            request.setAttribute("status", "Error updating!");
        }
        
        request.setAttribute("status", "Record deleted successfully!");

        request.getRequestDispatcher("catalogue.jsp").forward(request, response);
        
    }
    
    public static void deleteMultipleCatalogue(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        HttpSession session = request.getSession();
        String[] itemCodesRetrieved = (String[])session.getAttribute("itemCodesRetrieved");

        if(itemCodesRetrieved==null){
            
            request.getRequestDispatcher("catalogue.jsp").forward(request, response);
            
        }else{ 
            
            for(int i=0; i<itemCodesRetrieved.length; i++){

                try {
                    String itemCode = itemCodesRetrieved[i];

                    Connection conn = ConnectionManager.getConnection();
                    out.println("passes conn");

                    String sql = "DELETE FROM `order_item` WHERE ItemCode = '" + itemCode + "'";

                    PreparedStatement stmt = conn.prepareStatement(sql);
                    out.println("passes stmt");

                    stmt.executeUpdate();
                    out.println("passes rs");

                } catch (SQLException ex) {
                    Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
                    request.setAttribute("status", "Error updating!");
                }

            }
            request.setAttribute("status", "Records deleted successfully!");

            request.getRequestDispatcher("catalogue.jsp").forward(request, response);
        }
    }
    
    
    
}
