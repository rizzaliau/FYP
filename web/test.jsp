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
            #t1{
                margin-top: 200px;
                margin-left: 40px;
                width: 1040px;
                height: 200px;

                position: relative
            }
            #t2{
                margin-top: 230px;
                margin-left: 40px;
                width: 1040px;
                height: 500px;

                position: relative
            }

            #t3{
                margin-top: 150px;
                margin-left: 35px;
                width: 1040px;
                height: 60px;

                position: relative  
            }
            #id{
                left: 35px;
            }
            @media print {
                div { page-break-after: always; }
                a[href]:after {
                    content: none !important;
                }
            }
            #printpagebutton{
                width: 100px;
                position: relative;
                top:100px;
                left:45px;
            }
        </style>
    </head>
    <body>
        <input id="printpagebutton" class="btn btn-info btn-fill pull-right" type="button" value="Print" onclick="printFunction()"/>
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
                    /*
                    out.println("<p id='left2-col'>");
                    out.print(orderID);
                    out.print("<br>");
                    out.println(orderDateFormatted);
                    out.println("<br>");
                    out.println(salesOrderdetails.getDisplayTerm());
                    out.println("<br>");
                    out.println("Route No." + salesOrderdetails.getRouteNumber());

                    out.println("</p>");
                    out.println("<p id='left-col'>");
                     */
                    out.println("<div>");
                    out.println("<table id='t1' border='0'>");
                    out.println("<thead>");
                    out.println("<th>");
                    out.println("</th>");
                    out.println("<th>");
                    out.println("</th>");
                    out.println("</thead>");
                    out.println("<tr>");
                    out.println("<td>");
                    out.println("Customer Code: XXXX-XXXX");
                    out.println("</td>");
                    out.println("<td>");
                    out.println("</td>");
                    out.println("</tr>");


        %>
    <tr>
        <td>
            <b><%= salesOrderdetails.getCompanyName()%></b><br>
        </td>
    </tr>
    <tr>
        <td>
            <%= salesOrderdetails.getDeliverAddr1()%><br>
        </td>
        <td>
            <%=orderID%>
        </td>
    <tr>
    <tr>
        <td>
            <%= salesOrderdetails.getDeliverAddr2()%>
        </td>
        <td>
            <%=orderDateFormatted%>
        </td>
        <% if (!salesOrderdetails.getDeliverAddr3().equals("-")) {
                out.println("<tr>");
                out.println("<td>");
                out.println(salesOrderdetails.getDeliverAddr3());
                out.println("</td>");
                 if (!salesOrderdetails.getDeliverAddr4().equals("-")) {
                out.println("<td>");
                out.println(salesOrderdetails.getDeliverAddr4());
                out.println("</td>");
                }
                out.println("</tr>");
            }
        %>

    <tr>
        <td>
            Contact Number: <%= salesOrderdetails.getDeliverContact() + " |" + " "%>
            Contact Person: <%= salesOrderdetails.getDebtorName()%><br>
        </td>
        <td>
            <%=salesOrderdetails.getDisplayTerm()%>
        </td>
    </tr>
    <tr>
        <td>
        </td>
        <td>
            Route <%=salesOrderdetails.getRouteNumber()%>

        </td>
    </tr>
</p>
<table id ="t2" border="0">
    <thead>
    <th></th>
    <th></th>
    <th></th>
    <th></th>
    <th></th>
    <th></th>
</thead>
<tbody>
    <%  double total = 0;
        int size = itemDetailsMap.keySet().size();
        int count = 0;
        for (Integer number : itemDetailsMap.keySet()) {
            double subtotal = 0;
            count += 1;
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
        while (count < 27) {
            out.println("<tr>");
            out.println("<td></td>");
            out.println("<td></td>");
            out.println("<td></td>");
            out.println("<td></td>");
            out.println("<td></td>");
            out.println("<td></td>");
            out.println("</tr>");
            count += 1;
        }

        DecimalFormat df = new DecimalFormat("0.00");

    %>
</tbody>
</table>
<table id ="t3" collapsed>
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
    <tr>
        <td style='width: 35px'></td>
        <td style='width: 30px'></td>
        <td style='width: 315px'></td>
        <td style='width: 80px'></td>
        <% String usernameSession = (String) session.getAttribute("username"); %>  
        <td style='width: 40px'><i><%= usernameSession %></i></td>
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
<script>
    function printFunction() {
        var printButton = document.getElementById("printpagebutton");
        //Set the print button visibility to 'hidden' 
        printButton.style.visibility = 'hidden';
        window.print();
        printButton.style.visibility = 'show';
        location.reload()
    }
</script>

</html>
