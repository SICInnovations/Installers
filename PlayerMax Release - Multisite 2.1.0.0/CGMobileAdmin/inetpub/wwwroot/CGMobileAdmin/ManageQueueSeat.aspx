<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ManageQueueSeat.aspx.cs" Inherits="HAMobileWebAdmin.ManageQueueSeat" %>
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
            <span id="spnHeading" runat="server" style="color: white; vertical-align: central;">Confirm Seating</span>
        </div>
    </div>
    <div class="tblcontent form-horizontal mt20 col-md-4 col-md-offset-4">

        <div class="mt20 clearfix">
            <div class="col-sm-12 confirmSeatingLabel text-center">
                <asp:Label ID="lblFullName" runat="server" Text="Full Name" class="label "></asp:Label>
            </div>
        </div>

        <div class="mt20 clearfix">
            <div class="col-sm-12  confirmSeatingLabel text-center">
                <asp:Label ID="lblPartySize" runat="server" Text="Party Size" class="label "></asp:Label>
            </div>
        </div>
        <div class="mt20 clearfix">
            <div class="col-sm-12  confirmSeatingLabel text-center">
                <asp:Label ID="lblPlayerTier" runat="server" Text="Tier" class="label "></asp:Label>
            </div>
        </div>

        <div class="row btncontroles">
            <div class="col-xs-6 mt20">
                    <asp:Button ID="btnconfirm" runat="server" CssClass="btn btn-icon-save btn-gray"  Text="CONFIRM" OnClick="btnconfirm_Click" /></div>
         <div class="col-xs-6  mt20">
                    <asp:Button ID="btncancel" runat="server" Text="CANCEL" CssClass="btn btn-icon-save btn-gray "  OnClick="btncancel_Click"  />&nbsp;&nbsp;</div>
                </div>

    </div>

    <div class="row">
        <div class="col-xs-8">
            <div class="col-xs-6 icons-control-btn pull-right">
               
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
</asp:Content>
