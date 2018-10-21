<%-- 
    Document   : cancelSalesOrderConfirmation
    Created on : 12 May, 2018, 1:04:11 AM
    Author     : Rizza
--%>


<%@page import="java.text.DecimalFormat"%>
<%@page import="utility.walletUtility"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="utility.notificationUtility"%>
<%@page import="entity.Notification"%>
<%@page import="utility.salesOrderUtility"%>
<%@page import="entity.SalesOrderDetails"%>
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
                                            
                                            String orderID = request.getParameter("orderID");   
                                            String status = request.getParameter("status"); 
                                            String deliveryDate = request.getParameter("deliveryDate"); 
                                            SalesOrderDetails salesOrderdetails = salesOrderUtility.getAllSalesOrderDetails(orderID);
                                            //String statusRetrieved = salesOrderdetails.getStatus();
                                            
                                            String currentModifier = usernameSession;
                                            String currentTimeStamp = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date());
                                            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                                            

                                        %>
            <div class="content">
                <div class="container-fluid">
                    <div class="row">
                        <div class="col-md-11">
                            <div class="card strpied-tabled-with-hover">
                                <div class="card-header ">

                                    <h4 class="card-title">Sales Order Management</h4>
                                    <p class="card-category">Cancel Confirmation</p>
                                    <br>
                                    <p class="card-category"><font color ="red"><h5>Are you sure you want to cancel Order ID <%= orderID %> for <%= salesOrderdetails.getDebtorName()%> ?</h5></font></p>
                                    <font color ="black">Please enter cancel sales order reason:</font>
                                </div>
                                
                                <font color="red"><center>
                                    <%                                
                                        String msgStatus = (String) request.getAttribute("msgStatus");

                                        if (msgStatus != null) {
                                            out.print("</br>");
                                            out.print(msgStatus);
                                            out.print("</br>");
                                        }

                                    %> 
                                    </font></center>
                                    
                            
                                        <form action="cancelSalesOrderController" method="post">
                   
                                            &nbsp;&nbsp;&nbsp;<textarea id ="cancelReasons" rows="10" cols="100" required placeholder="Cancelled Reason" style="height:200px;" pattern="[A-Za-z ]{1,80}" title="Please only enter alphabets" name="cancelledReason" value='Cancelled Reason'></textarea>
                                            
                                            <input type= "hidden" name="orderIDRecordToBeDeleted" value='<%= orderID %>'/>
                                            <input type= "hidden" name="statusRecordToBeDeleted" value='<%= status %>'/>
                                            <input type= "hidden" name="deliveryDateRecordToBeDeleted" value='<%= deliveryDate %>'/>
                                            <input type= "hidden" name="preferredLanguage" value='<%= salesOrderdetails.getPreferredLanguage() %>'/>
                                            <input type="hidden" value="<%= currentTimeStamp %>" name="lastModifiedTimeStamp">
                                            <input type="hidden" value="<%= currentModifier %>" name="lastModifiedBy">
                                            <input type="hidden" value="<%= status %>" name="statusConfirmation">
                                            <p>
                                            <input type="submit" class="btn btn-info btn-fill pull-right" value="Confirm Cancel" style="margin-right: 100px; margin-top: 10px; margin-bottom: 20px; "> 
                                            <a href="salesOrder.jsp"><input class="btn btn-info btn-fill pull-left" type="button" name="Cancel"  value="Back" style="margin-left:15px; margin-top: 10px; margin-bottom: 20px;"/></a>
                                            
                                            <% 
                                                //out.print(status); 
                                                if(status.equals("pendingDelivery")){
                                                    status = "Pending Delivery";
                                                }

                                                DecimalFormat df = new DecimalFormat("0.00");

                                                double salesOrderTotal = walletUtility.findSalesOrderTotal(orderID,status);
                                                //out.print("Sales Order total is"+df.format(salesOrderTotal)); 
                                            %>
                                            
                                            <input type="hidden" value="<%= df.format(salesOrderTotal) %>" name="amountToBeAdded">
                                        </form>   
                                

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
    $(document).ready(function() {
        // Javascript method's body can be found in assets/js/demos.js
        demo.initDashboardPageCharts();

    });
</script>
<script>
$(document).ready(                       
        function() {
            setInterval(function() {
                 $('#notification').load('wallet.jsp #notification'); 
            }, 5000);
        });
</script>

</html>