<%-- 
    Document   : catalogue
    Created on : 12 May, 2018, 1:04:11 AM
    Author     : Rizza
<%@include file="protect.jsp" %>
--%>

<%@page import="utility.notificationUtility"%>
<%@page import="entity.Notification"%>
<%@page import="entity.OrderItem"%>
<%@page import="utility.salesOrderUtility"%>
<%@page import="entity.SalesOrder"%>
<%@page import="entity.Debtor"%>
<%@page import="java.util.Map"%>
<%@page import="utility.debtorUtility"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="protect.jsp" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
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
        <link rel="stylesheet" href="https://cdn.datatables.net/1.10.19/css/jquery.dataTables.min.css"/> 

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
                                   
                           if (isMasterAdmin!=null && isMasterAdmin.equals("1")) {
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
                        <li>
                            <a class="nav-link" href="salesOrder.jsp">
                                <img src="assets/img/salesOrder_icon.png"/>
                                <p>Sales Order</p>
                            </a>
                        </li>
                        <li class='nav-item active'>
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
                                                <% Map<Integer, Notification> notificationMap = notificationUtility.getNotificationsMap(); %>
                                                <span class="notification"> <%= notificationMap.size()  %> </span>
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
                                <% String usernameSession = (String) session.getAttribute("username"); %>
                                    Welcome, <%= usernameSession %> 

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

                <%
                    Map<Integer, OrderItem> catalogueMap = salesOrderUtility.getCatalogueMap();
                %>

                <div class="content">
                    <div class="container-fluid">
                        <div class="row">
                            <div class="col-md-12">
                                <div class="card striped-tabled-with-hover">
                                    <div class="card-header ">

                                        <h4 class="card-title">Catalogue Management</h4>
                                    </div>
                                    <div class="col-md-12">
                                        <%
                                            String msgStatus = (String) request.getAttribute("updateSuccess");

                                            String catalogueStatus = (String) session.getAttribute("catalogueStatus");

                                            if (msgStatus != null) {
                                                out.print("</br>");
                                                out.print("<div class = 'alert alert-danger'><button type = 'button' aria-hidden= 'true' class='close' data-dismiss ='alert'><i class = 'nc-icon nc-simple-remove'></i></button><span>");
                                                out.print(msgStatus);
                                                out.print("</span></div>");
                                                 
                                            }

                                            if (catalogueStatus != null) {
                                                out.print("</br>");
                                                out.print("<div class = 'alert alert-success'><button type = 'button' aria-hidden= 'true' class='close' data-dismiss ='alert'><i class = 'nc-icon nc-simple-remove'></i></button><span>");
                                                out.print(catalogueStatus);
                                                out.print("</span></div>");
                                                session.removeAttribute("catalogueStatus");
                                            }


                                        %> 
                                        
                                        <div>
                                            <div>
                                                <input hidden id="mytext" type="text" value="Active" />    
                                                <select class="example-filter-input" id="5">
                                                    <option value="Active">Active</option>
                                                    <option value="Inactive">Inactive</option>
                                                    <option value="All">All</option>
                                                </select>  
                                                <label>Items</label>
                                            </div>
                                        </div>
                                     
                                </div>
                                <div>
                                <a href="newCatalogueItem.jsp"><input class="btn btn-info btn-fill pull-right" type="button" name="Add New Item"  value="Add New Item" style="margin-right:20px;width:150px;" /></a>
                                </div>
                                <br>

                                <div class="card-body table-full-width table-responsive" style="margin-right:5px; margin-left: 5px; margin-bottom: 5px;">
                                    <table class="order-table table table-hover table-striped display" id="productList" style="width: 100%;">
                                        <thead>
                                            <tr>
                                                <th>Item Code</th>
                                                <th>Image</th>
                                                <th>Description (ENG)</th>
                                                <th>Description (中)</th>
                                                <th>Unit Price($)</th>
                                                <th>Status</th>
                                                <th>Edit/View | Deactivate</th>
                                            </tr>                                           
                                        </thead>
                                        <tbody>
                                            <%                                                    
                                                int count = 0;
                                                for (Integer number : catalogueMap.keySet()) {
                                                    out.print("<tr>");
                                                    OrderItem orderItem = catalogueMap.get(number);

                                                    out.print("<td>" + orderItem.getItemCode() + "</td>");
                                                    out.print("<td><img src='" + orderItem.getImageURL() + "' style='width:50px;height:50px;' ></td>");
                                                    out.print("<td class='name'>" + orderItem.getDescription() + "</td>");
                                                    out.print("<td>" + orderItem.getDescriptionChinese() + "</td>");
                                                    out.print("<td>" + orderItem.getUnitPrice2DP() + "</td>");

                                                    if (orderItem.getStatus().equals("Active") || orderItem.getStatus().equals("active")) {
                                                            out.print("<td><span class='label activeUser'>Active</span></td>");
                                                            out.print("<td><a href='catalogueEdit.jsp?serial=" + number + "'>Edit/View</a>&nbsp;&nbsp;&nbsp;<a href='deleteCatalogueConfirmation.jsp?itemCode=" + orderItem.getItemCode() + "'>Deactivate</a></td>");
                                                    }else{
                                                            out.print("<td><span class='label inactiveUser'>Inactive</span></td>");
                                                            out.print("<td><a href='catalogueEdit.jsp?serial=" + number + "'>Edit/View</a>&nbsp;&nbsp;&nbsp;<a href='activateCatalogueConfirmation.jsp?itemCode=" + orderItem.getItemCode() + "'>Activate</a></td>");
                                                    }

                                                    out.print("</tr>");
                                                    count++;
                                                }

                                            %>
                                        </tbody>
                                    </table>
                                    <div class="row">
                                        <div class="col-md-2">

                                        </div>
                                        <div class="col-md-8">

                                        </div>
                                    </div>
                                    <br>
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
<script src="https://code.jquery.com/jquery-3.3.1.js" ></script>
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

<script src="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.js"></script>
<script src="https://cdn.datatables.net/1.10.19/js/jquery.dataTables.js"></script>
<script>
                                $(document).ready(function () {

                                    var dataTable = $('#productList').DataTable({
                                        // "oSearch": {"sSearch": "Active"}
                                    });
                                    dataTable.columns(5).search("Active", false, false, false).draw();
                                    
                                            $('.example-filter-input').on('keyup click change', function () {
                                                var i = $(this).attr('id');  // getting column index
                                                var v = $(this).val();  // getting search input value
                                                if (v == 'All') {
                                                    dataTable.columns(i).search('').draw();
                                                }else{
                                                    dataTable.columns(i).search(v, false, false, false).draw();
                                                }   


                                            });
                                    $('.example-search-input').on('keyup click change', function () {
                                        var i = $(this).attr('id');  // getting column index
                                        var v = $(this).val();  // getting search input value
                                        dataTable.columns(i).search(v).draw();

                                    });

                                    $(".datepicker").datepicker({
                                        dateFormat: "yy-mm-dd",
                                        showOn: "button",
                                        showAnim: 'slideDown',
                                        showButtonPanel: true,
                                        autoSize: true,
                                        buttonImage: "//jqueryui.com/resources/demos/datepicker/images/calendar.gif",
                                        buttonImageOnly: true,
                                        buttonText: "Select date",
                                        closeText: "Clear"
                                    });
                                    $(document).on("click", ".ui-datepicker-close", function () {
                                        $('.datepicker').val("");
                                        dataTable.columns(5).search("").draw();
                                    });
                                });
</script>
<script>
$(document).ready(                       
        function() {
            setInterval(function() {
                 $('#notification').load('accountSettings.jsp #notification'); 
            }, 5000);
        });
</script>
</html>