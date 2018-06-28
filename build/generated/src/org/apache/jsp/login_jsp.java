package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;

public final class login_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final JspFactory _jspxFactory = JspFactory.getDefaultFactory();

  private static java.util.List<String> _jspx_dependants;

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

      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("<!DOCTYPE html>\n");
      out.write("<html>\n");
      out.write("    <head>\n");
      out.write("        <meta charset=\"UTF-8\">\n");
      out.write("        <title>Admin Home</title>\n");
      out.write("\n");
      out.write("        <link rel=\"stylesheet\" href=\"https://cdnjs.cloudflare.com/ajax/libs/normalize/5.0.0/normalize.min.css\">\n");
      out.write("\n");
      out.write("        <link rel='stylesheet prefetch' href='https://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css'>\n");
      out.write("\n");
      out.write("        <link rel=\"stylesheet\" href=\"css/style.css\">\n");
      out.write("\n");
      out.write("\n");
      out.write("    <body>\n");
      out.write("        \n");
      out.write("\n");
      out.write("        <!-- <body style=\"background-image:url('https://s3-ap-southeast-1.amazonaws.com/media.redmart.com/marketplace/logos/subvendors/unnamed-1497317987343.jpg')\"> -->\n");
      out.write("        \n");
      out.write("        <img src=\"assets/img/Lim Kee Background.jpg\" style=\"width:98vw;height:97vh\">\n");
      out.write("\n");
      out.write("        <div class=\"logmod\">\n");
      out.write("            <div class=\"logmod__wrapper\">\n");
      out.write("\n");
      out.write("                <div class=\"logmod__heading\">\n");
      out.write("                    <font size = 5><strong>Lim Kee Admin Portal</strong></font>\n");
      out.write("                    <font color=\"red\">\n");
      out.write("                    <p>\n");
      out.write("                    ");
                                
                        String errorMsgs = (String) request.getAttribute("errorMsg");
                   
                        if (errorMsgs != null) {
                            out.print(errorMsgs);
                            out.print("</br>");
                        }

                    
      out.write(" \n");
      out.write("                    </font>\n");
      out.write("                    <span class=\"logmod__heading-subtitle\">Enter your user and password <strong>to sign in</strong> 请填写用户名和/或密码</span>\n");
      out.write("                </div> \n");
      out.write("                \n");
      out.write("                \n");
      out.write("                <div class=\"logmod__form\">\n");
      out.write("                    <form method=\"post\" accept-charset=\"utf-8\" action=\"loginController\" class=\"simform\">\n");
      out.write("                        <div class=\"sminputs\">\n");
      out.write("                            <div class=\"input full\">\n");
      out.write("                                <label class=\"string optional\" for=\"user-name\">User*</label>\n");
      out.write("                                <input class=\"string optional\" maxlength=\"255\" id=\"user\" placeholder=\"User\" type=\"user\" size=\"50\" name=\"user\"/>\n");
      out.write("                            </div>\n");
      out.write("                        </div>\n");
      out.write("                        <div class=\"sminputs\">\n");
      out.write("                            <div class=\"input full\">\n");
      out.write("                                <label class=\"string optional\" for=\"user-pw\">Password *</label>\n");
      out.write("                                <input class=\"string optional\" maxlength=\"255\" id=\"user-pw\" placeholder=\"Password\" type=\"password\" size=\"50\" name=\"password\"/>\n");
      out.write("                                <span class=\"hide-password\">Show</span>\n");
      out.write("                            </div>\n");
      out.write("                        </div>\n");
      out.write("                        <div class=\"simform__actions\">\n");
      out.write("                            <input class=\"sumbit\" name=\"commit\" type=\"submit\" value=\"Log In\" /> \n");
      out.write("\n");
      out.write("                            <span class=\"simform__actions-sidetext\"><a class=\"special\" role=\"link\" href=\"adminHome.jsp\">Forgot your password?<br>Click here</a></span>\n");
      out.write("                        </div> \n");
      out.write("                    </form>\n");
      out.write("                </div> \n");
      out.write("                <div class=\"logmod__alter\">\n");
      out.write("                    <div class=\"logmod__alter-container\">\n");
      out.write("                        \n");
      out.write("                    </div>\n");
      out.write("                </div>\n");
      out.write("            </div>\n");
      out.write("        </div>\n");
      out.write("                    \n");
      out.write("        \n");
      out.write("        <script src='http://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js'></script>\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("        <script  src=\"js/index.js\"></script>\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("    </body>\n");
      out.write("\n");
      out.write("    <script src='http://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js'></script>\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("    <script  src=\"js/index.js\"></script>\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("</html>\n");
      out.write("\n");
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
