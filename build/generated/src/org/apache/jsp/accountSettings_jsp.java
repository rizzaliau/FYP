package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;

public final class accountSettings_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final JspFactory _jspxFactory = JspFactory.getDefaultFactory();

  private static java.util.List<String> _jspx_dependants;

  static {
    _jspx_dependants = new java.util.ArrayList<String>(1);
    _jspx_dependants.add("/protect.jsp");
  }

  private org.glassfish.jsp.api.ResourceInjector _jspx_resourceInjector;

  public java.util.List<String> getDependants() {
    return _jspx_dependants;
  }

  public void _jspService(HttpServletRequest request, HttpServletResponse response)
        throws java.io.IOException, ServletException {

    PageContext pageContext = null;
    HttpSession session = null;
    ServletContext application = null;
    ServletConfig config = null;
    JspWriter out = null;
    Object page = this;
    JspWriter _jspx_out = null;
    PageContext _jspx_page_context = null;

    try {
      response.setContentType("text/html;charset=UTF-8");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;
      _jspx_resourceInjector = (org.glassfish.jsp.api.ResourceInjector) application.getAttribute("com.sun.appserv.jsp.resource.injector");

      out.write("<!DOCTYPE html>\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("<!DOCTYPE html>\n");
      out.write("\n");
 
    String user = (String)session.getAttribute("username");
    
    //out.println("protect.jsp user retrieved is: " +user);
    
    if(user == null){
        response.sendRedirect("login.jsp");
    }
    
    //else if (!user.equals("admin")) {
        //response.sendRedirect("login.jsp");
    //}
    

      out.write('\n');
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("<html lang=\"en\">\n");
      out.write("\n");
      out.write("\n");
      out.write("    <head>\n");
      out.write("        <meta charset=\"UTF-8\">\n");
      out.write("        <link rel=\"apple-touch-icon\" sizes=\"76x76\" href=\"assets/img/apple-icon.png\">\n");
      out.write("        <link rel=\"icon\" type=\"image/png\" href=\"assets/img/favicon.ico\">\n");
      out.write("        <meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge,chrome=1\" />\n");
      out.write("        <title>Lim Kee Admin Portal</title>\n");
      out.write("        <meta content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0, shrink-to-fit=no' name='viewport' />\n");
      out.write("        <!--     Fonts and icons     -->\n");
      out.write("        <link href=\"https://fonts.googleapis.com/css?family=Montserrat:400,700,200\" rel=\"stylesheet\" />\n");
      out.write("        <link rel=\"stylesheet\" href=\"https://maxcdn.bootstrapcdn.com/font-awesome/latest/css/font-awesome.min.css\" />\n");
      out.write("        <!-- CSS Files -->\n");
      out.write("        <link href=\"assets/css/bootstrap.min.css\" rel=\"stylesheet\" />\n");
      out.write("        <link href=\"assets/css/light-bootstrap-dashboard.css?v=2.0.1\" rel=\"stylesheet\" />\n");
      out.write("        <!-- CSS Just for demo purpose, don't include it in your project -->\n");
      out.write("        <link href=\"assets/css/demo.css\" rel=\"stylesheet\" />\n");
      out.write("        <link rel=\"stylesheet\" href=\"https://www.w3schools.com/lib/w3-colors-highway.css\">\n");
      out.write("    </head>\n");
      out.write("\n");
      out.write("    <body>\n");
      out.write("        <div class=\"wrapper\">\n");
      out.write("            <div class=\"sidebar\" data-image=\"assets/img/sidebar-5.jpg\" data-color=\"orange\">\n");
      out.write("                <!--\n");
      out.write("            Tip 1: You can change the color of the sidebar using: data-color=\"purple | blue | green | orange | red\"\n");
      out.write("    \n");
      out.write("            Tip 2: you can also add an image using data-image tag\n");
      out.write("                -->\n");
      out.write("                <div class=\"sidebar-wrapper\">\n");
      out.write("                    <div class=\"logo\">\n");
      out.write("                        <a href=\"#\" class=\"simple-text\">\n");
      out.write("                            LIM KEE Admin Portal\n");
      out.write("                        </a>\n");
      out.write("                        <!--  Welcome-->\n");
      out.write("                        ");
                            
                            String userName = request.getParameter("user");
                            String passWord = request.getParameter("password");
                            //String gender = (String)request.getAttribute("gender");
                            //out.println(userName);

                            String usernameSession = (String) session.getAttribute("username");

                            //out.println(usernameSession);
                            //out.println("Username retrieved from session is:"+usernameSession);

                        
      out.write("\n");
      out.write("                    </div>\n");
      out.write("                    <ul class=\"nav\">\n");
      out.write("                        <li>\n");
      out.write("                            <a class=\"nav-link\" href=\"dashboard.jsp\">\n");
      out.write("                                <i class=\"nc-icon nc-chart-pie-35\"></i>\n");
      out.write("                                <p>Dashboard</p>\n");
      out.write("                            </a>\n");
      out.write("                        </li>\n");
      out.write("                        <li>\n");
      out.write("                            <a class=\"nav-link\" href=\"./userMGMT.jsp\">\n");
      out.write("                                <i class=\"nc-icon nc-circle-09\"></i>\n");
      out.write("                                <p>Customer Mgmt</p>\n");
      out.write("                            </a>\n");
      out.write("                        </li>\n");
      out.write("                        <li>\n");
      out.write("                            <a class=\"nav-link\" href=\"./salesOrderMGMT.jsp\">\n");
      out.write("                                <i class=\"nc-icon nc-notes\"></i>\n");
      out.write("                                <p>Sales Order Mgmt</p>\n");
      out.write("                            </a>\n");
      out.write("                        </li>\n");
      out.write("                        <li>\n");
      out.write("                            <a class=\"nav-link\" href=\"analytics.jsp\">\n");
      out.write("                                <i class=\"nc-icon nc-paper-2\"></i>\n");
      out.write("                                <p>Catalogue Mgmt</p>\n");
      out.write("                            </a>\n");
      out.write("                        </li>\n");
      out.write("                        <li>\n");
      out.write("                            <a class=\"nav-link\" href=\"./maps.html\">\n");
      out.write("                                <i class=\"nc-icon nc-single-02\"></i>\n");
      out.write("                                <p>Loyalty Programme</p>\n");
      out.write("                            </a>\n");
      out.write("                        </li>\n");
      out.write("                        <li class=\"nav-item active\">\n");
      out.write("                            <a class=\"nav-link\" href=\"./notifications.html\">\n");
      out.write("                                <i class=\"nc-icon nc-settings-gear-64\"></i>\n");
      out.write("                                <p>Account Settings</p>\n");
      out.write("                            </a>\n");
      out.write("                        </li>\n");
      out.write("                        \n");
      out.write("                    </ul>\n");
      out.write("                </div>\n");
      out.write("            </div>\n");
      out.write("            <div class=\"main-panel\">\n");
      out.write("                <!-- Navbar -->\n");
      out.write("                <nav class=\"navbar navbar-expand-lg \" color-on-scroll=\"500\">\n");
      out.write("                    <div class=\" container-fluid  \">\n");
      out.write("                        <a class=\"navbar-brand\" href=\"dashboard.jsp\"> Dashboard </a>\n");
      out.write("                        <button href=\"\" class=\"navbar-toggler navbar-toggler-right\" type=\"button\" data-toggle=\"collapse\" aria-controls=\"navigation-index\" aria-expanded=\"false\" aria-label=\"Toggle navigation\">\n");
      out.write("                            <span class=\"navbar-toggler-bar burger-lines\"></span>\n");
      out.write("                            <span class=\"navbar-toggler-bar burger-lines\"></span>\n");
      out.write("                            <span class=\"navbar-toggler-bar burger-lines\"></span>\n");
      out.write("                        </button>\n");
      out.write("                        <div class=\"collapse navbar-collapse justify-content-end\" id=\"navigation\">\n");
      out.write("                            <ul class=\"nav navbar-nav mr-auto\">\n");
      out.write("                                <li class=\"nav-item\">\n");
      out.write("                                    <a href=\"#\" class=\"nav-link\" data-toggle=\"dropdown\">\n");
      out.write("\n");
      out.write("                                        <span class=\"d-lg-none\">Dashboard</span>\n");
      out.write("                                    </a>\n");
      out.write("                                </li>\n");
      out.write("                                <li class=\"dropdown nav-item\">\n");
      out.write("                                    <a href=\"#\" class=\"dropdown-toggle nav-link\" data-toggle=\"dropdown\">\n");
      out.write("                                        <i class=\"nc-icon nc-planet\"></i>\n");
      out.write("                                        <span class=\"notification\">5</span>\n");
      out.write("                                        <span class=\"d-lg-none\">Notification</span>\n");
      out.write("                                    </a>\n");
      out.write("                                    <ul class=\"dropdown-menu\">\n");
      out.write("                                        <a class=\"dropdown-item\" href=\"#\">New Order 1</a>\n");
      out.write("                                        <a class=\"dropdown-item\" href=\"#\">New Order 2</a>\n");
      out.write("                                        <a class=\"dropdown-item\" href=\"#\">New Order 3</a>\n");
      out.write("                                        <a class=\"dropdown-item\" href=\"#\">New Order 4</a>\n");
      out.write("                                        <a class=\"dropdown-item\" href=\"#\">New Order 5</a>\n");
      out.write("                                    </ul>\n");
      out.write("                                </li>\n");
      out.write("                            </ul>\n");
      out.write("                            <ul class=\"navbar-nav ml-auto\">\n");
      out.write("                                <li class=\"nav-item dropdown\">\n");
      out.write("                                    <a class=\"nav-link dropdown-toggle\" href=\"http://example.com\" id=\"navbarDropdownMenuLink\" data-toggle=\"dropdown\" aria-haspopup=\"true\" aria-expanded=\"false\">\n");
      out.write("                                        <span class=\"no-icon\">Dropdown</span>\n");
      out.write("                                    </a>\n");
      out.write("                                    <div class=\"dropdown-menu\" aria-labelledby=\"navbarDropdownMenuLink\">\n");
      out.write("                                        <a class=\"dropdown-item\" href=\"#\">Action</a>\n");
      out.write("                                        <a class=\"dropdown-item\" href=\"#\">Another action</a>\n");
      out.write("                                        <a class=\"dropdown-item\" href=\"#\">Something</a>\n");
      out.write("                                        <a class=\"dropdown-item\" href=\"#\">Something else here</a>\n");
      out.write("                                        <div class=\"divider\"></div>\n");
      out.write("                                        <a class=\"dropdown-item\" href=\"#\">Separated link</a>\n");
      out.write("                                    </div>\n");
      out.write("                                </li>\n");
      out.write("                                <li class=\"nav-item\">\n");
      out.write("                                    <a class=\"nav-link\" href=\"logout.jsp\">\n");
      out.write("                                        <span class=\"no-icon\">Log out</span>\n");
      out.write("                                    </a>\n");
      out.write("                                </li>\n");
      out.write("                            </ul>\n");
      out.write("                        </div>\n");
      out.write("                    </div>\n");
      out.write("                </nav>\n");
      out.write("                <!-- End Navbar -->\n");
      out.write("                <div class=\"content\">\n");
      out.write("                    <div class=\"container-fluid\">\n");
      out.write("                        <div class=\"row\">\n");
      out.write("                            <div class=\"col-md-8\">\n");
      out.write("                                <div class=\"card\">\n");
      out.write("                                    <div class=\"card-header\">\n");
      out.write("                                        <h4 class=\"card-title\">Edit account</h4>\n");
      out.write("                                    </div>\n");
      out.write("\n");
      out.write("                                    <div class=\"col-md-8\"><font color=\"red\">\n");
      out.write("                                        ");
                                     //String passwordErrorMsg = (String) request.getAttribute("diffPassword");
                                            //String passwordUpdate = (String)request.getAttribute("updateSuccess");
                                            String status = (String) request.getAttribute("status");

       //                                    if (passwordErrorMsg != null) {
       //                                        out.print("</br>");
       //                                        out.print(passwordErrorMsg);
       //                                        out.print("</br>");
       //                                    }
       //                                    
       //                                    if (passwordUpdate!=null){
       //                                        out.print("</br>");
       //                                        out.print(passwordUpdate);
       //                                        out.print("</br>");
       //                                    }
                                            if (status != null) {
                                                out.print("</br>");
                                                out.print(status);
                                                out.print("</br>");
                                            }


                                        
      out.write(" \n");
      out.write("                                    </div></font>\n");
      out.write("\n");
      out.write("                                    <div class=\"card-body\">\n");
      out.write("                                        <form method=\"post\" accept-charset=\"utf-8\" action=\"changePasswordController\" >\n");
      out.write("                                            <div class=\"row\">\n");
      out.write("                                                <div class=\"col-md-5 pr-1\">\n");
      out.write("                                                    <div class=\"form-group\">\n");
      out.write("                                                        <label>New Password</label>\n");
      out.write("                                                        <input type=\"password\" name=\"newPass1\" class=\"form-control\" placeholder=\"Password\">\n");
      out.write("                                                    </div>\n");
      out.write("                                                </div>\n");
      out.write("                                            </div>\n");
      out.write("                                            <div class=\"row\">\n");
      out.write("                                                <div class=\"col-md-5 pr-1\">\n");
      out.write("                                                    <div class=\"form-group\">\n");
      out.write("                                                        <label for=\"exampleInputEmail1\">Re-enter New Password</label>\n");
      out.write("                                                        <input type=\"password\" name=\"newPass2\" class=\"form-control\" placeholder=\"Password\">\n");
      out.write("                                                    </div>\n");
      out.write("                                                </div>\n");
      out.write("\n");
      out.write("                                            </div>\n");
      out.write("                                            <button type=\"submit\" class=\"btn btn-info btn-fill pull-right\">Change Password</button>\n");
      out.write("                                            <div class=\"clearfix\"></div>\n");
      out.write("                                        </form>\n");
      out.write("                                    </div>\n");
      out.write("                                </div>\n");
      out.write("                            </div>\n");
      out.write("                            <div class=\"col-md-4\">\n");
      out.write("                                <div class=\"card card-user\">\n");
      out.write("                                    <div class=\"card-image\">\n");
      out.write("                                        <img src=\"assets/limkee/jquerypic5.jpg\" alt=\"...\">\n");
      out.write("                                    </div>\n");
      out.write("                                    <div class=\"card-body\">\n");
      out.write("                                        <div class=\"author\">\n");
      out.write("                                            <a href=\"#\">\n");
      out.write("                                                <img class=\"avatar border-gray\" src=\"../assets/limkee/jquerypic5.jpg\" alt=\"...\">\n");
      out.write("                                            </a>\n");
      out.write("                                            <p>\n");
      out.write("                                            </p>\n");
      out.write("                                            <p class=\"description\">\n");
      out.write("                                                <b>Lim Kee Food Manufacturing Pte Ltd</b>\n");
      out.write("                                            </p>\n");
      out.write("                                        </div>\n");
      out.write("                                        <p class=\"description text-center\">\n");
      out.write("                                            \"1980s Our first production plant started at Ang Mo Kio Industrial Park 1.\"\n");
      out.write("                                            <br>\"Sharing our passion and love for steamed buns(paus)since our founding days\"\n");
      out.write("                                        </p>\n");
      out.write("                                    </div>\n");
      out.write("                                    <hr>\n");
      out.write("                                    <div class=\"button-container mr-auto ml-auto\">\n");
      out.write("                                        <button href=\"#\" class=\"btn btn-simple btn-link btn-icon\">\n");
      out.write("                                            <i class=\"fa fa-facebook-square\"></i>\n");
      out.write("                                        </button>\n");
      out.write("                                        <button href=\"#\" class=\"btn btn-simple btn-link btn-icon\">\n");
      out.write("                                            <i class=\"fa fa-twitter\"></i>\n");
      out.write("                                        </button>\n");
      out.write("                                        <button href=\"#\" class=\"btn btn-simple btn-link btn-icon\">\n");
      out.write("                                            <i class=\"fa fa-google-plus-square\"></i>\n");
      out.write("                                        </button>\n");
      out.write("                                    </div>\n");
      out.write("                                </div>\n");
      out.write("                            </div>\n");
      out.write("                        </div>\n");
      out.write("                    </div>\n");
      out.write("                </div>\n");
      out.write("\n");
      out.write("                <footer class=\"footer\">\n");
      out.write("                    <div class=\"container\">\n");
      out.write("                        <nav>\n");
      out.write("                            <ul class=\"footer-menu\">\n");
      out.write("                                <li>\n");
      out.write("                                    <a href=\"#\">\n");
      out.write("                                        Home\n");
      out.write("                                    </a>\n");
      out.write("                                </li>\n");
      out.write("                                <li>\n");
      out.write("                                    <a href=\"#\">\n");
      out.write("                                        Company\n");
      out.write("                                    </a>\n");
      out.write("                                </li>\n");
      out.write("                                <li>\n");
      out.write("                                    <a href=\"#\">\n");
      out.write("                                        Portfolio\n");
      out.write("                                    </a>\n");
      out.write("                                </li>\n");
      out.write("                                <li>\n");
      out.write("                                    <a href=\"#\">\n");
      out.write("                                        Blog\n");
      out.write("                                    </a>\n");
      out.write("                                </li>\n");
      out.write("                            </ul>\n");
      out.write("                            <p class=\"copyright text-center\">\n");
      out.write("                                This website's content is Copyright \n");
      out.write("                                <script>\n");
      out.write("                                    document.write(new Date().getFullYear())\n");
      out.write("                                </script>\n");
      out.write("                                © Lim Kee Food Manufacturing Pte Ltd\n");
      out.write("                            </p>\n");
      out.write("                        </nav>\n");
      out.write("                    </div>\n");
      out.write("                </footer>\n");
      out.write("            </div>\n");
      out.write("        </div>\n");
      out.write("        <!--   -->\n");
      out.write("        <!-- <div class=\"fixed-plugin\">\n");
      out.write("        <div class=\"dropdown show-dropdown\">\n");
      out.write("            <a href=\"#\" data-toggle=\"dropdown\">\n");
      out.write("                <i class=\"fa fa-cog fa-2x\"> </i>\n");
      out.write("            </a>\n");
      out.write("    \n");
      out.write("            <ul class=\"dropdown-menu\">\n");
      out.write("                            <li class=\"header-title\"> Sidebar Style</li>\n");
      out.write("                <li class=\"adjustments-line\">\n");
      out.write("                    <a href=\"javascript:void(0)\" class=\"switch-trigger\">\n");
      out.write("                        <p>Background Image</p>\n");
      out.write("                        <label class=\"switch\">\n");
      out.write("                            <input type=\"checkbox\" data-toggle=\"switch\" checked=\"\" data-on-color=\"primary\" data-off-color=\"primary\"><span class=\"toggle\"></span>\n");
      out.write("                        </label>\n");
      out.write("                        <div class=\"clearfix\"></div>\n");
      out.write("                    </a>\n");
      out.write("                </li>\n");
      out.write("                <li class=\"adjustments-line\">\n");
      out.write("                    <a href=\"javascript:void(0)\" class=\"switch-trigger background-color\">\n");
      out.write("                        <p>Filters</p>\n");
      out.write("                        <div class=\"pull-right\">\n");
      out.write("                            <span class=\"badge filter badge-black\" data-color=\"black\"></span>\n");
      out.write("                            <span class=\"badge filter badge-azure\" data-color=\"azure\"></span>\n");
      out.write("                            <span class=\"badge filter badge-green\" data-color=\"green\"></span>\n");
      out.write("                            <span class=\"badge filter badge-orange\" data-color=\"orange\"></span>\n");
      out.write("                            <span class=\"badge filter badge-red\" data-color=\"red\"></span>\n");
      out.write("                            <span class=\"badge filter badge-purple active\" data-color=\"purple\"></span>\n");
      out.write("                        </div>\n");
      out.write("                        <div class=\"clearfix\"></div>\n");
      out.write("                    </a>\n");
      out.write("                </li>\n");
      out.write("                <li class=\"header-title\">Sidebar Images</li>\n");
      out.write("    \n");
      out.write("                <li class=\"active\">\n");
      out.write("                    <a class=\"img-holder switch-trigger\" href=\"javascript:void(0)\">\n");
      out.write("                        <img src=\"../assets/img/sidebar-1.jpg\" alt=\"\" />\n");
      out.write("                    </a>\n");
      out.write("                </li>\n");
      out.write("                <li>\n");
      out.write("                    <a class=\"img-holder switch-trigger\" href=\"javascript:void(0)\">\n");
      out.write("                        <img src=\"../assets/img/sidebar-3.jpg\" alt=\"\" />\n");
      out.write("                    </a>\n");
      out.write("                </li>\n");
      out.write("                <li>\n");
      out.write("                    <a class=\"img-holder switch-trigger\" href=\"javascript:void(0)\">\n");
      out.write("                        <img src=\"..//assets/img/sidebar-4.jpg\" alt=\"\" />\n");
      out.write("                    </a>\n");
      out.write("                </li>\n");
      out.write("                <li>\n");
      out.write("                    <a class=\"img-holder switch-trigger\" href=\"javascript:void(0)\">\n");
      out.write("                        <img src=\"../assets/img/sidebar-5.jpg\" alt=\"\" />\n");
      out.write("                    </a>\n");
      out.write("                </li>\n");
      out.write("    \n");
      out.write("                <li class=\"button-container\">\n");
      out.write("                    <div class=\"\">\n");
      out.write("                        <a href=\"http://www.creative-tim.com/product/light-bootstrap-dashboard\" target=\"_blank\" class=\"btn btn-info btn-block btn-fill\">Download, it's free!</a>\n");
      out.write("                    </div>\n");
      out.write("                </li>\n");
      out.write("    \n");
      out.write("                <li class=\"header-title pro-title text-center\">Want more components?</li>\n");
      out.write("    \n");
      out.write("                <li class=\"button-container\">\n");
      out.write("                    <div class=\"\">\n");
      out.write("                        <a href=\"http://www.creative-tim.com/product/light-bootstrap-dashboard-pro\" target=\"_blank\" class=\"btn btn-warning btn-block btn-fill\">Get The PRO Version!</a>\n");
      out.write("                    </div>\n");
      out.write("                </li>\n");
      out.write("    \n");
      out.write("                <li class=\"header-title\" id=\"sharrreTitle\">Thank you for sharing!</li>\n");
      out.write("    \n");
      out.write("                <li class=\"button-container\">\n");
      out.write("                                    <button id=\"twitter\" class=\"btn btn-social btn-outline btn-twitter btn-round sharrre\"><i class=\"fa fa-twitter\"></i> · 256</button>\n");
      out.write("                    <button id=\"facebook\" class=\"btn btn-social btn-outline btn-facebook btn-round sharrre\"><i class=\"fa fa-facebook-square\"></i> · 426</button>\n");
      out.write("                </li>\n");
      out.write("            </ul>\n");
      out.write("        </div>\n");
      out.write("    </div>\n");
      out.write("        -->\n");
      out.write("    </body>\n");
      out.write("    <!--   Core JS Files   -->\n");
      out.write("    <script src=\"assets/js/core/jquery.3.2.1.min.js\" type=\"text/javascript\"></script>\n");
      out.write("    <script src=\"assets/js/core/popper.min.js\" type=\"text/javascript\"></script>\n");
      out.write("    <script src=\"assets/js/core/bootstrap.min.js\" type=\"text/javascript\"></script>\n");
      out.write("    <!--  Plugin for Switches, full documentation here: http://www.jque.re/plugins/version3/bootstrap.switch/ -->\n");
      out.write("    <script src=\"assets/js/plugins/bootstrap-switch.js\"></script>\n");
      out.write("    <!--  Google Maps Plugin    -->\n");
      out.write("    <script type=\"text/javascript\" src=\"https://maps.googleapis.com/maps/api/js?key=YOUR_KEY_HERE\"></script>\n");
      out.write("    <!--  Chartist Plugin  -->\n");
      out.write("    <script src=\"assets/js/plugins/chartist.min.js\"></script>\n");
      out.write("    <!--  Notifications Plugin    -->\n");
      out.write("    <script src=\"assets/js/plugins/bootstrap-notify.js\"></script>\n");
      out.write("    <!-- Control Center for Light Bootstrap Dashboard: scripts for the example pages etc -->\n");
      out.write("    <script src=\"assets/js/light-bootstrap-dashboard.js?v=2.0.1\" type=\"text/javascript\"></script>\n");
      out.write("    <!-- Light Bootstrap Dashboard DEMO methods, don't include it in your project! -->\n");
      out.write("    <script src=\"assets/js/demo.js\"></script>\n");
      out.write("\n");
      out.write("    <script type=\"text/javascript\">\n");
      out.write("                                    $(document).ready(function () {\n");
      out.write("                                        // Javascript method's body can be found in assets/js/demos.js\n");
      out.write("                                        demo.initDashboardPageCharts();\n");
      out.write("                                        demo.showNotification();\n");
      out.write("                                    });\n");
      out.write("    </script>\n");
      out.write("\n");
      out.write("</html>");
    } catch (Throwable t) {
      if (!(t instanceof SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          out.clearBuffer();
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
        else throw new ServletException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}
