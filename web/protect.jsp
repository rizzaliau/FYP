<%-- 
    Document   : protect
    Created on : 23 May, 2018, 2:18:29 AM
    Author     : Rizza
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<% 
    String user = (String)session.getAttribute("username");

    if(user == null){
        response.sendRedirect("login.jsp");
    }

%>
