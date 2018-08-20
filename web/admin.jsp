<%-- 
    Document   : admin.jsp
    Created on : 15 August, 2018, 1:04:11 AM
    Author     : Rizza

--%>


<%@page import="entity.User"%>
<%@page import="utility.adminUtility"%>
<%@page import="entity.Debtor"%>
<%@page import="java.util.Map"%>
<%@page import="utility.debtorUtility"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%--<%@include file="protectAdmin.jsp" %>--%>
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
        <link href="https://maxcdn.bootstrapcdn.com/boot" rel="stylesheet" />
        <link href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/3.5.1/animate.min.css" rel="stylesheet"/>
        <link href="assets/css/light-bootstrap-dashboard.css?v=2.0.1" rel="stylesheet" />
        <!-- CSS Just for demo purpose, don't include it in your project -->
        <link href="assets/css/demo.css" rel="stylesheet" />
        <link rel="stylesheet" href="https://www.w3schools.com/lib/w3-colors-highway.css">
<!--        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css"/>-->
        <link rel="stylesheet" href="https://cdn.datatables.net/1.10.19/css/jquery.dataTables.min.css"/>      
        <style>
            .no-result {
                display:none;
            }
            .sort{
                padding: 8px 10px;
                border: none;
                display: inline-block;
                color: black;
                background-color: transparent;
                text-decoration: none;
                height: 30px;
                font-size: 1.5em;
                outline: none !important;
            }

        </style>
    </head>

    <body>
        <div class="wrapper">
            
            <!-- Sidebar -->
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
                        <%
                           //if(){ 
                                out.print("<li class='nav-item active'>");
                                out.print("<a class='nav-link' href='admin.jsp'>");
                                out.print("<i class='nc-icon nc-key-25'></i>");
                                out.print("<p>Admin</p>");
                                out.print("</a>");
                                out.print("</li>");
                           //}
                           
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
                
                <%                            
                            String usernameSession = (String) session.getAttribute("username");
                %>
                
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
                                <li class="dropdown nav-item">
                                    <a href="#" class="dropdown-toggle nav-link" data-toggle="dropdown">
                                        <i class="nc-icon nc-planet"></i>
                                        <span class="notification">0</span>
                                        <span class="d-lg-none">Notification</span>
                                    </a>
                                    <ul class="dropdown-menu">
<!--                                        <a class="dropdown-item" href="#">New Order 1</a>
                                        <a class="dropdown-item" href="#">New Order 2</a>
                                        <a class="dropdown-item" href="#">New Order 3</a>
                                        <a class="dropdown-item" href="#">New Order 4</a>
                                        <a class="dropdown-item" href="#">New Order 5</a>-->
                                    </ul>
                                </li>
                            </ul>
                            <ul class="navbar-nav ml-auto">
                                    Welcome, <%= usernameSession %> 

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

                <%                
                    Map<Integer, User> adminMap = adminUtility.getAllAdmins();
                %>

                <div class="content">
                    <div class="container-fluid">
                        <div class="row">
                            <div class="col-md-12">
                                <div class="card striped-tabled-with-hover">
                                    <div class="card-header ">
                                        <h4 class="card-title">Admin Management</h4>
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
                                        <div>
                                            <div>
                                            <input hidden id="mytext" type="text" value="All" />    
                                            <select class="example-filter-input" id="3">
                                                <option value="Active">Active</option>
                                                <option value="Inactive">Inactive</option>
                                                <option value="All">All</option>
                                            </select>  
                                            <label>Admins</label>
                                            </div>
                                        </div>
                                    </div>
                                    <a href="newAdmin.jsp"><input class="btn btn-info btn-fill pull-right" type="button" name="Add New Admin"  value="Add New Admin" style="margin-right:20px;" /></a>
                                    <br>
                                    <div class="card-body table-full-width table-responsive" style="margin-right:5px; margin-left: 5px;">
                                        <table id="example" class="order-table table table-hover table-striped display" style="width:100%">
                                            <thead>
                                                <tr>
                                                    <th>Admin ID</th>
                                                    <th>Username</th>
                                                    <th>Is Master Admin</th>
                                                    <th>Status</th>
                                                    <th>Edit/View</th>
                                                </tr>
                                            </thead>
                                            <tbody>

                                                <%      for (Integer number : adminMap.keySet()) {
                                                    
                                                            out.print("<tr>");
                                                            User admin = adminMap.get(number);

                                                            out.print("<td>" + admin.getID() + "</td>");
                                                            out.print("<td>" + admin.getName() + "</td>");
                                                            out.print("<td>" + admin.getIsMasterString() + "</td>");
                                                            //out.print("<td>" + admin.getStatus() + "</td>");
                                                            
                                                            if (admin.getStatus().equals("Active") || admin.getStatus().equals("active")) {
                                                                    out.print("<td><span class='label activeUser'>Active</span></td>");
                                                                } else if (admin.getStatus().equals("Inactive") || admin.getStatus().equals("inactive")) {
                                                                    {
                                                                        out.print("<td><span class='label inactiveUser'>Inactive</span></td>");
                                                                    }
                                                            }
                                                            
                                                            out.print("<td><a href='editAdmin.jsp?serial=" + number + "&status=active'>Edit/View</a></td>");
                                                            out.print("</tr>");

                                                    }

                                                %>
                                            </tbody>
                                        </table>
                                    </div>
                                    <br>
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
    <script  src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
    <!-- Control Center for Light Bootstrap Dashboard: scripts for the example pages etc -->
    <script src="assets/js/light-bootstrap-dashboard.js?v=2.0.1" type="text/javascript"></script>
    <!-- Light Bootstrap Dashboard DEMO methods, don't include it in your project! -->
    <script src="assets/js/demo.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.js"></script>
    <script src="https://cdn.datatables.net/1.10.19/js/jquery.dataTables.js"></script>
    <script>
                                        $(document).ready(function () {

                                            var dataTable = $('#example').DataTable({
                                                // "oSearch": {"sSearch": "Active"}
                                            });
                                            dataTable.columns(3).search("Active", false, false, false).draw();
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

</html>