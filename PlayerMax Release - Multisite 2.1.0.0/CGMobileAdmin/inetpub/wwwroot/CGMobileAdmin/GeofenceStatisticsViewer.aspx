<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="GeofenceStatisticsViewer.aspx.cs" Inherits="HAMobileWebAdmin.GeofenceStatisticsViewer" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=11.0.0.0, Culture=neutral, PublicKeyToken=89845DCD8080cc91" Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="scriptManager1" runat="server" EnablePageMethods="true"></asp:ScriptManager>
        <div>
            <div class="row topMargin">
                <div class="col-md-12">
                    <div class="row">
                        <asp:Label ID="lblErrorMessage" runat="server" Text="Report Not Found. Please try again." ForeColor="Red" Visible="false"></asp:Label>
                        <rsweb:ReportViewer ID="rptViewer" runat="server" Width="100%" valign="top" Height="900px"></rsweb:ReportViewer>
                    </div>
                </div>
            </div>
        </div>
    </form>
</body>
</html>

