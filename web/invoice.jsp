

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
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="protect.jsp" %>
<!doctype html>
<html>
    <head>
        <meta charset="utf-8">
        <title>Lim Kee Food Manufacturing Pte Ltd</title>
        <link href="assets/css/bootstrap.min.css" rel="stylesheet" />
        <style>
            @page {
                margin: 0;
            }

            .invoice-box {
                max-width: 800px;
                margin: auto;
                padding: 30px;
                border: 1px solid #eee;
                box-shadow: 0 0 10px rgba(0, 0, 0, .15);
                font-size: 16px;
                line-height: 24px;
                font-family: 'Helvetica Neue', 'Helvetica', Helvetica, Arial, sans-serif;
                color: #555;
            }

            .invoice-box table {
                width: 100%;
                line-height: inherit;
                text-align: left;
            }

            .invoice-box table td {
                padding: 5px;
                vertical-align: top;
            }

            .invoice-box table tr td:nth-child(2) {
                text-align: right;
            }

            .invoice-box table tr.top table td {
                padding-bottom: 20px;
            }

            .invoice-box table tr.top table td.title {
                font-size: 45px;
                line-height: 45px;
                color: #333;
            }

            .invoice-box table tr.information table td {
                padding-bottom: 40px;
            }

            .invoice-box table tr.heading td {
                background: #eee;
                border-bottom: 1px solid #ddd;
                font-weight: bold;
            }

            .invoice-box table tr.details td {
                padding-bottom: 20px;
            }

            .invoice-box table tr.item td{
                border-bottom: 1px solid #eee;
            }

            .invoice-box table tr.item.last td {
                border-bottom: none;
            }

            .invoice-box table tr.total td:nth-child(2) {
                border-top: 2px solid #eee;
                font-weight: bold;
            }

            @media only screen and (max-width: 600px) {
                .invoice-box table tr.top table td {
                    width: 100%;
                    display: block;
                    text-align: center;
                }

                .invoice-box table tr.information table td {
                    width: 100%;
                    display: block;
                    text-align: center;
                }
            }

            /** RTL **/
            .rtl {
                direction: rtl;
                font-family: Tahoma, 'Helvetica Neue', 'Helvetica', Helvetica, Arial, sans-serif;
            }

            .rtl table {
                text-align: right;
            }

            .rtl table tr td:nth-child(2) {
                text-align: left;
            }
        </style>
    </head>

    <body>
        <%
            String orderID = request.getParameter("orderID");
            String status = request.getParameter("status");

            if (status.equals("pendingDelivery")) {
                status = "Pending Delivery";
            }

            SalesOrderDetails salesOrderdetails = salesOrderUtility.getSalesOrderDetails(orderID, status);

            Map<Integer, ItemDetails> itemDetailsMap = salesOrderUtility.getItemDetailsMap(orderID, status);

            Map<Integer, ItemDetails> refundedItemDetailsMap = salesOrderUtility.getRefundedItemDetailsMap(orderID);

        %>


        <div class="invoice-box">
            <table cellpadding="0" cellspacing="0">
                <tr class="top">
                    <td colspan="6">
                        <table>
                            <tr>
                                <td class="title">
                                    <img src="assets/img/navbar.png" style="width:100%; max-width:100px;">
                                </td>

                                <td>
                                    No:<%= orderID%><br>
                                    <%
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

                                    %>
                                    Delivery Date: <%= deliveryDateFormatted%><br>
                                    Order Date: <%= orderDateFormatted%><br>
                                    Terms:<%= salesOrderdetails.getDisplayTerm()%>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>

                <tr class="information">
                    <td colspan="6">
                        <table>
                            <tr>
                                <td>
                                    <b><%= salesOrderdetails.getCompanyName()%></b><br>
                                    <%= salesOrderdetails.getDeliverAddr1()%><br>
                                    <%= salesOrderdetails.getDeliverAddr2()%><br>
                                    <%= salesOrderdetails.getDeliverAddr3()%><br>
                                    <%= salesOrderdetails.getDeliverAddr4()%>
                                </td>
                                <td>
                                    Contact Person:<%= salesOrderdetails.getDebtorName()%><br>
                                    Contact No: <%= salesOrderdetails.getDeliverContact()%><br>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>

                <tr class="heading">
                    <td>
                        Qty
                    </td>
                    <td>
                        UOM
                    </td>
                    <td>
                        Description
                    </td>
                    <td>
                        Retail Price
                    </td>                    
                    <td>
                        Unit Price
                    </td>
                    <td>
                        Amount ($$)
                    </td>                                                                                  
                </tr>

                <tr class="item">
                    <%  double total = 0;
                        int size = itemDetailsMap.keySet().size();
                        int count = 0;
                        for (Integer number : itemDetailsMap.keySet()) {
                            double subtotal = 0;
                            if ((int) number == size - 1) {
                                out.print("<tr class='item last'>");
                            } else {
                                out.print("<tr class='item'>");
                            }
                            ItemDetails itemDetail = itemDetailsMap.get(number);
                            OrderItem item = salesOrderUtility.getOrderItem(itemDetail.getItemCode());

                            int qtyDouble = Integer.parseInt(itemDetail.getQty());
                            int returnedQty = Integer.parseInt(itemDetail.getReturnedQty());
                            int finalqty = qtyDouble - returnedQty;
                            out.print("<td>" + finalqty + "</td>");

                            double unitPriceDouble = Double.parseDouble(itemDetail.getUnitPrice());

                            out.print("<td>" + item.getUnitOfMetric() + "</td>");
                            out.print("<td>" + item.getDescriptionChinese() + "  " + item.getDescription() + "</td>");
                            out.print("<td>" + item.getRetailPrice2DP() + "</td>");
                            out.print("<td>" + itemDetail.getUnitPrice2DP() + "</td>");

                            subtotal = qtyDouble * unitPriceDouble;
                            DecimalFormat df = new DecimalFormat("0.00");
                            out.print("<td>" + df.format(subtotal) + "</td>");

                            total += subtotal;
                            out.print("</tr>");
                        }
                        DecimalFormat df = new DecimalFormat("0.00");
                    %>
                <tr class="total">
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td>
                        <b>Subtotal:</b>
                    </td>
                    <td>
                        <%= df.format(total)%>
                    </td>
                </tr>
                <tr class="total">
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td>
                        <b>Add GST (7%): </b>
                    </td>
                    <td>
                        <%= df.format(total * 0.07)%>
                    </td>
                </tr>
                <tr class="total">
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td>
                        <b>Total: </b>
                    </td>
                    <td>
                        <%= df.format(total * 1.07)%>
                    </td>
                </tr>
            </table>
            <br>
            <input id="printpagebutton" class="btn btn-info btn-fill pull-right" type="button" value="Print" onclick="printFunction()"/>                    
        </div>
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
