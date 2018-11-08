<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="PromotionReport.aspx.cs" Inherits="HAMobileWebAdmin.PromotionReport" %>

<%@ Register TagPrefix="rsweb" Namespace="Microsoft.Reporting.WebForms" Assembly="Microsoft.ReportViewer.WebForms, Version=11.0.0.0, Culture=neutral, PublicKeyToken=89845DCD8080cc91" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="row topMargin">
        <div class="col-sm-4">
            <div class="col-xs-4">
                <label>Date From:</label>
            </div>
            <div class="col-xs-8">
                <div class="input-group date datePickers" data-date-format="mm-dd-yyyy">
                    <asp:TextBox ID="txtDateFrom"  runat="server" class="form-control datePickers"></asp:TextBox>
                    <span class="input-group-addon" id="Span1"><i class="icon-th"></i></span>
                </div>
            </div>
        </div>
        <div class="col-sm-4">
            <div class="col-xs-4">
                <label>Date To:</label> 
            </div>
            <div class="col-xs-8">
                <div class="input-group date datePickers" data-date-format="mm-dd-yyyy">
                    <asp:TextBox ID="txtDateTo" runat="server" class="form-control datePickers"></asp:TextBox>
                    <span class="input-group-addon" id="adscheduleFrom"><i class="icon-th"></i></span>
                </div>
            </div>
        </div>
        <div class="col-sm-4">
            <asp:Button ID="btnGetReport" runat="server" OnClick="btnGetReport_Click" Text="Get Report" />
        </div>
    </div>
    <style type="text/css">
        #ctl00_MainContent_ReportViewer1_ctl05 {
            height: 30px;
            padding-top: 3px;
        }
    </style>
     <div class="row table-viewer">
         <div class="col-md-12 topMargin">
             <rsweb:ReportViewer ID="ReportViewer1" Width="100%" runat="server"></rsweb:ReportViewer>
         </div>
    </div>
    
   
   
    <script type="text/javascript">
        $(document).ready(function () {
            $('.datePickers').datepicker({
                autoclose: true,
                todayBtn: true,
                todayHighlight: true
            });
        });
    </script>
</asp:Content>

