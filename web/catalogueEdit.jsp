<%-- 
    Document   : userMGMT
    Created on : 12 May, 2018, 1:04:11 AM
    Author     : Rizza
--%>


<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="utility.notificationUtility"%>
<%@page import="entity.Notification"%>
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
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="./css/styleUpload.css" rel="stylesheet" media="screen">
        <link href="./css/mobile-style.css" rel="stylesheet" media="screen">
    </head>

    <body>
         <!-- Modal pop up alert -->
        <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel"><font color = "red">*Alert*</font></h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        Your changes will not be saved. Are you sure you want to leave this page?
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-success" data-dismiss="modal"><a href = "catalogueEdit.jsp">Continue</a></button>
                        <button type="button" class="btn btn-danger"><a href = "catalogue.jsp">Leave this page</a></button>
                    </div>
                </div>
            </div>
        </div>
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
                            <a class="nav-link" href="loyaltyProgramme.jsp">
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
                
                <div class="content">
                    <div class="container-fluid">
                        <div class="row">
                            <div class="col-md-12">
                                <div class="card strpied-tabled-with-hover">
                                    <div class="card-header ">

                                        <h4 class="card-title">Catalogue Management</h4>
                                        <p class="card-category">Edit Catalogue Item</p>
                                    </div>
                                    <div class="card-body">


                                        <%

                                            Map<Integer, OrderItem> catalogueMap = salesOrderUtility.getCatalogueMap();
                                            String serial = request.getParameter("serial");
                                            int numInt = Integer.parseInt(serial);

                                            OrderItem orderItem = catalogueMap.get(numInt);

                                        %>


                                        <form method="post" action="editCatalogueController">
                                        <div class="title">
                                            <p><b>Current Image</b></p>
                                        </div>
                                            <center><img src="<%= orderItem.getImageURL()%>" style='width:100px;height:100px;' ></center>
                                        <br>
                                        <br>
                                        <div class="title">
                                             <p>Drop image file to replace current image</p>
                                         </div>
                                        <div class="dropzone">
                                            <div class="info"></div>
                                        </div>
                                        <script type="text/javascript" src="./js/imgur.js"></script>
                                        <script type="text/javascript" src="./js/uploadEdit.js"></script>
                                        <br>
                                        <br>
                                        <div class="row">
                                                
                                            <%                                                
                                                String currentModifier = usernameSession;
                                                String currentTimeStamp = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date());
                                                String lastModifiedTimeStampFormatted = orderItem.getLastModifiedTimeStamp();
                                                if(!orderItem.getLastModifiedTimeStamp().equals("-")){
                                                    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                                                    Date d = sdf.parse(orderItem.getLastModifiedTimeStamp());
                                                    sdf.applyPattern("dd-MM-yyyy HH:mm:ss");
                                                    lastModifiedTimeStampFormatted = sdf.format(d); 
                                                }

                                            %>
                                            
                                               
                                                <div class="col-md-3 pr-1">
                                                    <div class="form-group">
                                                        <label>Item Code*</label>
                                                        <input type="text" class="form-control" placeholder="Item Code" required="" value="<%= orderItem.getItemCode()%>" size="5" disabled="">
                                                        <input type="hidden" class="form-control" value="<%= orderItem.getItemCode()%>" name="itemCode">
                                                    </div>
                                                </div>
                                                 <div class="col-md-3 pr-1">
                                                    <div class="form-group">
                                                        <label>Last Modified By</label>
                                                        <input type="text" class="form-control" placeholder="" required="" value="<%= orderItem.getLastModifiedBy()%>" size="10" disabled="">
                                                        <input type="hidden" class="form-control" value="<%= currentModifier %>" name="lastModifiedBy">
                                                    </div>
                                                </div>
                                                <div class="col-md-3 pr-1">
                                                    <div class="form-group">
                                                        <label>Last Modified Time</label>
                                                        <input type="text" class="form-control" placeholder="" required="" value="<%= lastModifiedTimeStampFormatted%>" size="10" disabled="">
                                                        <input type="hidden" class="form-control" value="<%= currentTimeStamp %>" name="lastModifiedTimeStamp">
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-md-6 pr-1">
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
                                                        <label>Unit Price($)*</label>
                                                        <input type="text" class="form-control" placeholder="Unit Price" required="" value="<%= orderItem.getUnitPrice2DP()%>" size="5" name="unitPrice"> 
                                                                                            
                                                    </div>
                                                </div>

                                            </div>



                                                        <div class="row" style="margin-left: -5px;">

                                                <input type="hidden" class="form-control" value="<%= orderItem.getImageURL()%>" name="imageURL">
                                                <div class="col-md-3 pr-1">
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
                                                        <label>Retail Price($)*</label>
                                                        <input type="text" class="form-control" placeholder="Retail Price" required="" value="<%= orderItem.getRetailPrice2DP()%>" size="5" name="retailPrice">        
                                                        
                                                    </div>
                                                </div>
                                                <div class="col-md-3 px-1">
                                                    <div class="form-group">
                                                        <label>Unit of Metric*</label>
                                                        <input type="text" class="form-control" placeholder="Unit of Metric" required ="" value="<%= orderItem.getUnitOfMetric()%>" size="5" name="unitOfMetric">                                         
                                                    </div>
                                                </div>

                                            </div>

                                            <input class="btn btn-info btn-fill pull-right" type="submit" name="submit"  value="Done"/>
                                            <input class="btn btn-info btn-fill pull-left" type="button" name="Cancel" data-toggle="modal" data-target="#exampleModal"  value="Cancel" style = "margin-right: 10px;"/>
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
                    <!-- Cancel alert pop up -->
                    <script>
                        function cancelFunction() {
                        confirm("Your changes will not be saved. Are you sure you want to continue?");
                        }
                    </script>
                    <script>
                     $('#myModal').on('shown.bs.modal', function () {
                     $('#myInput').trigger('focus')
                     })
                    </script>
                    <script>
                    $(document).ready(                       
                            function() {
                                setInterval(function() {
                                     $('#notification').load('loyaltyProgramme.jsp #notification'); 
                                }, 5000);
                            });
                    </script>

                    </html>