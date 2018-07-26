<%-- 
    Document   : readAllNotifications
    Created on : 26 Jul, 2018, 11:36:46 PM
    Author     : Rizza
--%>


    <%@page import="utility.notificationUtility"%>

    <% 
        notificationUtility.updateAllNotifications();

        String referer = request.getHeader("Referer");
        response.sendRedirect(referer);

    %>
