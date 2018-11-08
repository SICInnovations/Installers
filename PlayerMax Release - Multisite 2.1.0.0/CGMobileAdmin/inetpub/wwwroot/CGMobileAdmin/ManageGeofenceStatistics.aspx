<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="Site.Master" CodeBehind="ManageGeofenceStatistics.aspx.cs" Inherits="HAMobileWebAdmin.ManageGeofenceStatistics" %>

<asp:Content runat="server" ID="Content1" ContentPlaceHolderID="HeadContent">
    <title>COG Mobile | Manage Geofence Statics</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

<style type="text/css">
    .infomsg {
        display:none;
}
</style>

    <div style="text-align: center;">
        <asp:UpdateProgress ID="updateProgress" runat="server">
            <ProgressTemplate>
                <div style="position: fixed; text-align: center; height: 100%; width: 100%; top: 0; right: 0; left: 0; z-index: 9999999; background-color: #000000; opacity: 0.7;">
                    <asp:Image ID="imgUpdateProgress" runat="server" ImageUrl="Content/img/loader.gif" AlternateText="Loading ..." ToolTip="Loading ..." Style="padding: 10px; position: fixed; top: 45%; left: 50%;" />
                </div>
            </ProgressTemplate>
        </asp:UpdateProgress>
    </div>
    <asp:UpdatePanel ID="updpnlContentDetail" runat="server" UpdateMode="Conditional">
        <ContentTemplate>
            <div class="row">
                <asp:HiddenField runat="server" ID="hdnGeofencefocusLatLong" Value="" />
                <asp:HiddenField runat="server" ID="hdnRadiusLatLong" Value="" />
                <asp:HiddenField runat="server" ID="hdnRadius" Value="" />
                <asp:HiddenField runat="server" ID="hdnIsRadius" Value="" />
                <asp:HiddenField runat="server" ID="hdnIsPolygon" Value="" />
                <asp:HiddenField runat="server" ID="hdnGeofenceID" Value="" />
                <asp:HiddenField runat="server" ID="hdnGimbleID" Value="" />
                <asp:HiddenField runat="server" ID="hdnActive" Value="Active" />
                <asp:HiddenField runat="server" ID="hdnCoordinates" Value="" />
                <asp:HiddenField runat="server" ID="hdnGvGeofenceSelectedIndex" Value="0" />
                <asp:HiddenField runat="server" ID="hdnPolygonLatLong" Value="" />
                <div class="col-sm-3">

                    <div class="filterWrapper">
                        <div id="dvLeftcontentdetail" class="filterWrapper relative" style="min-height: 620px">
                            <h4>Geofence Statistics</h4>
                            <div>
                                <div class="row">
                                    <div class="col-md-12">
                                        <label for="contentType"><b>Property</b></label>
                                        <asp:DropDownList ID="ddlProperty" runat="server" CssClass="form-control jq-selectbox" OnSelectedIndexChanged ="ddlProperty_SelectedIndexChanged" AutoPostBack="true">                                            
                                        </asp:DropDownList>
                                    </div>
                                    <div class="col-md-12">
                                        <label for="contentType"><b>Status</b></label>
                                        <asp:DropDownList ID="ddlStatus" AutoPostBack="true" runat="server" CssClass="form-control jq-selectbox" OnSelectedIndexChanged="ddlStatus_SelectedIndexChanged">
                                            <asp:ListItem Value="0">All</asp:ListItem>
                                            <asp:ListItem Value="1">Only Active Geofences</asp:ListItem>
                                            <asp:ListItem Value="2">Only Inactive Geofences</asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                    <div class="col-md-12  geofence-text">
                                        <label for="contentType"><b>Geofences</b></label>
                                        <asp:DropDownList ID="ddlGeofences" runat="server" CssClass="form-control jq-selectbox">
                                        </asp:DropDownList>
                                    </div>
                                    <div class="clearfix time_data">
                                        <div class="col-md-12 data_range"><b>Date Range for Statistics</b></div>
                                        <div class="col-xs-8 filterWrapper col-xs-8-width">
                                            <div class="row">
                                                <div class="clearfix calTime">
                                                    <div class="col-xs-3">
                                                        <label for="scheduleFrom" class="geofencedatepickarpaddinglabel">From</label>
                                                    </div>
                                                    <div class="col-xs-9">
                                                        <div class="input-group date datePickers" data-date-format="mm-dd-yyyy">
                                                            <asp:TextBox runat="server" ID="txtScheduleFrom" class="form-control datePickers geofencedatepickarwidth geofencedatepickarpadding-input"></asp:TextBox>
                                                            <span class="input-group-addon" id="adscheduleFrom"><i class="icon-th"></i></span>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="clearfix calTime">
                                                    <div class="col-xs-3">
                                                        <label for="scheduleTo" class="geofencedatepickarpaddinglabel">To</label>
                                                    </div>
                                                    <div class="col-xs-9">
                                                        <div class="input-group date datePickers" data-date-format="mm-dd-yyyy">
                                                            <asp:TextBox runat="server" ID="txtScheduleTo" class="form-control datePickers geofencedatepickarwidth "></asp:TextBox>
                                                            <span class="input-group-addon" id="adscheduleto"><i class="icon-th"></i></span>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                        </div>
                                        <div class="col-xs-4 pull-right">
                                            <div class="row">
                                                <div class="clearfix calTime">
                                                    <div class="col-xs-2 row geofencedatepickarpadding-left">
                                                        <label for="scheduleFromAt">at</label>
                                                    </div>
                                                    <div class="col-xs-10 geofencedatepickarpadding-right">
                                                        <div class="bootstrap-timepicker input-group input-group-width">
                                                            <asp:TextBox runat="server" ID="txtScheduleFromAt" class="form-control timePickers"></asp:TextBox>
                                                            <i class="icon-time"></i>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="clearfix calTime">
                                                    <div class="col-xs-2 row geofencedatepickarpadding-left">
                                                        <label for="scheduleToAt ">at</label>
                                                    </div>
                                                    <div class="col-xs-10 geofencedatepickarpadding-right">
                                                        <div class="bootstrap-timepicker input-group input-group-width">
                                                            <asp:TextBox runat="server" ID="txtScheduletoAt" class="form-control timePickers"></asp:TextBox>
                                                            <i class="icon-time"></i>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <asp:Button runat="server" ID="btnGatherStatics" class="col-md-12" Text="Gather Statistics" OnClick="btnGatherStatics_Click" />
                                    </div>

                                </div>
                                <div class="statics-table" >
                                    <table class="statics-tableTableHeight">
                                        <thead>
                                            <tr>
                                                <td width="60%">Metric</td>
                                                <td width="40%">Value</span></td>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr>                                               
                                                <td>People in Selected Geofences Right Now</</td>
                                                <td><span class="pull-left"><b><%=report.PeopleSelectedGeofences %></b></span>
                                                <asp:ImageButton ImageUrl="content/img/value-icon.png" class="pull-right"  runat="server" CommandName="GeofencePeopleNow" CommandArgument="25" ID="btnShowGeofencePeopleNowDetailStatics" OnClick="btnShowDetailStatics_OnClick"/></td>
                                            </tr>
                                            <tr>
                                                <td>Count of Entries</b></</td>
                                                <td><span class="pull-left"><b><%=report.CountofEntries %></b></span>
                                                <asp:ImageButton ImageUrl="content/img/value-icon.png" class="pull-right"  runat="server" CommandName="GeofenceCountOfEntries" CommandArgument="26" ID="btnShowGeofenceCountOfEntriesDetailStatics" OnClick="btnShowDetailStatics_OnClick"/></td>
                                            </tr>
                                            <tr>
                                                <td>Count of Unique Entries</</td>
                                                <td><span class="pull-left"><b><%=report.CountofUniqueEntries %></b></span>
                                                <asp:ImageButton ImageUrl="content/img/value-icon.png" class="pull-right"  runat="server" CommandName="GeofenceCountOfUniqueEntries" CommandArgument="27" ID="btnShowGeofenceCountOfUniqueEntriesDetailStatics" OnClick="btnShowDetailStatics_OnClick"/></td>
                                            </tr>
                                            <tr>
                                                <td>Count of Unique Linked  Account Entries</</td>
                                                <td><span class="pull-left"><b><%=report.CountofUniqueLinkedAccountEntries %></b></span>
                                                <asp:ImageButton ImageUrl="content/img/value-icon.png" class="pull-right"  runat="server" CommandName="GeofenceUniqueLinkedEntries" CommandArgument="28" ID="btnShowGeofenceUniqueLinkedEntriesDetailStatics" OnClick="btnShowDetailStatics_OnClick"/></td>
                                            </tr>
                                            <tr>
                                                <td>Count of Unique Unlinked Account Entries</td>
                                                <td><span class="pull-left"><b><%=report.CountofUniqueUnlinkedAccountEntries %></b></span>
                                                <asp:ImageButton ImageUrl="content/img/value-icon.png" class="pull-right"  runat="server" CommandName="GeofenceUniqueUnlinkedEntries" CommandArgument="29" ID="btnShowGeofenceUniqueUnlinkedEntriesDetailStatics" OnClick="btnShowDetailStatics_OnClick"/></td>
                                            </tr>
                                            <tr>
                                                <td>Average Dwell in Minutes</</td>
                                                <td><span class="pull-left"><b><%=report.AverageDwellinMinutes %></b></span>
                                                <asp:ImageButton ImageUrl="content/img/value-icon.png" class="pull-right"  runat="server" CommandName="GeofenceAvgDwellInMinutes" CommandArgument="30" ID="btnShowGeofenceAvgDwellInMinutesDetailStatics" OnClick="btnShowDetailStatics_OnClick"/></td>
                                            </tr>
                                            <tr>
                                                <td>Count of Messages and Offers to Linked Accounts</</td>
                                                <td><span class="pull-left"><b><%=report.CountofMessagesandOfferstoLinkedAccounts %></b></span>
                                                <asp:ImageButton ImageUrl="content/img/value-icon.png" class="pull-right"  runat="server" CommandName="GeofenceMessageAndOffersLinked" CommandArgument="31" ID="btnShowGeofenceMessageAndOffersLinkedDetailStatics" OnClick="btnShowDetailStatics_OnClick"/></td>
                                            </tr>
                                            <tr>
                                                <td>Count of Messages and  Offers to Unlinked Accounts</td>
                                                <td><span class="pull-left"><b><%=report.CountofMessagesandOfferstoUnlinkedAccounts %></b></span>
                                                <asp:ImageButton ImageUrl="content/img/value-icon.png" class="pull-right"  runat="server" CommandName="GeofenceMessageAndOffersUnLinked" CommandArgument="32" ID="btnShowGeofenceMessageAndOffersUnLinkedDetailStatics" OnClick="btnShowDetailStatics_OnClick"/></td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-sm-9">
                    <div class="row clearfix relative btnGroup btnGroup3 dvgeofencerightheight" id="dvRightContent">
                        <div class="col-md-12 clearfix">
                            <div class="map_seg clearfix">
                                <div class="row">
                                    <div class="ctrl_btns GeofencestaticsMapHeight col-lg-6 col-md-7 col-xs-12 pull-right">
                                        <button class="btn zoom-out">
                                            <asp:ImageButton runat="server" ImageUrl="Content/img/zoom-out.png" ID="ImageButton1" />
                                        </button>
                                        <button class="btn zoom-in">
                                            <asp:ImageButton runat="server" ImageUrl="Content/img/zoom-in.png" ID="ImageButton2" />
                                        </button>
                                        <div id="map-canvas"></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <script type="text/javascript">

                $(document).ready(function () {
                    RegisterDateAndTimePickers();
                    //Set Polygon configurations
                    var centerpointlatlong = document.getElementById('MainContent_hdnGeofencefocusLatLong').value;
                    var type;
                    if (centerpointlatlong != '') {
                        var xy = centerpointlatlong.split(",");
                        SetCenterPoint(xy[0], xy[1]);
                    }
                    else {
                        SetCenterPoint('', '');
                    }
                    SetMapDrawingType();
                    $("#dvRightContent").height($('#dvLeftcontentdetail').height());

                });
                //***************************************Start On UpdatePanel Refresh Register Common Functions ********************************************************8

                var prm = Sys.WebForms.PageRequestManager.getInstance();
                if (prm != null) {
                    prm.add_endRequest(function (sender, e) {
                        if (sender._postBackSettings.panelsToUpdate != null) {

                            RegisterDateAndTimePickers();
                            //Set Polygon configurations
                            var centerpointlatlong = document.getElementById('MainContent_hdnGeofencefocusLatLong').value;
                            if (centerpointlatlong != '') {
                                var xy = centerpointlatlong.split(",");
                                SetCenterPoint(xy[0], xy[1]);
                            }
                            else {
                                SetCenterPoint('', '');
                            }
                            SetMapDrawingType();
                            $("#dvRightContent").height($('#dvLeftcontentdetail').height());
                        }
                    });
                }
                function SetMapDrawingType() {
                    var type;
                    var radius = document.getElementById('MainContent_hdnRadius').value;
                    var isRadius = $('#<%=hdnIsRadius.ClientID%>').val();
                    var isPolygon = $('#<%=hdnIsPolygon.ClientID%>').val();

                    if (isRadius == 1)
                        type = 1;
                    else if (isPolygon == 1)
                        type = 0;

                    IsRadius(type);
                    initialize();

                    if (isRadius == 1) {
                        var radiusLatLong = document.getElementById('MainContent_hdnRadiusLatLong').value;
                        DrawRadius(radiusLatLong, radius)
                    }
                    if (isPolygon == 1) {
                        var polygonLatLong = document.getElementById('MainContent_hdnPolygonLatLong').value;
                        DrawPolygon(polygonLatLong);
                    }
                }
                function RegisterDateAndTimePickers() {
                    //  Date Picker
                    $('.datePickers').datepicker({
                        autoclose: true,
                        todayBtn: true,
                        todayHighlight: true
                    });

                    $('.timePickers').timepicker(
                    {
                        template: false,
                        showInputs: false,
                        minuteStep: 5,
                        defaultTime: false
                    });
                }

                function FormValidation() {


                }
            </script>
            <script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?v=3.exp&sensor=false&libraries=drawing,geometry"></script>
            <asp:PlaceHolder runat="server" ID="PlaceholderGeofenceScript1"></asp:PlaceHolder>
        </ContentTemplate>
    </asp:UpdatePanel>

</asp:Content>
