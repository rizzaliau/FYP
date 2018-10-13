<%-- 
    Document   : edit
    Created on : 12 May, 2018, 1:04:11 AM
    Author     : Rizza
<%@include file="protect.jsp" %>
--%>


<%@page import="utility.dashboardUtility"%>
<%@page import="utility.adminUtility"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="utility.notificationUtility"%>
<%@page import="entity.Notification"%>
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

                            if (isMasterAdmin.equals("1")) {
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
                        <li class='nav-item active'>
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


                <div class="content">
                    <div class="container-fluid">
                        <div class="row">
                            <div class="col-md-11">
                                <div class="card">
                                    <div class="card-header">
                                        <h4 class="card-title">Customer Management</h4>

                                        <p class="card-category">Customer Details</p>
                                    </div>
                                    <div class="card-body">



                                        <%
                                            Map<Integer, Debtor> mapUsed = new HashMap<>();

                                            String num = request.getParameter("serial");
                                            int numInt = Integer.parseInt(num);

                                            String status = request.getParameter("status");

                                            if (status.equals("active")) {
                                                mapUsed = debtorUtility.getDebtorMap();
                                            } else if (status.equals("inactive")) {
                                                mapUsed = debtorUtility.getInactiveDebtorMap();
                                            } else if (status.equals("search")) {
                                                mapUsed = (Map<Integer, Debtor>) session.getAttribute("searchMapResults");
                                            }

                                            Debtor debtor = mapUsed.get(numInt);

                                        %>


                                        <form method="post" action="editController">


                                            <%                                                    String currentModifier = usernameSession;
                                                String currentTimeStamp = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date());

                                                SimpleDateFormat sdf2 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                                                String lastModifiedTimeStampFormatted = "";

                                                if (!(debtor.getLastModifiedTimeStamp() == null || debtor.getLastModifiedTimeStamp().equals("-") || debtor.getLastModifiedTimeStamp().equals(""))) {
                                                    Date d2 = sdf2.parse(debtor.getLastModifiedTimeStamp());
                                                    sdf2.applyPattern("dd-MM-yyyy HH:mm:ss");
                                                    lastModifiedTimeStampFormatted = sdf2.format(d2);
                                                } else {
                                                    lastModifiedTimeStampFormatted = "-";
                                                }

                                                String lastModifiedBy = debtor.getLastModifiedBy();
                                                if (lastModifiedBy.equals("")) {
                                                    lastModifiedBy = "-";
                                                }

                                                // Alert for customer who do not meet the requirements for the past three months starting from the current month
                                                String currentMonth = adminUtility.getMonthTimestamp(currentTimeStamp);
                                                String currentYear = adminUtility.getYearTimestamp(currentTimeStamp);
                                                int currentMonthInt = Integer.parseInt(currentMonth);
                                                int currentYearInt = Integer.parseInt(currentYear);

                                                if (currentMonthInt == 1) {
                                                    currentMonthInt = 13;
                                                }

                                                Map<Integer, String> allMonths = dashboardUtility.getAllMonths();
                                                Map<Integer, String> customersWhoDoNotMeetRequirementByYearMonth1 = dashboardUtility.getCustomersWhoDoNotMeetRequirementByYearMonth(currentYearInt, currentMonthInt - 1);
                                                Map<Integer, String> customersWhoDoNotMeetRequirementByYearMonth2 = dashboardUtility.getCustomersWhoDoNotMeetRequirementByYearMonth(currentYearInt, currentMonthInt - 2);
                                                Map<Integer, String> customersWhoDoNotMeetRequirementByYearMonth3 = dashboardUtility.getCustomersWhoDoNotMeetRequirementByYearMonth(currentYearInt, currentMonthInt - 3);

                                                String customersWhoDoNotMeetRequirementAlertMessage = "<div class = 'alert alert-danger'><button type = 'button' aria-hidden= 'true' class='close' data-dismiss ='alert'><i class = 'nc-icon nc-simple-remove'></i></button><span>"
                                                        + "ALERT: Customer " + debtor.getDebtorName() + " did not meet the requirements in  ";

                                                int countDoNotMeetRequirements = 0;

                                                for (Integer number : customersWhoDoNotMeetRequirementByYearMonth1.keySet()) {
                                                    if (debtor.getDebtorCode().equals(customersWhoDoNotMeetRequirementByYearMonth1.get(number))) {

                                                        customersWhoDoNotMeetRequirementAlertMessage += allMonths.get(currentMonthInt - 1);
                                                        countDoNotMeetRequirements++;

                                                    }
                                                }

                                                for (Integer number : customersWhoDoNotMeetRequirementByYearMonth2.keySet()) {
                                                    if (debtor.getDebtorCode().equals(customersWhoDoNotMeetRequirementByYearMonth2.get(number))) {

                                                        if (countDoNotMeetRequirements == 1) {
                                                            customersWhoDoNotMeetRequirementAlertMessage += ", " + allMonths.get(currentMonthInt - 2);
                                                        } else {
                                                            customersWhoDoNotMeetRequirementAlertMessage += allMonths.get(currentMonthInt - 2);
                                                            countDoNotMeetRequirements++;
                                                        }
                                                    }
                                                }

                                                for (Integer number : customersWhoDoNotMeetRequirementByYearMonth3.keySet()) {
                                                    if (debtor.getDebtorCode().equals(customersWhoDoNotMeetRequirementByYearMonth3.get(number))) {

                                                        if (countDoNotMeetRequirements == 1) {
                                                            customersWhoDoNotMeetRequirementAlertMessage += ", " + allMonths.get(currentMonthInt - 3);
                                                            countDoNotMeetRequirements++;

                                                        } else {
                                                            customersWhoDoNotMeetRequirementAlertMessage += " and " + allMonths.get(currentMonthInt - 3);
                                                            countDoNotMeetRequirements++;
                                                        }
                                                    }
                                                }

                                                customersWhoDoNotMeetRequirementAlertMessage += " " + currentYearInt + "</span></div>";

                                                if (countDoNotMeetRequirements > 0) {
                                                    //Final message of customersWhoDoNotMeetRequirementAlertMessage printed if they they do not meet
                                                    //requirements
                                                    out.println(customersWhoDoNotMeetRequirementAlertMessage);
                                                }

                                            %>    

                                            <div class="row">
                                                <div class="col-md-3 pr-1">
                                                    <div class="form-group">
                                                        <label>Customer Code*</label>
                                                        <input type="text" class="form-control" value="<%= debtor.getDebtorCode()%>" size="10" disabled>
                                                        <input type="hidden" value="<%= debtor.getDebtorCode()%>" name="debtorCode">
                                                    </div>
                                                </div>
                                                <div class="col-md-3 pr-1">
                                                    <div class="form-group">
                                                        <label>Last Modified By</label>
                                                        <input type="text" class="form-control" placeholder="" required="" value="<%= lastModifiedBy%>" size="10" disabled="">
                                                        <input type="hidden" class="form-control" value="<%= currentModifier%>" name="lastModifiedBy">
                                                    </div>
                                                </div>
                                                <div class="col-md-3 pr-1">
                                                    <div class="form-group">
                                                        <label>Last Modified Time</label>
                                                        <input type="text" class="form-control" placeholder="" required="" value="<%= lastModifiedTimeStampFormatted%>" size="10" disabled="">
                                                        <input type="hidden" class="form-control" value="<%= currentTimeStamp%>" name="lastModifiedTimeStamp">
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row">    
                                                <div class="col-md-5 pr-1">
                                                    <div class="form-group">

                                                        <label>Company Name*</label>
                                                        <input type="text" class="form-control" required placeholder="Company Name" title="Please only enter alphabets" value="<%= debtor.getCompanyName()%>" size="10" name="companyName">                                                           
                                                    </div>
                                                </div>
                                                <div class="col-md-3 pr-1">
                                                    <div class="form-group">
                                                        <label>Preferred Language*</label>
                                                        <select name="language" class="form-control" required>
                                                            <%
                                                                String language = debtor.getPreferredLanguage();
                                                                if (language.equals("English")) {
                                                                    out.println("<option value='English'>English</option>");
                                                                    out.println("<option value='Chinese'>Chinese</option>");
                                                                } else {
                                                                    out.println("<option value='Chinese'>Chinese</option>");
                                                                    out.println("<option value='English'>English</option>");
                                                                }
                                                            %> 
                                                        </select>
                                                    </div>
                                                </div>

                                            </div>
                                            <div class="row">
                                                <div class="col-md-5 pr-1">
                                                    <div class="form-group">
                                                        <label>Billing Address*</label>
                                                        <input type="text" class="form-control" required placeholder="Billing Address" value="<%= debtor.getInvAddr1()%>" size="10" name="invAddr1">
                                                        <br>
                                                        <input type="text" class="form-control" placeholder="" value="<%= debtor.getInvAddr2()%>" size="10" name="invAddr2">
                                                        <br>
                                                        <input type="text" class="form-control" placeholder="" value="<%= debtor.getInvAddr3()%>" size="10" name="invAddr3" >
                                                        <br>
                                                        <input type="text" class="form-control" placeholder="" value="<%= debtor.getInvAddr4()%>" size="10" name="invAddr4d">
                                                    </div>
                                                </div>
                                                <div class="col-md-5 pr-1">
                                                    <div class="form-group">
                                                        <label>Delivery Address* <input type="checkbox" name="billingtoo" onclick="fillDelivery(this.form)"><em>Same as Billing Address</em></input></label>
                                                        <input type="text" class="form-control" required placeholder="Delivery Address" value="<%= debtor.getDeliverAddr1()%>" size="10" name="deliverAddr1">
                                                        <br>
                                                        <input type="text" class="form-control" placeholder="" value="<%= debtor.getDeliverAddr2()%>" size="10" name="deliverAddr2">
                                                        <br>
                                                        <input type="text" class="form-control" placeholder="" value="<%= debtor.getDeliverAddr3()%>" size="10" name="deliverAddr3">
                                                        <br>
                                                        <input type="text" class="form-control" placeholder="" value="<%= debtor.getDeliverAddr4()%>" size="10" name="deliverAddr4" >
                                                    </div>
                                                </div>

                                            </div>
                                            <div class="row">
                                                <div class="col-md-6 pr-1">
                                                    <div class="form-group">
                                                        <label>Contact Person*</label>
                                                        <input type="text" class="form-control" required placeholder="Customer Name" pattern="[A-Za-z ]{1,30}" title="Please only enter alphabets" value="<%= debtor.getDebtorName()%>" size="10" name="debtorName">

                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-md-3 pr-1">
                                                    <div class="form-group">
                                                        <label>Username*</label>
                                                        <input type="text" class="form-control" required placeholder="Username" value="<%= debtor.getCompanyCode()%>" size="10" name="companyCode">
                                                    </div>
                                                </div>

                                                <div class="col-md-3 pl-1">
                                                    <div class="form-group">
                                                        <label for = "password">      </label>
                                                        <input type="hidden" value="<%= debtor.getPassword()%>" name="hashPassword">
                                                    </div>
                                                </div>

                                            </div>

                                            <div class="row">
                                                <div class="col-md-3 pr-1">
                                                    <div class="form-group">
                                                        <label>Contact Number 1</label>
                                                        <input type="text" class="form-control" pattern="[0-9]{8}" title="Please enter 8 digit numbers" placeholder="Contact Number 1" value="<%= debtor.getDeliverContact()%>" size="10" name="deliverContact">
                                                    </div>
                                                </div>
                                                <div class="col-md-3 px-1">
                                                    <div class="form-group">
                                                        <!-- need to change the value of this field-->
                                                        <label>Contact Number 2</label>
                                                        <input type="text" class="form-control" placeholder="Contact Number 2" pattern="(^$)|(^\d{8}$)" title="Please enter 8 digit numbers" value="<%= debtor.getDeliverContact2()%>" size="10" name="deliverContact2">
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="row">
                                                <div class="col-md-4 pr-1">
                                                    <div class="form-group">
                                                        <label>Status*</label>                                                       
                                                        <select name="status" class="form-control" required>
                                                            <%
                                                                String sts = debtor.getStatus();
                                                                out.println(sts);
                                                                if (sts.equals("blacklisted") || sts.equals("Blacklisted")) {
                                                                    //out.println("equals blacklist");
                                                                    out.println("<option value='Blacklisted'>Blacklisted</option>");
                                                                    out.println("<option value='Inactive'>Inactive</option>");
                                                                    out.println("<option value='Active'>Active</option>");
                                                                } else if (sts.equals("inactive") || sts.equals("Inactive")) {
                                                                    //out.println("equals inactive");
                                                                    out.println("<option value='Inactive'>Inactive</option>");
                                                                    out.println("<option value='Active'>Active</option>");
                                                                    out.println("<option value='Blacklisted'>Blacklisted</option>");
                                                                } else {
                                                                    //out.println("equals active");
                                                                    out.println("<option value='Active'>Active</option>");
                                                                    out.println("<option value='Blacklisted'>Blacklisted</option>");
                                                                    out.println("<option value='Inactive'>Inactive</option>");
                                                                }

                                                            %>
                                                        </select>
                                                    </div>
                                                </div>

                                                <!--                                                <div class="col-md-4 pr-1">
                                                                                                    <div class="form-group">
                                                                                                        <label>Payment Term</label>
                                                                                                        <select name="displayTerm" class="form-control" required > -->
                                                <%                                                                 /*                                                               String displayTerm = debtor.getDisplayTerm();
                                                   if (displayTerm.equals("C.O.D")) {
                                                       out.println("<option value='C.O.D'>C.O.D</option>");
                                                       out.println("<option value='1 day'>1 day</option>");
                                                       out.println("<option value='15 days'>15 days</option>");
                                                       out.println("<option value='30 days'>30 days</option>");
                                                   } else if (displayTerm.equals("1 day")) {
                                                       out.println("<option value='1 day'>1 day</option>");
                                                       out.println("<option value='15 days'>15 days</option>");
                                                       out.println("<option value='30 days'>30 days</option>");
                                                       out.println("<option value='C.O.D'>C.O.D</option>");

                                                   } else if (displayTerm.equals("15 days")) {
                                                       out.println("<option value='15 days'>15 days</option>");
                                                       out.println("<option value='30 days'>30 days</option>");
                                                       out.println("<option value='C.O.D'>C.O.D</option>");
                                                       out.println("<option value='1 day'>1 day</option>");
                                                   } else {
                                                       out.println("<option value='30 days'>30 days</option>");
                                                       out.println("<option value='C.O.D'>C.O.D</option>");
                                                       out.println("<option value='1 day'>1 day</option>");
                                                       out.println("<option value='15 days'>15 days</option>");
                                                   }
                                                     */
                                                %>
                                                <!--                                                        </select>                                                        
                                                                                                    </div>
                                                                                                </div>
                                                -->
                                                <input type="hidden" value='C.O.D' name="displayTerm" />

                                                <div class="col-md-4 pr-1">
                                                    <div class="form-group">                                                                                                         <label>Route*</label>
                                                        <select name ="routeNumber" class="form-control" required>
                                                            <%                                                                                String routeNum = debtor.getRouteNumber();
                                                                for (int i = 1; i <= 18; i++) {
                                                                    if ((Integer.parseInt(routeNum) == i)) {
                                                                        out.print("<option value='" + i + "' selected>" + i + "</option>");
                                                                    } else {
                                                                        out.print("<option value='" + i + "'>" + i + "</option>");
                                                                    }
                                                                }
                                                            %>  
                                                        </select>
                                                        <script>
                                                            //sdocument.write(document.getElementByName('routeNumberDropdown').value);
                                                            document.write('<input type="hidden" name="displayTerm" value="' + document.getElementByName('routeNumberDropdown').value + ">");
                                                        </script>
                                                        <!--
                                                        <input type="hidden" name="routeNumber" id="routeNumber" value="<script>
                                                               document.getElementByName('routeNumberDropdown').value 
                                                               </script>">
                                                        -->
                                                    </div>
                                                </div>

                                            </div>

                                            <a href="changeCustomerPassword.jsp?debtorCode=<%=debtor.getDebtorCode()%>&hashPassword=<%=debtor.getPassword()%>&companyName=<%= debtor.getCompanyName()%>"><input class="btn btn-info btn-fill pull-right" type="button" name="changeCustomerPassword"  value="Change Customer Password" /></a>
                                            <input class="btn btn-info btn-fill pull-left" type="button" name="Cancel"  value="Cancel" data-toggle="modal" data-target="#myModal1"/>
                                            <input class="btn btn-info btn-fill pull-right" type="submit" name="submit"  value="Done" style="margin-right:15px;" />
                                            <div class="clearfix"></div>


                                            <div class="modal fade modal-mini modal-primary" id="myModal1" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                                                <div class="modal-dialog">
                                                    <div class="modal-content">
                                                        <div class="modal-header justify-content-center">
                                                            <div class="modal-profile">
                                                                <img src="assets/img/lightbulb_icon.png" height="50px" width="50px"/>
                                                            </div>
                                                        </div>
                                                        <div class="modal-body text-center">
                                                            <p>Your changes will not be saved. Are you sure you want to leave this page?</p>
                                                        </div>
                                                        <div class="modal-footer">
                                                            <button type="button" class="btn btn-link btn-simple" onclick="location.href = 'customer.jsp'" >Leave Page</button>
                                                            <button type="button" class="btn btn-link btn-simple" data-dismiss="modal">Continue</button>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

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
            function getSelectedStatus() {
            document.getElementByName("status").value = (Number)document.getElementByName("statusDropdown").value;
            return (Number)document.getElementByName("statusDropdown").value;
            }
            function getSelectedRouteNumber(){
            document.getElementByName("routeNumber").value = (Number)document.getElementByName("routeNumberDropdown").value;
            return (Number)document.getElementByName("routeNumberDropdown").value;
            }
            function getSelectedDisplayTerm(){
            document.getElementByName("displayTerm").value = (Number)document.getElementByName("displayTermDropdown").value;
            return (Number)document.getElementByName("displayTermDropdown").value;
            }
        </script>
        
        <script>
                    function fillDelivery(f) {
                    if (f.billingtoo.checked == true) {
                    f.deliverAddr1.value = f.inAddr1.value;
                    f.deliverAddr2.value = f.invAddr2.value;
                    f.deliverAddr3.value = f.invAddr3.value;
                    f.deliverAddr4.value = f.invAddr4.value;
                    } else {
                    f.deliverAddr1.value = "";
                    f.deliverAddr1.placeholder = "Delivery Address";
                    f.deliverAddr2.value = "";
                    f.deliverAddr3.value = "";
                    f.deliverAddr4.value = "";
                    }
                    }
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