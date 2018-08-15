<%@page import="utility.notificationUtility"%>
<%@page import="entity.Notification"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.Map"%>
<!DOCTYPE html>

<%@include file="protect.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>


<html lang="en">


    <head>
        <meta charset="UTF-8">
        <meta http-equiv="refresh" content="90">
        <link rel="apple-touch-icon" sizes="76x76" href="assets/img/apple-icon.png">
        <link rel="icon" type="image/png" href="assets/img/favicon.ico">
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
        
        <title>Lim Kee Admin Portal </title>
        
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
                        <!--  Welcome-->
                        <%                            
                            String userName = request.getParameter("user");
                            String passWord = request.getParameter("password");
                            //String gender = (String)request.getAttribute("gender");
                            //out.println(userName);

                            String usernameSession = (String) session.getAttribute("username");

                            //out.println(usernameSession);
                            //out.println("Username retrieved from session is:"+usernameSession);

                        %>
                    </div>
                    <ul class="nav">
                        <%
                           boolean isMasterAdmin = false;
                           
                            if(isMasterAdmin == true){ 
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
                        <li>
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
                        <li class="nav-item active">
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
                        <a class="navbar-brand" href="dashboard.jsp"><img src="assets/img/limkee_logo.png" style="margin-right: 10px; width:60px; height:42px;"/>LIM KEE ADMIN PORTAL</a>
                        <button href="" class="navbar-toggler navbar-toggler-right" type="button" data-toggle="collapse" aria-controls="navigation-index" aria-expanded="false" aria-label="Toggle navigation">
                            <span class="navbar-toggler-bar burger-lines"></span>
                            <span class="navbar-toggler-bar burger-lines"></span>
                            <span class="navbar-toggler-bar burger-lines"></span>
                        </button>
                        <div class="collapse navbar-collapse justify-content-end" id="navigation">
                            <ul class="nav navbar-nav mr-auto">
<!--                            <li class="nav-item">
                                    <a href="#" class="nav-link" data-toggle="dropdown">

                                        <span class="d-lg-none">Dashboard</span>
                                    </a>
                                </li>-->

                                <!--<li class="nav-item">
                                    <a class="nav-link" href="logout.jsp">
                                        <span class="no-icon">Log out</span>
                                    </a>
                                </li> -->
                            </ul>
                            <ul class="navbar-nav ml-auto">
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
                                                        out.print("<a class='dropdown-item' href='updateNotification.jsp?orderID="+notification.getOrderID()+"'>" +notification.getDebtorName()+
                                                                "  placed a new order #"+notification.getOrderID()+" on "+notification.getFormattedCreatedTimeStamp()+"</a>");
                                                        }     
                                                }
                                                out.print("<div class='divider'></div>");
                                                out.print("<center><a class='dropdown-item' href='allNotifications.jsp'>View all notifications</a></center>");
                                            %>  

                                        </ul>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="logout.jsp">
                                        <span class="no-icon">Log out</span>
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
                            <div class="col-md-8">
                                <div class="card">
                                    <div class="card-header">
                                        <h4 class="card-title">Change Password</h4>
                                    </div>

                                    <div class="col-md-8"><font color="red">
                                        <%                                     //String passwordErrorMsg = (String) request.getAttribute("diffPassword");
                                            //String passwordUpdate = (String)request.getAttribute("updateSuccess");
                                            String status = (String) request.getAttribute("status");

                                            if (status != null) {
                                                out.print("</br>");
                                                out.print(status);
                                                out.print("</br>");
                                            }


                                        %> 
                                    </div></font>

                                    <div class="card-body">
                                        <form method="post" accept-charset="utf-8" action="changePasswordController" >
                                            <div class="row">
                                                <div class="col-md-5 pr-1">
                                                    <div class="form-group">
                                                        <label>Enter current password</label>
                                                        <input type="password" name="currentPass" class="form-control" required>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-md-5 pr-1">
                                                    <div class="form-group">
                                                        <label>Enter new password</label>
                                                        <input type="password" name="newPass1" class="form-control">
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-md-5 pr-1">
                                                    <div class="form-group">
                                                        <label for="exampleInputEmail1">Confirm new password</label>
                                                        <input type="password" name="newPass2" class="form-control">
                                                    </div>
                                                </div>

                                            </div>
                                            <button type="submit" class="btn btn-info btn-fill pull-right">Change Password</button>
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
            <script type="text/javascript">
                                        $(document).ready(function () {
                                            // Javascript method's body can be found in assets/js/demos.js
                                            demo.initDashboardPageCharts();

                                        });
            </script>

</html>