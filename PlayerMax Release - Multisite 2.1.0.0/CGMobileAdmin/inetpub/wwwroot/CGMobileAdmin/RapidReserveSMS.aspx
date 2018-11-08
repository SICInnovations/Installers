<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="RapidReserveSMS.aspx.cs" Inherits="HAMobileWebAdmin.RapidReserveSMS" %>

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
    <asp:UpdatePanel ID="updpnlContent" runat="server" UpdateMode="Conditional">
        <ContentTemplate>

            <asp:HiddenField runat="server" ID="hdnTableAvailableNowText" />
            <asp:HiddenField runat="server" ID="hdnDelayMessageText" />
            <asp:HiddenField runat="server" ID="hdnCustomMessageText" />
            <asp:HiddenField runat="server" ID="hdnCustomMessageLabel" />
            <asp:HiddenField runat="server" ID="hdnSelectedMessage" />
            <div class="row">
                <div class="headerBg">
                    <span id="spnHeading" runat="server" style="color: white; vertical-align: central;">Send SMS Message</span>
                </div>

            </div>
            <div style="text-align: center;">
                <asp:UpdateProgress ID="updateProgress" runat="server">
                    <ProgressTemplate>
                        <div style="position: fixed; text-align: center; height: 100%; width: 100%; top: 0; right: 0; left: 0; z-index: 9999999; background-color: #000000; opacity: 0.7;">
                            <asp:Image ID="imgUpdateProgress" runat="server" ImageUrl="Content/img/loader.gif" AlternateText="Loading ..." ToolTip="Loading ..." Style="padding: 10px; position: fixed; top: 45%; left: 50%;" />
                        </div>
                    </ProgressTemplate>
                </asp:UpdateProgress>
            </div>
            <div class="col-md-12 container mt40">
                <div class="col-md-6 mt46">
                    <asp:Button ID="btnTblAvailNow" runat="server" Text="Table Available Now" CssClass="btn btn-primary NotiBtn sms-button  btn-block " />
                    <asp:Button ID="btnMinDelay" runat="server" Text="Minor Delay Notification" CssClass="btn btn-primary NotiBtn sms-button btn-block" />
                    <asp:Button ID="btnCustomMessage" runat="server" Text="<Custom Message Button Label>" CssClass="btn btn-primary sms-button NotiBtn btn-block" />
                </div>

                <div class="col-md-6">
                    <%--<div class="col-md-6 upside ">--%>
                    <p class="text-center">Preview</p>
                    <p class="text-center">
                        <asp:Label ID="lblMessagePreviewLabel" Style="text-align: center;" runat="server" Text="Message"></asp:Label>
                    </p>
                    <div class="text-box col-md-12">
                        <asp:Label ID="lblMessage" Style="text-align: center;" runat="server" Text=""></asp:Label>
                    </div>
                    <div class="row">
                        <div class=" mt10 col-md-12 clearfix">
                            <asp:Button ID="btnconfirm" runat="server" CssClass="btn btn-primary NotiBtn pull-left  col-md-5 col-xs-12" Text="CONFIRM" OnClick="btnconfirm_Click" />
                            <asp:Button ID="btncancel" runat="server" Text="CANCEL" CssClass="btn btn-primary pull-right NotiBtn col-md-5 col-xs-12" OnClick="btncancel_Click" />&nbsp;&nbsp;
                    
                        </div>
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

        </ContentTemplate>
    </asp:UpdatePanel>

    <script type="text/javascript">
        var prm = Sys.WebForms.PageRequestManager.getInstance();
        if (prm != null) {
            prm.add_endRequest(function (sender, e) {
                if (sender._postBackSettings.panelsToUpdate != null) {
                    SMS();
                }
            });
        };
        $(document).ready(function () {
            SMS();
        });

        function SMS() {
            $('.sms-button').click(function () {
                var id = this.id;
                $('.sms-button').removeClass("active");
                if (id == 'MainContent_btnTblAvailNow') {
                    $(id).addClass("active");
                    var label = 'Table Available Now Message';
                    $('#<%=lblMessagePreviewLabel.ClientID%>').html(label);
                    var msg = $('input:hidden[id*="hdnTableAvailableNowText"]').val();
                    $('#<%=lblMessage.ClientID%>').html(msg);
                    $('#<%=hdnSelectedMessage.ClientID%>').val(msg);
                }

                if (id == 'MainContent_btnMinDelay') {
                    $(id).addClass("active");
                    var label = 'Minor Delay Notification Message';
                    $('#<%=lblMessagePreviewLabel.ClientID%>').html(label);
                    var msg = $('input:hidden[id*="hdnDelayMessageText"]').val();
                    $('#<%=lblMessage.ClientID%>').html(msg);
                    $('#<%=hdnSelectedMessage.ClientID%>').val(msg);
                }
                if (id == 'MainContent_btnCustomMessage') {
                    $(id).addClass("active");
                    var label = $('input:hidden[id*="hdnCustomMessageLabel"]').val() + ' Message';
                    $('#<%=lblMessagePreviewLabel.ClientID%>').html(label);
                    var msg = $('input:hidden[id*="hdnCustomMessageText"]').val();
                    $('#<%=lblMessage.ClientID%>').html(msg);
                    $('#<%=hdnSelectedMessage.ClientID%>').val(msg);
                }
                return false;
            });
        }

    </script>

</asp:Content>
