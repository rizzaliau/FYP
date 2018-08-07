<%-- 
    Document   : userMGMT
    Created on : 12 May, 2018, 1:04:11 AM
    Author     : Rizza
<%@include file="protect.jsp" %>
--%>

<%@page import="entity.OrderItem"%>
<%@page import="utility.salesOrderUtility"%>
<%@page import="entity.SalesOrder"%>
<%@page import="entity.Debtor"%>
<%@page import="java.util.Map"%>
<%@page import="utility.debtorUtility"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css"/>
        <link rel="stylesheet" href="https://cdn.datatables.net/1.10.19/css/jquery.dataTables.min.css"/>     
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
                        <li>
                            <a class="nav-link" href="./salesOrderMGMT.jsp">
                                <i class="nc-icon nc-notes"></i>
                                <p>Sales Order Mgmt</p>
                            </a>
                        </li>
                        <li class="nav-item active">
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
                                        <span class="d-lg-none">Dashboard</span>
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
                                <!--
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
                                -->
                                <li class="nav-item">
                                    <a class="nav-link" href="logout.jsp">
                                        <span class="no-icon">Log out</span>
                                    </a>
                                </li>
                            </ul>
                        </div>
                    </div>
                </nav>

                <%                Map<Integer, OrderItem> catalogueMap = salesOrderUtility.getCatalogueMap();
                %>

                <div class="content">
                    <div class="container-fluid">
                        <div class="row">
                            <div class="col-md-12">
                                <div class="card striped-tabled-with-hover">
                                    <div class="card-header ">

                                        <h4 class="card-title">Catalogue Management</h4>
                                    </div>
                                    <div class="col-md-8"><font color="red">
                                        <%
                                            String msgStatus = (String) request.getAttribute("updateSuccess");
                                            String msgStatus2 = (String) request.getAttribute("status");

                                            if (msgStatus != null) {
                                                out.print("</br>");
                                                out.print(msgStatus);
                                                out.print("</br>");
                                            }

                                            if (msgStatus2 != null) {
                                                out.print("</br>");
                                                out.print(msgStatus2);
                                                out.print("</br>");
                                            }


                                        %> 
                                        </font>
                                    </div>
                                    <div class="col-md-2">
                                        <a href="newCatalogueItem.jsp"><input class="btn btn-info btn-fill pull-right" type="button" name="Add New Item"  value="Add New Item" style="margin-right:20px;" /></a>
                                    </div>
                                    <br>

                                    <div class="card-body table-full-width table-responsive">
                                        <table class="order-table table table-hover table-striped display" id="productList">
                                            <thead>
                                                <tr>
                                                    <th>Item Code</th>
                                                    <th>Image</th>
                                                    <th>Description (ENG)</th>
                                                    <th>Description (中)</th>
                                                    <th>Unit Price($)</th>
                                                    <th>Default Qty</th>
                                                    <th>Qty Multiples</th>
                                                    <th>Action</th>
                                                </tr>                                           
                                            </thead>
                                            <tbody>
                                                <%  
                                                    int count = 0;
                                                    for (Integer number : catalogueMap.keySet()) {
                                                        out.print("<tr>");
                                                        OrderItem orderItem = catalogueMap.get(number);
                                                        //out.print("<td><input type='checkbox' name='recordsToBeDeleted' value='"+ orderItem.getItemCode() +"'></td>");
                                                        //out.println("<td>"+count+"</td>");
                                                        out.print("<td>" + orderItem.getItemCode() + "</td>");
                                                        out.print("<td><img src='" + orderItem.getImageURL() + "' style='width:50px;height:50px;' ></td>");
                                                        out.print("<td class='name'>" + orderItem.getDescription() + "</td>");
                                                        out.print("<td>" + orderItem.getDescriptionChinese() + "</td>");
                                                        out.print("<td>" + orderItem.getUnitPrice() + "</td>");
                                                        out.print("<td>" + orderItem.getDefaultQuantity() + "</td>");
                                                        out.print("<td>" + orderItem.getQuantityMultiples() + "</td>");

                                                        out.print("<td><a href='catalogueEdit.jsp?serial=" + number + "'>Edit/View</a>&nbsp;&nbsp;&nbsp;<a href='deleteCatalogueConfirmation.jsp?itemCode=" + orderItem.getItemCode() + "'>Deactivate</a></td>");
                                                        //out.print("<td ><a href='deleteCatalogueConfirmation.jsp?itemCode="+orderItem.getItemCode()+"'>Deactivate</a></td>");
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
                                                <!--<a href="searchCatalogueItem.jsp"><input class="btn btn-info btn-fill pull-left" type="button" name="search" value="Search" style="margin-left:20px;"/></a>
                                                -->
                                                <!--
                                                <a href="salesOrderMGMT.jsp"><input class="btn btn-info btn-fill pull-right" type="button" name="Catalogue"  value="Sales Order" style="margin:1px;" /></a>
                                                -->
                                                <!--
                                                <img src="assets/img/search_icon.png" style="width:3vw;height:6vh; max-width:50%;height:auto;">
                                                -->
                                            </div>
                                        </div>
                                        <br>
                                        <!--
                                        <input type="submit" class="btn btn-info btn-fill pull-right" value="Delete records"> 
                                        -->
                                        </form>   

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
    <script type="text/javascript">
                                    $(document).ready(function () {
                                        // Javascript method's body can be found in assets/js/demos.js
                                        demo.initDashboardPageCharts();

                                    });
    </script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.js"></script>
    <script src="https://cdn.datatables.net/1.10.19/js/jquery.dataTables.js"></script>
    <script>
                                    $(document).ready(function () {

                                        var dataTable = $('#productList').DataTable({
                                            // "oSearch": {"sSearch": "Active"}
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
</html>