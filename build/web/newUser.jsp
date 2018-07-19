<%-- 
    Document   : userMGMT
    Created on : 12 May, 2018, 1:04:11 AM
    Author     : Rizza
--%>


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
                        <li class="nav-item active">
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
                    Map<Integer, Debtor> debtorMap = debtorUtility.getDebtorMap();
                %>

                <div class="content">
                    <div class="container-fluid">
                        <div class="row">
                            <div class="col-md-10">
                                <div class="card">
                                    <div class="card-header">
                                        <h4 class="card-title">Customer Management</h4>
                                        <p>
                                         <h5 class="card-title"><font color = "red">Please fill in details below to add new customer</font></h5>
                                         <p>
                                         <p class="card-category"><font color = "red">* denotes required fields</font></p>
                                    </div>
                                    <div class="card-body">

                                        <br>
                                        <form method="post" action="newUserController">
                                            <div class="row">
                                                <div class="col-md-3 pr-1">
                                                    <div class="form-group">
                                                        <label>Customer Code*</label>
                                                        <input type="text" class="form-control" required placeholder="Customer Code" required value="" size="10" name="debtorCode">
                                                    </div>
                                                </div>
                                                <div class="col-md-5 px-1">
                                                    <div class="form-group">
                                                        <label>Company Name*</label>
                                                        <input type="text" class="form-control" required placeholder="Company Name" value="" size="10" name="companyName" pattern="[A-Za-z ]{1,30}" title="Please enter alphabets">                                            
                                                    </div>
                                                </div>

                                            </div>
                                            <div class="row">
                                                <div class="col-md-5 pr-1">
                                                    <div class="form-group">
                                                        <label>Billing Address*</label>
                                                        <input type="text" class="form-control" required placeholder="Billing Address" value="" size="10" name="inAddr1">
                                                        <br>
                                                        <input type="text" class="form-control" required placeholder="" value="" size="10" name="invAddr2">
                                                        <br>
                                                        <input type="text" class="form-control" placeholder="" value="" size="10" name="invAddr3" >
                                                        <br>
                                                        <input type="text" class="form-control" placeholder="" value="" size="10" name="invAddr4d">
                                                    </div>
                                                </div>
                                                <div class="col-md-5 pr-1">
                                                    <div class="form-group">
                                                        <label>Delivery Address*</label>
                                                        <input type="text" class="form-control" required placeholder="Delivery Address" value="" size="10" name="deliverAddr1">
                                                        <br>
                                                        <input type="text" class="form-control" required placeholder="" value="" size="10" name="deliverAddr2">
                                                        <br>
                                                        <input type="text" class="form-control" placeholder="" value="" size="10" name="deliverAddr3">
                                                        <br>
                                                        <input type="text" class="form-control" placeholder="" value="" size="10" name="deliverAddr4" >
                                                    </div>
                                                </div>

                                            </div>
                                            <div class="row">
                                                <div class="col-md-6 pr-1">
                                                    <div class="form-group">
                                                        <label>Contact Person*</label>
                                                        <input type="text" class="form-control" required placeholder="Contact Person" pattern="[A-Za-z ]{1,30}" title="Please enter alphabets" value="" size="10" name="debtorName">                                               
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-md-3 pr-1">
                                                    <div class="form-group">
                                                        <label>Username*</label>
                                                        <input type="text" class="form-control" required placeholder="Username" value="" size="10" name="companyCode">
                                                    </div>
                                                </div>

                                                <div class="col-md-3 pl-1">
                                                    <div class="form-group">
                                                        <label for = "password">Password*</label>
                                                        <input type="password" minLength="8" required placeholder="min 8 characters" class="form-control" value="" size="10" name="hashPassword">

                                                    </div>
                                                </div>
                                            </div>

                                            <div class="row">
                                                <div class="col-md-3 pr-1">
                                                    <div class="form-group">
                                                        <label>Contact Number</label>
                                                        <input type="text" class="form-control"  pattern="[0-9]{8}" title="Please enter numerics" required placeholder="Contact Number" value="" size="10" name="deliverContact">
                                                    </div>
                                                </div>
                                                <!-- not required placeholder-->
                                                <div class="col-md-3 px-1">
                                                    <div class="form-group">
                                                        <label>Contact Number 2</label>
                                                        <input type="text" class="form-control"  pattern="[0-9]{8}" title="Please enter numerics" placeholder="Contact Number 2" value="" size="10" name="deliverContact2">
                                                    </div>
                                                </div>

                                            </div>


                                            <div class="row">
                                                <div class="col-md-4 pr-1">
                                                    <div class="form-group">
                                                        <label>Status*</label>
                                                        <select name="status" class="form-control" required>
                                                            <option value="Active">Active</option>
                                                            <option value="Inactive">Inactive</option>
                                                            <option value="Blacklisted">Blacklisted</option>
                                                        </select>    
                                                    </div>
                                                </div>
                                                <div class="col-md-4 pr-1">
                                                    <div class="form-group">
                                                        <label>Payment Term*</label>
                                                        <select name="displayTerm" class="form-control" required >
                                                            <option value="C.O.D">C.O.D</option>
                                                            <option value="1 day">1 day</option>
                                                            <option value="15 days">15 days</option>
                                                            <option value="30 days">30 days</option>
                                                        </select>
                                                    </div>
                                                </div>
                                                <div class="col-md-4 pr-1">
                                                    <div class="form-group">
                                                        <label>Area*</label>
                                                        <select name="routeNumber" class="form-control" required>
                                                            <%
                                                               for (int i=1;i<=18;i++){
                                                                   out.print("<option value='"+i+"'>"+i+"</option>");
                                                                 }
                                                            %>
                                                        </select>

                                                    </div>
                                                </div>

                                            </div>

                                            <input class="btn btn-info btn-fill pull-right" type="submit" name="submit"  value="Add New User" />
                                            <a href="newUser.jsp"><input class="btn btn-info btn-fill pull-left" type="button" name="reset"  value="Reset" /></a>
                                            
                                            
                                            <div class="clearfix"></div>
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