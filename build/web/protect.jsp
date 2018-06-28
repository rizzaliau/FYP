<%-- 
    Document   : protect
    Created on : 23 May, 2018, 2:18:29 AM
    Author     : Rizza
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<% 
    String user = (String)session.getAttribute("username");
    
    //out.println("protect.jsp user retrieved is: " +user);
    
    if(user == null){
        response.sendRedirect("login.jsp");
    }
    
    //else if (!user.equals("admin")) {
        //response.sendRedirect("login.jsp");
    //}
    
%>
