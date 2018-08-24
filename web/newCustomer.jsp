<%-- 
    Document   : userMGMT
    Created on : 12 May, 2018, 1:04:11 AM
    Author     : Rizza
--%>


<%@page import="java.text.SimpleDateFormat"%>
<%@page import="utility.notificationUtility"%>
<%@page import="entity.Notification"%>
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
                                   
                           if(isMasterAdmin.equals("1")){ 
                                out.print("<li>");
                                out.print("<a class='nav-link' href='admin.jsp'>");
                                out.print("<i class='nc-icon nc-key-25'></i>");
                                out.print("<p>Admin</p>");
                                out.print("</a>");
                                out.print("</li>");
                           }
                           
                        %>
                        <li>
                            <a class="nav-link" href="dashboard.jsp">
                                <i class="nc-icon nc-chart-pie-35"></i>
                                <p>Dashboard</p>
                            </a>
                        </li>
                        <li class='nav-item active'>
                            <a class="nav-link" href="customer.jsp">
                                <i class="nc-icon nc-circle-09"></i>
                                <p>Customer</p>
                            </a>
                        </li>
                        <li>
                            <a class="nav-link" href="salesOrder.jsp">
                                <i class="nc-icon nc-notes"></i>
                                <p>Sales Order</p>
                            </a>
                        </li>
                        <li>
                            <a class="nav-link" href="catalogue.jsp">
                                <i class="nc-icon nc-paper-2"></i>
                                <p>Catalogue</p>
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
                                                   //out.println("<div class='notification'>");
                                                   for (int i=1 ; i<=notificationMap.size(); i++){
                                                            if(i<=5){
                                                            Notification notification = notificationMap.get(i);
                                                            out.print("<a class='dropdown-item' href='updateNotification.jsp?orderID="+notification.getOrderID()+"'>" +notification.getDebtorName()+
                                                                    "  placed a new order #"+notification.getOrderID()+" on "+notification.getFormattedCreatedTimeStamp()+"</a>");
                                                            }     
                                                    }
                                                    //out.print("</div>");
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
                                    <center>
                                    <font color="red">
                                        <%
                                            String msgStatus = (String) request.getAttribute("status");

                                            if (msgStatus != null) {
                                                out.print("</br>");
                                                out.print(msgStatus);
                                                out.print("</br>");
                                            }


                                        %> 
                                        </font></center>

                                    <div class="card-body">

                                        <br>
                                        <form method="post" action="newUserController">
                                            
                                            <%
                                                String currentModifier = usernameSession;
                                                String currentTimeStamp = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date());
                                            %>
                                            
                                            <input type="hidden" class="form-control" value="<%= currentModifier %>" name="lastModifiedBy">
                                            <input type="hidden" class="form-control" value="<%= currentTimeStamp %>" name="lastModifiedTimeStamp">
                                            
                                            
                                            <div class="row">
                                                <div class="col-md-3 pr-1">
                                                    <div class="form-group">
                                                        <label>Customer Code*</label>
                                                        <input type="text" class="form-control" required placeholder="Customer Code" required value="301-B050" size="10" name="debtorCode">
                                                    </div>
                                                </div>
                                                <div class="col-md-5 px-1">
                                                    <div class="form-group">
                                                        <label>Company Name*</label>
                                                        <input type="text" class="form-control" required placeholder="Company Name" value="BUGIS VILLAGE HOUSE" size="10" name="companyName" title="Please only enter alphabets">                                            
                                                    </div>
                                                </div>

                                            </div>
                                            <div class="row">
                                                <div class="col-md-5 pr-1">
                                                    <div class="form-group">
                                                        <label>Billing Address*</label>
                                                        <input type="text" class="form-control" required placeholder="Billing Address" value="110 TUAS SOUTH AVENUE 3" size="10" name="inAddr1">
                                                        <br>
                                                        <input type="text" class="form-control" required placeholder="" value="#01-59" size="10" name="invAddr2">
                                                        <br>
                                                        <input type="text" class="form-control" placeholder="" value="SINGAPORE 637369" size="10" name="invAddr3" >
                                                        <br>
                                                        <input type="text" class="form-control" placeholder="" value="" size="10" name="invAddr4d">
                                                    </div>
                                                </div>
                                                <div class="col-md-5 pr-1">
                                                    <div class="form-group">
                                                        <label>Delivery Address*</label>
                                                        <input type="text" class="form-control" required placeholder="Delivery Address" value="110 TUAS SOUTH AVENUE 3" size="10" name="deliverAddr1">
                                                        <br>
                                                        <input type="text" class="form-control" required placeholder="" value="#01-59" size="10" name="deliverAddr2">
                                                        <br>
                                                        <input type="text" class="form-control" placeholder="" value="SINGAPORE 637369" size="10" name="deliverAddr3">
                                                        <br>
                                                        <input type="text" class="form-control" placeholder="" value="" size="10" name="deliverAddr4" >
                                                    </div>
                                                </div>

                                            </div>
                                            <div class="row">
                                                <div class="col-md-6 pr-1">
                                                    <div class="form-group">
                                                        <label>Contact Person*</label>
                                                        <input type="text" class="form-control" required placeholder="Contact Person" pattern="[A-Za-z ]{1,30}" title="Please only enter alphabets" value="Ming" size="10" name="debtorName">                                               
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-md-3 pr-1">
                                                    <div class="form-group">
                                                        <label>Username*</label>
                                                        <input type="text" class="form-control" required placeholder="Username" value="BVEH" size="10" name="companyCode">
                                                    </div>
                                                </div>

                                                <div class="col-md-3 pl-1">
                                                    <div class="form-group">
                                                        <label for = "password">Password*</label>
                                                        <input type="password" minLength="8" required placeholder="min 8 characters" class="form-control" value="12345678" size="10" name="hashPassword">

                                                    </div>
                                                </div>
                                            </div>

                                            <div class="row">
                                                <div class="col-md-3 pr-1">
                                                    <div class="form-group">
                                                        <label>Contact Number</label>
                                                        <input type="text" class="form-control" pattern="[0-9]{8}" title="Please enter 8 digit numbers" required placeholder="Contact Number" value="97214546" size="10" name="deliverContact">
                                                    </div>
                                                </div>
                                                <!-- not required placeholder-->
                                                <div class="col-md-3 px-1">
                                                    <div class="form-group">
                                                        <!-- Not Compulsory -->
                                                        <label>Contact Number 2</label>
                                                        <input type="text" class="form-control" pattern="(^$)|(^\d{8}$)" placeholder="Contact Number 2" value="97224546" size="10" name="deliverContact2">
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
                                                
