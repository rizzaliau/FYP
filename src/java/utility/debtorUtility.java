/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package utility;

import dao.ConnectionManager;
import entity.Debtor;
import java.io.IOException;
import static java.lang.System.out;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Rizza
 */
public class debtorUtility {
    
    public static void getAllDebtors(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
        
        Map<Integer, Debtor> debtorList = debtorUtility.getDebtorMap(); 
        
        request.setAttribute("debtorListPopulated",debtorList);
        RequestDispatcher view = request.getRequestDispatcher("userMGMT.jsp");
        
        view.forward(request,response);

    }
    
    public static Map<Integer, Debtor> getDebtorMap(){
        Map<Integer, Debtor> debtorMap = new HashMap<>();
        
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        int count = 1;
        
        try {
            conn = ConnectionManager.getConnection();
            String populateMap = "SELECT * FROM `debtor` WHERE status = 'ACTIVE'";
            pstmt = conn.prepareStatement(populateMap);
            rs = pstmt.executeQuery();
            
            System.out.println("Passed connection");

            while (rs.next()) {
                
                String debtorCode = rs.getString("DebtorCode");
                String companyCode = rs.getString("companyCode");
                String hashPassword = rs.getString("HashPassword");
                String companyName = rs.getString("CompanyName");
                String debtorName = rs.getString("DebtorName");
                String deliverContact = rs.getString("DeliverContact");
                String deliverContact2 = rs.getString("DeliverContact2");
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
                
                if(invAddr1==null){
                    invAddr1 = "";
                }
                if(invAddr2==null){
                    invAddr2 = "";
                }
                if(invAddr3==null){
                    invAddr3 = "";
                }
                if(invAddr4==null){
                    invAddr4 = "";
                }
                
                if(deliverAddr1==null){
                    deliverAddr1 = "";
                }
                if(deliverAddr2==null){
                    deliverAddr2 = "";
                }
                if(deliverAddr3==null){
                    deliverAddr3 = "";
                }
                if(deliverAddr4==null){
                    deliverAddr4 = "";
                }
                if(deliverContact2==null){
                    deliverContact2 = "";
                }
                
                Debtor debtor = new Debtor (debtorCode,companyCode,hashPassword,companyName,debtorName,deliverContact,deliverContact2,
                    invAddr1,invAddr2,invAddr3,invAddr4,deliverAddr1,deliverAddr2,
                    deliverAddr3,deliverAddr4,displayTerm,status,routeNumber);
                
                debtorMap.put(count, debtor);
                count++;
            }
            
        }catch(SQLException e){
            
            System.out.println("SQLException thrown by getDebtorMap method");
            System.out.println(e.getMessage());
            
        }finally{
            ConnectionManager.close(conn, pstmt, rs);
        }
        
        return debtorMap;
    }
    
    public static Map<Integer, Debtor> getInactiveDebtorMap(){
        Map<Integer, Debtor> debtorMap = new HashMap<>();
        
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        int count = 1;
        
        try {
            conn = ConnectionManager.getConnection();
            String populateMap = "SELECT * FROM `debtor` WHERE status = 'INACTIVE' OR status = 'BLACKLISTED'";
            //String populateMap = "SELECT IFNULL(\"\",DebtorCode),IFNULL(\"\",DebtorCode),IFNULL(\"\",companyCode),IFNULL(\"\",HashPassword),IFNULL(\"\",CompanyName),IFNULL(\"\",DebtorName),IFNULL(\"\",DeliverContact),IFNULL(\"\",DeliverFax1),IFNULL(\"\",InvAddr1),IFNULL(\"\",InvAddr2),IFNULL(\"\",InvAddr3),IFNULL(\"\",InvAddr4),IFNULL(\"\",DeliverAddr1),IFNULL(\"\",DeliverAddr2),IFNULL(\"\",DeliverAddr3),IFNULL(\"\",DeliverAddr4), IFNULL(\"\",DisplayTerm),IFNULL(\"\",Status),IFNULL(\"\",RouteNumber)from debtor WHERE status = 'INACTIVE' OR status = 'BLACKLISTED';";
            pstmt = conn.prepareStatement(populateMap);
            rs = pstmt.executeQuery();
            
            System.out.println("Passed connection");

            while (rs.next()) {
                
                String debtorCode = checkForNull(rs.getString("DebtorCode"));
                String companyCode = checkForNull(rs.getString("companyCode"));
                String hashPassword = checkForNull(rs.getString("HashPassword"));
                String companyName = checkForNull(rs.getString("CompanyName"));
                String debtorName = checkForNull(rs.getString("DebtorName"));
                String deliverContact = checkForNull(rs.getString("DeliverContact"));
                String deliverFax1 = checkForNull(rs.getString("DeliverFax1"));
                String invAddr1 = checkForNull(rs.getString("InvAddr1"));
                String invAddr2 = checkForNull(rs.getString("InvAddr2"));        
                String invAddr3 = checkForNull(rs.getString("InvAddr3"));
                String invAddr4 = checkForNull(rs.getString("InvAddr4"));
                String deliverAddr1 = checkForNull(rs.getString("DeliverAddr1"));
                String deliverAddr2 = checkForNull(rs.getString("DeliverAddr2"));
                String deliverAddr3 = checkForNull(rs.getString("DeliverAddr3"));
                String deliverAddr4 = checkForNull(rs.getString("DeliverAddr4"));
                String displayTerm = checkForNull(rs.getString("DisplayTerm"));
                String status = checkForNull(rs.getString("Status"));
                String routeNumber = checkForNull(rs.getString("RouteNumber"));
                /*
                if(invAddr1==null){
                    invAddr1 = "";
                }
                if(invAddr2==null){
                    invAddr2 = "";
                }
                if(invAddr3==null){
                    invAddr3 = "";
                }
                if(invAddr4==null){
                    invAddr4 = "";
                }
                
                if(deliverAddr1==null){
                    deliverAddr1 = "";
                }
                if(deliverAddr2==null){
                    deliverAddr2 = "";
                }
                if(deliverAddr3==null){
                    deliverAddr3 = "";
                }
                if(deliverAddr4==null){
                    deliverAddr4 = "";
                }
                
                if(deliverFax1==null){
                    deliverFax1 = "";
                }*/
                
                Debtor debtor = new Debtor (debtorCode,companyCode,hashPassword,companyName,debtorName,deliverContact,deliverFax1,
                    invAddr1,invAddr2,invAddr3,invAddr4,deliverAddr1,deliverAddr2,
                    deliverAddr3,deliverAddr4,displayTerm,status,routeNumber);
                
                debtorMap.put(count, debtor);
                count++;
            }
            
        }catch(SQLException e){
            
            System.out.println("SQLException thrown by getDebtorMap method");
            System.out.println(e.getMessage());
            
        }finally{
            ConnectionManager.close(conn, pstmt, rs);
        }
        
        return debtorMap;
    }
    
    private static String checkForNull(String string){
       if(string == null || string.equals("null")){
           return "";
       }
       return string;
   }
}

