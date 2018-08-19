<%-- 
    Document   : protectAdmin
    Created on : 19 Aug, 2018, 1:31:16 AM
    Author     : Rizza
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<% 
    String user = (String)session.getAttribute("username");

    String isMaster = (String) session.getAttribute("isMaster");

    if (isMaster.equals("0") || user == null){
        response.sendRedirect("login.jsp");
    }

%>