<!--                                                <div class="col-md-4 pr-1">
                                                    <div class="form-group">
                                                        <label>Payment Term*</label>
                                                        <select name="displayTerm" class="form-control" required >
                                                            <option value="C.O.D">C.O.D</option>
                                                            <option value="1 day">1 day</option>
                                                            <option value="15 days">15 days</option>
                                                            <option value="30 days">30 days</option>
                                                        </select>
                                                    </div>
                                                </div>-->
                                                <input type="hidden" value='C.O.D' name="displayTerm" />
                                                
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
                                                        
                                                <div class="col-md-4 pr-1">
                                                    <div class="form-group">
                                                        <label>Preferred Language*</label>
                                                        <input type="text" class="form-control" required placeholder="" title="Please only enter alphabets" value="English" size="10" name="preferredLanguage">                                                           
                                                    </div>

                                                </div>
                                            
                                            <input class="btn btn-info btn-fill pull-right" type="submit" name="submit"  value="Add New Customer" />
                                            <a href="newCustomer.jsp"><input class="btn btn-info btn-fill pull-left" type="button" name="reset"  value="Reset" /></a>
                                            
                                            
                                            <div class="clearfix"></div>
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
                function() {
                    setInterval(function() {
                         $('#notification').load('loyaltyProgramme.jsp #notification'); 
                    }, 5000);
                });
    </script>
