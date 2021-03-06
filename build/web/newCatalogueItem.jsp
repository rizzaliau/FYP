<%-- 
    Document   : userMGMT
    Created on : 12 May, 2018, 1:04:11 AM
    Author     : Rizza
--%>


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
    <link rel="shortcut icon" href="./favicon.png">
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
     
                </div>
               <ul class="nav">
                        <li>
                            <a class="nav-link" href="dashboard.jsp">
                                <i class="nc-icon nc-chart-pie-35"></i>
                                <p>Dashboard</p>
                            </a>
                        </li>
                        <li>
                            <a class="nav-link" href="./userMGMT.jsp">
                                <i class="nc-icon nc-circle-09"></i>
                                <p>Customer Mgmt</p>
                            </a>
                        </li>
                        <li>
                            <a class="nav-link" href="./salesOrderMGMT.jsp">
                                <i class="nc-icon nc-notes"></i>
                                <p>Sales Order Mgmt</p>
                            </a>
                        </li>
                        <li class="nav-item active">
                            <a class="nav-link" href="catalogue.jsp">
                                <i class="nc-icon nc-paper-2"></i>
                                <p>Catalogue Mgmt</p>
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
        <div class="main-panel">
            <!-- Navbar -->
            <nav class="navbar navbar-expand-lg " color-on-scroll="500">
                <div class=" container-fluid  ">
                    <a class="navbar-brand" href="#pablo"> Dashboard </a>
                    <button href="" class="navbar-toggler navbar-toggler-right" type="button" data-toggle="collapse" aria-controls="navigation-index" aria-expanded="false" aria-label="Toggle navigation">
                        <span class="navbar-toggler-bar burger-lines"></span>
                        <span class="navbar-toggler-bar burger-lines"></span>
                        <span class="navbar-toggler-bar burger-lines"></span>
                    </button>
                    <div class="collapse navbar-collapse justify-content-end" id="navigation">
                        <ul class="nav navbar-nav mr-auto">
                            <li class="nav-item">
                                <a href="#" class="nav-link" data-toggle="dropdown">

                                </a>
                            </li>
                            <li class="dropdown nav-item">
                                <a href="#" class="dropdown-toggle nav-link" data-toggle="dropdown">
                                    <i class="nc-icon nc-planet"></i>
                                    <span class="notification">5</span>
                                    <span class="d-lg-none">Notification</span>
                                </a>
                                <ul class="dropdown-menu">
                                    <a class="dropdown-item" href="#">New Order 1</a>
                                    <a class="dropdown-item" href="#">New Order 2</a>
                                    <a class="dropdown-item" href="#">New Order 3</a>
                                    <a class="dropdown-item" href="#">New Order 4</a>
                                    <a class="dropdown-item" href="#">New Order 5</a>
                                </ul>
                            </li>
                        </ul>
                        <ul class="navbar-nav ml-auto">

                            <li class="nav-item dropdown">
                                <a class="nav-link dropdown-toggle" href="http://example.com" id="navbarDropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                    <span class="no-icon">Dropdown</span>
                                </a>
                                <div class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
                                    <a class="dropdown-item" href="#">Action</a>
                                    <a class="dropdown-item" href="#">Another action</a>
                                    <a class="dropdown-item" href="#">Something</a>
                                    <a class="dropdown-item" href="#">Something else here</a>
                                    <div class="divider"></div>
                                    <a class="dropdown-item" href="#">Separated link</a>
                                </div>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="#pablo">
                                    <span class="no-icon">Log out</span>
                                </a>
                            </li>
                        </ul>
                    </div>
                </div>
            </nav>
            

            
            <div class="content">
                <div class="container-fluid">
                    <div class="row">
                        <div class="col-md-12">
                            <div class="card strpied-tabled-with-hover">
                                <div class="card-header ">

                                    <h4 class="card-title">Catalogue Management</h4>
                                    <p class="card-category">New Catalogue Item</p>
                                </div>
                                <center><b><font color="red">
                                
                            <%                                
                                String msgStatus = (String) request.getAttribute("status");

                                if (msgStatus != null) {
                                    out.print("</br>");
                                    out.print(msgStatus);
                                    out.print("</br>");
                                }

                            %> 
                            
                            </font></b></center>
                            <!--start of form UI-->
                                <div class="card-body">
                                    <h5 class="card-title"><font color = "red">Please complete the 2 Step Process to add a new catalogue item</font></h5>
                                         <p>
                                        <br>
                                        <br>
                                         <div class="title">
                                             <p><b>Step 1:</b> Upload Image and obtain URL</p>
                                         </div>
                                        <div class="dropzone">
                                            <div class="info"></div>
                                        </div>
                                        <script type="text/javascript" src="./js/imgur.js"></script>
                                        <script type="text/javascript" src="./js/upload.js"></script>
