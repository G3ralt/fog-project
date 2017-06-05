<%@page import="model.Product"%>
<%@page import="exceptions.ConnectionException"%>
<%@page import="model.Invoice"%>
<%@page import="model.Order"%>
<%@page import="java.util.ArrayList"%>
<%@page import="model.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<% User user = null; 
   Product product = null;
%>
<%! String firstName, lastName, address, email, accountID;
    int phone, zipCode;
%>
<% String errorMessage = ""; %>
<%
    if (session.getAttribute("error") != null) {
        errorMessage = ConnectionException.getExceptionMessage((String) session.getAttribute("error"), session);
        session.removeAttribute("error");%>

<!-- Exception modal-->
<div id="exceptionModal" class="modal" style="overflow-y: scroll; z-index: 10;">
    <form class="modal-content animate">
        <div class="imgcontainer">
            <span onclick="document.getElementById('exceptionModal').style.display = 'none'" class="close" title="Close Modal">&times;</span>
            <h1 class="w3-container ">Error /Exception/ Occurred!</h1>
            <div class="imgcontainer alert alert-danger">
                <strong><%= errorMessage%></strong>
            </div>
        </div>
        <div class="loginContainer">
        </div>
    </form>
</div>
<!-- Exception modal END -->

<!--Make modal Exception to be visible-->
<script>
    // Get the modal
    var modal = document.getElementById('exceptionModal');
    modal.style.display = 'block';
</script>
<% } %>
<%
    if (session.getAttribute("user") == null) {
        response.sendRedirect("../index.jsp");
    } else {
        user = (User) session.getAttribute("user");

        firstName = user.getfName();
        lastName = user.getlName();
        phone = user.getPhone();
        address = user.getAddress();
        zipCode = user.getZipCode();
        email = user.getEmail();
        accountID = user.getAccountID();

    }%>
