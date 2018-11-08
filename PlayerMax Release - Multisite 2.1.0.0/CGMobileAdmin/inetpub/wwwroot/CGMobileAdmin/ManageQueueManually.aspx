<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ManageQueueManually.aspx.cs" Inherits="HAMobileWebAdmin.ManageQueueManually" %>

<%@ Register TagPrefix="My" TagName="ServerTime" Src="~/UserControl/ServerTime.ascx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <link href="Content/custom.css" rel="stylesheet" />
    <script type="text/ecmascript">
    </script>
    <style>
        .td {
            text-align: right;
            padding-right: 15px;
            width: 320px;
        }

        .input:focus {
            border: 1px solid #58B8EF;
        }
    </style>
    <div class="row">
        <div class="col-sm-12">
            <div class="col-sm-6 pull-right">
                <My:ServerTime runat="server" ID="ServerTime" />
            </div>
        </div>
    </div>
    <div class="row">
        <div class="headerBg">
            <span id="spnHeading" runat="server" style="color: white; vertical-align: central;"></span>
        </div>

    </div>
    <div class="tblcontent form-horizontal mt20">

        <div class="form-group">
            <label for="inputEmail3" class="col-sm-2 control-label text-right">Player Club ID</label>
            <div class="col-sm-3">
                <asp:TextBox ID="txtPlayerClubID" runat="server" MaxLength="50" class="form-control fmcontrol"></asp:TextBox>
            </div>
        </div>
        <div class="form-group">
            <label for="inputEmail3" class="col-sm-2 control-label text-right">Party Size</label>
            <div class="col-sm-3">
                <asp:TextBox ID="txtPartySize" runat="server" MaxLength="4" CssClass="form-control fmcontrol numeric" AutoPostBack="true" OnTextChanged="txtPartySize_TextChanged"></asp:TextBox>
            </div>
        </div>

        <div class="form-group">
            <label for="inputEmail3" class="col-sm-2 control-label">Venue </label>
            <div class="col-sm-3">
                <asp:TextBox ID="txtVenue" Style="text-align: center;" disabled="disabled" runat="server" class="form-control fmcontrol"></asp:TextBox>
            </div>
        </div>

        <div class="form-group">
            <label for="inputEmail3" class="col-sm-2 control-label">Mobile # For SMS</label>
            <div class="col-sm-5">
                <asp:TextBox ID="txtMobileSMS" runat="server" MaxLength="13"  onfocus ="return PhoneReFormat();" onblur="return PHoneFormat(this.value);" class="form-control fmcontrol phone numeric"></asp:TextBox>
            </div>
        </div>

        <div class="form-group">
            <label for="inputEmail3" class="col-sm-2 control-label">Reason</label>
            <div class="col-sm-5">
                <asp:TextBox ID="txtReason" runat="server" MaxLength="40" class="form-control fmcontrol"></asp:TextBox>
            </div>
        </div>
        <div class="form-group">
            <label for="inputEmail3" class="col-sm-2 control-label">Est Seating Time</label>
            <div class="col-sm-3">
                <asp:TextBox ID="txtEstimatedTime" disabled="disabled" runat="server" class="form-control fmcontrol"></asp:TextBox>
            </div>
        </div>


    </div>

    <div class="row">
        <div class="col-md-12">
            <div class="col-md-12 icons-control-btn clearfix">
                <asp:Button ID="btncancel" runat="server" Text="CANCEL" CssClass="btn btn-icon-save pull-right btn-gray " OnClick="btncancel_Click" />&nbsp;&nbsp;
                <asp:Button ID="btnconfirm" runat="server" CssClass="btn btn-icon-save pull-right btn-gray" Text="CONFIRM" OnClick="btnconfirm_Click" />
                <asp:Button ID="btnHome" runat="server" Text="Home" CssClass="btn btn-icon-save pull-left btn-gray" OnClick="btnHome_OnClick"></asp:Button>
            </div>
        </div>
    </div>
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
                    <button type="button" class="btn btn-danger cancelbtn" id="btnOK" data-dismiss="modal">OK</button>
                </div>
            </div>
        </div>
    </div>

    <script type="text/javascript">

        isNumber();
        
        function PhoneReFormat() {
            var phone = 0;
            phone = document.getElementById('MainContent_txtMobileSMS').value;
            phone = phone.replace("(", "").replace(")", "").replace("-", "").replace(" ", "");
            document.getElementById('MainContent_txtMobileSMS').value = phone;
            var elemLen = document.getElementById('MainContent_txtMobileSMS').value.length;
            if (document.selection) {
                document.getElementById('MainContent_txtMobileSMS').focus();
                var oSel = document.selection.createRange();
                oSel.moveStart('character', -elemLen);
                oSel.moveStart('character', elemLen);
                oSel.moveEnd('character', 0);
                oSel.select();
            }
            else if (document.getElementById('MainContent_txtMobileSMS').selectionStart || document.getElementById('MainContent_txtMobileSMS').selectionStart == '0') {
                
                document.getElementById('MainContent_txtMobileSMS').selectionStart = elemLen;
                document.getElementById('MainContent_txtMobileSMS').selectionEnd = elemLen;
                document.getElementById('MainContent_txtMobileSMS').focus();
            } 
            return false;
        }


        function PHoneFormat(phonenum) {

            if (document.getElementById('<%=txtMobileSMS.ClientID%>').value.length > 10 && document.getElementById('<%=txtMobileSMS.ClientID%>').value.indexOf('(') === -1) {
                document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Phone number cannot be more than 10 digit.';
                $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                document.getElementById('<%=txtMobileSMS.ClientID%>').value = '';
                return false;
            }
            if (document.getElementById('<%=txtMobileSMS.ClientID%>').value.length < 10) {
                document.getElementById('<%=txtMobileSMS.ClientID%>').value = phonenum;
                return false;
            }
            else {
                if (document.getElementById('<%=txtMobileSMS.ClientID%>').value.length == 10 || document.getElementById('<%=txtMobileSMS.ClientID%>').value != "") {

                    var regexObj = /^(?:\+?1[-. ]?)?(?:\(?([0-9]{3})\)?[-. ]?)?([0-9]{3})[-. ]?([0-9]{4})$/;
                    if (regexObj.test(phonenum)) {
                        var parts = phonenum.match(regexObj);
                        var phone = "";
                        if (parts[1]) { phone += "(" + parts[1] + ") "; }
                        phone += parts[2] + "-" + parts[3];
                        document.getElementById('<%=txtMobileSMS.ClientID%>').value = phone;
                        return phone;
                    }
                    else {
                        document.getElementById('<%=txtMobileSMS.ClientID%>').value = phonenum;
                        return phonenum;
                    }
                }
            }
        }




        function isNumber() {
            $('.numeric').keydown(function (event) {
                // Allow special chars + arrows 

                if (event.keyCode == 46 || event.keyCode == 8 || event.keyCode == 9
                    || event.keyCode == 27 || event.keyCode == 13
                    || (event.keyCode == 65 && event.ctrlKey === true)
                    || (event.keyCode >= 35 && event.keyCode <= 39)) {
                    return;
                }
                else {
                    // If it's not a number stop the keypress
                    if (event.shiftKey || (event.keyCode < 48 || event.keyCode > 57) && (event.keyCode < 96 || event.keyCode > 105)) {
                        event.preventDefault();
                    }

                }
            });
            $(".numeric").bind("paste", function (e) {
                return false;
            });
            $(".numeric").bind("drop", function (e) {
                return false;
            });
        }
        function formValidation() {
          
                if (document.getElementById('<%=txtPlayerClubID.ClientID%>').value == "") {
                    document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please enter Player Club ID';
                    $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                    document.getElementById('<%=txtPlayerClubID.ClientID%>').focus();
                    return false;
                }
          
                if (document.getElementById('<%=txtPartySize.ClientID%>').value == "") {
                    document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please Party Size';
                    $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                    document.getElementById('<%=txtPartySize.ClientID%>').focus();
                    return false;
                }
          
           
                if (document.getElementById('<%=txtMobileSMS.ClientID%>').value == "") {
                    document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please enter Mobile Number';
                    $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                    document.getElementById('<%=txtMobileSMS.ClientID%>').focus();
                    return false;
                }
         
        }
    </script>
</asp:Content>
