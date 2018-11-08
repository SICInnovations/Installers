<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Viewer.aspx.cs" Inherits="HAMobileWebAdmin.Viewer" %>

<%@ Register Assembly="Infragistics4.WebUI.WebScheduleDataProvider.v14.1, Version=14.1.20141.2150, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" Namespace="Infragistics.WebUI.Data" TagPrefix="ig_scheduledata" %>

<%@ Register Assembly="Infragistics4.WebUI.WebSchedule.v14.1, Version=14.1.20141.2150, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <script type="text/javascript">

        function DisableDoubleClick() {
            //$("*").dblclick(function () {
            //    return false;
            //});
        }
    </script>
    <link href="Content/css/ig_monthview.css" rel="stylesheet" />
    <link href="Content/css/ig_webschedule.css" rel="stylesheet" />
     <link href="Content/css/ig_shared.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
     <div class="page_links-header">
  <%--<button  title="Tournament" class="igmv_ResourceButton igws_R1 igmv_ResourceButtonActive  " type="button" hidefocus="true" tabindex="-1" uie="RBUT1"><label>Tournament</label></button>--%>
        <button  class="igmv_ResourceButton igws_R2   igmv_FadedAppointment" type="button" hidefocus="true" tabindex="-1" uie="RBUT2"><label>AdPression</label></button>
        <button  class="igmv_ResourceButton igws_R3   igmv_FadedAppointment" type="button" hidefocus="true" tabindex="-1" uie="RBUT3"><label>Refer A Friend</label></button>
     </div>
    <asp:UpdatePanel runat="server">
        <ContentTemplate>
            <igsch:WebMonthView ID="wmvSchedules" WebScheduleInfoID="wmvSchedulesInfo" runat="server"
                Height="600px" Width="100%" WeekendDisplayFormat="Full" WeekNumbersVisible="False" 
                DayOfWeekHeaderFormat="Full" EnableAutoActivityDialog="false" EnableAppStyling="False" EnableTheming="false" 
                NavigationAnimation="Linear" >
                <DayStyle Height="50px" />
            </igsch:WebMonthView>
            <ig_scheduledata:WebScheduleGenericDataProvider runat="server" ID="wmvSchedulesDataSource"
                WebScheduleInfoID="wmvSchedulesInfo" StyleSetName="" StyleSetPath="" StyleSheetDirectory="">
                <AppointmentBinding DataKeyMember="ID" ResourceKeyMember="ResourceKey" />
                <ResourceBinding DataKeyMember="ID" />
                <VarianceBinding DataKeyMember="ID" ResourceKeyMember="ResourceKey" />
            </ig_scheduledata:WebScheduleGenericDataProvider>
            <igsch:WebScheduleInfo ID="wmvSchedulesInfo" runat="server" EnableRecurringActivities="True"
                EnableSmartCallbacks="True" EnableAppStyling="False" EnableMultiResourceView="True" EnableReminders="False"
                OnActivityAdding="wmvSchedulesInfo_ActivityAdding" OnVarianceAdding="wmvSchedulesInfo_VarianceAdding">
            </igsch:WebScheduleInfo>
            <asp:HiddenField runat="server" ID="hdnTournamentColor" Value="#FF3300" />
            <asp:HiddenField runat="server" ID="hdnRafColor" Value="#66FF66" />
            <asp:HiddenField runat="server" ID="hdnAdPressionColor" Value="#FFFF99" />
            <asp:HiddenField runat="server" ID="hdnOffersColor" Value="#009933" />

            <script type="text/javascript">
                $(document).ready(function () {
                    // SetColor();                   
                    RegisterCalendarScript();
                });
                var prm = Sys.WebForms.PageRequestManager.getInstance();
                if (prm != null) {
                    prm.add_endRequest(function (sender, e) {
                        if (sender._postBackSettings.panelsToUpdate != null) {
                           // SetColor();
                            RegisterCalendarScript();
                            
                        }
                    });
                }

                function SetColor() {
                    $('tr').removeAttr('style');
                    $('.igmv_NavigationButtonPrev').find('img').attr('style', 'padding-bottom: 5px;');
                    $('.igmv_NavigationButtonPrev').find('img').attr('src', 'Content/Images/previous.png');
                    $('.igmv_NavigationButtonNext').find('img').attr('style', 'padding-bottom: 5px;');
                    $('.igmv_NavigationButtonNext').find('img').attr('src', 'Content/Images/next.png');
                    $('.igmv_NavigationButton').attr('class', '');
                    $('.igws_R1').css('background-color', $('input:hidden[id*="hdnTournamentColor"]').val());
                    $('.igws_R2').css('background-color', $('input:hidden[id*="hdnAdPressionColor"]').val());
                    $('.igws_R3').css('background-color', $('input:hidden[id*="hdnRafColor"]').val());
                    $('.igws_R4').css('background-color', $('input:hidden[id*="hdnOffersColor"]').val());
                }
                function test()
                {
                    alert();
                }
                function RegisterCalendarScript()
                {                  
                   
                    $(".igws_R1").click(function () {
                       // window.location.href = 'TournamentBuilder.aspx';
                    });

                    $(".igws_R2").click(function () {
                        window.location.href = 'ManageAdPression.aspx';
                    });

                    $(".igws_R3").click(function () {
                        window.location.href = 'ReferAFriend.aspx';
                    });
                }
            </script>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
