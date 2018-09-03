<%-- 
    Document   : test.jsp
    Created on : 2 Sep, 2018, 12:15:02 AM
    Author     : Zx Low
--%>
<%@page import="java.util.Arrays"%>
<%@page import="dao.UserDAO"%>
<%@page import="entity.OrderItem"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="entity.ItemDetails"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.time.LocalDateTime"%>
<%@page import="entity.SalesOrderDetails"%>
<%@page import="utility.salesOrderUtility"%>
<%@page import="entity.SalesOrder"%>
<%@page import="entity.Debtor"%>
<%@page import="java.util.Map"%>
<%@page import="utility.debtorUtility"%>
<%@page import="java.util.Arrays"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <title>Lim Kee Food Manufacturing Pte Ltd</title>
        <link href="assets/css/bootstrap.min.css" rel="stylesheet" />
        <link href="assets/css/light-bootstrap-dashboard.css?v=2.0.1" rel="stylesheet" />
        <link rel="stylesheet" type="text/css" href="css/sheets-of-paper-a4.css">
        <style>
            html,body{
                height:297mm;
                width:210mm;
            } 
            #left-col { 
                position: absolute;
                top: 220px;
                left: 25px;
                width: 500px;
                height: 200px;

            } 
            #right-col { 
                position: absolute;
                top: 300px;
                left: 890px;
                width: 100px;
                height: 100px;

            } 

            #table{
                position: absolute;
                top: 500px;
                left: 40px;
                width: 1040px;
                height: 400px;

            }

            #table2{
                position: absolute;
                top: 1250px;
                left: 35px;
                width: 1040px;
                height: 60px;

            }
            @media print {
                p { page-break-after: always; }
            }
        </style>
    </head>
    <body>

        <%
            String[] orderInfos = request.getParameterValues("orderInfo");

            if (orderInfos != null && orderInfos.length > 0) {
                for (int i = 0; i < orderInfos.length; i++) {
                    String order = orderInfos[i];
                    int marker = order.indexOf(',');
                    String orderID = order.substring(0, marker);
                    String status = order.substring(marker + 1);
                    //out.println(Arrays.toString(orderIDs));
                    //out.print("Order Id:" + orderID);
                    //out.print("Status:" + status);
                    //out.print("</br>");
                    if (status.equals("pendingDelivery")) {
                        status = "Pending Delivery";
                    }

                    SalesOrderDetails salesOrderdetails = salesOrderUtility.getSalesOrderDetails(orderID, status);

                    Map<Integer, ItemDetails> itemDetailsMap = salesOrderUtility.getItemDetailsMap(orderID, status);

                    Map<Integer, ItemDetails> refundedItemDetailsMap = salesOrderUtility.getRefundedItemDetailsMap(orderID);

                    SimpleDateFormat sdf2 = new SimpleDateFormat("yyyy-MM-dd");
                    Date d2 = sdf2.parse(salesOrderdetails.getDeliveryDate());
                    sdf2.applyPattern("dd-MM-yyyy");
                    String deliveryDateFormatted = sdf2.format(d2);

                    String timestamp = salesOrderdetails.getCreateTimeStamp();
                    String orderDate = timestamp.substring(0, timestamp.indexOf(" "));

                    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                    Date d = sdf.parse(orderDate);
                    sdf.applyPattern("dd-MM-yyyy");
                    String orderDateFormatted = sdf.format(d);

                    out.println("<p id='right-col'>");
                    out.print(orderID);
                    out.print("<br>");
                    out.println(orderDateFormatted);
                    out.println("<br>");
                    out.println(salesOrderdetails.getDisplayTerm());
                    out.println("<br>");
                    out.println("Route No." + salesOrderdetails.getRouteNumber());

                    out.println("</p>");
                    out.println("<p id='left-col'>");
                    out.println("Customer Code: XXXX-XXXX");
                    out.println("<br><br>");
        %>
        <b><%= salesOrderdetails.getCompanyName()%></b><br>
        <%= salesOrderdetails.getDeliverAddr1()%><br>
        <%= salesOrderdetails.getDeliverAddr2()%><br>
        <% if (!salesOrderdetails.getDeliverAddr3().equals("-")) {
                out.println(salesOrderdetails.getDeliverAddr3());
            }
            if (!salesOrderdetails.getDeliverAddr4().equals("-")) {
                out.println(salesOrderdetails.getDeliverAddr4());
            }
        %>
        Contact Number: <%= salesOrderdetails.getDeliverContact() + " |" + " "%>
        Contact Person: <%= salesOrderdetails.getDebtorName()%><br>
    </p>
    <table id ="table">
        <%  double total = 0;
            int size = itemDetailsMap.keySet().size();
            int count = 0;
            for (Integer number : itemDetailsMap.keySet()) {
                double subtotal = 0;
                out.println("<tr>");
                ItemDetails itemDetail = itemDetailsMap.get(number);
                OrderItem item = salesOrderUtility.getOrderItem(itemDetail.getItemCode());

                int qtyDouble = Integer.parseInt(itemDetail.getQty());
                int returnedQty = Integer.parseInt(itemDetail.getReturnedQty());
                int finalqty = qtyDouble - returnedQty;
                out.print("<td style='width: 40px'>" + finalqty + "</td>");

                double unitPriceDouble = Double.parseDouble(itemDetail.getUnitPrice());

                out.print("<td style='width: 30px'>" + item.getUnitOfMetric() + "</td>");
                out.print("<td style='width: 270px'>" + item.getDescriptionChinese() + "  " + item.getDescription() + "</td>");
                out.print("<td style='width: 45px'>" + item.getRetailPrice2DP() + "</td>");
                out.print("<td style='width: 45px'>" + itemDetail.getUnitPrice2DP() + "</td>");

                subtotal = qtyDouble * unitPriceDouble;
                DecimalFormat df = new DecimalFormat("0.00");
                out.print("<td style='width: 40px'>" + df.format(subtotal) + "</td>");

                total += subtotal;
                out.print("</tr>");
            }
            DecimalFormat df = new DecimalFormat("0.00");

        %>
        <table id ="table2" collapsed>
            <tr>
                <td style='width: 35px'></td>
                <td style='width: 30px'></td>
                <td style='width: 315px'></td>
                <td style='width: 80px'><b>Subtotal ($)</b></td>
                <td style='width: 40px'><%=df.format(total)%></td>
            </tr>
            <tr>
                <td style='width: 35px'></td>
                <td style='width: 30px'></td>
                <td style='width: 315px'></td>
                <td style='width: 80px'><b>Add GST (7%)</b></td>
                <td style='width: 40px'><%=df.format(total * 0.07)%></td>
            </tr>
            <tr>
                <td style='width: 35px'></td>
                <td style='width: 30px'></td>
                <td style='width: 315px'></td>
                <td style='width: 80px'><b>Total ($)</b></td>
                <td style='width: 40px'><%=df.format(total * 1.07)%></td>
            </tr>                
        </table>
        <%
                    out.println("</div>");
                }
            } else {
                out.println("No orders selected! ");
            }
        %>
</body>
</html>
