<%-- 
    Document   : salesOrderEdit
    Created on : 12 May, 2018, 1:04:11 AM
    Author     : Rizza
<%@include file="protect.jsp" %>
--%>


<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="utility.notificationUtility"%>
<%@page import="entity.Notification"%>
<%@page import="entity.OrderItem"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="entity.ItemDetails"%>
<%@page import="utility.salesOrderUtility"%>
<%@page import="entity.SalesOrderDetails"%>
<%@page import="java.util.HashMap"%>
<%@page import="entity.Debtor"%>
<%@page import="java.util.Map"%>
<%@page import="utility.debtorUtility"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8" />
        <link rel="apple-touch-icon" sizes="76x76" href="assets/img/apple-icon.png">
        <link rel="icon" type="image/png" href="assets/img/favicon.ico">
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
        <title>Lim Kee Admin Portal</title>
        <meta content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0, shrink-to-fit=no' name='viewport' />
        <!--     Fonts and icons     -->
        <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700,200" rel="stylesheet" />
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/latest/css/font-awesome.min.css" />
        <!-- CSS Files -->
        <link href="assets/css/bootstrap.min.css" rel="stylesheet" />
        <link href="assets/css/light-bootstrap-dashboard.css?v=2.0.1" rel="stylesheet" />
        <!-- CSS Just for demo purpose, don't include it in your project -->
        <link href="assets/css/demo.css" rel="stylesheet" />
        <link rel="stylesheet" href="https://www.w3schools.com/lib/w3-colors-highway.css">
    </head>

    <body>

        <div class="wrapper">
            <!-- Sidebar -->
            <div class="sidebar" data-image="assets/img/navbar.png" data-color="orange">
                <!--
            Tip 1: You can change the color of the sidebar using: data-color="purple | blue | green | orange | red"
    
            Tip 2: you can also add an image using data-image tag
                -->
                <div class="sidebar-wrapper">
                    <div class="logo">
                        <a href="#" class="simple-text">
                            LIM KEE Admin Portal
                        </a>

                    </div>
                    <ul class="nav">
                        <%
                            String isMasterAdmin = (String) session.getAttribute("isMaster");

                            if (isMasterAdmin.equals("1")) {
                                out.print("<li>");
                                out.print("<a class='nav-link' href='admin.jsp'>");
                                out.print("<img src='assets/img/masterAdmin_icon.png'/>");
                                out.print("<p>&nbspAdmin</p>");
                                out.print("</a>");
                                out.print("</li>");
                            }

                        %>
                        <li>
                            <a class="nav-link" href="dashboard.jsp">
                                <img src="assets/img/dashboard_icon.png"/>
                                <p>Dashboard</p>
                            </a>
                        </li>
                        <li>
                            <a class="nav-link" href="customer.jsp">
                                <img src="assets/img/debtor_icon.png"/>
                                <p>Customer</p>
                            </a>
                        </li>
                        <li class='nav-item active'>
                            <a class="nav-link" href="salesOrder.jsp">
                                <img src="assets/img/salesOrder_icon.png"/>
                                <p>Sales Order</p>
                            </a>
                        </li>
                        <li>
                            <a class="nav-link" href="catalogue.jsp">
                                <img src="assets/img/item_icon.png"/>
                                <p>Catalogue</p>
                            </a>
                        </li>
                        <li>
                            <a class="nav-link" href="wallet.jsp">
                                <img src="assets/img/wallet_icon.png"/>
                                <p>Wallet</p>
                            </a>
                        </li>
                        <li>
                            <a class="nav-link" href="./accountSettings.jsp">
                                <img src="assets/img/accSettings_icon.png"/>
                                <p>Account Settings</p>
                            </a>
                        </li>

                    </ul>
                </div>
            </div>
            <!--End Sidebar -->    
            <div class="main-panel">
                <!-- Navbar -->
                <nav class="navbar navbar-expand-lg " color-on-scroll="500">
                    <div class=" container-fluid  ">
                        <a class="navbar-brand" href="#"><img src="assets/img/limkee_logo.png" style="margin-right: 10px; width:60px; height:42px;"/></a>
                        <button href="" class="navbar-toggler navbar-toggler-right" type="button" data-toggle="collapse" aria-controls="navigation-index" aria-expanded="false" aria-label="Toggle navigation">
                            <span class="navbar-toggler-bar burger-lines"></span>
                            <span class="navbar-toggler-bar burger-lines"></span>
                            <span class="navbar-toggler-bar burger-lines"></span>
                        </button>
                        <div class="collapse navbar-collapse justify-content-end" id="navigation">
                            <ul class="nav navbar-nav mr-auto">
                                <div id="notification">
                                    <li class="dropdown nav-item">
                                        <a href="#" class="dropdown-toggle nav-link" data-toggle="dropdown">
                                            <i class="nc-icon nc-planet"></i>
                                            <% Map<Integer, Notification> notificationMap = notificationUtility.getNotificationsMap();%>
                                            <span class="notification"> <%= notificationMap.size()%> </span>
                                            <span class="d-lg-none">Notification</span>
                                        </a>
                                        <ul class="dropdown-menu">

                                               <%
                                                   for (int i=1 ; i<=notificationMap.size(); i++){
                                                            if(i<=5){
                                                            Notification notification = notificationMap.get(i);
                                                            out.print("<a class='dropdown-item' href='salesOrderEdit.jsp?orderID="+notification.getOrderID()+"&status=Pending Delivery&update=true'>" +notification.getDebtorName()+
                                                                    "  placed a new order #"+notification.getOrderID()+" on "+notification.getFormattedCreatedTimeStamp()+"</a>");
                                                            }     
                                                    }
                                                    out.print("<center><a class='dropdown-item' href='allNotifications.jsp'>View all notifications</a></center>");
                                                    
                                               %> 

                                        </ul>
                                    </li>
                                </div>
                            </ul>
                            <ul class="navbar-nav ml-auto">
                                <% String usernameSession = (String) session.getAttribute("username");%>
                                Welcome, <%= usernameSession%> 

                                <li class="nav-item">
                                    <a class="nav-link" href="logout.jsp">
                                        <span class="no-icon">Log out</span>
                                        <div id="show" align="center"></div>
                                    </a>
                                </li>
                            </ul>
                        </div>
                    </div>
                </nav>
                <!-- End Navbar -->

                <div class="content">
                    <div class="container-fluid">
                        <div class="row">
                            <div class="col-md-12">
                                <div class="card strpied-tabled-with-hover">
                                    <div class="card-header ">

                                        <h4 class="card-title">Sales Order Management</h4>
                                        <p class="card-category">Sales Order Edit</p>
                                    </div>
                                    <div class="card-body">


                                        <%
                                            String orderID = request.getParameter("orderID");
                                            String status = request.getParameter("status");
                                            String updateNotification = request.getParameter("update");                                          

                                            if (status.equals("pendingDelivery")) {
                                                status = "Pending Delivery";
                                            }

                                            SalesOrderDetails salesOrderdetails = salesOrderUtility.getSalesOrderDetails(orderID, status);

                                            String customerCode = salesOrderUtility.getCustomerCode(orderID, status);

                                            Map<Integer, ItemDetails> itemDetailsMap = salesOrderUtility.getItemDetailsMap(orderID, status);

                                            Map<Integer, ItemDetails> refundedItemDetailsMap = salesOrderUtility.getRefundedItemDetailsMap(orderID);
                                            
                                            if(updateNotification != null){
                                                
                                                if(updateNotification.equals("true")){
                                                    notificationUtility.updateNotificationsMap(orderID);
                                                }
                                            }
                                            

                                        %>

                                        <form method="post" action="editSalesOrderController">
                                            <input type="hidden" name="debtorCode" value="<%= customerCode%>">
                                            <input type="hidden" name="orderID" value="<%= orderID%>">
                                            <input type="hidden" name="preferredLanguage" value="<%= salesOrderdetails.getPreferredLanguage()%>">

                                            <%

                                                String currentModifier = usernameSession;
                                                String currentTimeStamp = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date());
                                                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

                                                Date d2 = sdf.parse(salesOrderdetails.getCreateTimeStamp());
                                                sdf.applyPattern("dd-MM-yyyy HH:mm:ss");
                                                String orderDateFormatted = sdf.format(d2);

                                                SimpleDateFormat sdf3 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                                                String lastModifiedTimeStampFormatted = "";
                                                if (salesOrderdetails.getLastModifiedTimeStamp() != null && !salesOrderdetails.getLastModifiedTimeStamp().equals("-")) {
                                                    Date d3 = sdf3.parse(salesOrderdetails.getLastModifiedTimeStamp());
                                                    sdf3.applyPattern("dd-MM-yyyy HH:mm:ss");
                                                    lastModifiedTimeStampFormatted = sdf3.format(d3);
                                                } else {
                                                    lastModifiedTimeStampFormatted = salesOrderdetails.getLastModifiedTimeStamp();
                                                }

                                            %>    

                                            <div class="row">
                                                <div class="col-md-3 pr-4">
                                                    <div class="form-group">
                                                        <label>Last Modified By</label>
                                                        <input type="text" class="form-control" size="10" value="<%= salesOrderdetails.getLastModifiedBy()%>" disabled="">
                                                        <input type="hidden" class="form-control" value="<%= currentModifier%>" name="lastModifiedBy">
                                                    </div>
                                                </div>
                                                <div class="col-md-3 pr-2">
                                                    <div class="form-group">
                                                        <label>Last Modified TIme</label>
                                                        <input type="text" class="form-control" placeholder="Last Modified TimeStamp" size="10" value="<%=lastModifiedTimeStampFormatted%>" disabled="">
                                                        <input type="hidden" class="form-control" value="<%= currentTimeStamp%>" name="lastModifiedTimeStamp">
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="row">
                                                <div class="col-md-4 pr-1">
                                                    <div class="form-group">
                                                        <label>Contact Person</label>
                                                        <input type="text" class="form-control" placeholder="Contact Person" size="10" name="Username" value="<%= salesOrderdetails.getDebtorName()%>" disabled="">
                                                    </div>
                                                </div>
                                                <div class="col-md-4 pr-1">
                                                    <div class="form-group">
                                                        <label>Company Name</label>
                                                        <input type="text" class="form-control" placeholder="Company Name" required placeholder="" value="<%= salesOrderdetails.getCompanyName()%>" size="10" name="companyName" disabled="">                                            
                                                    </div>
                                                </div>

                                            </div>
                                            <div class="row">
                                                <div class="col-md-3 pr-1">
                                                    <div class="form-group">
                                                        <label>Contact Number</label>
                                                        <input type="text" class="form-control" placeholder="Contact Number" size="10" name="ContactNumber" value="<%= salesOrderdetails.getDeliverContact()%>" disabled="">
                                                    </div>
                                                </div>
                                                <input type='hidden' name='DisplayTerm' value='C.O.D'>
                                            </div>
                                            <div class="row">
                                                <div class="col-md-3 pr-1">
                                                    <div class="form-group">
                                                        <label>Order ID</label>
                                                        <input type="text" class="form-control" placeholder="Order ID" size="10" name="OrderID" value="<%= salesOrderdetails.getOrderID()%>" disabled="">
                                                    </div>
                                                </div>

                                                <div class="col-md-3 pr-1">
                                                    <div class="form-group">
                                                        <label>Order Date</label>
                                                        <input type="text" class="form-control" placeholder="Order Date" required placeholder="" value="<%=orderDateFormatted%>" size="10" name="Order Date" disabled="">                                            
                                                    </div>
                                                </div>

                                                <div class="col-md-4 pr-1">
                                                    <div class="form-group">
                                                        <label>Status</label>
                                                        <!--this should be a dropdown --> 

                                                        <select name="status" class="form-control" id="status">
                                                            <%
                                                                String sts = salesOrderdetails.getStatus();
                                                                if (sts.equals("Pending Delivery") || sts.equals("pendingDelivery")) {
                                                                    out.println("<option value='Pending Delivery'>Pending Delivery</option>");
                                                                    out.println("<option value='Delivered'>Delivered</option>");

                                                                } else if (sts.equals("Cancelled") || sts.equals("cancelled")) {
                                                                    out.println("<option disable value='Cancelled'>Cancelled</option>");
                                                                } else {
                                                                    out.println("<option value='Delivered'>Delivered</option>");
                                                                    out.println("<option value='Pending Delivery'>Pending Delivery</option>");
                                                                }

                                                            %> 
                                                        </select>
                                                    </div>
                                                </div>

                                            </div>         

                                            <div class="row">
                                                <div class="col-md-5 pr-1">
                                                    <div class="form-group">
                                                        <label>Delivery Address</label>
                                                        <input type="text" class="form-control" placeholder="Delivery Address1" size="10" name="Delivery Address1" value="<%= salesOrderdetails.getDeliverAddr1()%>" disabled="">
                                                    </div>
                                                </div>
                                                <div class="col-md-4 pr-1">
                                                    <div class="form-group">
                                                        <label>&nbsp;</label>
                                                        <input type="text" class="form-control" placeholder="Delivery Address2" required placeholder="" value="<%= salesOrderdetails.getDeliverAddr2()%>" size="10" name="Delivery Address2" disabled="">                                            
                                                    </div>
                                                </div>

                                            </div>
                                            <div class="row">
                                                <div class="col-md-4 pr-1">
                                                    <div class="form-group">
                                                        <label></label>
                                                        <input type="text" class="form-control" placeholder="Delivery Address3" size="10" name="Delivery Address3" value="<%= salesOrderdetails.getDeliverAddr3()%>" disabled="">
                                                    </div>
                                                </div>
                                                <div class="col-md-4 pr-1">
                                                    <div class="form-group">
                                                        <label></label>
                                                        <input type="text" class="form-control" placeholder="Delivery Address4" required placeholder="" value="<%= salesOrderdetails.getDeliverAddr4()%>" size="10" name="Delivery Address4" disabled="">                                            
                                                    </div>
                                                </div>

                                            </div>

                                            <div class="row">
                                                <div class="col-md-4 pr-1">
                                                    <div class="form-group">
                                                        <label>Route</label>
                                                        <input type="text" class="form-control" placeholder="Delivery Route" size="10" name="Delivery Route" value="<%= salesOrderdetails.getRouteNumber()%>" disabled="">
                                                    </div>
                                                </div>
                                                <div class="col-md-4 pr-1">
                                                    <div class="form-group">
                                                        <label>Delivery Date</label>
                                                        <input type="date" class="form-control" placeholder="deliveryDate" required placeholder="" value="<%= salesOrderdetails.getDeliveryDate()%>" size="10" name="deliveryDate">                                            
                                                    </div>
                                                </div>

                                            </div>



                                            <div class="row">
                                                <div class="col-md-4 pr-1">
                                                    <div class="form-group">
                                                        <label>Paper Bag Required?</label>
                                                        <select name="paperBagRequired" class="form-control">
                                                            <%
                                                                String paperBagDropDown = salesOrderdetails.getPaperBagRequired();
                                                                if (paperBagDropDown.equals("yes") || paperBagDropDown.equals("Yes")) {
                                                                    out.println("<option value='1'>Yes</option>");
                                                                    out.println("<option value='0'>No</option>");
                                                                } else {
                                                                    out.println("<option value='0'>No</option>");

                                                                    out.println("<option value='1'>Yes</option>");
                                                                }

                                                            %> 
                                                        </select>
                                                    </div>
                                                </div>

                                            </div>
                                            <br>           
                                            <hr>
                                            <div class="card-body table-full-width table-responsive">
                                                <table class="table table-hover table-striped">
                                                    <tbody>

                                                        <%                                                            double total = 0;
                                                            out.print("<tr>");
                                                            out.print("<thead><th><b>Item Code</b></th>"
                                                                    + "<th><b>Item Name</b></th>"
                                                                    + "<th><b></b></th>"
                                                                    + "<th><b>Quantity</b></th>"
                                                                    + "<th><b>Returned Quantity</b></th>"
                                                                    + "<th><b>Reduced Quantity</b></th>"
                                                                    + "<th><b>Unit Price($)</b></th>"
                                                                    + "<th><b>Subtotal($)</b></th></thead>");

                                                            for (Integer number : itemDetailsMap.keySet()) {
                                                                double subtotal = 0;

                                                                ItemDetails itemDetail = itemDetailsMap.get(number);
                                                                OrderItem item = salesOrderUtility.getOrderItem(itemDetail.getItemCode());

                                                                double qtyDouble = Double.parseDouble(itemDetail.getQty());
                                                                double unitPriceDouble = Double.parseDouble(itemDetail.getUnitPrice());
                                                                //double returnedQty = itemDetail.getReturnedQty();
                                                                double returnedQty = Double.parseDouble(itemDetail.getReturnedQty());
                                                                subtotal = qtyDouble * unitPriceDouble;

                                                                //out.print("<tr><thead><th>Item Code</th></thead>");
                                                                out.print("<td>" + itemDetail.getItemCode() + "</td>");
                                                                out.print("<td>" + item.getDescription() + "</td>");
                                                                out.print("<td>" + "" + "</td>");

                                                                out.print("<input type='hidden' size='10' name='itemCode' value='" + itemDetail.getItemCode() + "'>");
                                                                out.print("<input type='hidden' size='10' name='originalQty' value='" + itemDetail.getQty() + "'>");
                                                                out.print("<input type='hidden' size='10' name='unitPrice' value='" + itemDetail.getUnitPrice() + "'>");
                                                                //out.print("<tr><thead><th>Quantity</th></thead>");
                                                                out.print("<td><input type='number' required size='10' name='qty' id='indivQty' onChange='updatePrices(" + itemDetail.getItemCode() + ")' value='" + itemDetail.getQty() + "'></td>");
                                                                //out.print("<tr><thead><th>Returned Quantity</th></thead>");
                                                                out.print("<td>" + itemDetail.getReturnedQty() + "</td>");
                                                                out.print("<td>" + itemDetail.getReducedQty() + "</td>");
                                                                //out.print("<tr><thead><th>Unit Price</th></thead>");
                                                                out.print("<td>" + itemDetail.getUnitPrice2DP() + "</td>");
                                                                //out.print("<tr><thead><th>Subtotal</th></thead>");
                                                                DecimalFormat df = new DecimalFormat("0.00");
                                                                out.print("<td id=" + itemDetail.getItemCode() + "'indivSubtotal' >" + df.format(subtotal) + "</td>");
                                                                out.print("</tr>");

                                                                total += subtotal;
                                                            }
                                                            DecimalFormat df = new DecimalFormat("0.00");
                                                        %>
                                                   
                                            
                                            
                                            
                                                
                                           

                                                        <%
                                                            
                                                            double refundedTotal = 0;

                                                            if (refundedItemDetailsMap.size() > 0) {
                                                                out.print("<div class='card-header'><h4 class='card-title'>Returned Items</h4><p class='card-category'>List of return items</p>");
                                                                //out.print("<center><thead><th><b>Returned Items</b></th></center>");
                                                                out.print("<thead><th><b>Item Code</b></th>"
                                                                        + "<th><b>Item Name</b></th>"
                                                                        + "<th><b></b></th>"
                                                                        + "<th><b></b></th>"
                                                                        + "<th><b>Returned Quantity</b></th>"
                                                                        + "<th><b></b></th>"
                                                                        + "<th><b></b></th>"
                                                                        + "<th><b></b></th>"
                                                                        + "<th><b>Unit Price($)</b></th>"
                                                                        + "<th><b>Subtotal($)</b></th></thead>");
                                                            }

                                                            for (Integer number : refundedItemDetailsMap.keySet()) {
                                                                double refundedSubtotal = 0;

                                                                ItemDetails refundedItemDetail = refundedItemDetailsMap.get(number);
                                                                OrderItem item = salesOrderUtility.getOrderItem(refundedItemDetail.getItemCode());

                                                                double qtyDouble = Double.parseDouble(refundedItemDetail.getReturnedQty());
                                                                double unitPriceDouble = Double.parseDouble(refundedItemDetail.getUnitPrice());
                                                                refundedSubtotal = qtyDouble * unitPriceDouble;

                                                                out.print("<td>" + refundedItemDetail.getItemCode() + "</td>");
                                                                out.print("<td>" + item.getDescription() + "</td>");
                                                                out.print("<th><b></b></th>");
                                                                out.print("<th><b></b></th>");
                                                                out.print("<td>" + refundedItemDetail.getReturnedQty() + "</td>");
                                                                out.print("<th><b></b></th>");
                                                                out.print("<th><b></b></th>");
                                                                out.print("<th><b></b></th>");
                                                                out.print("<td>" + refundedItemDetail.getUnitPrice2DP() + "</td>");
                                                                out.print("<td>" + df.format(refundedSubtotal) + "</td>");
                                                                out.print("</tr>");

                                                                refundedTotal += refundedSubtotal;
                                                            }

                                                        %>
                                                        
                                                        <tr bgcolor="white">
                                                            <td></td>
                                                            <td></td>
                                                            <td></td>
                                                            <td></td>
                                                            <td></td>
                                                            <td></td>
                                                           
                                                            <td><b><font color="red">SUBTOTAL ($)</font></b></td>
                                                            <td><b><%= df.format(total)%></b></td>
                                                        </tr>                                                     
                                                        <tr bgcolor="white">
                                                            <td></td>
                                                            <td></td>
                                                            <td></td>
                                                            <td></td>
                                                            <td></td>
                                                            <td></td>
                                                       
                                                            <td><b><font color="red">GST (7%)</font></b></td>
                                                            <td><b><%= df.format(total * 0.07)%></b></td>
                                                        </tr>
                                                        <tr bgcolor="white">
                                                            <td></td>
                                                            <td></td>
                                                            <td></td>
                                                            <td></td>
                                                            <td></td>
                                                            <td></td>

                                                            <td><b><font color="red">TOTAL ($)</font></b></td>
                                                            <td><b><%= df.format(total * 1.07)%></b></td>
                                                        </tr>

                                                         <tr bgcolor="white">
                                                            <td></td>
                                                            <td></td>
                                                            <td></td>
                                                            <td></td>
                                                            <td></td>
                                                            <td></td>

                                                            <td><b><font color="red">WALLET DEDUCTION ($)</font></b></td>
                                                            <td><b>
                                                                    <% 
                                                                        double walletDeduction = total * 1.07 - salesOrderdetails.getPaidAmt();
                                                                        
                                                                        if(walletDeduction>0){
                                                                            walletDeduction = walletDeduction*-1;
                                                                        }
                                                                        
                                                                        if(walletDeduction == 0){
                                                                            out.println("-");
                                                                        }
                                                                                
                                                                        out.println(df.format(walletDeduction)); 
                                                                    %>
                                                            </b></td>
                                                        </tr>                                                                                                                
                                                        <tr bgcolor="white">
                                                            <td></td>
                                                            <td></td>
                                                            <td></td>
                                                            <td></td>
                                                            <td></td>
                                                            <td></td>
                                                         
                                                            <td><b><font color="red">PAYABLE AMOUNT ($)</font></b></td>
                                                            <td><b><%= df.format(salesOrderdetails.getPaidAmt()) %></b></td>
                                                        </tr>

                                                    </tbody>
                                                </table>
                                                        
                                            </div>
                                           

                                                <input class="btn btn-info btn-fill pull-right" type="submit" name="submit"  value="Done" />
                                                <input class="btn btn-info btn-fill pull-left" type="button" name="Cancel" data-toggle="modal" data-target="#myModal1" value="Cancel" />

                                                <div class="modal fade modal-mini modal-primary" id="myModal1" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                                                    <div class="modal-dialog">
                                                        <div class="modal-content">
                                                            <div class="modal-header justify-content-center">
                                                                <div class="modal-profile">
                                                                    <img src="assets/img/lightbulb_icon.png" height="50px" width="50px"/>
                                                                </div>
                                                            </div>
                                                            <div class="modal-body text-center">
                                                                <p>Your changes will not be saved. Are you sure you want to leave this page?</p>
                                                            </div>
                                                            <div class="modal-footer">
                                                                <button type="button" class="btn btn-link btn-simple" onclick="location.href = 'salesOrder.jsp'" >Leave Page</button>
                                                                <button type="button" class="btn btn-link btn-simple" data-dismiss="modal">Continue</button>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                        </form>
                                    
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <footer class="footer">
                <p class="copyright text-center">
                    This website's content is Copyright 
                    <script>
                        document.write(new Date().getFullYear())
                    </script>
                    © Lim Kee Food Manufacturing Pte Ltd
                </p>
            </footer>
        </div>
    </div>

