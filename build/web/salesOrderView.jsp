<%-- 
    Document   : salesOrderView
    Created on : 12 May, 2018, 1:04:11 AM
    Author     : Rizza
--%>


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
            <div class="sidebar" data-image="assets/img/sidebar-5.jpg" data-color="orange">
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
                        <li>
                            <a class="nav-link" href="dashboard.jsp">
                                <i class="nc-icon nc-chart-pie-35"></i>
                                <p>Dashboard</p>
                            </a>
                        </li>
                        <li>
                            <a class="nav-link" href="./userMGMT.jsp">
                                <i class="nc-icon nc-circle-09"></i>
                                <p>Customer Mgmt</p>
                            </a>
                        </li>
                        <li class="nav-item active">
                            <a class="nav-link" href="./salesOrderMGMT.jsp">
                                <i class="nc-icon nc-notes"></i>
                                <p>Sales Order Mgmt</p>
                            </a>
                        </li>
                        <li>
                            <a class="nav-link" href="catalogue.jsp">
                                <i class="nc-icon nc-paper-2"></i>
                                <p>Catalogue Mgmt</p>
                            </a>
                        </li>
                        <li>
                            <a class="nav-link" href="loyaltyProgramme.jsp">
                                <i class="nc-icon nc-single-02"></i>
                                <p>Loyalty Programme</p>
                            </a>
                        </li>
                        <li>
                            <a class="nav-link" href="./accountSettings.jsp">
                                <i class="nc-icon nc-settings-gear-64"></i>
                                <p>Account Settings</p>
                            </a>
                        </li>

                    </ul>
                </div>
            </div>
            <div class="main-panel">
                <!-- Navbar -->
                <nav class="navbar navbar-expand-lg " color-on-scroll="500">
                    <div class=" container-fluid  ">
                        <a class="navbar-brand" href="#pablo"> Dashboard </a>
                        <button href="" class="navbar-toggler navbar-toggler-right" type="button" data-toggle="collapse" aria-controls="navigation-index" aria-expanded="false" aria-label="Toggle navigation">
                            <span class="navbar-toggler-bar burger-lines"></span>
                            <span class="navbar-toggler-bar burger-lines"></span>
                            <span class="navbar-toggler-bar burger-lines"></span>
                        </button>
                        <div class="collapse navbar-collapse justify-content-end" id="navigation">
                            <ul class="nav navbar-nav mr-auto">
                                <li class="nav-item">
                                    <a href="#" class="nav-link" data-toggle="dropdown">

                                    </a>
                                </li>
                                <li class="dropdown nav-item">
                                    <a href="#" class="dropdown-toggle nav-link" data-toggle="dropdown">
                                        <i class="nc-icon nc-planet"></i>
                                        <span class="notification">5</span>
                                        <span class="d-lg-none">Notification</span>
                                    </a>
                                    <ul class="dropdown-menu">
                                        <a class="dropdown-item" href="#">New Order 1</a>
                                        <a class="dropdown-item" href="#">New Order 2</a>
                                        <a class="dropdown-item" href="#">New Order 3</a>
                                        <a class="dropdown-item" href="#">New Order 4</a>
                                        <a class="dropdown-item" href="#">New Order 5</a>
                                    </ul>
                                </li>

                            </ul>
                            <ul class="navbar-nav ml-auto">

                                <li class="nav-item dropdown">
                                    <a class="nav-link dropdown-toggle" href="http://example.com" id="navbarDropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                        <span class="no-icon">Dropdown</span>
                                    </a>
                                    <div class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
                                        <a class="dropdown-item" href="#">Action</a>
                                        <a class="dropdown-item" href="#">Another action</a>
                                        <a class="dropdown-item" href="#">Something</a>
                                        <a class="dropdown-item" href="#">Something else here</a>
                                        <div class="divider"></div>
                                        <a class="dropdown-item" href="#">Separated link</a>
                                    </div>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="#pablo">
                                        <span class="no-icon">Log out</span>
                                    </a>
                                </li>
                            </ul>
                        </div>
                    </div>
                </nav>
                <!--start of form view --> 
                <div class="content">
                    <div class="container-fluid">
                        <div class="row">
                            <div class="col-md-12">
                                <div class="card strpied-tabled-with-hover">
                                    <div class="card-header ">

                                        <h4 class="card-title">Sales Order Management</h4>
                                        <p class="card-category">Sales Order View</p>
                                    </div>
                                    <div class="card-body">

                                        <%
                                            String orderID = request.getParameter("orderID");
                                            String status = request.getParameter("status");

                                            if (status.equals("pendingDelivery")) {
                                                status = "Pending Delivery";
                                            }

                                            SalesOrderDetails salesOrderdetails = salesOrderUtility.getSalesOrderDetails(orderID, status);

                                            Map<Integer, ItemDetails> itemDetailsMap = salesOrderUtility.getItemDetailsMap(orderID, status);

                                            Map<Integer, ItemDetails> refundedItemDetailsMap = salesOrderUtility.getItemDetailsMap(orderID, "Refunded");

                                        %>

                                        <div class="row">
                                            <div class="col-md-3 pr-1">
                                                <div class="form-group">
                                                    <label>Username</label>
                                                    <input type="text" class="form-control" placeholder="Username" size="10" name="Username" value="<%= salesOrderdetails.getDebtorName()%>" disabled="">
                                                </div>
                                            </div>
                                            <div class="col-md-3 pr-1">
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
                                            <div class="col-md-3 pr-1">
                                                <div class="form-group">
                                                    <label>Display Term</label>
                                                    <input type="text" class="form-control" placeholder="Display Term" required placeholder="" value="<%= salesOrderdetails.getDisplayTerm()%>" size="10" name="DisplayTerm" disabled="">                                            
                                                </div>
                                            </div>

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
                                                    <input type="text" class="form-control" placeholder="Order Date" required placeholder="" value="<%= salesOrderdetails.getCreateTimeStamp()%>" size="10" name="Order Date" disabled="">                                            
                                                </div>
                                            </div>

                                            <div class="col-md-3 pr-1">
                                                <div class="form-group">
                                                    <label>Status</label>
                                                    <input type="text" class="form-control" placeholder="Status" required placeholder="" value="<%= salesOrderdetails.getStatus()%>"  size="10" name="Status" disabled="">                                            
                                                </div>
                                            </div>

                                        </div>

                                        <div class="row">
                                            <div class="col-md-4 pr-1">
                                                <div class="form-group">
                                                    <label>Delivery Address </label>
                                                    <input type="text" class="form-control" placeholder="Delivery Address1" size="10" name="Delivery Address1" value="<%= salesOrderdetails.getDeliverAddr1()%>" disabled="">
                                                </div>
                                            </div>
                                            <div class="col-md-4 pr-1">
                                                <div class="form-group">
                                                    <label> </label>
                                                    <input type="text" class="form-control" placeholder="Delivery Address2" required placeholder="" value="<%= salesOrderdetails.getDeliverAddr2()%>" size="10" name="Delivery Address2" disabled="">                                            
                                                </div>
                                            </div>

                                        </div>

                                        <div class="row">
                                            <div class="col-md-4 pr-1">
                                                <div class="form-group">
                                                    <label> </label>
                                                    <input type="text" class="form-control" placeholder="Delivery Address3" size="10" name="Delivery Address3" value="<%= salesOrderdetails.getDeliverAddr3()%>" disabled="">
                                                </div>
                                            </div>
                                            <div class="col-md-4 pr-1">
                                                <div class="form-group">
                                                    <label> </label>
                                                    <input type="text" class="form-control" placeholder="Delivery Address4" required placeholder="" value="<%= salesOrderdetails.getDeliverAddr4()%>" size="10" name="Delivery Address4" disabled="">                                            
                                                </div>
                                            </div>

                                        </div>

                                        <!--draw a line-->
                                        <hr>
                                        <div class="card-body table-full-width table-responsive">
                                            <table class="table table-hover table-striped">
                                                <tbody>


                                                    <%

                                                        double total = 0;
                                                        out.print("<tr>");
                                                        out.print("<thead><th><b>Item Code</b></th>"
                                                                + "<th><b>Picture</b></th>"
                                                                + "<th><b>Quantity</b></th>"
                                                                + "<th><b>Returned Quantity</b></th>"
                                                                + "<th><b>Unit Price</b></th>"
                                                                + "<th><b>Subtotal</b></th></thead>");

                                                        for (Integer number : itemDetailsMap.keySet()) {
                                                            double subtotal = 0;

                                                            ItemDetails itemDetail = itemDetailsMap.get(number);

                                                            double qtyDouble = Double.parseDouble(itemDetail.getQty());
                                                            double unitPriceDouble = Double.parseDouble(itemDetail.getUnitPrice());
                                                            subtotal = qtyDouble * unitPriceDouble;

                                                            out.print("<td>" + itemDetail.getItemCode() + "</td>");
                                                            out.print("<td>" + "" + "</td>");
                                                            out.print("<input type='hidden' size='10' name='itemCode' value='" + itemDetail.getItemCode() + "'>");

                                                            out.print("<td>" + itemDetail.getQty() + "</td>");

                                                            out.print("<td>" + itemDetail.getReturnedQty() + "</td>");

                                                            out.print("<td>" + itemDetail.getUnitPrice() + "</td>");

                                                            out.print("<td>" + subtotal + "</td>");
                                                            out.print("</tr>");

                                                            total += subtotal;
                                                        }

                                                    %>

                                                    <tr><thead><th><b><font color="red">Total Amount</font></b></th></thead>
                                                <td><%= total%></td>
                                                </tr>
                                                <tr>
                                                    <td><br></td> 
                                                </tr>

                                                <%

                                                    double refundedTotal = 0;

                                                    for (Integer number : refundedItemDetailsMap.keySet()) {
                                                        double refundedSubtotal = 0;

                                                        ItemDetails refundedItemDetail = refundedItemDetailsMap.get(number);

                                                        double qtyDouble = Double.parseDouble(refundedItemDetail.getQty());
                                                        double unitPriceDouble = Double.parseDouble(refundedItemDetail.getUnitPrice());
                                                        refundedSubtotal = qtyDouble * unitPriceDouble;

                                                        out.print("<tr><thead><th>Item Code</th></thead>");
                                                        out.print("<td>" + refundedItemDetail.getItemCode() + "</td>");
                                                        out.print("<tr><thead><th>Quantity</th></thead>");
                                                        out.print("<td>" + refundedItemDetail.getQty() + "</td>");
                                                        out.print("<tr><thead><th>Returned Quantity</th></thead>");
                                                        out.print("<td>" + refundedItemDetail.getReturnedQty() + "</td>");
                                                        out.print("<tr><thead><th>Unit Price</th></thead>");
                                                        out.print("<td>" + refundedItemDetail.getUnitPrice() + "</td>");
                                                        out.print("<tr><thead><th>Subtotal</th></thead>");
                                                        out.print("<td>" + refundedSubtotal + "</td>");
                                                        out.print("</tr>");
                                                        out.print("<tr><td><br></td></tr>");

                                                        refundedTotal += refundedSubtotal;
                                                    }

                                                %>

                                                </tbody>
                                            </table>



                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>



                <footer class="footer">
                    <div class="container">
                        <nav>
                            <ul class="footer-menu">
                                <li>
                                    <a href="#">
                                        Home
                                    </a>
                                </li>
                                <li>
                                    <a href="#">
                                        Company
                                    </a>
                                </li>
                                <li>
                                    <a href="#">
                                        Portfolio
                                    </a>
                                </li>
                                <li>
                                    <a href="#">
                                        Blog
                                    </a>
                                </li>
                            </ul>
                            <p class="copyright text-center">
                                This website's content is Copyright 
                                <script>
                                    document.write(new Date().getFullYear())
                                </script>
                                © Lim Kee Food Manufacturing Pte Ltd
                            </p>
                        </nav>
                    </div>
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

</html>