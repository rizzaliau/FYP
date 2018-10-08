<%-- 
    Document   : customerDashboard
    Created on : 26 Aug, 2018, 6:32:35 PM
    Author     : Rizza
--%>


<%@page import="java.text.DecimalFormat"%>
<%@page import="entity.BreakdownItem"%>
<%@page import="utility.adminUtility"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="utility.dashboardUtility"%>
<%@page import="utility.notificationUtility"%>
<%@page import="entity.Notification"%>
<%@page import="java.util.Map"%>
<!DOCTYPE html>

<%--<%@include file="protect.jsp" %>--%>
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
                                out.print("<i class='nc-icon nc-key-25'></i>");
                                out.print("<p>Admin</p>");
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
                                        <h4 class="card-title">Customer Dashboard Management</h4>
                                        <!--commented the tabs for the dashboard
                                        <ul class="tabrow" id="my_selection">
                                                    <li><a href="SalesRevenueDashboard.jsp">Sales</a></li>
                                                    <li><a href="productDashboard.jsp">Product</a></li>
                                                    <li class="selected"><a href="customerDashboard.jsp">Customer</a></li>
                                                </ul>
                                        -->
                                    </div>   
                                    
                                    <div class="card-body ">
                                    <!-- HIDE THE BUTTON FIRST 
                                    <center>    
                                        <a href="dashboard.jsp"><input class="btn btn-info btn-fill pull-center" type="button" name="salesDashboard"  value="Sales" /></a>
                                        <a href="productDashboard.jsp"><input class="btn btn-info btn-fill pull-center" type="button" name="productDashboard"  value="Product"  /></a>
                                        <a href="customerDashboard.jsp"><input class="btn btn-info btn-fill pull-center" type="button" name="customerDashboard"  value="Customer"/></a>
                                    </center>
                                    -->
                                      
                       <!-- Start of Dashboard II charts -->  
                       
                        <%
                            // Resuable variables

                            String currentTimeStamp = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date());
                            String currentMonth = adminUtility.getMonthTimestamp(currentTimeStamp);                                                
                            String currentYear =  adminUtility.getYearTimestamp(currentTimeStamp);
                            int currentMonthInt = Integer.parseInt(currentMonth);
                            int currentYearInt = Integer.parseInt(currentYear);


                        %>
                       
                       
                       <!-- Start of Filter month/year for top 10 Customers -->
                            
                            <form method="post" action="customerDashboard.jsp" name="top10CustomersForm" >
                            
                                <div class="card-body ">
                                    
                                            <%
                                                Map<Integer, Integer> availableSalesOrderYears = dashboardUtility.getAvailableSalesOrderYears();
                                                Map<Integer, String> allMonths = dashboardUtility.getAllMonths();
                                            %>
                                        
                                            <div class="form-group">
                                                    <select id="top10Year" name="top10CustomersMonth" onchange="return setValue();" class="form-control">

                                                        <%
                                                            out.print("<option value='none'>Select Month</option>");
                                                            for (int i = 1; i <= allMonths.size(); i++) {
                                                                String month = allMonths.get(i);
                                                                out.print("<option value='" + i + "'>" + month + "");

                                                            }
                                                        %>

                                                    </select>
                                            </div>
                                        

                                       
                                            <div class="form-group">
                                                <select id="top10Month" name="top10CustomersYear" onchange="return setValue();" class="form-control">

                                                    <%
                                                        out.print("<option value='none'>Select Year</option>");
                                                        for (int i = availableSalesOrderYears.size(); i >= 1; i--) {
                                                            int year = availableSalesOrderYears.get(i);
                                                            out.print("<option value='" + year + "'>" + year + "");

                                                        }
                                                    %>

                                                </select>
                                            </div>
                                      

                                        <input type="hidden" name="dropdown" id="dropdown">
                                        <input type="submit" class="btn btn-info btn-fill pull-left" type="button" value="Filter" name="btn_dropdown" style="position: relative; left:2px;; height: 40px;">
                                    </form>
                            
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
                                        
                                        //Retrieve parameters from form
                                        String yearRetrievedTop10Customers = request.getParameter("top10CustomersYear");
                                        String monthRetrievedTop10Customers = request.getParameter("top10CustomersMonth");

                                        int top10MonthInt = currentMonthInt;

                                        //out.println(yearRetrievedTop10Customers);
                                        //out.println(monthRetrievedTop10Customers);

                                        if (yearRetrievedTop10Customers == null && monthRetrievedTop10Customers == null) {

                                            top10CustomersByYearMonth = dashboardUtility.getTop10CustomersByYearMonth(currentYearInt,currentMonthInt);
                                            allCustomerSalesByYearMonth = dashboardUtility.getAllCustomerSalesByYearMonth(currentYearInt,currentMonthInt);

                                            yearRetrievedTop10Customers = currentYear;

                                        } else if (yearRetrievedTop10Customers.equals("none") && monthRetrievedTop10Customers.equals("none")
                                                || yearRetrievedTop10Customers.equals("none") || monthRetrievedTop10Customers.equals("none")) {

                                            top10CustomersByYearMonth = dashboardUtility.getTop10CustomersByYearMonth(currentYearInt,currentMonthInt);
                                            allCustomerSalesByYearMonth = dashboardUtility.getAllCustomerSalesByYearMonth(currentYearInt,currentMonthInt);

                                            yearRetrievedTop10Customers = currentYear;

                                        } else {
                                            int top10YearInt = Integer.parseInt(yearRetrievedTop10Customers);
                                            top10MonthInt = Integer.parseInt(monthRetrievedTop10Customers);

                                            top10CustomersByYearMonth = dashboardUtility.getTop10CustomersByYearMonth(top10YearInt,top10MonthInt);
                                            allCustomerSalesByYearMonth = dashboardUtility.getAllCustomerSalesByYearMonth(top10YearInt,top10MonthInt);

                                        }

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
                                            text:'Top 10 Customers <%= allMonths.get(top10MonthInt)%> <%= yearRetrievedTop10Customers%> ',
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
                                 <form method="post" action="customerDashboard.jsp" name="customersDoNotMeetRequirementForm" >
                                     <div class="row">
                                         <div class="col-md-5 pr-1">
                                             <div class="form-group">
                                                     <select id="top10Year" name="customersDoNotMeetRequirementMonth" onchange="return setValue();" class="form-control">

                                                         <%
                                                             out.print("<option value='none'>Select Month</option>");
                                                             for (int i = 1; i <= allMonths.size(); i++) {
                                                                 String month = allMonths.get(i);
                                                                 out.print("<option value='" + i + "'>" + month + "");

                                                             }
                                                         %>

                                                     </select>
                                             </div>
                                         </div>

                                         <div class="col-md-5 pr-1">
                                             <div class="form-group">
                                                 <select id="top10Month" name="customersDoNotMeetRequirementYear" onchange="return setValue();" class="form-control">

                                                     <%
                                                         out.print("<option value='none'>Select Year</option>");
                                                         for (int i = availableSalesOrderYears.size(); i >= 1; i--) {
                                                             int year = availableSalesOrderYears.get(i);
                                                             out.print("<option value='" + year + "'>" + year + "");

                                                         }
                                                     %>

                                                 </select>
                                             </div>
                                         </div>

                                         <input type="hidden" name="dropdown" id="dropdown">
                                         <input type="submit" class="btn btn-info btn-fill pull-left" type="button" value="Filter" name="btn_dropdown" style="position: relative; left:2px;; height: 40px;">
                                     </form>
                             </center>
                             <br>
                             
                             <!-- End of Filter month/year for Customers Who Do Not Meet the Requirement Chart -->
                             

                             <!-- Start of Customers Who Do Not Meet the Requirement Chart -->       
                                    
                            <div class="container">
                              <canvas id="customerWhoDoNotMeetRequirement"></canvas>
                            </div> 
                             
                            <% 
                                //Logic for customerWhoDoNotMeetRequirement
                                 
                                 //Map<Integer, String> customersWhoDoNotMeetRequirementByYearMonth = dashboardUtility.getCustomersWhoDoNotMeetRequirementByYearMonth(2017,11);
                                    
                                 //Map<String, Double> allCustomerWhoDoNotMeetRequirementSalesByYearMonth = dashboardUtility.getAllCustomerSalesByYearMonth(2017,11);

                                //Key rank, String customer code
                                
                                Map<Integer, String> customersWhoDoNotMeetRequirementByYearMonth = null;

                                Map<String, Double> allCustomerWhoDoNotMeetRequirementSalesByYearMonth = null;

                                //Retrieve parameters from form
                                String yearRetrievedCustomersDoNotMeetRequirement = request.getParameter("customersDoNotMeetRequirementYear");
                                String monthRetrievedCustomersDoNotMeetRequirement = request.getParameter("customersDoNotMeetRequirementMonth");

                                int customersDoNotMeetRequirementMonthInt = currentMonthInt;

                                //out.println(yearRetrievedTop10Customers);
                                //out.println(monthRetrievedTop10Customers);

                                if (yearRetrievedCustomersDoNotMeetRequirement == null && monthRetrievedCustomersDoNotMeetRequirement == null) {

                                    customersWhoDoNotMeetRequirementByYearMonth = dashboardUtility.getCustomersWhoDoNotMeetRequirementByYearMonth(currentYearInt,currentMonthInt);
                                    allCustomerWhoDoNotMeetRequirementSalesByYearMonth = dashboardUtility.getAllCustomerSalesByYearMonth(currentYearInt,currentMonthInt);

                                    yearRetrievedCustomersDoNotMeetRequirement = currentYear;

                                } else if (yearRetrievedCustomersDoNotMeetRequirement.equals("none") && monthRetrievedCustomersDoNotMeetRequirement.equals("none")
                                        || yearRetrievedCustomersDoNotMeetRequirement.equals("none") || monthRetrievedCustomersDoNotMeetRequirement.equals("none")) {

                                    customersWhoDoNotMeetRequirementByYearMonth = dashboardUtility.getCustomersWhoDoNotMeetRequirementByYearMonth(currentYearInt,currentMonthInt);
                                    allCustomerWhoDoNotMeetRequirementSalesByYearMonth = dashboardUtility.getAllCustomerSalesByYearMonth(currentYearInt,currentMonthInt);

                                    yearRetrievedCustomersDoNotMeetRequirement = currentYear;

                                } else {
                                    
                                    int customersWhoDoNotMeetRequirementYearInt = Integer.parseInt(yearRetrievedCustomersDoNotMeetRequirement);
                                    customersDoNotMeetRequirementMonthInt = Integer.parseInt(monthRetrievedCustomersDoNotMeetRequirement);
                                    //map parameters month, revenue
                                    //hardcoded year to 2018
                                    customersWhoDoNotMeetRequirementByYearMonth = dashboardUtility.getCustomersWhoDoNotMeetRequirementByYearMonth(customersWhoDoNotMeetRequirementYearInt,customersDoNotMeetRequirementMonthInt);
                                    allCustomerWhoDoNotMeetRequirementSalesByYearMonth = dashboardUtility.getAllCustomerSalesByYearMonth(customersWhoDoNotMeetRequirementYearInt,customersDoNotMeetRequirementMonthInt);

                                    //yearRetrievedCustomersDoNotMeetRequirement = "2018";
                                }


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
                                            text:'Customers Do Not Meet Requirements <%= allMonths.get(customersDoNotMeetRequirementMonthInt)%> <%= yearRetrievedCustomersDoNotMeetRequirement%>',
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
                                    
                                    
                                    
                                    
                                    <!-- Start of Filter year/customer for Return Products By Customers Chart -->
                                    
                                    <%
                                        Map<Integer, String> allAvailableCustomers = dashboardUtility.getAllAvailableCustomers();
                                    %>
                                    
                                    
                                    <center>
                                        <form method="post" action="customerDashboard.jsp" name="returnProductsByCustomerForm" >
                                            <div class="row">
                                                <div class="col-md-5 pr-1">
                                                    <div class="form-group">
                                                            <select id="returnProductsByCustomerCustomerCode" name="returnProductsByCustomerCustomerCode" onchange="return setValue();" class="form-control">

                                                                <%
                                                                    out.print("<option value='none'>Select Customer Code</option>");
                                                                    for (int i = 1; i <= allAvailableCustomers.size(); i++) {
                                                                        String customerCode = allAvailableCustomers.get(i);
                                                                        out.print("<option value='" + customerCode + "'>" + customerCode + "");

                                                                    }
                                                                %>

                                                            </select>
                                                    </div>
                                                </div>

                                                <div class="col-md-5 pr-1">
                                                    <div class="form-group">
                                                        <select id="returnProductsByCustomerYear" name="returnProductsByCustomerYear" onchange="return setValue();" class="form-control">

                                                            <%
                                                                out.print("<option value='none'>Select Year</option>");
                                                                for (int i = availableSalesOrderYears.size(); i >= 1; i--) {
                                                                    int year = availableSalesOrderYears.get(i);
                                                                    out.print("<option value='" + year + "'>" + year + "");

                                                                }
                                                            %>

                                                        </select>
                                                    </div>
                                                </div>

                                                <input type="hidden" name="dropdown" id="dropdown">
                                                <input type="submit" class="btn btn-info btn-fill pull-left" type="button" value="Filter" name="btn_dropdown" style="position: relative; left:2px;; height: 40px;">
                                            </form>
                                    </center>
                                    <br>

                                    <!-- End of Filter year/customer for Return Products By Customers Chart -->
                                    
                                    
                                    <!-- Start of Return Products By Customers Chart --> 
                                    
                                    <div class="container">
                                      <canvas id="returnProductsByCustomerChart"></canvas>
                                    </div>   
                                    
                                    
                                    <%
                                        
                                        Map<Integer, Double> returnProductsByCustomerYearBreakdown = dashboardUtility.getReturnProductsByCustomerYearBreakdown(2018,"301-C028");

                                        //Retrieve parameters from form
                                        String yearRetrievedReturnProductsByCustomer = request.getParameter("returnProductsByCustomerYear");
                                        String customerCodeRetrievedReturnProductsByCustomer = request.getParameter("returnProductsByCustomerCustomerCode");
                                        
                                        int customersWhoDoNotMeetRequirementYearInt = currentYearInt;

                                        if (yearRetrievedReturnProductsByCustomer == null && customerCodeRetrievedReturnProductsByCustomer == null) {

                                            returnProductsByCustomerYearBreakdown = dashboardUtility.getReturnProductsByCustomerYearBreakdown(currentYearInt,allAvailableCustomers.get(1));

                                            yearRetrievedReturnProductsByCustomer = currentYear;
                                            
                                            customerCodeRetrievedReturnProductsByCustomer = allAvailableCustomers.get(1);

                                        } else if (yearRetrievedReturnProductsByCustomer.equals("none") && customerCodeRetrievedReturnProductsByCustomer.equals("none")
                                            || yearRetrievedReturnProductsByCustomer.equals("none") || customerCodeRetrievedReturnProductsByCustomer.equals("none")) {

                                            returnProductsByCustomerYearBreakdown = dashboardUtility.getReturnProductsByCustomerYearBreakdown(currentYearInt,allAvailableCustomers.get(1));

                                            yearRetrievedReturnProductsByCustomer = currentYear;
                                            
                                            customerCodeRetrievedReturnProductsByCustomer = allAvailableCustomers.get(1);

                                        } else {

                                            customersWhoDoNotMeetRequirementYearInt = Integer.parseInt(yearRetrievedReturnProductsByCustomer);

                                            returnProductsByCustomerYearBreakdown = dashboardUtility.getReturnProductsByCustomerYearBreakdown(customersWhoDoNotMeetRequirementYearInt,customerCodeRetrievedReturnProductsByCustomer);
                                        }

                                    %>
                                    

                                    <script>
                                      let returnProductsByCustomerChart = document.getElementById('returnProductsByCustomerChart').getContext('2d');

                                      // Global Options
                                      Chart.defaults.global.defaultFontFamily = 'Segoe UI';
                                      Chart.defaults.global.defaultFontSize = 12;
                                      Chart.defaults.global.defaultFontColor = '#777';

                                      let massPopChart6 = new Chart(returnProductsByCustomerChart, {
                                        type:'line', // bar, horizontalBar, pie, line, doughnut, radar, polarArea
                                        data:{
                                          labels:['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
                                            'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'],
                                          datasets:[{
                                            label:'Returned Products By Customers',
                                            data:[
                                              <%= returnProductsByCustomerYearBreakdown.get(1) %>,
                                              <%= returnProductsByCustomerYearBreakdown.get(2) %>,
                                              <%= returnProductsByCustomerYearBreakdown.get(3) %>,
                                              <%= returnProductsByCustomerYearBreakdown.get(4) %>,
                                              <%= returnProductsByCustomerYearBreakdown.get(5) %>,
                                              <%= returnProductsByCustomerYearBreakdown.get(6) %>,
                                              <%= returnProductsByCustomerYearBreakdown.get(7) %>,
                                              <%= returnProductsByCustomerYearBreakdown.get(8) %>,
                                              <%= returnProductsByCustomerYearBreakdown.get(9) %>,
                                              <%= returnProductsByCustomerYearBreakdown.get(10) %>,
                                              <%= returnProductsByCustomerYearBreakdown.get(11) %>,
                                              <%= returnProductsByCustomerYearBreakdown.get(12) %>
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
                                            text:'Returned Products For Customer <%= customerCodeRetrievedReturnProductsByCustomer%> for Year <%= yearRetrievedReturnProductsByCustomer%>',
                                            fontSize:12
                                          },
                                          legend:{
                                            display:true,
                                            position:'bottom',
                                            labels:{
                                              fontColor:'#000'
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
                                    
                                    <!-- Start of Filter month for Return Products By Customers table -->
                                    
                                    
                                    <center>
                                        <form method="post" action="customerDashboard.jsp" name="returnProductsBreakdownByCustomerForm" >
                                            <div class="row">

                                                <div class="col-md-5 pr-1">
                                                    <div class="form-group">
                                                        <select id="returnProductsByCustomerMonth" name="returnProductsBreakdownByCustomerMonth" onchange="return setValue();" class="form-control">

                                                            <%
                                                                out.print("<option value='none'>Select Month</option>");
                                                                for (int i = 1; i <= allMonths.size(); i++) {
                                                                    String month = allMonths.get(i);
                                                                    out.print("<option value='" + i + "'>" + month + "");

                                                                }
                                                            %>

                                                        </select>
                                                    </div>
                                                </div>
                                                            
                                                <div class="col-md-5 pr-1">
                                                    <div class="form-group">
                                                        <select id="returnProductsByCustomerYear" name="returnProductsBreakdownByCustomerYear" onchange="return setValue();" class="form-control">

                                                            <%
                                                                out.print("<option value='none'>Select Year</option>");
                                                                for (int i = availableSalesOrderYears.size(); i >= 1; i--) {
                                                                    int year = availableSalesOrderYears.get(i);
                                                                    out.print("<option value='" + year + "'>" + year + "");

                                                                }
                                                            %>

                                                        </select>
                                                    </div>
                                                </div>                  
                                                            
                                               
                                                
                                                <div class="col-md-5 pr-1">
                                                    <div class="form-group">
                                                            <select id="returnProductsByCustomerCustomerCode" name="returnProductsBreakdownByCustomerCustomerCode" onchange="return setValue();" class="form-control">

                                                                <%
                                                                    out.print("<option value='none'>Select Customer Code</option>");
                                                                    for (int i = 1; i <= allAvailableCustomers.size(); i++) {
                                                                        String customerCode = allAvailableCustomers.get(i);
                                                                        out.print("<option value='" + customerCode + "'>" + customerCode + "");

                                                                    }
                                                                %>

                                                            </select>
                                                    </div>
                                                </div>

       
                                                            
                                                
                                                <input type="hidden" name="dropdown" id="dropdown">
                                                <input type="submit" class="btn btn-info btn-fill pull-left" type="button" value="Filter" name="btn_dropdown" style="position: relative; left:2px;; height: 40px;">
                                            </form>
                                    </center>
                                    <br>

                                    <!-- End of Filter month for Return Products By Customers table -->
                                    
                                    
                                    <!-- Start of return products breakdown table -->
                                    

                                    
                                    <%
                                      String returnProductsBreakdownByCustomerMonth = request.getParameter("returnProductsBreakdownByCustomerMonth");
                                      String returnProductsBreakdownByCustomerYear = request.getParameter("returnProductsBreakdownByCustomerYear");
                                      String returnProductsBreakdownByCustomerCustomerCode = request.getParameter("returnProductsBreakdownByCustomerCustomerCode");
                                      
                                      Map<Integer, BreakdownItem> breakdownProductsMap = null;
                                      int returnProductsBreakdownByCustomerMonthInt = currentMonthInt;
                                      int returnProductsBreakdownByCustomerYearInt = currentYearInt;
                                      
                                      if(returnProductsBreakdownByCustomerMonth==null&&returnProductsBreakdownByCustomerYear==null 
                                            && returnProductsBreakdownByCustomerCustomerCode == null){                            

                                            breakdownProductsMap = dashboardUtility.getBreakdownProductsMap(currentMonthInt,currentYearInt, allAvailableCustomers.get(1));  
                                            returnProductsBreakdownByCustomerCustomerCode=allAvailableCustomers.get(1);
                                            
                                      }else if(returnProductsBreakdownByCustomerMonth.equals("none")&&returnProductsBreakdownByCustomerYear.equals("none") 
                                            && returnProductsBreakdownByCustomerCustomerCode.equals("none")){
                                      
                                            breakdownProductsMap = dashboardUtility.getBreakdownProductsMap(currentMonthInt,currentYearInt, allAvailableCustomers.get(1));  
                                            returnProductsBreakdownByCustomerCustomerCode=allAvailableCustomers.get(1);
                                          
                                      }else{
                                           returnProductsBreakdownByCustomerMonthInt = Integer.parseInt(returnProductsBreakdownByCustomerMonth);
                                           returnProductsBreakdownByCustomerYearInt = Integer.parseInt(returnProductsBreakdownByCustomerYear);
                                        
                                           breakdownProductsMap = dashboardUtility.getBreakdownProductsMap(returnProductsBreakdownByCustomerMonthInt,returnProductsBreakdownByCustomerYearInt, returnProductsBreakdownByCustomerCustomerCode);          
                                      
                                             
                                      }
                                    %>
                                
                                    
                                    <center>
                                        <p class="card-category"><b>Breakdown Of Returned Products For Customer <%= returnProductsBreakdownByCustomerCustomerCode%> for <%= allMonths.get(returnProductsBreakdownByCustomerMonthInt) %> <%= returnProductsBreakdownByCustomerYearInt%></b></p>
                                    </center>
                                    <br>
                                    
                                        <table id="example" class="order-table table table-hover table-striped display" style="width:100%">
                                            <thead>
                                                <tr>
                                                    <th>Item Name</th>
                                                    <th>Quantity</th>
                                                    <th>Returned Quantity</th>
                                                </tr>
                                            </thead>
                                            <tbody>

                                                <%  
                                                    DecimalFormat df = new DecimalFormat("0");
                                                    for (Integer number : breakdownProductsMap.keySet()) {
                                                        out.print("<tr>");
                                                        BreakdownItem breakdownItem = breakdownProductsMap.get(number);
                                                        out.print("<td>" + breakdownItem.getItemName() + "</td>");
                                                        out.print("<td>" + df.format(breakdownItem.getQty()) + "</td>");
                                                        out.print("<td>" + df.format(breakdownItem.getReturnedQty()) + "</td>");
                                                        out.print("</tr>");
                                                    }

                                                %>
                                                
                                            </tbody>
                                        </table>
                                                        
                                                        
                            <!-- End of Dashboard II charts -->                              
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