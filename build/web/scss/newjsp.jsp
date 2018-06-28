<%-- 
    Document   : newjsp
    Created on : 3 Jun, 2018, 5:31:59 PM
    Author     : Rizza
--%>

<%@page import="java.util.Map"%>
<%@page import="utility.debtorUtility"%>
<%@page import="entity.Debtor"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        
        
            <%
                Map<Integer, Debtor> debtorMap = debtorUtility.getDebtorMap();
            %>
                                
            <table border="1">
                <tr>
                    <th> Debtor Code </th>
                    <th> Company Code </th>
                </tr>

                <tr>
                <%  
                    for (Integer number : debtorMap.keySet()) {

                        Debtor debtor = debtorMap.get(number);

                        out.print("<td>" + debtor.getDebtorCode() + "</td>");
                        out.print("<td>" + debtor.getCompanyCode() + "</td>");

                    }

                %>
        
        
        
        
        
        
        
    </body>
</html>