<%ArrayList<Order> orders = null; %>
<%ArrayList<Invoice> invoices = null; %>
<%orders = (ArrayList<Order>) session.getAttribute("orders");%>
<%invoices = (ArrayList<Invoice>) session.getAttribute("invoices");%>
<html>
    <head>
        <title>Profile page</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <!-- Import end here -->
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
        <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
        <!-- External links to documents -->
        <link rel="stylesheet" href="../css/style.css">
        <script
            src="https://code.jquery.com/jquery-3.2.1.min.js"
            integrity="sha256-hwg4gsxgFZhOsEEamdOYGBf13FyQuiTwlAQgxVSNgt4="
            crossorigin="anonymous">
        </script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
        <style>    
            #editProfile {
                display: none;
            }
        </style>
    </head>

    <body class="w3-light-grey">      
        <nav class="navbar navbar-inverse navbar-fixed-top">
            <div class="container-fluid">
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>                        
                    </button>
                    <a class="navbar-brand" href="../index.jsp">FOG</a>
                </div>
                <div class="collapse navbar-collapse" id="myNavbar">
                    <ul class="nav navbar-nav">                        
                        <li><a href="../beforeyoubuy.jsp">Before you buy</a></li>
                    </ul>      
                    <ul class="nav navbar-nav navbar-right">
                        <% if (user != null) {%>
                        <!-- HERE WHEN LOGGED IN DIV -->
                        <li>
                            <a href="#" id="dropdownMenu1" data-toggle="dropdown"><%= email%>&nbsp;<span class="caret"></span></a>
                            <ul class="dropdown-menu" aria-labelledby="dropdownMenu1">
                                <li class="divider"></li>
                                <li><a id="logoutFunction" href="#">Log out</a></li>
                            </ul>
                        </li>
                        <% } else {%>
                        <!-- ELSE THE COMMON ONE WITH LOGIN -->
                        <li><a href="#" onclick="document.getElementById('id01').style.display = 'block'">Login</a></li>
                            <% }%>
                        <li><a href="../support.jsp">Support</a></li>
                    </ul>
                </div>
            </div>
        </nav>
        <!--Logout modal -->
        <div id="logout" class="modal">
            <form class="modal-content animate">
                <div class="imgcontainer">

                    <h1 class="w3-container ">You are logged out!</h1>
                    <p class="w3-container ">(You will be redirected after 3 seconds...)</p>
                </div>
            </form>
        </div><!-- Logout END -->


        <div style="margin-top: 70px;"></div>

        <div class="w3-white w3-card-2 w3-container w3-margin w3-padding-32">
            <h1>Your very own page</h1>
            <hr>
            <ul class="nav nav-tabs">

                <li role="presentation" class="active"><a href="#pending" id="pending-tab" role="tab" data-toggle="tab"> Profile Info&nbsp;</a></li>


                <li role="presentation" class=""><a href="#completed" role="tab" id="profile" data-toggle="tab" >Orders&nbsp;</a></li>

                <li role="presentation" class=""><a href="#cancelled" role="tab" id="profile-tab" data-toggle="tab">Add info&nbsp;</a></li>
            </ul>

            <div class="tab-content" id="myTabContent">
                <!-- Profile info Tab -->
                <div class="tab-pane fade active in" role="tabpanel" id="pending">
                    <h1><span class="glyphicon glyphicon-user"></span>&nbsp;Profile Info :</h1>
                    <div id="id01" class="w3-padding-16 w3-margin-32 w3-left">
                        <table class="w3-table w3-bordered w3-padding" cellpadding="5">
                            <tr>
                                <th>First Name:</th>
                                <td><%= firstName%></td>
                            </tr>
                            <tr>
                                <th>Last Name:</th>
                                <td><%= lastName%></td>
                            </tr>
                            <tr>
                                <th>Email:</th>
                                <td><%= email%></td>
                            </tr>                        
                            <tr>
                                <th>Address:</th>
                                <td><%= address%></td>
                            </tr>
                            <tr>
                                <th>ZipCode:</th>
                                <td><%= zipCode%></td>
                            </tr>
                            <tr>
                                <th>Phone number:</th>
                                <td><%= phone%></td>
                            </tr>
                            <tr>
                                <th>Account ID: </th>
                                <td><%= accountID%></td>
                            </tr>
                        </table>

                    </div>
                    <!-- Profile info END -->

                    <a id="edit" class="btn btn-warning" onclick="document.getElementById('editProfile').style.display = 'block'">Edit</a>

                    <!-- Edit Profile Modal -->
                    <div class="modal" id="editProfile" style="overflow-y: scroll">
                        <form class="modal-content animate" action="../Profile" method="POST">
                            <div class="loginContainer">
                                <label><b>Email</b></label>
                                <input type="text" placeholder="<%= email%>" name="email" pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,3}$" title="customer@fog.dk" class="inputFields">
                                <label><b>Password</b></label>
                                <input type="password" placeholder="Best min. 8 characters" name="password" title="at least 8 characters" pattern=".{8,}" class="inputFields" id="passwordReg">
                                <label><b>Re-type Password</b></label>
                                <input type="password" placeholder="Just to check ;)" name="repassword" title="type the same password" pattern=".{8,}" class="inputFields" id="repasswordReg">
                                <div><p id="pCheckPassword" style="color: red"></p></div>
                                <label><b>Phone number</b></label>
                                <input type="text" placeholder="<%= phone%>" name="phone" title="e.g. 45871001 (8 numericals)" pattern="[0-9]{8,8}" class="inputFields">
                                <label><b>Address</b></label>
                                <input type="text" placeholder="<%= address%>" name="address" title="e.g. Street Name 23" pattern="[A-Za-z0-9 ]{5,190}">
                                <label><b>Zip code</b></label>
                                <input type="text" placeholder="<%= zipCode%>" name="zipCode" title="e.g. 2800" pattern="[0-9]{4}" class="inputFields">

                                <button type="submit" class="btn btn-success" id="RegButton"><span class="glyphicon glyphicon-ok"></span>&nbsp;Submit</button>
                                <button type="button" class="btn btn-danger pull-right" onclick="document.getElementById('editProfile').style.display = 'none'"><span class="glyphicon glyphicon-remove"></span>&nbsp;Cancel</button>
                            </div>
                        </form>
                    </div>
                    <!-- Edit Profile END -->
                </div>
                <!-- Profile info Tab END-->

                <!-- Orders Tab -->
                <div class="tab-pane fade col-xs-12" role="tabpanel" id="completed">
                    <div class="table-responsive">
                        <h1><span class="glyphicon glyphicon-shopping-cart"></span>&nbsp;Orders</h1>
                        <% if (orders.isEmpty()) { %>
                        <div class="well well-lg">
                            <p>You don't have any orders yet.</p>
                            <p>Sit comfortably , because it is time to make your first :)</p>
                        </div>
                        <% } else {%>
                        <table class="table table-hover">
                            <th>Order ID</th>
                            <th>Order Status</th>
                            <th>More info</th>                         
                                <% for (Order order : orders) {%>                      
                            <tr class="<% if (order.getOrderStatus() == 0) {
                                    out.print("info");
                                } else {
                                    out.print("success");
                                }%>">
                                <td>Order ID: <%=order.getOrderID()%></td>
                                <td>
                                    <p><%if (order.getOrderStatus() == 0) {
                                            out.print("Pending");
                                        } else {
                                            out.print("Completed");
                                        }%>
                                    </p>
                                    <div class="collapse" id="<%= order.getOrderID()%>">
                                        <div class="well col-lg-6">
                                            <p>Ordered on Date: <%=order.getDate()%></p>
                                            <p>Delivery ID:<% if (order.getDeliveryID() == null) {
                                                    out.print(" Waiting for Delivery Date");
                                                } else {
                                                    out.print(" " + order.getDeliveryID());
                                                }%>
                                            </p>
                                            <p>Invoice ID:<% if (order.getInvoiceID() == null) {
                                                    out.print(" Invoice is not issued yet");
                                                } else {
                                                    out.print(" " + order.getInvoiceID());
                                                }%>
                                            </p>
                                        </div>
                                    </div>
                                </td>
                                <td><button type="button" data-toggle="collapse" data-target="#<%=order.getOrderID()%>" >Click to collapse</button></td>
                            </tr>

                            <% }%>
                        </table>
                        <% }%>
                    </div>
                </div>
                <!-- Orders Tab END-->

                <!-- Upload Picture Tab--> 
                <div class="tab-pane fade" role="tabpanel" id="cancelled">
                    <h1><span class="glyphicon glyphicon-picture"></span>&nbsp;Upload a picture of your carport :</h1>
                </div>
                <!-- Upload Picture Tab END -->

            </div>
        </div>



        <footer class="w3-container w3-padding-64 w3-center w3-opacity w3-light-grey w3-xlarge">          
            <h3>Johannes Fog A/S - Firskovvej 20 - 2800 Lyngby - CVR-nr. 16314439</h3>
        </footer>


        <!-- Prevent "space" button script -->
        <script>
            $(function () {
                $('.inputFields').on('keypress', function (e) {
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

        <!-- Close Edit Profile Details modal -->
        <script>
            // Get the modal
            var editProfile = document.getElementById('editProfile');

            // When the user clicks anywhere outside of the modal, close it
            window.onclick = function (event) {
                if (event.target == editProfile) {
                    editProfile.style.display = 'none';
                }
            }
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
                    window.location = '../logout.jsp';
                }, delay);
                return false;
            });

        </script>
    </body>
</html>

