<%-- 
    Document   : salesOrder
    Created on : 12 May, 2018, 1:04:11 AM
    Author     : Rizza

--%>

<%@page import="utility.notificationUtility"%>
<%@page import="entity.Notification"%>
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
        <link rel="stylesheet" href="https://cdn.datatables.net/1.10.19/css/jquery.dataTables.min.css"/>
        <link rel="stylesheet" href="https://code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css"/>
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

                <%
                    String sourcePage = "current orders";
                    Map<Integer, SalesOrder> salesOrderMap = salesOrderUtility.getAllSalesOrderMap(sourcePage);

                %>

                <div class="content">
                    <div class="container-fluid">
                        <div class="row">
                            <div class="col-md-12">
                                <div class="card striped-tabled-with-hover">
                                    <div class="card-header ">

                                        <h4 class="card-title">Current Orders</h4>


                                        <div class="col-md-12">
                                            <%  String msgStatus = (String) request.getAttribute("updateSuccess");
                                                //String msgStatus2 = (String) request.getAttribute("status");
                                                
                                                String orderStatus = (String) session.getAttribute("orderStatus");

                                                if (msgStatus != null) {
                                                    out.print("</br>");
                                                    out.print("<div class = 'alert alert-danger'><button type = 'button' aria-hidden= 'true' class='close' data-dismiss ='alert'><i class = 'nc-icon nc-simple-remove'></i></button><span>");
                                                    out.print(msgStatus);
                                                    out.print("</span></div>");
                                                }

                                                if (orderStatus != null) {
                                                    out.print("</br>");
                                                    out.print("<div class = 'alert alert-success'><button type = 'button' aria-hidden= 'true' class='close' data-dismiss ='alert'><i class = 'nc-icon nc-simple-remove'></i></button><span>");
                                                    out.print(orderStatus);
                                                    out.print("</span></div>");
                                                    session.removeAttribute("orderStatus");
                                                }
                                            %> 
                                        
                                        <div>
                                            <div style="margin-left:-10px;">
                                                <input hidden id="mytext" type="text" value="Active"  />    
                                                <label>Route(s):</label>
                                                <select class="example-filter-input" id="3" >
                                                    <option value="All">All</option>
                                                    <% for (int i = 1; i < 15; i++) {
                                                            out.println("<option value='" + i + "'>" + i + "</option>");
                                                        }
                                                    %>
                                                </select>  
                                            </div>
                                        </div>
                                    </div>

                                    <form action="invoice.jsp" method="post">                                        
                                        <a href="orderHistory.jsp"><input class="btn btn-info btn-fill pull-right" type="button" name="Order History"  value="Order History" style="margin-right:20px;" /></a>                                        
                                        <input class="btn btn-info btn-fill pull-right" type="submit" name="Print Selected"  value="Print Selected" style="margin-right:20px;" />
                                        <br>
                                        <input readonly="readonly" type="search" id="4" class="example2-search-input datepicker" style="margin-right:15px; margin-left: 15px;">
                                        <div class="card-body table-full-width table-responsive" style="margin-right:10px; margin-left:5px;">

                                            <table id="example2" class="order-table table table-hover table-striped display" style="width:100%">
                                                <thead>
                                                    <tr>
                                                        <th>S/N</th>
                                                        <th>Order ID</th>
                                                        <th>Customer Code</th>
                                                        <th>Route</th>
                                                        <th>Delivery Date</th>
                                                        <th>Status</th>
                                                        <th>Edit/View</th>
                                                        <th>Cancel</th>
                                                        <th>Select <br> All<!-- select all boxes --><input type="checkbox" name="select-all" id="select-all" /></input></th>
                                                    </tr>
                                                </thead>
                                                <tbody>

                                                    <%
                                                        int pendingCount = 1;
                                                        for (Integer number : salesOrderMap.keySet()) {

                                                            SalesOrder salesOrder = salesOrderMap.get(number);
                                                            SalesOrderDetails salesOrderdetails = salesOrderUtility.getAllSalesOrderDetails(salesOrder.getOrderID());

                                                            if (salesOrderdetails.getStatus().equals("Pending Delivery")) {
                                                                out.print("<tr>");
                                                                
                                                                    out.print("<td>" + pendingCount + "</td>");
                                                                    pendingCount++;
                                                                    out.print("<td>" + salesOrder.getOrderID().toString() + "</td>");
                                                                    out.print("<td>" + salesOrder.getDebtorCode() + "</td>");
                                                                    out.print("<td>" + salesOrder.getRouteNumber() + "</td>");

                                                                    SimpleDateFormat sdf2 = new SimpleDateFormat("yyyy-MM-dd");
                                                                    Date d2 = sdf2.parse(salesOrderdetails.getDeliveryDate());
                                                                    sdf2.applyPattern("dd-MM-yyyy");
                                                                    String deliveryDateFormatted = sdf2.format(d2);

                                                                    out.print("<td>" + deliveryDateFormatted + "</td>");

                                                                    String timestamp = salesOrderdetails.getCreateTimeStamp();
                                                                    String orderDate = timestamp.substring(0, timestamp.indexOf(" "));

                                                                    out.print("<td><span class='label inactiveUser'>Pending</span></td>");

                                                                    out.print("<td><a href='salesOrderEdit.jsp?orderID=" + salesOrder.getOrderID() + "&status=" + salesOrderdetails.getStatus() + "'>Edit/View</a></td>");

                                                                    out.print("<td><a href='cancelSalesOrderConfirmation.jsp?orderID=" + salesOrder.getOrderID() + "&status=pendingDelivery&deliveryDate=2018-06-25'>Cancel</a></td>");
                                                                    out.print("<td><input type='checkbox' value='" + salesOrder.getOrderID().toString() + ",pendingDelivery' name='orderInfo'></input>");

                                                                out.print("</tr>");
                                                            }
                                                        }

                                                    %>
                                                </tbody>  
                                            </table>
                                    </form>
                                    <br>                                                
                                </div>
                                <div class="row">
                                    <div class="col-md-2">
                                    </div>
                                     <div class="col-md-4">
                                    </div>
                                    <div class="col-md-2">
                                    </div>
                                    <div class="col-md-2">
                                    </div>
                                    <div class="col-md-2">

                                    </div>
                                </div>
                                <br>
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

                        var dataTable = $('#example2').DataTable({
                            "columns": [
                                null,
                                null,
                                null,
                                null,
                                null,
                                null,
                                null,
                                null,
                                {"orderable": false},
                            ]
                        });

                        $('.example2-search-input').on('keyup click change', function () {
                            var i = $(this).attr('id');  // getting column index
                            var v = $(this).val();  // getting search input value
                            dataTable.columns(i).search(v).draw();

                        });
                        $('.example-filter-input').on('keyup click change', function () {
                            var i = $(this).attr('id');  // getting column index
                            var v = $(this).val();  // getting search input value
                            if (v == 'All') {
                                dataTable.columns(i).search('').draw();
                            } else {
                                dataTable.columns(i).search(v, false, false, false).draw();
                            }


                        });
                        $('.example-search-input').on('keyup click change', function () {
                            var i = $(this).attr('id');  // getting column index
                            var v = $(this).val();  // getting search input value
                            dataTable.columns(i).search(v).draw();

                        });

                        $(".datepicker").datepicker({
                            dateFormat: "dd-mm-yy",
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
                            dataTable.columns(4).search("").draw();
                        });
                    });
</script>

<script>
    $(document).ready(
            function () {
                setInterval(function () {
                    $('#notification').load('wallet.jsp #notification');
                }, 5000);
            });
    $('#select-all').click(function (event) {
        if (this.checked) {
            // Iterate each checkbox
            $(':checkbox').each(function () {
                this.checked = true;
            });
        } else {
            $(':checkbox').each(function () {
                this.checked = false;
            });
        }
    });

</script>


</html>