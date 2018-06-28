<%-- 
    Document   : logout
    Created on : 27 May, 2018, 2:54:05 PM
    Author     : Rizza
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>
    
    <body>
        <%
            session.invalidate();
            response.sendRedirect("login.jsp");
        %>
    </body>
</html>
