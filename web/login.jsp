<%-- 
    Document   : login2
    Created on : 9 May, 2018, 4:36:59 PM
    Author     : Rizza
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Admin Home</title>

        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/normalize/5.0.0/normalize.min.css">

        <link rel='stylesheet prefetch' href='https://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css'>

        <link rel="stylesheet" href="css/style.css">


    <body>
        

        <!-- <body style="background-image:url('https://s3-ap-southeast-1.amazonaws.com/media.redmart.com/marketplace/logos/subvendors/unnamed-1497317987343.jpg')"> -->
        
        <img src="assets/img/limkee_wallpaper.jpg" style="width:100vw;height:98vh">

        <div class="logmod">
            <div class="logmod__wrapper">

                <div class="logmod__heading">
                    <img src="assets/img/limkee_logo.png" style="width:6vw;height:10vh; max-width:100%;height:auto;">
                    
                    <br>
                    <font size = 5><strong>Lim Kee Admin Portal</strong></font>
                    <br>
                    <br>
                    <font color="red">
                    
                    <%                                
                        String errorMsgs = (String) request.getAttribute("errorMsg");
                   
                        if (errorMsgs != null) {
                            out.print(errorMsgs);
                            out.print("</br>");
                        }

                    %> 
                    </font>
                    <span class="logmod__heading-subtitle">Enter your <strong>username</strong> and <strong>password </strong>to sign in </span>
                </div> 
                
                
                <div class="logmod__form">
                    <form method="post" accept-charset="utf-8" action="loginController" class="simform">
                        <div class="sminputs">
                            <div class="input full">
                                <label class="string optional" for="user-name">Username</label>
                                <input class="string optional" maxlength="255" id="user" placeholder="Username" type="user" size="50" name="user" value=""/>
                            </div>
                        </div>
                        <div class="sminputs">
                            <div class="input full">
                                <label class="string optional" for="user-pw">Password *</label>
                                <input class="string optional" maxlength="255" id="user-pw" placeholder="Password" type="password" size="50" name="password"value=""/>
                                <span class="hide-password" id="pwOption" onclick="showPassword()">Show</span>
                            </div>
                        </div>
                        <div class="simform__actions">
                            <input class="sumbit" name="commit" type="submit" value="Log In" style="background-color: #e88347; border-radius: 20px; "/>
                            <!--    
                            <span class="simform__actions-sidetext"><a class="special" role="link" href="adminHome.jsp">Forgot your password?<br>Click here</a></span>
                            -->
                            </div> 
                    </form>
                </div> 
                <div class="logmod__alter">
                    <div class="logmod__alter-container">
                        
                    </div>
                </div>
            </div>
        </div>
                    
        
        <script src='http://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js'></script>
        <script  src="js/index.js"></script>
        <script>
        function showPassword() {
            var x = document.getElementById("pwOption");
            if (x.type === "password") {
                x.type = "text";
            } else {
                x.type = "password";
            }
        }
        </script>
    </body>
</html>

