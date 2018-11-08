<%@ Page Title="Log in" Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="HAMobileWebAdmin.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>COG Mobile | Login</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- Bootstrap -->
    <link rel="stylesheet" type="text/css" href="~/Content/css/bootstrap.min.css" />
    <link rel="stylesheet" href="~/Content/css/typography.css" />
    <link rel="stylesheet" href="~/Content/css/glyphicons.css" />
    <link rel="stylesheet" href="~/Content/css/custom.css" />
    <!-- HTML5 Shiv and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
  <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
  <script src="https://oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js"></script>

  <![endif]-->
    <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
    <script type="text/javascript" src="Scripts/CommonJS/jquery-1.11.0.min.js"></script>
    <script type="text/javascript" src="Scripts/CommonJS/bootstrap.min.js"></script>
    <script type="text/javascript" src="Scripts/CommonJS/custom.js"></script>
    <!-- Include all compiled plugins (below), or include individual files as needed -->

    <script type="text/javascript">
        function ValidateUser() {
            if (document.getElementById("txtUserame").value == "") {
              
                document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please enter user id!';
                $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                document.getElementById("txtUserame").focus();
                return false;
            }
            if (document.getElementById("txtPassword").value == "") {
                document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please enter user password!';
                $('#AlertBox').modal({ backdrop: 'static', keyboard: false });              
                document.getElementById("txtPassword").focus();
                return false;
            }
            if (document.getElementById("ddlDomain").value == "-1") {               
                document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please select a domain!';
                $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                document.getElementById("ddlDomain").focus();
                return false;
            }
        }       

        $(document).ready(function () {
            RegisterModel();
            
        });
        function RegisterModel() {
            $('#ConfirmBox').on('show.bs.modal', function (e) {
            });
        }
    </script>
</head>
<body class="login">
    <form id="form1" runat="server">
        <asp:HiddenField runat="server" ID="hdnImageFileId1" />
        <asp:HiddenField runat="server" ID="hdnImageFileId2" />
        <asp:HiddenField runat="server" ID="hdnImageFileId3" />
      <%--  <header>
            <div>
                <asp:Image EnableViewState="True" ID="imgBrandingArea1" runat="server"  Style="width: 340px; height: 150px;" AlternateText="BRANDING AREA 1" />
                <asp:HiddenField runat="server" ID="hdnBrandingArea1Url" />
                <%--<h5 class="uppercase">branding area 1</h5>
            </div>
        </header>--%>
        <div class="section clearfix" id="loginPage">
            
                 
            <div class="login-area">
                    <div>
                   <div>
                          <asp:Image EnableViewState="True" ID="imgBrandingArea1" runat="server"  Style="width: 100%; height: 150px;" AlternateText="BRANDING AREA 1" />
                <asp:HiddenField runat="server" ID="hdnBrandingArea1Url" />
                    </div>
                <div class="clearfix whiteBg" id="loginForm">
                
                    <div class="form-group clearfix borderBottom">
                        <div class="col-xs-4">
                            <label for="userid">User ID</label>
                        </div>
                        <div class="col-xs-8">
                            <asp:TextBox ID="txtUserame" CssClass="form-control2" runat="server" placeholder="User name"></asp:TextBox>
                        </div>
                    </div>
                    <div class="form-group clearfix borderBottom">
                        <div class="col-xs-4">
                            <label for="password">Password</label>
                        </div>
                        <div class="col-xs-8">
                            <asp:TextBox ID="txtPassword" TextMode="Password" CssClass="form-control2" runat="server" placeholder="Password"></asp:TextBox>
                        </div>
                    </div>
                    <div class="form-group clearfix borderBottom">
                        <div class="col-xs-4">
                            <label for="domain">Domain</label>
                        </div>
                        <div class="col-xs-8">
                            <div class="selectWrap">
                                <asp:DropDownList ID="ddlDomain" runat="server">
                                </asp:DropDownList>
                            </div>
                        </div>
                    </div>
                    <div class="form-group clearfix mb0">
                        <asp:Button Text="Sign In" runat="server" ID="btnSignIn" OnClick="btnSignIn_Click" OnClientClick="return ValidateUser()" />
                    </div>
                  
                </div>
                    </div>
                <div class="ht100">
                    <asp:Image EnableViewState="True" ID="imgBrandingArea2" runat="server"  Style="width: 100%;height:100%;"   AlternateText="BRANDING AREA 2" />
                    <asp:HiddenField runat="server" ID="hdnBrandingArea2Url" />
                    <%--<h5 class="uppercase" style="text-align: center; margin: 50px 0">branding area 2</h5>--%>
                </div>
                </div>
            <div class="right-branding-area">
                <div class="center-image">
                <asp:Image EnableViewState="True" ID="imgBrandingArea3" runat="server"   AlternateText="BRANDING AREA 3" />
                <asp:HiddenField runat="server" ID="hdnBrandingArea3Url" />
                <%-- <h5 class="uppercase" style="text-align: center; margin: 200px 0">branding area 3</h5>--%>
                </div>
            </div>
               
        </div>
         <script type="text/javascript">
             $(document).ready(function () {
             $('.center-image').css({ 'height': ((jQuery(window).height())) + 'px' });
              });
    </script>
          <div id="AlertBox" class="modal fade bs-example-modal-sm" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>
                            <h4 class="modal-title">Alert</h4>
                        </div>
                        <div class="modal-body">
                            <p id="alertMessage" runat="server"></p>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn" id="btnOK" data-dismiss="modal">OK</button>
                        </div>
                    </div>
                </div>
            </div>
           
    </form>
   
</body>
</html>
