
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
                            <div class="col-md-7">
                                <div class="card striped-tabled-with-hover">
                                    <div class="card-header ">
                                        <h4 class="card-title">Sales Revenue</h4>
                                                <!--
                                        	 <ul class="tabrow" id="my_selection">
                                                    <li class="selected"><a href="dashboard.jsp">Sales</a></li>
                                                    <li><a href="productDashboard.jsp">Product</a></li>
                                                    <li><a href="customerDashboard.jsp">Customer</a></li>
                                                </ul>
                                                -->
                                    </div>   
                                   
                                    <!-- HIDE THE BUTTON FIRST 
                                    <center>    
                                        <a href="dashboard.jsp"><input class="btn btn-info btn-fill pull-center" type="button" name="salesDashboard"  value="Sales" /></a>
                                        <a href="productDashboard.jsp"><input class="btn btn-info btn-fill pull-center" type="button" name="productDashboard"  value="Product"  /></a>
                                        <a href="customerDashboard.jsp"><input class="btn btn-info btn-fill pull-center" type="button" name="customerDashboard"  value="Customer"/></a>
                                    </center>
                                   -->
                                    <br>    
                                    
                                    <%
                                      Map<Integer, Integer> availableSalesOrderYears = dashboardUtility.getAvailableSalesOrderYears();  
                                    %>
                                    
                                   
                                        <div>
                                            <div class="col-md-4 pr-1">
                                                    <div class="form-group">
                                            <!-- Filter year for total revenue -->
                                            <form method="post" action="dashboard.jsp" name="filterTotalSalesYearForm">
                                                
                                                <select id="filterYear" name="yearTotalRevenue" onchange="return setValue();" class="form-control">
                                                    
                                                    <%
                                                        out.print("<option value='none'>Select Year</option>");
                                                        for (int i = availableSalesOrderYears.size(); i >= 1; i--) {
                                                                int year = availableSalesOrderYears.get(i);
                                                                
                                                                //out.print("<a href='filterSalesDashboard.jsp?year='"+year+"'>"+year+"</a>");
                                                                //out.print("<option value='filterSalesDashboard.jsp?year="+year+"' >"+year+"</option>");
                                                                out.print("<option value='"+year+"'>"+year+"");

                                                        }
                                                    %>

                                                </select>
                                                    
                                                    
                                                <input type="hidden" name="dropdown" id="dropdown">
                                                <input type="submit" value="Filter" name="btn_dropdown">
                                            </form>
                                                    </div>
                                            </div>
                                            
                                            
                                        </div>
                                    
                                    <br>
                                    
                                    <!-- Total Revenue Chart -->
                                    <div class="container">
                                      <canvas id="totalRevenueChart"></canvas>
                                    </div>    
                                    
                                    <%
                                        Map<Integer, Double> salesRevenueByMonthMap = null;
                                        DecimalFormat df = new DecimalFormat("0.00");
                                        
                                        String yearRetrieved = request.getParameter("yearTotalRevenue");
                                        
                                        if(yearRetrieved==null){
                                            salesRevenueByMonthMap = dashboardUtility.getSalesRevenueByMonth(2018);
                                            yearRetrieved = "2018";

                                        }else if(yearRetrieved.equals("none")){                                           
                                            salesRevenueByMonthMap = dashboardUtility.getSalesRevenueByMonth(2018);
                                            yearRetrieved = "2018";
                                                                                   
                                        }else{
                                            int yearInt = Integer.parseInt(yearRetrieved);
                                            //map parameters month, revenue
                                            //hardcoded year to 2018
                                            salesRevenueByMonthMap = dashboardUtility.getSalesRevenueByMonth(yearInt);
         
                                        }
                                    %>    
                                    <center>
                                    <script>
                                      let totalRevenueChart = document.getElementById('totalRevenueChart').getContext('2d');

                                      // Global Options
                                      Chart.defaults.global.defaultFontFamily = 'Segoe UI';
                                      Chart.defaults.global.defaultFontSize = 10;
                                      Chart.defaults.global.defaultFontColor = 'black';

                                      let massPopChart = new Chart(totalRevenueChart, {
                                        type:'line', // bar, horizontalBar, pie, line, doughnut, radar, polarArea
                                        data:{
                                          labels:['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
                                            'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'],
                                          datasets:[{
                                            label:'Total Revenue Sales',
                                            data:[
                                              <%= df.format(salesRevenueByMonthMap.get(1)) %>,
                                              <%= df.format(salesRevenueByMonthMap.get(2)) %>,
                                              <%= df.format(salesRevenueByMonthMap.get(3)) %>,
                                              <%= df.format(salesRevenueByMonthMap.get(4)) %>,
                                              <%= df.format(salesRevenueByMonthMap.get(5)) %>,
                                              <%= df.format(salesRevenueByMonthMap.get(6)) %>,
                                              <%= df.format(salesRevenueByMonthMap.get(7)) %>,
                                              <%= df.format(salesRevenueByMonthMap.get(8)) %>,
                                              <%= df.format(salesRevenueByMonthMap.get(9)) %>,
                                              <%= df.format(salesRevenueByMonthMap.get(10)) %>,
                                              <%= df.format(salesRevenueByMonthMap.get(11)) %>,
                                              <%= df.format(salesRevenueByMonthMap.get(12)) %>
                                            ],
                                            //backgroundColor:'green',
                                            backgroundColor:[
                                              'rgba(245,104,41,100)',
                                              
                                            ],
                                            borderWidth:1,
                                            borderColor:'black',
                                            hoverBorderWidth:3,
                                            hoverBorderColor:'#000'
                                          }]
                                        },
                                        options:{
                                          title:{
                                            display:true,
                                            text:'Total Revenue Monthly Breakdown By Year <%= yearRetrieved %>',
                                            fontSize:12
                                            
                                          },
                                          legend:{
                                            display:true,
                                            position:'right',
                                            labels:{
                                              fontColor:'black'
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
                                                labelString: 'Revenue ($)'
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
                                    </center>
                                    <br>
                                    <br>
                                    
                                </div>
                            </div>

                        <div class="col-md-5">
                            <div class="card ">
                                <div class="card-header ">
                                    <h4 class="card-title">Products</h4>
                                    <p class="card-category">Products Performance</p>
                                </div>
                                <div class="card-body ">
                                    <%
                                      //Map<Integer, Integer> availableSalesOrderYears = dashboardUtility.getAvailableSalesOrderYears(); 

                                      Map<Integer, String> allMonths = dashboardUtility.getAllMonths();
                                    %>   
                                    
                                    
                                    <!-- Filter month/year for top 5 Products -->
                                    <center>
                                        <div>
                                            <div class="col-md-5 pr-1">
                                                    <div class="form-group">
                                            <form method="post" action="dashboard.jsp" name="filterYearForm"  >
                                                <select id="filterYear" name="month" onchange="return setValue();" class="form-control">
                                                    
                                                    <%
                                                        out.print("<option value='none'>Select Month</option>");
                                                        for (int i = 1; i <= allMonths.size(); i++) {
                                                                String month = allMonths.get(i);
                                                                out.print("<option value='"+i+"'>"+month+"");

                                                        }
                                                    %>

                                                </select>
                                                    
                                                <select id="filterYear" name="year" onchange="return setValue();" class="form-control">
                                                    
                                                    <%
                                                        out.print("<option value='none'>Select Year</option>");
                                                        for (int i = availableSalesOrderYears.size(); i >= 1; i--) {
                                                                int year = availableSalesOrderYears.get(i);
                                                                //out.print("<option value='"+year+"'>"+year+"</option>");
                                                                //out.print("<a href='filterSalesDashboard.jsp?year='"+year+"'>"+year+"</a>");
                                                                //out.print("<option value='filterSalesDashboard.jsp?year="+year+"' >"+year+"</option>");
                                                                out.print("<option value='"+year+"'>"+year+"");

                                                        }
                                                    %>

                                                </select>
                                                    
                                                <input type="hidden" name="dropdown" id="dropdown">
                                                <input type="submit" value="Filter" name="btn_dropdown">
                                            </form>
                                                    </div>
                                            </div>
                                            
                                            <label>Month | Year</label>
                                        </div>
                                    </center>
                                    <br>
                                    
                                    <!-- Graph for top 5 Products -->
                                    <div class="container">
                                      <canvas id="getTop5ProductsChart" width="500" height="300"></canvas>
                                    </div>    
                                    
                                    <%
                                      //DecimalFormat df = new DecimalFormat("0.00");
                                      //Map<Integer, String> getTop5ProductsByMonth = dashboardUtility.getTop5ProductsByMonth(6,2018);
                                      
                                      
                                        Map<Integer, String> getTop5ProductsByMonth = null;
                                        Map<String, Integer> qtyForItemDescriptionMonthMap = null;
                                        
                                        //DecimalFormat df = new DecimalFormat("0.00");

                                        String yearRetrievedTop5 = request.getParameter("year");
                                        String monthRetrievedTop5 = request.getParameter("month");
                                        int monthInt = 1;

                                        if(yearRetrievedTop5==null&&monthRetrievedTop5==null){
                                            getTop5ProductsByMonth = dashboardUtility.getTop5ProductsByMonth(1,2018);
                                            qtyForItemDescriptionMonthMap = dashboardUtility.getQtyForItemDescriptionMonth(1,2018);
                                            
                                            //monthRetrievedTop5 = 1;
                                            yearRetrievedTop5 = "2018";
                                        }else if(yearRetrievedTop5.equals("none")&&monthRetrievedTop5.equals("none") 
                                            ||yearRetrievedTop5.equals("none")|| monthRetrievedTop5.equals("none")){
                                            
                                            getTop5ProductsByMonth = dashboardUtility.getTop5ProductsByMonth(1,2018);
                                            qtyForItemDescriptionMonthMap = dashboardUtility.getQtyForItemDescriptionMonth(1,2018);
                                            
                                            yearRetrievedTop5 = "2018";
                                            
                                        }else{
                                            int yearInt = Integer.parseInt(yearRetrievedTop5);
                                            monthInt = Integer.parseInt(monthRetrievedTop5);
                                            //map parameters month, revenue
                                            //hardcoded year to 2018
                                            getTop5ProductsByMonth = dashboardUtility.getTop5ProductsByMonth(monthInt,yearInt);
                                            qtyForItemDescriptionMonthMap = dashboardUtility.getQtyForItemDescriptionMonth(monthInt,yearInt);

                                        }

                                      

                                    %>
                                    <center>
                                    <script>
                                      let getTop5ProductsChart = document.getElementById('getTop5ProductsChart').getContext('2d');

                                      // Global Options
                                      Chart.defaults.global.defaultFontFamily = 'Segoe UI';
                                      Chart.defaults.global.defaultFontSize = 10;
                                      Chart.defaults.global.defaultFontColor = 'black';

                                      let massPopChart2 = new Chart(getTop5ProductsChart, {
                                        type:'pie', // bar, horizontalBar, pie, line, doughnut, radar, polarArea
                                        data:{
                                          labels:[
                                              '<%= getTop5ProductsByMonth.get(1)%>', 
                                              '<%= getTop5ProductsByMonth.get(2)%>', 
                                              '<%= getTop5ProductsByMonth.get(3)%>', 
                                              '<%= getTop5ProductsByMonth.get(4)%>', 
                                              '<%= getTop5ProductsByMonth.get(5)%>'],
                                          datasets:[{
                                            label:'Total Revenue Sales',
                                            data:[
                                              <%= qtyForItemDescriptionMonthMap.get(getTop5ProductsByMonth.get(1)) %>,
                                              <%= qtyForItemDescriptionMonthMap.get(getTop5ProductsByMonth.get(2)) %>,
                                              <%= qtyForItemDescriptionMonthMap.get(getTop5ProductsByMonth.get(3)) %>,
                                              <%= qtyForItemDescriptionMonthMap.get(getTop5ProductsByMonth.get(4)) %>,
                                              <%= qtyForItemDescriptionMonthMap.get(getTop5ProductsByMonth.get(5)) %>
                                            ],
                                            //backgroundColor:'green',
                                            backgroundColor:[
                                              'rgba(245, 104, 41, 1)',
                                              'rgba(14, 61, 89, 1)',
                                              'rgba(135, 166, 28,1)',
                                              'rgba(242, 159, 5, 1)',
                                              'rgba(217, 37, 38, 1)',
                                              'rgba(255, 159, 64, 0.6)',
                                              'rgba(255, 99, 132, 0.6)'
                                            ],
                                            borderWidth:1,
                                            borderColor:'black',
                                            hoverBorderWidth:3,
                                            hoverBorderColor:'black'
                                          }]
                                        },
                                        options:{
                                          title:{
                                            display:true,
                                            text:'Top 5 Products by Volume <%= allMonths.get(monthInt) %> <%= yearRetrievedTop5 %>',
                                            fontSize:12
                                          },
                                          legend:{
                                            display:true,
                                            position:'right',
                                            labels:{
                                              fontColor:'black'
                                              
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
                    <div class="col-md-8">
                            <div class="card ">
                                <div class="card-header ">
                                    <h4 class="card-title">Return Products</h4>
                                    <p class="card-category">24 Hours performance</p>
                                </div>
                                <div class="card-body ">
                                     <!--filter for Top 5 Most returned products -->
                                    <center>
                                        <div>

                                            <form method="post" action="dashboard.jsp" name="filterReturnedProductsForm">
                                                <select id="filterYear" name="monthReturnedProducts" onchange="return setValue();">
                                                    
                                                    <%
                                                        out.print("<option value='none'>Select Month");
                                                        for (int i = 1; i <= allMonths.size(); i++) {
                                                                String month = allMonths.get(i);
                                                                out.print("<option value='"+i+"'>"+month+"");

                                                        }
                                                    %>

                                                </select>
                                                    
                                                <select id="filterMonth" name="yearReturnedProducts" onchange="return setValue();">
                                                    
                                                    <%
                                                        out.print("<option value='none'>Select Year");
                                                        for (int i = availableSalesOrderYears.size(); i >= 1; i--) {
                                                                int year = availableSalesOrderYears.get(i);

                                                                out.print("<option value='"+year+"'>"+year+"");

                                                        }
                                                    %>

                                                </select>
                                                    
                                                <input type="hidden" name="dropdown" id="dropdown">
                                                <input type="submit" value="Filter" name="btn_dropdown">
                                            </form>
                                            
                                            <label>Month | Year</label>
                                        </div>
                                    </center>
                                    <br>                             
                                    <%
                                      // Hardcoded for month 6, june
                                      //Map<Integer, String> getMostReturnedProductsByMonth = dashboardUtility.getMostReturnedProductsByMonth(6,2018);
                                      //Map<String, Double> getMostReturnedProductsByMonthPercentage = dashboardUtility.getReturnedQtyPercentageForItemDescriptionMonth(6,2018);

                                        Map<Integer, String> getMostReturnedProductsByMonth = null;
                                        Map<String, Double> getMostReturnedProductsByMonthPercentage = null;
                                        
                                        //DecimalFormat df = new DecimalFormat("0.00");

                                        String yearProductReturnedRetrieved = request.getParameter("yearReturnedProducts");
                                        String monthProductReturnedRetrieved = request.getParameter("monthReturnedProducts");
                                        int monthReturnedInt = 1;

                                        if(yearProductReturnedRetrieved==null&&monthProductReturnedRetrieved==null){
                                            getMostReturnedProductsByMonth = dashboardUtility.getMostReturnedProductsByMonth(1,2018);
                                            getMostReturnedProductsByMonthPercentage = dashboardUtility.getReturnedQtyPercentageForItemDescriptionMonth(6,2018);
                                            
                                            //monthRetrieved = 1;
                                            yearProductReturnedRetrieved = "2018";
                                            
                                        }else if(yearProductReturnedRetrieved.equals("none")&&monthProductReturnedRetrieved.equals("none") 
                                            ||yearProductReturnedRetrieved.equals("none")|| monthProductReturnedRetrieved.equals("none")){
                                            
                                            getMostReturnedProductsByMonth = dashboardUtility.getMostReturnedProductsByMonth(1,2018);
                                            getMostReturnedProductsByMonthPercentage = dashboardUtility.getReturnedQtyPercentageForItemDescriptionMonth(6,2018);
                                            
                                            yearProductReturnedRetrieved = "2018";
                                            
                                         
                                        }else{
                                            int yearProductReturnedInt = Integer.parseInt(yearProductReturnedRetrieved);
                                            monthReturnedInt = Integer.parseInt(monthProductReturnedRetrieved);

                                            getMostReturnedProductsByMonth = dashboardUtility.getMostReturnedProductsByMonth(monthReturnedInt,yearProductReturnedInt);
                                            getMostReturnedProductsByMonthPercentage = dashboardUtility.getReturnedQtyPercentageForItemDescriptionMonth(monthReturnedInt,yearProductReturnedInt);

                                        }


                                    %>
                                    
                                    
                                    <!--Graph for Top 5 Most returned products -->
                                    <div class="container">
                                      <canvas id="mostReturnedChart"></canvas>
                                    </div> 
                                    
                                    
                                    <script>
                                      let mostReturnedChart = document.getElementById('mostReturnedChart').getContext('2d');

                                      // Global Options
                                      Chart.defaults.global.defaultFontFamily = 'Lato';
                                      Chart.defaults.global.defaultFontSize = 18;
                                      Chart.defaults.global.defaultFontColor = '#777';

                                      let massPopChart3 = new Chart(mostReturnedChart, {
                                        type:'horizontalBar', // bar, horizontalBar, pie, line, doughnut, radar, polarArea
                                        data:{
                                          labels:[
                                              '<%= getMostReturnedProductsByMonth.get(1) %>',
                                              '<%= getMostReturnedProductsByMonth.get(2) %>', 
                                              '<%= getMostReturnedProductsByMonth.get(3) %>', 
                                              '<%= getMostReturnedProductsByMonth.get(4) %>', 
                                              '<%= getMostReturnedProductsByMonth.get(5) %>'],
                                          datasets:[{
                                            label:'% Returned Rate',
                                            data:[
                                              <%= df.format(getMostReturnedProductsByMonthPercentage.get(getMostReturnedProductsByMonth.get(1))) %>,
                                              <%= df.format(getMostReturnedProductsByMonthPercentage.get(getMostReturnedProductsByMonth.get(2))) %>,
                                              <%= df.format(getMostReturnedProductsByMonthPercentage.get(getMostReturnedProductsByMonth.get(3))) %>,
                                              <%= df.format(getMostReturnedProductsByMonthPercentage.get(getMostReturnedProductsByMonth.get(4))) %>,
                                              <%= df.format(getMostReturnedProductsByMonthPercentage.get(getMostReturnedProductsByMonth.get(5))) %>
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
                                            text:'Top 5 Most Returned Products <%= allMonths.get(monthReturnedInt) %> <%= yearProductReturnedRetrieved %>',
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
                                                labelString: 'Item Name'
                                              }
                                            }],

                                            xAxes: [{
                                              scaleLabel: {
                                                display: true,
                                                labelString: 'Return Rate (%)'
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

<!--tabs button jquery script -->
<script>
document.getElementById('my_selection').onchange = function() {
    window.location.href = this.children[this.selectedIndex].getAttribute('href');
}
</script>



</html>