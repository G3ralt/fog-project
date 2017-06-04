<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>CAR01H HØJ REJSNING</title>
    </head>
    <body class="w3-content w3-border-left w3-border-right">

        <!-- NAVBAR Suite START-->
        <jsp:include page="navbarSuite.jsp" />  
        <!-- NAVBAR Suite END-->

        <!-- content starts 50px from the top, because the navbar is 50px -->
        <div style="margin-top: 50px;"></div>

        <!-- !PAGE CONTENT! -->
        <div class="w3-main w3-white w3-padding-16 w3-card-2">
            <h1 class="w3-center">CAR01H HØJ REJSNING</h1>   

            <!-- Slideshow Header -->
            <div class="w3-container w3-content" id="apartment">

                <div class="w3-display-container mySlides">
                    <img src="media/pictures/premadeCarports/CAR01H/CAR01H.png" style="width:100%;margin-bottom:-6px">
                    <div class="w3-display-bottomleft w3-container w3-black">
                        <p>Real Picture</p>
                    </div>
                </div>
                <div class="w3-display-container mySlides">
                    <img src="media/pictures/premadeCarports/CAR01H/CAR01HSheme1.png" style="width:100%;margin-bottom:-6px">
                    <div class="w3-display-bottomleft w3-container w3-black">
                        <p>Scheme</p>
                    </div>
                </div>
                <div class="w3-display-container mySlides">
                    <img src="media/pictures/premadeCarports/CAR01H/CAR01HSheme2.png" style="width:100%;margin-bottom:-6px">
                    <div class="w3-display-bottomleft w3-container w3-black">
                        <p>Scheme</p>
                    </div>
                </div>
                <div class="w3-display-container mySlides">
                    <img src="media/pictures/premadeCarports/CAR01H/CAR01HSheme3.png" style="width:100%;margin-bottom:-6px">
                    <div class="w3-display-bottomleft w3-container w3-black">
                        <p>Scheme</p>
                    </div>
                </div>
            </div>
            <div class="w3-row-padding w3-section">
                <div class="w3-col s3">
                    <img class="demo w3-opacity w3-hover-opacity-off" src="media/pictures/premadeCarports/CAR01H/CAR01H.png" style="width:100%;cursor:pointer" onclick="currentDiv(1)" title="Real picture">
                </div>
                <div class="w3-col s3">
                    <img class="demo w3-opacity w3-hover-opacity-off" src="media/pictures/premadeCarports/CAR01H/CAR01HSheme1.png" style="width:100%;cursor:pointer" onclick="currentDiv(2)" title="Scheme1">
                </div>
                <div class="w3-col s3">
                    <img class="demo w3-opacity w3-hover-opacity-off" src="media/pictures/premadeCarports/CAR01H/CAR01HSheme2.png" style="width:100%;cursor:pointer" onclick="currentDiv(3)" title="Scheme2">
                </div>
                <div class="w3-col s3">
                    <img class="demo w3-opacity w3-hover-opacity-off" src="media/pictures/premadeCarports/CAR01H/CAR01HSheme3.png" style="width:100%;cursor:pointer" onclick="currentDiv(4)" title="Scheme3">
                </div>
            </div>

            <div class="w3-container">
                <h4><strong>Description</strong></h4>
                <div class="w3-row w3-large">
                    <div class="w3-col s12">
                        <p>3,60 x 5,40 mtr. 
                            Uden redskabsrum
                            Trykimprægnerede stolper & stern.
                            Leveres med: Søm, skruer, beslag og betontagstenstag.
                            Udførlig byggevejledning til carport og spær medfølger.
                            Betontagsten i sort med 30 års garanti.
                            NB! Leveres som Byg-selv sæt - usamlet og ubehandlet!</p>
                    </div>
                </div>
                <hr>

                <h4><strong>Price :</strong></h4>
                <div class="w3-row w3-large">
                    <div class="w3-col s6">
                        <p>pr. stk. 12.995,-</p>
                    </div>
                </div>
                <hr>

                <h4><strong>Extra Info</strong></h4>
                <p><i class="fa fa-check w3-large"></i> 14 dages returret</p>
                <p><i class="fa fa-check w3-large"></i> Sikker betaling</p>
                <p>We accept: <i class="fa fa-credit-card w3-large"></i> <i class="fa fa-cc-mastercard w3-large"></i> <i class="fa fa-cc-amex w3-large"></i> <i class="fa fa-cc-cc-visa w3-large"></i><i class="fa fa-cc-paypal w3-large"></i></p>
                <ul class="nav nav-tabs">
                    <li role="presentation" class="active"><a href="#shiping" role="tab" data-toggle="tab">Yderligere leveringsinformation&nbsp;</a></li>
                    <li role="presentation" class=""><a href="#dokument" role="tab" data-toggle="tab">Dokumenter&nbsp;</a></li>
                </ul>
                <% session.setAttribute("productPrice", "12995.00"); %>
                <!-- TABS CONTENT -->
                <div class="tab-content">
                    <div class="tab-pane fade active in" role="tabpanel" id="shiping">
                        <h4>Leveringstype: Særlige leveringsbetingelser</h4>  
                        <h1>Fragtvilkår for denne vare</h1>  
                        <div class="w3-padding-16 w3-margin-32">
                            <table class="w3-table w3-bordered w3-padding" cellpadding="5">
                                <tr>
                                    <td>Levering - Sjælland:</td>
                                    <td>250,00 pr. stk.</td>
                                </tr>
                                <tr>
                                    <td>Levering - Fyn:</td>
                                    <td>1.475,00 pr. stk.</td>
                                </tr>
                                <tr>
                                    <td>Levering - Jylland:</td>
                                    <td>1.875,00 pr. stk.</td>
                                </tr>
                                <tr>
                                    <td>Særlige leveringsdage:</td>
                                    <td>Fredag</td>
                                </tr>
                            </table>
                            <img src="media/pictures/levering900_b2c.png">
                        </div>
                    </div>

                    <div class="tab-pane fade" role="tabpanel" id="dokument">
                        <h1><a href="https://www.johannesfog.dk/globalassets/inriver/resources/9116199_car01h-2016.pdf" target="_blank">CAR01H Tegninger (PDF)</a></h1>
                    </div>
                </div>
                <!-- TABS CONTENT END-->

                <hr>

                <h4><strong>Buy this beauty</strong></h4>
                <p>When you click the "Buy" button that means you accept our Terms&Conditions.</p>
                <p>You will be lead through the process by our system. Happy buying.</p>
                <% session.setAttribute("productID", "2"); %>
                <%
                    //onclick the button will open a pop-up with Log in if there is no session was opened, else leads the user to customType.jsp
                    if (session.getAttribute("user") == null) { %>
                <a onclick="document.getElementById('id01').style.display = 'block'" href="#" class="w3-button w3-teal w3-block w3-xlarge">Buy</a>
                <% } else { %>
                <a href="regularpage.jsp" class="w3-button w3-teal w3-block w3-xlarge">Buy</a>
                <% }%>
            </div>
        </div><!-- End page content -->

        <!-- FOOTER Suite-->
        <jsp:include page="footer.jsp" />

        <script>// Slideshow Apartment Images
            var slideIndex = 1;
            showDivs(slideIndex);

            function plusDivs(n) {
                showDivs(slideIndex += n);
            }

            function currentDiv(n) {
                showDivs(slideIndex = n);
            }

            function showDivs(n) {
                var i;
                var x = document.getElementsByClassName("mySlides");
                var dots = document.getElementsByClassName("demo");
                if (n > x.length) {
                    slideIndex = 1
                }
                if (n < 1) {
                    slideIndex = x.length
                }
                for (i = 0; i < x.length; i++) {
                    x[i].style.display = "none";
                }
                for (i = 0; i < dots.length; i++) {
                    dots[i].className = dots[i].className.replace(" w3-opacity-off", "");
                }
                x[slideIndex - 1].style.display = "block";
                dots[slideIndex - 1].className += " w3-opacity-off";
            }
        </script>

        <!-- Prevent "space" button script -->
        <script>
            $(function () {
                $('#emailLog').on('keypress', function (e) {
                    if (e.which == 32)
                        return false;
                });
                $('#passwordLog').on('keypress', function (e) {
                    if (e.which == 32)
                        return false;
                });
                $('#passwordReg').on('keypress', function (e) {
                    if (e.which == 32)
                        return false;
                });
                $('#repasswordReg').on('keypress', function (e) {
                    if (e.which == 32)
                        return false;
                });
            });
        </script>

        <!-- Checks the Re-type of password -->
        <script>
            $(function () {

                $('#repasswordReg').on('keyup', function () {
                    var password = $("#passwordReg").val();
                    var confirmPassword = $("#repasswordReg").val();

                    if (password != confirmPassword) {
                        $("#pCheckPassword").html("Passwords do not match!");
                        $('#RegButton').prop('disabled', true);
                    } else {
                        $("#pCheckPassword").html("Passwords match.");
                        $('#RegButton').prop('disabled', false);

                    }
                });
            });
        </script>

        <!-- Calls logout on button click -->
        <script>
            $('#logoutFunction').click(function ()
            {
                setTimeout(function () {
                    document.getElementById('logout').style.display = 'block';
                }, 800);
                var delay = 3000;
                setTimeout(function () {
                    window.location = 'logout.jsp';
                }, delay);
                return false;
            });

        </script>

    </body>
</html>
