/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package utility;

import dao.ConnectionManager;
import dao.UserDAO;
import entity.Debtor;
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
    
}