</body>
<!--   Core JS Files   -->
<script src="assets/js/core/jquery.3.2.1.min.js" type="text/javascript"></script>
<script src="assets/js/core/popper.min.js" type="text/javascript"></script>
<script src="assets/js/core/bootstrap.min.js" type="text/javascript"></script>
<!--  Plugin for Switches, full documentation here: http://www.jque.re/plugins/version3/bootstrap.switch/ -->
<script src="assets/js/plugins/bootstrap-switch.js"></script>
<!--  Google Maps Plugin    -->
<script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?key=YOUR_KEY_HERE"></script>
<!--  Chartist Plugin  -->
<script src="assets/js/plugins/chartist.min.js"></script>
<!--  Notifications Plugin    -->
<script src="assets/js/plugins/bootstrap-notify.js"></script>
<!-- Control Center for Light Bootstrap Dashboard: scripts for the example pages etc -->
<script src="assets/js/light-bootstrap-dashboard.js?v=2.0.1" type="text/javascript"></script>
<!-- Light Bootstrap Dashboard DEMO methods, don't include it in your project! -->
<script src="assets/js/demo.js"></script>
<script type="text/javascript">
                        $(document).ready(function () {
                            // Javascript method's body can be found in assets/js/demos.js
                            demo.initDashboardPageCharts();

                        });
</script>

<script>
    $(document).ready(
            function () {
                setInterval(function () {
                    $('#notification').load('wallet.jsp #notification');
                }, 5000);
                //document.write($("#status").value);
                if (document.getElementById('status').value == 'Cancelled') {

                    var elems = document.getElementsByTagName('input');
                    var dropdowns = document.getElementsByTagName('select');
                    var len = elems.length;

                    for (var i = 0; i < len; i++) {
                        elems[i].disabled = true;
                    }
                    len = dropdowns.length;
                    for (var i = 0; i < len; i++) {
                        dropdowns[i].disabled = true;
                    }

                }
            });
</script>

</html>