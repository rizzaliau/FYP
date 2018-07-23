<%-- 
    Document   : updateNotification.jsp
    Created on : 23 Jul, 2018, 11:39:30 PM
    Author     : Rizza
--%>

        <%@page import="utility.notificationUtility"%>
        
        <% 
            String orderIDRetrieved = request.getParameter("orderID");
            notificationUtility.updateNotificationsMap(orderIDRetrieved);
            
            String referer = request.getHeader("Referer");
            response.sendRedirect(referer);
        
        %>
