<%-- 
    Document   : customerDashboard
    Created on : 26 Aug, 2018, 6:32:35 PM
    Author     : Rizza
--%>


<%@page import="utility.dashboardUtility"%>
<%@page import="utility.notificationUtility"%>
<%@page import="entity.Notification"%>
<%@page import="java.util.Map"%>
<!DOCTYPE html>

<%@include file="protect.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

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
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.6.0/Chart.min.js"></script>
    
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
                        <li class='nav-item active'>
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
                                <div class="card striped-tabled-with-hover">
                                    <div class="card-header ">
                                        <h4 class="card-title">Dashboard Management</h4>
                                    </div>   
                                    <br>
                                    <center>    
                                        <a href="dashboard.jsp"><input class="btn btn-info btn-fill pull-center" type="button" name="salesDashboard"  value="Sales" /></a>
                                        <a href="productDashboard.jsp"><input class="btn btn-info btn-fill pull-center" type="button" name="productDashboard"  value="Product"  /></a>
                                        <a href="customerDashboard.jsp"><input class="btn btn-info btn-fill pull-center" type="button" name="customerDashboard"  value="Customer"/></a>
                                    </center>
                                    <br>    

                                    <div class="container">
                                      <canvas id="top10CustomersChart"></canvas>
                                    </div>    
                                    
                                    <%
                                        //map parameters month, revenue
                                        Map<Integer, Double> salesRevenueByMonthMap = dashboardUtility.getSalesRevenueByMonth();

                                    %>    
                                    <center>
                                    <script>
                                      let myChart = document.getElementById('top10CustomersChart').getContext('2d');

                                      // Global Options
                                      Chart.defaults.global.defaultFontFamily = 'Lato';
                                      Chart.defaults.global.defaultFontSize = 18;
                                      Chart.defaults.global.defaultFontColor = '#777';

                                      let massPopChart = new Chart(top10CustomersChart, {
                                        type:'horizontalBar', // bar, horizontalBar, pie, line, doughnut, radar, polarArea
                                        data:{
                                          labels:['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
                                            'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'],
                                          datasets:[{
                                            label:'Sales By Customer ($)',
                                            data:[
                                              <%= salesRevenueByMonthMap.get(1) %>,
                                              <%= salesRevenueByMonthMap.get(2) %>,
                                              <%= salesRevenueByMonthMap.get(3) %>,
                                              <%= salesRevenueByMonthMap.get(4) %>,
                                              <%= salesRevenueByMonthMap.get(5) %>,
                                              <%= salesRevenueByMonthMap.get(6) %>,
                                              <%= salesRevenueByMonthMap.get(7) %>,
                                              <%= salesRevenueByMonthMap.get(8) %>,
                                              <%= salesRevenueByMonthMap.get(9) %>,
                                              <%= salesRevenueByMonthMap.get(10) %>,
                                              <%= salesRevenueByMonthMap.get(11) %>,
                                              <%= salesRevenueByMonthMap.get(12) %>
                                            ],
                                            //backgroundColor:'green',
                                            backgroundColor:[
                                              'rgba(255, 99, 132, 0.6)',
                                              'rgba(54, 162, 235, 0.6)',
                                              'rgba(255, 206, 86, 0.6)',
                                              'rgba(75, 192, 192, 0.6)',
                                              'rgba(153, 102, 255, 0.6)',
                                              'rgba(255, 159, 64, 0.6)',
                                              'rgba(255, 99, 132, 0.6)'
                                            ],
                                            borderWidth:1,
                                            borderColor:'#777',
                                            hoverBorderWidth:3,
                                            hoverBorderColor:'#000'
                                          }]
                                        },
                                        options:{
                                          title:{
                                            display:true,
                                            text:'Top 10 Customers By Month By Year',
                                            fontSize:25
                                          },
                                          legend:{
                                            display:true,
                                            position:'right',
                                            labels:{
                                              fontColor:'#000'
                                            }
                                          },
                                          layout:{
                                            padding:{
                                              left:50,
                                              right:0,
                                              bottom:0,
                                              top:0
                                            }
                                          },
                                          tooltips:{
                                            enabled:true
                                          },
                                          scales: {
                                            yAxes: [{
                                              scaleLabel: {
                                                display: true,
                                                labelString: 'Customer Code'
                                              }
                                            }],

                                            xAxes: [{
                                              scaleLabel: {
                                                display: true,
                                                labelString: 'Sales ($)'
                                              }
                                            }]

                                          } 
                                        }
                                      });
                                      
                                    </script>
                                    </center>
                                    <br>
                                    <br>
                                    
                                    <div class="container">
                                      <canvas id="customerWhoDoNotMeetRequirement"></canvas>
                                    </div> 
                                    
                                    <script>
                                      let customerWhoDoNotMeetRequirement = document.getElementById('customerWhoDoNotMeetRequirement').getContext('2d');

                                      // Global Options
                                      Chart.defaults.global.defaultFontFamily = 'Lato';
                                      Chart.defaults.global.defaultFontSize = 18;
                                      Chart.defaults.global.defaultFontColor = '#777';

                                      let massPopChart2 = new Chart(customerWhoDoNotMeetRequirement, {
                                        type:'horizontalBar', // bar, horizontalBar, pie, line, doughnut, radar, polarArea
                                        data:{
                                          labels:['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
                                            'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'],
                                          datasets:[{
                                            label:'Sales By Customer ($)',
                                            data:[
                                              <%= 0 %>,
                                              <%= 0 %>,
                                              <%= 0 %>,
                                              <%= 0 %>,
                                              <%= 0 %>,
                                              <%= 10 %>,
                                              <%= 0 %>,
                                              <%= 0 %>,
                                              <%= 0 %>,
                                              <%= 0 %>,
                                              <%= 0 %>,
                                              <%= 0 %>
                                            ],
                                            //backgroundColor:'green',
                                            backgroundColor:'green',
                                            borderWidth:1,
                                            borderColor:'#777',
                                            hoverBorderWidth:3,
                                            hoverBorderColor:'#000'
                                          }]
                                        },
                                        options:{
                                          title:{
                                            display:true,
                                            text:'Customers Do Not Meet Requirements By Month',
                                            fontSize:25
                                          },
                                          legend:{
                                            display:true,
                                            position:'right',
                                            labels:{
                                              fontColor:'#000'
                                            }
                                          },
                                          layout:{
                                            padding:{
                                              left:50,
                                              right:0,
                                              bottom:0,
                                              top:0
                                            }
                                          },
                                          tooltips:{
                                            enabled:true
                                          },
                                          scales: {
                                            yAxes: [{
                                              scaleLabel: {
                                                display: true,
                                                labelString: 'Customer Code'
                                              }
                                            }],

                                            xAxes: [{
                                              scaleLabel: {
                                                display: true,
                                                labelString: 'Sales ($)'
                                              }
                                            }]

                                          } 
                                        }
                                      });
                                      
                                    </script>
                                    <br>
                                    <br>
                                    
                                    <div class="container">
                                      <canvas id="returnProductsByCustomerChart"></canvas>
                                    </div>    

                                    <script>
                                      let returnProductsByCustomerChart = document.getElementById('returnProductsByCustomerChart').getContext('2d');

                                      // Global Options
                                      Chart.defaults.global.defaultFontFamily = 'Lato';
                                      Chart.defaults.global.defaultFontSize = 18;
                                      Chart.defaults.global.defaultFontColor = '#777';

                                      let massPopChart3 = new Chart(returnProductsByCustomerChart, {
                                        type:'line', // bar, horizontalBar, pie, line, doughnut, radar, polarArea
                                        data:{
                                          labels:['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
                                            'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'],
                                          datasets:[{
                                            label:'Returned Products By Customers',
                                            data:[
                                              <%= salesRevenueByMonthMap.get(1) %>,
                                              <%= salesRevenueByMonthMap.get(2) %>,
                                              <%= salesRevenueByMonthMap.get(3) %>,
                                              <%= salesRevenueByMonthMap.get(4) %>,
                                              <%= salesRevenueByMonthMap.get(5) %>,
                                              <%= salesRevenueByMonthMap.get(6) %>,
                                              <%= salesRevenueByMonthMap.get(7) %>,
                                              <%= salesRevenueByMonthMap.get(8) %>,
                                              <%= salesRevenueByMonthMap.get(9) %>,
                                              <%= salesRevenueByMonthMap.get(10) %>,
                                              <%= salesRevenueByMonthMap.get(11) %>,
                                              <%= salesRevenueByMonthMap.get(12) %>
                                            ],
                                            //backgroundColor:'green',
                                            backgroundColor:['white'
                                            ],
                                            borderWidth:2,
                                            borderColor:'#FFA500',
                                            hoverBorderWidth:3,
                                            hoverBorderColor:'#000'
                                          }]
                                        },
                                        options:{
                                          title:{
                                            display:true,
                                            text:'Returned Products By Customers By Month',
                                            fontSize:25
                                          },
                                          legend:{
                                            display:true,
                                            position:'right',
                                            labels:{
                                              fontColor:'#000'
                                            }
                                          },
                                          layout:{
                                            padding:{
                                              left:50,
                                              right:0,
                                              bottom:0,
                                              top:0
                                            }
                                          },
                                          tooltips:{
                                            enabled:true
                                          },
                                          scales: {
                                            yAxes: [{
                                              scaleLabel: {
                                                display: true,
                                                labelString: 'Return Quantity'
                                              }
                                            }],

                                            xAxes: [{
                                              scaleLabel: {
                                                display: true,
                                                labelString: 'Month'
                                              }
                                            }]

                                          } 
                                        }
                                      });
                                      
                                    </script>
                                    <br>
                                    <br>
                                    <center>
                                    Breakdown Of Products Return
                                    <br>
                                    Note: Table with Columns Item Name, Original Qty and Returned Qty to be Inserted
                                    </center>
                                    
                                    
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
<script src="assets/js/demo.js"></script>
<!--<script type="text/javascript">
    $(document).ready(function() {
        // Javascript method's body can be found in assets/js/demos.js
        demo.initDashboardPageCharts();

        demo.showNotification();

    });
</script>-->

<script>
$(document).ready(                       
        function() {
            setInterval(function() {
                 $('#notification').load('loyaltyProgramme.jsp #notification'); 
            }, 5000);
        });
</script>

</html>