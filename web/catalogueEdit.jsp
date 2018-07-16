<%-- 
    Document   : userMGMT
    Created on : 12 May, 2018, 1:04:11 AM
    Author     : Rizza
--%>


<%@page import="utility.salesOrderUtility"%>
<%@page import="entity.OrderItem"%>
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

                <%
                    //Map<Integer, Debtor> debtorMap = debtorUtility.getDebtorMap();
                %>

                <div class="content">
                    <div class="container-fluid">
                        <div class="row">
                            <div class="col-md-12">
                                <div class="card strpied-tabled-with-hover">
                                    <div class="card-header ">

                                        <h4 class="card-title">Sales Order Management</h4>
                                        <p class="card-category">Edit Catalogue Item</p>
                                    </div>
                                    <div class="card-body">


                                        <%
                                            //Map<Integer, Debtor> mapUsed = new HashMap<>();
                                            Map<Integer, OrderItem> catalogueMap = salesOrderUtility.getCatalogueMap();
                                            String serial = request.getParameter("serial");
                                            int numInt = Integer.parseInt(serial);

                                            //String status = request.getParameter("status");
//                                        if(status.equals("active")){
//                                            mapUsed = debtorUtility.getDebtorMap();
//                                        }else if(status.equals("inactive")){
//                                            mapUsed = debtorUtility.getInactiveDebtorMap();
//                                        }else if (status.equals("search")){
//                                            mapUsed = (Map<Integer, Debtor>)session.getAttribute("searchMapResults");
//                                        }
                                            OrderItem orderItem = catalogueMap.get(numInt);

                                        %>


                                        <form method="post" action="editCatalogueController">

                                            <div class="row">
                                                <div class="col-md-3 pr-1">
                                                    <div class="form-group">
                                                        <label>Item Code*</label>
                                                        <input type="text" class="form-control" placeholder="Item Code" required="" value="<%= orderItem.getItemCode()%>" size="5" name="itemCode">
                                                    </div>
                                                </div>
                                                <div class="col-md-5 px-1">
                                                    <div class="form-group">
                                                        <label>English Description*</label>
                                                        <input type="text" class="form-control" placeholder="English description" required="" value="<%= orderItem.getDescription()%>" size="20" name="description">                                            
                                                    </div>
                                                </div>

                                            </div>

                                            <div class="row">
                                                <div class="col-md-3 pr-1">
                                                    <div class="form-group">
                                                        <label>Chinese Description*</label>
                                                        <input type="text" class="form-control" placeholder="Chinese Description" required ="" value="<%= orderItem.getDescriptionChinese()%>" size="20" name="descriptionChinese">
                                                    </div>
                                                </div>
                                                <div class="col-md-5 px-1">
                                                    <div class="form-group">
                                                        <label>Retail Price</label>
                                                        <input type="text" class="form-control" placeholder="Retail Price" required="" value="<%= orderItem.getRetailPrice()%>" size="5" name="retailPrice">                                            
                                                    </div>
                                                </div>

                                            </div>



                                            <div class="row">
                                                <div class="col-md-5 pr-1">
                                                    <div class="form-group">
                                                        <label>Image URL*</label>
                                                        <input type="text" class="form-control" placeholder="Image URL" required ="" value="<%= orderItem.getImageURL()%>" size="50" name="imageURL">
                                                    </div>
                                                </div>
                                                <div class="col-md-3 px-1">
                                                    <div class="form-group">
                                                        <label>Default Quantity*</label>
                                                        <input type="text" class="form-control" placeholder="Default Quantity" required="" value="<%= orderItem.getDefaultQuantity()%>" size="5" name="defaultQuantity">                                            
                                                    </div>
                                                </div>
                                                <div class="col-md-3 px-1">
                                                    <div class="form-group">
                                                        <label>Quantity Multiples*</label>
                                                        <input type="text" class="form-control" placeholder="Quantity Multiples" required="" value="<%= orderItem.getQuantityMultiples()%>" size="5" name="quantityMultiples">                                            
                                                    </div>
                                                </div>

                                            </div>

                                            <div class="row">
                                                <div class="col-md-3 pr-1">
                                                    <div class="form-group">
                                                        <label>Unit of Metric</label>
                                                        <input type="text" class="form-control" placeholder="Unit of Metric" required ="" value="<%= orderItem.getUnitOfMetric()%>" size="5" name="unitOfMetric">
                                                    </div>
                                                </div>
                                                <div class="col-md-3 px-1">
                                                    <div class="form-group">
                                                        <label>Unit Price*</label>
                                                        <input type="text" class="form-control" placeholder="Unit Price" required="" value="<%= orderItem.getUnitPrice()%>" size="5" name="unitPrice">                                            
                                                    </div>
                                                </div>

                                            </div>

                                            <input class="btn btn-info btn-fill pull-right" type="submit" name="submit"  value="Update Item Details" style="margin-right:20px;"/>

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