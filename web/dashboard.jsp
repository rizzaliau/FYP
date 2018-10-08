
<%@page import="utility.adminUtility"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DecimalFormat"%>
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
        <!--tabs for the button-->
        <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
        <link rel='stylesheet' href='css/tabButton.css'/>
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
                        <%  String isMasterAdmin = (String) session.getAttribute("isMaster");

                            if (isMasterAdmin.equals("1")) {
                                out.print("<li>");
                                out.print("<a class='nav-link' href='admin.jsp'>");
                                out.print("<img src='assets/img/masterAdmin_icon.png'/>");
                                out.print("<p>&nbspAdmin</p>");
                                out.print("</a>");
                                out.print("</li>");
                            }

                        %>
                        <li class='nav-item active'>
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
                        <li>
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
                                            <% Map<Integer, Notification> notificationMap = notificationUtility.getNotificationsMap();%>
                                            <span class="notification"> <%= notificationMap.size()%> </span>
                                            <span class="d-lg-none">Notification</span>
                                        </a>
                                        <ul class="dropdown-menu">

                                            <%
                                                //out.println("<div class='notification'>");
                                                for (int i = 1; i <= notificationMap.size(); i++) {
                                                    if (i <= 5) {
                                                        Notification notification = notificationMap.get(i);
                                                        out.print("<a class='dropdown-item' href='updateNotification.jsp?orderID=" + notification.getOrderID() + "'>" + notification.getDebtorName()
                                                                + "  placed a new order #" + notification.getOrderID() + " on " + notification.getFormattedCreatedTimeStamp() + "</a>");
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
                    // Resuable variables
                    Map<Integer, Integer> availableSalesOrderYears = dashboardUtility.getAvailableSalesOrderYears();

                    String currentTimeStamp = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date());
                    String currentMonth = adminUtility.getMonthTimestamp(currentTimeStamp);                                                
                    String currentYear =  adminUtility.getYearTimestamp(currentTimeStamp);
                    int currentMonthInt = Integer.parseInt(currentMonth);
                    int currentYearInt = Integer.parseInt(currentYear);
                    
                    Map<Integer, String> allMonths = dashboardUtility.getAllMonths();
                    
                    //For overview Data
                    Map<Integer, Double> salesRevenueByMonthMapOverview = dashboardUtility.getSalesRevenueByMonth(currentYearInt);
                    Map<Integer, String> top10CustomersByYearMonthOverView = dashboardUtility.getTop10CustomersByYearMonth(currentYearInt,currentMonthInt);
                    Map<Integer, String> getMostReturnedProductsByMonthOverview = dashboardUtility.getMostReturnedProductsByMonth(currentMonthInt, currentYearInt);
                    Map<String, Integer> qtyForItemDescriptionMonthMapOverview = dashboardUtility.getQtyForItemDescriptionMonth(currentMonthInt, currentYearInt);
                    Map<Integer, String> getTop5ProductsByMonthOverview = dashboardUtility.getTop5ProductsByMonth(currentMonthInt, currentYearInt);
                    Map<String, Double> getMostReturnedProductsByMonthPercentageOverview = dashboardUtility.getReturnedQtyPercentageForItemDescriptionMonth(currentMonthInt, currentYearInt);
                    Map<String, Double> allCustomerSalesByYearMonthOverview = dashboardUtility.getAllCustomerSalesByYearMonth(currentYearInt,currentMonthInt);
                %>

                <div class="content">
                    
                    <div class="container-fluid">
                        <div class="row">
                            
                            <!-- Current Month Revenue -->
                            <div class ="col-md-3">
                                
                                <div class="card striped-tabled-with-hover" onclick="window.location = 'dashboard.jsp' ;" onmouseover="" style="cursor: pointer;">
                                    <div class="card-header ">
                                        <h4 class="card-title"><a href="dashboard.jsp"><font color="black">Current Month Revenue</font></a></h4>
                                        <p class="card-category"> <%=allMonths.get(currentMonthInt)%> </p>
                                        <h2 class="card-title"><font color="black"> $<%= salesRevenueByMonthMapOverview.get(currentMonthInt) %> </font></h2>
                                    </div>
                                </div>
                            </div>
                            <!-- Most Returned Product -->
                            <div class ="col-md-3">
                                
                                <div class="card striped-tabled-with-hover" onclick="window.location = 'dashboard.jsp' ;" onmouseover="" style="cursor: pointer;">
                                    <div class="card-header ">
                                        <h4 class="card-title"><a href="dashboard.jsp"><font color="black">Most Returned Product</font></a></h4>
                                        <p class="card-category"> <%= getMostReturnedProductsByMonthOverview.get(1) %></p>
                                        <h2 class="card-title"><font color="black"> <%= getMostReturnedProductsByMonthPercentageOverview.get(getMostReturnedProductsByMonthOverview.get(1)) %> %</font></h2>
                                    </div>
                                </div>
                            </div>
                            <!-- Top Customer -->        
                            <div class ="col-md-3">  
                                <div class="card striped-tabled-with-hover" onclick="window.location = 'dashboard.jsp' ;" onmouseover="" style="cursor: pointer;">
                                    <div class="card-header ">
                                        <h4 class="card-title"><a href="dashboard.jsp"><font color="black">Top Customer </font></a></h4>
                                        <p class="card-category"> Customer Code : <%= top10CustomersByYearMonthOverView.get(1 )%> </p>
                                        <% 
                                            if(allCustomerSalesByYearMonthOverview.get(top10CustomersByYearMonthOverView.get(1)) == null){
                                                out.println("<h2 class='card-title'><font color='black'>$</font></h2>");
                                            }else{
                                                out.println("<h2 class='card-title'><font color='black'>$"+allCustomerSalesByYearMonthOverview.get(top10CustomersByYearMonthOverView.get(1))+"</font></h2>");
                                            }
                                        %>

                                        <br>
                                    </div>
                                </div>
                            </div>
                            <!-- Top Product -->
                            <div class ="col-md-3">
                                
                                <div class="card striped-tabled-with-hover" onclick="window.location = 'dashboard.jsp' ;" onmouseover="" style="cursor: pointer;">
                                    <div class="card-header ">
                                        <h4 class="card-title"><a href="dashboard.jsp"><font color="black">Top Product</font></a></h4>
                                        <p class="card-category"> <%= getTop5ProductsByMonthOverview.get(1) %>  </p>
                                        <h2 class="card-title"><font color="black"> <%= qtyForItemDescriptionMonthMapOverview.get(getTop5ProductsByMonthOverview.get(1)) %> </font></h2>
                                        <br>
                                    </div>
                                </div>
                            </div>

                        </div>
                     </div>
                    
                    <div class="container-fluid">
                        <div class="row">
                            <div class ="col-md-6">
                                
                                <div class="card striped-tabled-with-hover" onclick="window.location = 'SalesRevenueDashboard.jsp' ;" onmouseover="" style="cursor: pointer;">
                                    <div class="card-header ">
                                        <h4 class="card-title"><a href="SalesRevenueDashboard.jsp"><font color="black">Sales Revenue</font></a></h4>
                                        <p class="card-category">Sales Performance</p>
                                      
                                    </div>   

                                    <!-- HIDE THE BUTTON FIRST 
                                    <center>    
                                        <a href="dashboard.jsp"><input class="btn btn-info btn-fill pull-center" type="button" name="salesDashboard"  value="Sales" /></a>
                                        <a href="productDashboard.jsp"><input class="btn btn-info btn-fill pull-center" type="button" name="productDashboard"  value="Product"  /></a>
                                        <a href="customerDashboard.jsp"><input class="btn btn-info btn-fill pull-center" type="button" name="customerDashboard"  value="Customer"/></a>
                                    </center>
                                    -->
                                    <br>    


                                    <div>
                                        <div class="col-md-4 pr-1">
                                        </div>
                                    </div>
                                    

                                    <!-- Total Revenue Chart -->
                                    <div class="container">
                                        <canvas id="totalRevenueChart"></canvas>
                                    </div>    

                                    <%
                                        Map<Integer, Double> salesRevenueByMonthMap = null;
                                        DecimalFormat df = new DecimalFormat("0.00");

                                        salesRevenueByMonthMap = dashboardUtility.getSalesRevenueByMonth(currentYearInt);

                                    %>    
                                    <center>
                                        <script>
                                            let totalRevenueChart = document.getElementById('totalRevenueChart').getContext('2d');

                                            // Global Options
                                            Chart.defaults.global.defaultFontFamily = 'Segoe UI';
                                            Chart.defaults.global.defaultFontSize = 12;
                                            Chart.defaults.global.defaultFontColor = 'black';

                                            let massPopChart = new Chart(totalRevenueChart, {
                                                type: 'line', // bar, horizontalBar, pie, line, doughnut, radar, polarArea
                                                data: {
                                                    labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
                                                        'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'],
                                                        fontFamily: 'Segoe UI',
                                                        fontSize: 12,
                                                    
                                                    datasets: [{
                                                            label: 'Total Revenue Sales',
                                                                fontFamily: 'Segoe UI',
                                                                fontSize: 12,
                                                            data: [
                                                                <%= df.format(salesRevenueByMonthMap.get(1))%>,
                                                                <%= df.format(salesRevenueByMonthMap.get(2))%>,
                                                                <%= df.format(salesRevenueByMonthMap.get(3))%>,
                                                                <%= df.format(salesRevenueByMonthMap.get(4))%>,
                                                                <%= df.format(salesRevenueByMonthMap.get(5))%>,
                                                                <%= df.format(salesRevenueByMonthMap.get(6))%>,
                                                                <%= df.format(salesRevenueByMonthMap.get(7))%>,
                                                                <%= df.format(salesRevenueByMonthMap.get(8))%>,
                                                                <%= df.format(salesRevenueByMonthMap.get(9))%>,
                                                                <%= df.format(salesRevenueByMonthMap.get(10))%>,
                                                                <%= df.format(salesRevenueByMonthMap.get(11))%>,
                                                                <%= df.format(salesRevenueByMonthMap.get(12))%>
                                                            ],
                                                            //backgroundColor:'green',
                                                            backgroundColor: [
                                                                'rgba(245,104,41,100)',
                                                            ],
                                                            borderWidth: 1,
                                                            borderColor: '#777',
                                                            hoverBorderWidth: 3,
                                                            hoverBorderColor: '#000',
                                                            fontFamily: 'Segoe UI',
                                                            fontSize: 12,
                                                        }]
                                                },
                                                options: {
                                                    title: {
                                                        display: true,
                                                        text: 'Total Revenue Monthly Breakdown By Year <%= currentYearInt%>',
                                                        fontSize: 12,
                                                        fontFamily: 'Segoe UI'

                                                    },
                                                    legend: {
                                                        display: true,
                                                        position: 'bottom',
                                                        fontFamily: 'Segoe UI',
                                                        fontSize: 12,
                                                        labels: {
                                                            fontColor: 'black'
                                                            
                                                        }
                                                    },
                                                    layout: {
                                                        padding: {
                                                            left: 0,
                                                            right: 0,
                                                            bottom: 0,
                                                            top: 0
                                                        }
                                                    },
                                                    tooltips: {
                                                        enabled: true,
                                                        fontFamily: 'Segoe UI',
                                                        fontSize: 12
                                                    },
                                                    scales: {
                                                        yAxes: [{
                                                                scaleLabel: {
                                                                    display: true,
                                                                    labelString: 'Revenue ($)',
                                                                    fontSize: 12,
                                                                    fontFamily: 'Segoe UI'
                                                                }
                                                            }],

                                                        xAxes: [{
                                                                scaleLabel: {
                                                                    display: true,
                                                                    labelString: 'Month',
                                                                    fontSize: 12,
                                                                    fontFamily: 'Segoe UI'
                                                                }
                                                            }]

                                                    }
                                                }
                                            });

                                        </script>
                                    </center>
                                    <br>
                                    <br>
                                    <br>
                                </div>
                            </div>

                            <div class="col-md-6">
                                <div class="card" onclick="window.location = 'productDashboard.jsp';" onmouseover="" style="cursor: pointer;">
                                    <div class="card-header ">
                                        <h4 class="card-title"><a href="productDashboard.jsp"><font color="black">Products</font></a></h4>
                                        <p class="card-category">Products Performance</p>
                                    </div>
                                    <div class="card-body ">
                                        <%
                                            //Map<Integer, Integer> availableSalesOrderYears = dashboardUtility.getAvailableSalesOrderYears(); 

                                            
                                        %>   


                                        <!-- Graph for top 5 Products -->
                                        <div class="container">
                                            <canvas id="getTop5ProductsChart" width="500" height="300"></canvas>
                                        </div>    

                                        <%
                                            //DecimalFormat df = new DecimalFormat("0.00");
                                            //Map<Integer, String> getTop5ProductsByMonth = dashboardUtility.getTop5ProductsByMonth(6,2018);
                                            Map<Integer, String> getTop5ProductsByMonth = null;
                                            Map<String, Integer> qtyForItemDescriptionMonthMap = null;

                                            getTop5ProductsByMonth = dashboardUtility.getTop5ProductsByMonth(currentMonthInt, currentYearInt);
                                            qtyForItemDescriptionMonthMap = dashboardUtility.getQtyForItemDescriptionMonth(currentMonthInt, currentYearInt);


                                        %>
                                        <center>
                                            <script>
                                                let getTop5ProductsChart = document.getElementById('getTop5ProductsChart').getContext('2d');

                                                // Global Options
                                                Chart.defaults.global.defaultFontFamily = 'Segoe UI';
                                                Chart.defaults.global.defaultFontSize = 12;
                                                Chart.defaults.global.defaultFontColor = 'black';

                                                let massPopChart2 = new Chart(getTop5ProductsChart, {
                                                    type: 'pie', // bar, horizontalBar, pie, line, doughnut, radar, polarArea
                                                    data: {
                                                        labels: [
                                                            '<%= getTop5ProductsByMonth.get(1)%>',
                                                            '<%= getTop5ProductsByMonth.get(2)%>',
                                                            '<%= getTop5ProductsByMonth.get(3)%>',
                                                            '<%= getTop5ProductsByMonth.get(4)%>',
                                                            '<%= getTop5ProductsByMonth.get(5)%>'],
                                                                fontFamily: 'Segoe UI',
                                                                fontSize: 12,
                                                        datasets: [{
                                                                label: 'Total Revenue Sales',
                                                                fontFamily: 'Segoe UI',
                                                                fontSize: 12,
                                                                data: [
                                                <%= qtyForItemDescriptionMonthMap.get(getTop5ProductsByMonth.get(1))%>,
                                                <%= qtyForItemDescriptionMonthMap.get(getTop5ProductsByMonth.get(2))%>,
                                                <%= qtyForItemDescriptionMonthMap.get(getTop5ProductsByMonth.get(3))%>,
                                                <%= qtyForItemDescriptionMonthMap.get(getTop5ProductsByMonth.get(4))%>,
                                                <%= qtyForItemDescriptionMonthMap.get(getTop5ProductsByMonth.get(5))%>
                                                                ],
                                                                
                                                                //backgroundColor:'green',
                                                                backgroundColor: [
                                                                    'rgba(245, 104, 41, 1)',
                                                                    'rgba(14, 61, 89, 1)',
                                                                    'rgba(135, 166, 28,1)',
                                                                    'rgba(242, 159, 5, 1)',
                                                                    'rgba(217, 37, 38, 1)',
                                                                    'rgba(255, 159, 64, 0.6)',
                                                                    'rgba(255, 99, 132, 0.6)'
                                                                ],
                                                                borderWidth: 1,
                                                                borderColor: '#777',
                                                                hoverBorderWidth: 3,
                                                                hoverBorderColor: '#000',
                                                                fontFamily: 'Segoe UI',
                                                                fontSize: '12'
                                                            }]
                                                    },
                                                    options: {
                                                        title: {
                                                            display: true,
                                                            text: 'Top 5 Products by Volume <%= allMonths.get(currentMonthInt)%> <%= currentYearInt%>',
                                                            fontFamily: 'Segoe UI',
                                                            fontSize: 12,
                                                    
                                                        },
                                                        legend: {
                                                            display: true,
                                                            position: 'bottom',
                                                            fontFamily: 'Segoe UI',
                                                            fontSize: 12,
                                                            
                                                            labels: {
                                                                fontColor: 'black',
                                                                fontFamily: 'Segoe UI',
                                                                fontSize: 12,
                                                            }
                                                        },
                                                        layout: {
                                                            padding: {
                                                                left: 0,
                                                                right: 0,
                                                                bottom: 0,
                                                                top: 0
                                                            }
                                                        },
                                                        tooltips: {
                                                            enabled: true,
                                                            fontFamily: 'Segoe UI',
                                                            fontSize: 12
                                                        }

                                                    }
                                                });

                                            </script>
                                        </center>
                                        <br>
                                        <br>

                                    </div>
                                </div>
                            </div>
                            <div class="col-md-12">
                                <div class="card" onclick="window.location = 'productDashboard.jsp';" onmouseover="" style="cursor: pointer;">
                                    <div class="card-header ">
                                        <h4 class="card-title">Return Products</h4>
                                        <p class="card-category">Return performances</p>
                                    </div>
                                    <div class="card-body ">

                                        <br>                             
                                        <%

                                            Map<Integer, String> getMostReturnedProductsByMonth = null;
                                            Map<String, Double> getMostReturnedProductsByMonthPercentage = null;

                                            getMostReturnedProductsByMonth = dashboardUtility.getMostReturnedProductsByMonth(currentMonthInt, currentYearInt);
                                            getMostReturnedProductsByMonthPercentage = dashboardUtility.getReturnedQtyPercentageForItemDescriptionMonth(currentMonthInt, currentYearInt);

                                        %>


                                        <!--Graph for Top 5 Most returned products -->
                                        <div class="container">
                                            <canvas id="mostReturnedChart"></canvas>
                                        </div> 


                                        <script>
                                            let mostReturnedChart = document.getElementById('mostReturnedChart').getContext('2d');

                                            // Global Options
                                            Chart.defaults.global.defaultFontFamily = 'Segoe UI';
                                            Chart.defaults.global.defaultFontSize = 12;
                                            Chart.defaults.global.defaultFontColor = 'black';

                                            let massPopChart3 = new Chart(mostReturnedChart, {
                                                type: 'horizontalBar', // bar, horizontalBar, pie, line, doughnut, radar, polarArea
                                                data: {
                                                    labels: [
                                                        '<%= getMostReturnedProductsByMonth.get(1)%>',
                                                        '<%= getMostReturnedProductsByMonth.get(2)%>',
                                                        '<%= getMostReturnedProductsByMonth.get(3)%>',
                                                        '<%= getMostReturnedProductsByMonth.get(4)%>',
                                                        '<%= getMostReturnedProductsByMonth.get(5)%>'],
                                                                fontFamily: 'Segoe UI',
                                                                fontSize: 12,
                                                    datasets: [{
                                                            label: '% Returned Rate',
                                                            fontFamily: 'Segoe UI',
                                                            fontSize: 12,
                                                            data: [
                                                                <%= df.format(getMostReturnedProductsByMonthPercentage.get(getMostReturnedProductsByMonth.get(1)))%>,
                                                                <%= df.format(getMostReturnedProductsByMonthPercentage.get(getMostReturnedProductsByMonth.get(2)))%>,
                                                                <%= df.format(getMostReturnedProductsByMonthPercentage.get(getMostReturnedProductsByMonth.get(3)))%>,
                                                                <%= df.format(getMostReturnedProductsByMonthPercentage.get(getMostReturnedProductsByMonth.get(4)))%>,
                                                                <%= df.format(getMostReturnedProductsByMonthPercentage.get(getMostReturnedProductsByMonth.get(5)))%>
                                                            ],
                                                            //backgroundColor:'green',
                                                            backgroundColor: 'rgba(245,104,41,100)',
                                                            borderWidth: 1,
                                                            borderColor: '#777',
                                                            hoverBorderWidth: 3,
                                                            hoverBorderColor: '#000',
                                                            fontFamily: 'Segoe UI',
                                                            fontSize: 12,
                                                        }]
                                                },
                                                options: {
                                                    title: {
                                                        display: true,
                                                        text: 'Top 5 Most Returned Products <%= allMonths.get(currentMonthInt)%> <%= currentYearInt%>',
                                                        fontFamily: 'Segoe UI',
                                                        fontSize: 12,
                                                    },
                                                    legend: {
                                                        display: true,
                                                        position: 'bottom',
                                                        labels: {
                                                            fontColor: 'black',
                                                            fontFamily: 'Segoe UI',
                                                            fontSize: 12,
                                                        }
                                                    },
                                                    layout: {
                                                        padding: {
                                                            left: 0,
                                                            right: 0,
                                                            bottom: 0,
                                                            top: 0
                                                        }
                                                    },
                                                    tooltips: {
                                                        enabled: true,
                                                        fontFamily: 'Segoe UI',
                                                        fontSize: 12,
                                                    },
                                                    scales: {
                                                        yAxes: [{
                                                                scaleLabel: {
                                                                display: true,
                                                                labelString: 'Item Name',
                                                                fontFamily: 'Segoe UI',
                                                                fontSize: 12,
                                                                }
                                                            }],

                                                        xAxes: [{
                                                                scaleLabel: {
                                                                    display: true,
                                                                    labelString: 'Return Rate (%)',
                                                                    fontFamily: 'Segoe UI',
                                                                    fontSize: 12,
                                                                }
                                                            }]

                                                    }
                                                }
                                            });

                                        </script>
                                        <br>
                                    </div>
                                </div>
                            </div>

                       <!-- Start of Dashboard II charts -->  
                       
                       
                       <!-- Start of Filter month/year for top 10 Customers -->
                            
                               <div class="col-md-12">
                                    <div class="card " onclick="window.location = 'customerDashboard.jsp';" onmouseover="" style="cursor: pointer;">
                                <div class="card-header ">
                                </div>
                                <div class="card-body ">
                                        
                                            <div class="form-group">

                                            </div>
                                        

                                       
                                            <div class="form-group">

                                            </div>
                                      
                                </div>
                            <br>
                         <!-- End of Filter month/year for top 10 Customers -->
                                        
                         <!-- Chart for top 10 Customers -->    
                       
                            <div class="container">
                                <canvas id="top10CustomersChart"></canvas>
                            </div> 
                            <br>
                                    
                                    <%
                                        //Key rank, String customer code
                                        Map<Integer, String> top10CustomersByYearMonth = null;                           
                                        Map<String, Double> allCustomerSalesByYearMonth = null;
                                        
                                        top10CustomersByYearMonth = dashboardUtility.getTop10CustomersByYearMonth(currentYearInt,currentMonthInt);
                                        allCustomerSalesByYearMonth = dashboardUtility.getAllCustomerSalesByYearMonth(currentYearInt,currentMonthInt);

                                    %>    
                                    <center>
                                    <script>
                                      let myChart = document.getElementById('top10CustomersChart').getContext('2d');

                                      // Global Options
                                      Chart.defaults.global.defaultFontFamily = 'Segoe UI';
                                      Chart.defaults.global.defaultFontSize = 12;
                                      Chart.defaults.global.defaultFontColor = 'black';

                                      let massPopChart4 = new Chart(top10CustomersChart, {
                                        type:'horizontalBar', // bar, horizontalBar, pie, line, doughnut, radar, polarArea
                                        data:{
                                          labels:['<%= top10CustomersByYearMonth.get(1) %>',
                                                  '<%= top10CustomersByYearMonth.get(2) %>', 
                                                  '<%= top10CustomersByYearMonth.get(3) %>',
                                                  '<%= top10CustomersByYearMonth.get(4) %>',
                                                  '<%= top10CustomersByYearMonth.get(5) %>',
                                                  '<%= top10CustomersByYearMonth.get(6) %>',
                                                  '<%= top10CustomersByYearMonth.get(7) %>',
                                                  '<%= top10CustomersByYearMonth.get(8) %>',
                                                  '<%= top10CustomersByYearMonth.get(9) %>', 
                                                  '<%= top10CustomersByYearMonth.get(10)%>'],
                                                                fontFamily: 'Segoe UI',
                                                                fontSize: 12,
                                          datasets:[{
                                            label:'Sales By Customer ($)',
                                            data:[
                                              <%= allCustomerSalesByYearMonth.get(top10CustomersByYearMonth.get(1)) %>,
                                              <%= allCustomerSalesByYearMonth.get(top10CustomersByYearMonth.get(2)) %>,
                                              <%= allCustomerSalesByYearMonth.get(top10CustomersByYearMonth.get(3)) %>,
                                              <%= allCustomerSalesByYearMonth.get(top10CustomersByYearMonth.get(4)) %>,
                                              <%= allCustomerSalesByYearMonth.get(top10CustomersByYearMonth.get(5)) %>,
                                              <%= allCustomerSalesByYearMonth.get(top10CustomersByYearMonth.get(6)) %>,
                                              <%= allCustomerSalesByYearMonth.get(top10CustomersByYearMonth.get(7)) %>,
                                              <%= allCustomerSalesByYearMonth.get(top10CustomersByYearMonth.get(8)) %>,
                                              <%= allCustomerSalesByYearMonth.get(top10CustomersByYearMonth.get(9)) %>,
                                              <%= allCustomerSalesByYearMonth.get(top10CustomersByYearMonth.get(10)) %>
                                            ],
                                                                fontFamily: 'Segoe UI',
                                                                fontSize: 12,
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
                                            hoverBorderColor:'#000',
                                            fontFamily: 'Segoe UI',
                                            fontSize: 12,
                                          }]
                                        },
                                        options:{
                                          title:{
                                            display:true,
                                            text:'Top 10 Customers <%= allMonths.get(currentMonthInt)%> <%= currentYearInt %> ',
                                            fontFamily: 'Segoe UI',
                                            fontSize: 12,
                                            
                                          },
                                          legend:{
                                            display:true,
                                            position:'bottom',
                                            fontFamily: 'Segoe UI',
                                            fontSize: 12,
                                            labels:{
                                              fontColor:'#000',
                                              fontFamily: 'Segoe UI',
                                              fontSize: 12,
                                            }
                                          },
                                          layout:{
                                            padding:{
                                              left:0,
                                              right:0,
                                              bottom:0,
                                              top:0
                                            }
                                          },
                                          tooltips:{
                                            enabled:true,
                                            fontFamily: 'Segoe UI',
                                            fontSize: 12,
                                          },
                                          scales: {
                                            yAxes: [{
                                              scaleLabel: {
                                                display: true,
                                                labelString: 'Customer Code',
                                                fontFamily: 'Segoe UI',
                                                fontSize: 12,
                                              }
                                            }],

                                            xAxes: [{
                                              scaleLabel: {
                                                display: true,
                                                labelString: 'Sales ($)',
                                                fontFamily: 'Segoe UI',
                                                fontSize: 12,
                                              }
                                            }]

                                          } 
                                        }
                                      });
                                      
                                    </script>
                                    </center>
                                    <br>

                        
                                    
           
                        <!-- Start of Filter month/year for Customers Who Do Not Meet the Requirement Chart -->
                             <center>
                                     <div class="row">
                                         <div class="col-md-5 pr-1">

                                         </div>

                                         <div class="col-md-5 pr-1">

                                         </div>

                             </center>
                             <br>
                             
                             <!-- End of Filter month/year for Customers Who Do Not Meet the Requirement Chart -->
                             

                             <!-- Start of Customers Who Do Not Meet the Requirement Chart -->       
                                    
                            <div class="container">
                              <canvas id="customerWhoDoNotMeetRequirement"></canvas>
                            </div> 
                             
                            <% 
                                
                                Map<Integer, String> customersWhoDoNotMeetRequirementByYearMonth = null;

                                Map<String, Double> allCustomerWhoDoNotMeetRequirementSalesByYearMonth = null;

                                customersWhoDoNotMeetRequirementByYearMonth = dashboardUtility.getCustomersWhoDoNotMeetRequirementByYearMonth(currentYearInt,currentMonthInt);
                                allCustomerWhoDoNotMeetRequirementSalesByYearMonth = dashboardUtility.getAllCustomerSalesByYearMonth(currentYearInt,currentMonthInt);
                                
                            %>

                                    <script>
                                      let customerWhoDoNotMeetRequirement = document.getElementById('customerWhoDoNotMeetRequirement').getContext('2d');
                                      // Global Options
                                      Chart.defaults.global.defaultFontFamily = 'Segoe UI';
                                      Chart.defaults.global.defaultFontSize = 12;
                                      Chart.defaults.global.defaultFontColor = 'black';

                                      let massPopChart5 = new Chart(customerWhoDoNotMeetRequirement, {
                                        type:'horizontalBar', // bar, horizontalBar, pie, line, doughnut, radar, polarArea
                                        data:{
                                            labels:['<%= customersWhoDoNotMeetRequirementByYearMonth.get(1) %>', 
                                                    '<%= customersWhoDoNotMeetRequirementByYearMonth.get(2) %>',
                                                    '<%= customersWhoDoNotMeetRequirementByYearMonth.get(3) %>', 
                                                    '<%= customersWhoDoNotMeetRequirementByYearMonth.get(4) %>', 
                                                    '<%= customersWhoDoNotMeetRequirementByYearMonth.get(5) %>', 
                                                    '<%= customersWhoDoNotMeetRequirementByYearMonth.get(6) %>',
                                                    '<%= customersWhoDoNotMeetRequirementByYearMonth.get(7) %>', 
                                                    '<%= customersWhoDoNotMeetRequirementByYearMonth.get(8) %>', 
                                                    '<%= customersWhoDoNotMeetRequirementByYearMonth.get(9) %>', 
                                                    '<%= customersWhoDoNotMeetRequirementByYearMonth.get(10) %>'],
                                            fontFamily: 'Segoe UI',
                                            fontSize: 12,
                                            datasets:[{
                                            label:'Sales By Customer ($)',
                                            data:[
                                              <%= allCustomerWhoDoNotMeetRequirementSalesByYearMonth.get(customersWhoDoNotMeetRequirementByYearMonth.get(1)) %>,
                                              <%= allCustomerWhoDoNotMeetRequirementSalesByYearMonth.get(customersWhoDoNotMeetRequirementByYearMonth.get(2)) %>,
                                              <%= allCustomerWhoDoNotMeetRequirementSalesByYearMonth.get(customersWhoDoNotMeetRequirementByYearMonth.get(3)) %>,
                                              <%= allCustomerWhoDoNotMeetRequirementSalesByYearMonth.get(customersWhoDoNotMeetRequirementByYearMonth.get(4)) %>,
                                              <%= allCustomerWhoDoNotMeetRequirementSalesByYearMonth.get(customersWhoDoNotMeetRequirementByYearMonth.get(5)) %>,
                                              <%= allCustomerWhoDoNotMeetRequirementSalesByYearMonth.get(customersWhoDoNotMeetRequirementByYearMonth.get(6)) %>,
                                              <%= allCustomerWhoDoNotMeetRequirementSalesByYearMonth.get(customersWhoDoNotMeetRequirementByYearMonth.get(7)) %>,
                                              <%= allCustomerWhoDoNotMeetRequirementSalesByYearMonth.get(customersWhoDoNotMeetRequirementByYearMonth.get(8)) %>,
                                              <%= allCustomerWhoDoNotMeetRequirementSalesByYearMonth.get(customersWhoDoNotMeetRequirementByYearMonth.get(9)) %>,
                                              <%= allCustomerWhoDoNotMeetRequirementSalesByYearMonth.get(customersWhoDoNotMeetRequirementByYearMonth.get(10)) %>
                                            ],
                                            //backgroundColor:'green',
                                            backgroundColor:'green',
                                            borderWidth:1,
                                            borderColor:'#777',
                                            hoverBorderWidth:3,
                                            hoverBorderColor:'#000',
                                            fontFamily: 'Segoe UI',
                                            fontSize: 12,
                                          }]
                                        },
                                        options:{
                                          title:{
                                            display:true,
                                            text:'Customers Do Not Meet Requirements <%= allMonths.get(currentMonthInt)%> <%= currentYearInt %>',
                                            fontSize:12,
                                            fontFamily: 'Segoe UI',

                                          },
                                          legend:{
                                            display:true,
                                            position:'bottom',
                                            fontFamily: 'Segoe UI',
                                            fontSize: 12,
                                            
                                            labels:{
                                              fontColor:'#000',
                                              fontFamily: 'Segoe UI',
                                              fontSize: 12,
                                            }
                                          },
                                          layout:{
                                            padding:{
                                              left:0,
                                              right:0,
                                              bottom:0,
                                              top:0
                                            }
                                          },
                                          tooltips:{
                                            enabled:true,
                                            fontFamily: 'Segoe UI',
                                            fontSize: 12
                                          },
                                          scales: {
                                            yAxes: [{
                                              scaleLabel: {
                                                display: true,
                                                labelString: 'Customer Code',
                                                fontFamily: 'Segoe UI',
                                                fontSize: 12
                                              }
                                            }],

                                            xAxes: [{
                                              scaleLabel: {
                                                display: true,
                                                labelString: 'Sales ($)',
                                                fontFamily: 'Segoe UI',
                                                fontSize: 12
                                              }
                                            }]

                                          } 
                                        }
                                      });
                                      
                                    </script>
                                    <br>
                                    <br>
                                    
                                    <!-- End of Customers Who Do Not Meet the Requirement Chart -->  
                                                                       
                                    </div>
                                </div>
                            </div>      
                                                        
                                                        
                            <!-- End of Dashboard II charts -->                              
                           
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
                                            function () {
                                                setInterval(function () {
                                                    $('#notification').load('loyaltyProgramme.jsp #notification');
                                                }, 5000);
                                            });
    </script>

    <!--tabs button jquery script -->
    <script>
        document.getElementById('my_selection').onchange = function () {
            window.location.href = this.children[this.selectedIndex].getAttribute('href');
        }
    </script>



</html>