<!--                                        <form action="uploadController" method="post" enctype="multipart/form-data">
                                            <input type="file" name="file" /></br>
                                            <input type="hidden" value='123456' name="test2" />
                                            <input type="submit" name="submit"value="Upload" />
                                        </form> -->
                                        <br>
                                        <br> 
                                        <div class="title">
                                            <p><b>Step 2:</b> Enter required fields</p>
                                            <p class="card-category"><font color = "red">* denotes required fields</font></p>
                                         </div>
                                        <form method="post" action="newCatalogueItemController">
                                            
                                              <div class="row">
                                                <div class="col-md-3 pr-1">
                                                    <div class="form-group">
                                                        <label>Item Code*</label>
                                                        <input type="text" pattern="[0-9]{1,8}" title="Please enter numeric numbers" class="form-control" placeholder="Item Code" required value="" size="5" name="itemCode" >
                                                    </div>
                                                </div>
                                                <div class="col-md-5 px-1">
                                                    <div class="form-group">
                                                        <label>English Description*</label>
                                                        <input type="text" class="form-control" required placeholder="English description" pattern="[A-Za-z ]{1,30}" title="Please only enter alphabets" value="" size="30" name="description">                                            
                                                    </div>
                                                </div>

                                            </div>
                                            <!-- chinese description validation --> 
                                            <div class="row">
                                                <div class="col-md-3 pr-1">
                                                    <div class="form-group">
                                                        <label>Chinese Description*</label>
                                                        <input type="text" class="form-control" required placeholder="Chinese Description" required value="" size="20" name="descriptionChinese">
                                                    </div>
                                                </div>
                                                <div class="col-md-5 px-1">
                                                    <div class="form-group">
                                                        <label>Unit Price($)*</label>
                                                        <input type="text" class="form-control"  pattern="[0-9]+([\.,][0-9]+)?" step="0.01" title="This should be a number with up to 2 decimal places." required placeholder="Unit Price" required value="" size="5" name="unitPrice">                                            
                                                    </div>
                                                </div>

                                            </div>
                                            
                                            <div class="row">
                                                <div class="col-md-5 pr-1">
                                                    <div class="form-group">
                                                        <label>Image URL*</label>
                                                        <input type="url" class="form-control" pattern="https?://.+" title="Include http://" required placeholder="Image URL" required value="" size="50" name="imageURL">
                                                        
                                                            <%
                                                                //String imageDirectoryRetrieved =(String) request.getAttribute("imgDirectory");
                                                                //if(imageDirectoryRetrieved == null || imageDirectoryRetrieved.equals("")){
                                                                    //out.println("<input type='text' class='form-control' value='Image not uploaded yet' disabled>");
                                                                //}else{
                                                                    //out.println("<input type='text' class='form-control' value='Image URL OK' disabled>");
                                                                    //out.println("<input type='hidden' value='"+imageDirectoryRetrieved+"' name='imageURL'>");
                                                                //}
                                                            %>
                                                             
                                                        
                                                    </div>
                                                </div>
                                                <div class="col-md-3 px-1">
                                                    <div class="form-group">
                                                        <label>Default Quantity*</label>
                                                        <input type="text" class="form-control" pattern="[0-9]{1,4}" title="Please enter numeric numbers" required placeholder="Default Quantity" value="" size="5" name="defaultQuantity">                                            
                                                    </div>
                                                </div>
                                                <div class="col-md-3 px-1">
                                                    <div class="form-group">
                                                        <label>Quantity Multiples*</label>
                                                        <input type="text" class="form-control" pattern="[0-9]{1,4}" title="Please enter numeric numbers" required placeholder="Quantity Multiples" value="" size="5" name="quantityMultiples">                                            
                                                    </div>
                                                </div>

                                            </div>
                                            
                                            <div class="row">
                                                <div class="col-md-3 pr-1">
                                                    <div class="form-group">
                                                        <label>Retail price($)*</label>
                                                        <input type="text" class="form-control" pattern="[0-9]+([\.,][0-9]+)?" step="0.01" title="This should be a number with up to 2 decimal places."   placeholder="Retail price" required value="" size="5" name="retailPrice">
                                                    </div>
                                                </div>
                                                <div class="col-md-3 px-1">
                                                    <div class="form-group">
                                                        <label>Unit of Metric*</label>
                                                        <input type="text" class="form-control" placeholder="Unit of Metric" required="" value="" size="5" name="unitOfMetric">                                            
                                                    </div>
                                                </div>

                                            </div>

                                     
                                            <input class="btn btn-info btn-fill pull-right" type="submit" name="submit" value="Add New Item" style="margin-left:20px;"/>
                                            <a href="catalogue.jsp"><input class="btn btn-info btn-fill pull-right" type="button" name="Cancel" onclick="cancelFunction();"  value="Cancel" style="margin-left:20px;"/></a>
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
                        <ul class="footer-menu">
                            <li>
                                <a href="#">
                                    Home
                                </a>
                            </li>
                            <li>
                                <a href="#">
                                    Company
                                </a>
                            </li>
                            <li>
                                <a href="#">
                                    Portfolio
                                </a>
                            </li>
                            <li>
                                <a href="#">
                                    Blog
                                </a>
                            </li>
                        </ul>
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
<script type="text/javascript">
    $(document).ready(function() {
        // Javascript method's body can be found in assets/js/demos.js
        demo.initDashboardPageCharts();

    });
</script>
<script>
function cancelFunction() {
    alert("By clicking on the cancel button, your information will be not save. Click 'OK button' to proceed.");
}
</script>


</html>