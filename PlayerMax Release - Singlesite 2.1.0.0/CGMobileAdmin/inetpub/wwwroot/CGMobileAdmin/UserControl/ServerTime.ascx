<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ServerTime.ascx.cs" Inherits="HAMobileWebAdmin.UserControl.ServerTime" %>
<asp:Label ID="lblServerTime" runat="server" CssClass="pull-right" Style="font-size: 18px;"></asp:Label>
<asp:HiddenField ID="hdnServerHour" runat="server" />
<asp:HiddenField ID="hdnServerMinutes" runat="server" />
<asp:HiddenField ID="hdnServerSeconds" runat="server" />
<asp:HiddenField ID="hdnServerAMPM" runat="server" />
<script type="text/javascript">
    setInterval(function () {
        var currenthour = Number($('#<%=hdnServerHour.ClientID%>').val());
        var currentmin = Number($('#<%=hdnServerMinutes.ClientID%>').val());
        var currentsec = Number($('#<%=hdnServerSeconds.ClientID%>').val());
        var currentampm = $('#<%=hdnServerAMPM.ClientID%>').val();
        if (currenthour == 0)
            currenthour = 12;
        currentsec = currentsec + 1;
        if (currentsec == 60) {
            currentsec = 0;
            currentmin = currentmin + 1;
        }
        if (currentmin == 60) {
            currentmin = 0;
            currenthour = currenthour + 1;
            if (currenthour == 12 && currentmin==0) {
                if (currentampm == "am" || currentampm == "AM")
                    currentampm = "PM"
                else
                    currentampm = "AM";
            }
        }
        if (currenthour > 12) {
            currenthour = currenthour - 12;
        }

        $('#<%=hdnServerHour.ClientID%>').val(currenthour);
        $('#<%=hdnServerMinutes.ClientID%>').val(currentmin);
        $('#<%=hdnServerSeconds.ClientID%>').val(currentsec);
        $('#<%=hdnServerAMPM.ClientID%>').val(currentampm);
        if (currentmin < 10)
            currentmin = '0' + currentmin;
        $('#<%=lblServerTime.ClientID%>').text("It is " + currenthour + ":" + currentmin + " " + currentampm);
    }, 1000);
</script>
