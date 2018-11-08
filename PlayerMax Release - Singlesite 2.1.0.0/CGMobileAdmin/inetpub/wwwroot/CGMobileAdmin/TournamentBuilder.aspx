<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="TournamentBuilder.aspx.cs" Inherits="HAMobileWebAdmin.TournamentBuilder" %>
<%@ Register Src="~/UserControl/CsvUploadControl.ascx" TagName="CsvUploadControl" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <link href="Content/css/scroll.css" rel="stylesheet" />
    <link href="Content/css/select2.css" rel="stylesheet" />
    <script src="Scripts/CommonJS/datatables.min.js"></script>
    <script src="Scripts/CommonJS/scroll.js"></script>   
    <script src="Scripts/select2.js"></script>
        
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div style="text-align: center;">
        <asp:UpdateProgress ID="updateProgress" runat="server">
            <ProgressTemplate>
                <div style="position: fixed; text-align: center; height: 100%; width: 100%; top: 0; right: 0; left: 0; z-index: 9999999; background-color: #000000; opacity: 0.7;">
                    <asp:Image ID="imgUpdateProgress" runat="server" ImageUrl="Content/img/loader.gif" AlternateText="Loading ..." ToolTip="Loading ..." Style="padding: 10px; position: fixed; top: 45%; left: 50%;" />
                </div>
            </ProgressTemplate>
        </asp:UpdateProgress>
    </div>
    <asp:UpdatePanel runat="server" ID="updPnlTournamentBuilder">
        <ContentTemplate>
            <div class="row" id="slotInventory">
                <div class="col-sm-3">
                    <h5>Tournament Builder</h5>
                    <div class="filterWrapper relative" id="dvLeftTournamentGrid">
                        <div class="row">
                            <div class="col-xs-7">
                                <label>Tournaments</label>
                            </div>
                            <div class="col-xs-5"><span class="addBtn">Add
                                <asp:Button runat="server" ID="btnAddTournament" OnClick="btnAddTournament_OnClick" CssClass="btn btn-add pull-right" /></span>
                           
                                
                                 </div>
                        </div>
                        <div class="input-group">
                            <asp:TextBox runat="server" CssClass="form-control height26" ID="txtTournamentFilter" />
                            <span class="input-group-btn">
                                <asp:Button ID="btnSearchTournament" OnClick="btnSearchTournament_OnClick" CssClass="btn btn-black glyphicons filter btn-icon white" runat="server" />
                                <i></i>
                            </span>
                        </div>
                        <div id="divgv">
                            <asp:GridView runat="server" CssClass="gridview" ID="grdTournaments" ShowHeader="False" AutoGenerateColumns="False" DataKeyNames="TournamentID" AllowPaging="true" PageSize="10" OnPageIndexChanging="grdTournaments_OnPageIndexChanging">
                                <Columns>
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <asp:LinkButton runat="server" ID="lnkTournament" CommandName="Select" Text='<%#Eval("TournamentName") %>' OnClick="lnkTournament_OnClick"></asp:LinkButton>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                                <PagerStyle CssClass="gridview-pager"></PagerStyle>
                                <SelectedRowStyle CssClass="gvSelectedRow" />
                            </asp:GridView>
                            <div id="content">
                            </div>
                        </div>
                        <div class="filterResults relative btnGroup">
                            <div class="btn-groupSpecial">
                                <asp:Button Text="Active" ID="lnkBtnActive" OnClick="lnkBtnActive_OnClick" CssClass="results-control col-xs-4" runat="server" />
                                <asp:Button Text="InActive" ID="lnkBtnInActive" OnClick="lnkBtnInActive_OnClick"  CssClass="results-control col-xs-4" runat="server" />
                                <asp:Button Text="All" ID="lnkBtnAll" OnClick="lnkBtnAll_OnClick"  CssClass="results-control col-xs-4" runat="server" />
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-sm-9">
                    <h5>Tournament Details</h5>
                    <div class="row clearfix relative btnGroup btnGroup3" id="dvRightContent">
                        <div class="col-md-12 clearfix">
                            <div class="tabControls">
                                <ul class="nav nav-tabs">
                                    <li class="col-xsm-7" id="liDetails"><a href="#detailsTab" data-toggle="tab">Details</a></li>
                                    <li class="col-xsm-3" id="liMessages"><a href="#messageTab" data-toggle="tab">Messages</a></li>
                                </ul>
                                <div class="tab-content">
                                    <!--Detail Tab Starts-->
                                    <div class="tab-pane active" id="detailsTab">
                                        <div class="">
                                            <div class="tabbable tabs-left">
                                                <ul class="nav nav-tabs">
                                                    <li class="col-xsm-5" id="liOverview"><a href="#overviewTab" data-toggle="tab">Overview</a></li>
                                                    <li class="col-xsm-5" id="liDefinition"><a href="#definitionTab" data-toggle="tab">Definition</a></li>
                                                    <li class="col-xsm-5" id="liSchedule"><a href="#scheduleTab" data-toggle="tab">Schedule</a></li>
                                                    <li class="col-xsm-5" id="liLocation"><a href="#locationTab" data-toggle="tab">Location</a></li>
                                                    <li class="col-xsm-5 .nav" id="liPopulation"><a href="#populationTab" data-toggle="tab">Population</a></li>
                                                </ul>
                                                <div class="tab-content">
                                                    <!--Overview Tab Starts-->
                                                    <div class="tab-pane fade" id="overviewTab">
                                                        <div class="tab-container clearfix">
                                                            <div class="col-md-12">
                                                                <asp:Literal runat="server" ID="ltlOverview"></asp:Literal>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <!--Overview Tab Ends-->

                                                    <!--Definition Tab Starts-->
                                                    <div class="tab-pane fade" id="definitionTab">
                                                        <div class="tab-container clearfix">
                                                            <div class="col-md-4">
                                                                <asp:HiddenField ID="hdnTotalLeaderBoardEntry" runat="server" Value="0" />
                                                                <label for="<%=txtTournamentName.ClientID %>">Tournament Name</label>
                                                                <asp:TextBox runat="server" ID="txtTournamentName" CssClass="form-control" />

                                                                <label for="<%=txtTournamentDesc.ClientID %>">Tournament Description</label>
                                                                <asp:TextBox runat="server" ID="txtTournamentDesc" CssClass="form-control" />

                                                                <label for="<%=txtLeaderBoardPos.ClientID %>">Leaderboard Position</label>
                                                                <asp:TextBox runat="server" ID="txtLeaderBoardPos" onkeypress="return isNumber(event);" AutoPostBack="True"
                                                                    OnTextChanged="txtLeaderBoardPos_OnTextChanged" CssClass="form-control" />

                                                                <label for="<%=ddlTournamentLeaderBoardBasis.ClientID %>">Tournament Leaderboard Basis</label>
                                                                <asp:DropDownList runat="server" CssClass="form-control" ID="ddlTournamentLeaderBoardBasis">
                                                                </asp:DropDownList>

                                                                <label for="<%=txtPointCalculationFactor.ClientID %>">Point Calculation Factor</label>
                                                                <asp:TextBox runat="server" ID="txtPointCalculationFactor" onkeypress="return isNumber(event);" CssClass="form-control" />

                                                                <label for="<%=txtExampleCalculation.ClientID %>">Example Calculation</label>
                                                                <asp:TextBox runat="server" ReadOnly="True" ID="txtExampleCalculation" CssClass="form-control" TextMode="MultiLine" />

                                                                <label for="<%=txtLeaderBoardAwardValue.ClientID %>">Leaderboard Award Value</label>
                                                                <asp:TextBox runat="server" ReadOnly="True" ID="txtLeaderBoardAwardValue" CssClass="form-control" />
                                                            </div>
                                                            <div class="col-md-8">
                                                                <label>Tournament Awards</label>
                                                                <div class="progress">
                                                                    <div aria-valuemax="100" aria-valuemin="0" role="progressbar" class="progress-bar progress-bar-success">
                                                                        <span class="sr-only"></span>
                                                                    </div>
                                                                </div>
                                                                <div id="ScrollableDiv">
                                                                    <asp:GridView runat="server" CssClass="table" ShowHeader="True" ID="grdLeaderBoardPositions"
                                                                        OnRowDataBound="grdLeaderBoardPositions_OnRowDataBound" AutoGenerateColumns="False">
                                                                        <Columns>
                                                                            <asp:TemplateField HeaderText="Leaderboard Position">
                                                                                <ItemTemplate>
                                                                                    <%#Container.DisplayIndex + 1 %>
                                                                                </ItemTemplate>
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="Leaderboard Award">
                                                                                <ItemTemplate>
                                                                                    <asp:DropDownList runat="server" ID="ddlAwards" CssClass="col-sm-12" />
                                                                                </ItemTemplate>
                                                                            </asp:TemplateField>
                                                                        </Columns>
                                                                    </asp:GridView>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <!--Definition Tab Ends-->

                                                    <!--Schedule Tab Start-->
                                                    <div class="tab-pane fade" id="scheduleTab">
                                                        <asp:Panel runat="server" ID="pnlSchedule">
                                                            <div class="tab-container clearfix">
                                                                <div class="col-md-4">
                                                                    <div class="filterWrapper filterWrapper2 relative">
                                                                        <div class="row clearfix whiteBg">
                                                                            <div class="col-xs-7">
                                                                                <label>Schedule</label>
                                                                            </div>
                                                                            <div class="col-xs-5">
                                                                                <span class="addBtn">Add<asp:Button ID="lnkbtnAddSchedule" runat="server" OnClick="btnAddSchedule_Click"
                                                                                    CssClass="btn btn-add pull-right"></asp:Button>
                                                                                </span>
                                                                            </div>
                                                                        </div>
                                                                        <div class="input-group">
                                                                            <asp:TextBox runat="server" ID="txtSearchBox" CssClass="form-control height26" />
                                                                            <span class="input-group-btn">
                                                                                <asp:Button ID="btnSearchSchedule" OnClick="btnSearchSchedule_OnClick" CssClass="btn btn-black glyphicons filter btn-icon white" runat="server" /><i></i>
                                                                            </span>
                                                                        </div>
                                                                        <div class="filterResults filterWrapper filterWrapper2 relative schedulegridheight ">
                                                                            <div id="div57">
                                                                                <asp:GridView CssClass="gridview" ID="grdSchedules" DataKeyNames="EventScheduleID" runat="server" ShowHeader="False" AutoGenerateColumns="false"
                                                                                    AllowPaging="true">
                                                                                    <Columns>
                                                                                        <asp:TemplateField>
                                                                                            <ItemTemplate>
                                                                                                <asp:LinkButton ID="lnkBtnScheduleName" runat="server" Text='<%#Eval("ScheduleName") %>' OnClick="lnkBtnScheduleName_Click" />
                                                                                            </ItemTemplate>
                                                                                        </asp:TemplateField>
                                                                                    </Columns>
                                                                                    <PagerStyle CssClass="gridview-pager"></PagerStyle>
                                                                                    <SelectedRowStyle CssClass="gvSelectedRow" />
                                                                                </asp:GridView>
                                                                                <div id="Div58"></div>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <div class="col-md-8">
                                                                    <label for="<%=txtScheduleName.ClientID %>">Schedule Name</label>
                                                                    <asp:TextBox ID="txtScheduleName" runat="server" CssClass="form-control"></asp:TextBox>
                                                                    <div class="fieldset">
                                                                        <fieldset>
                                                                            <legend>
                                                                                <label>Schedule</label></legend>
                                                                            <div class="col-xs-6">
                                                                                <div class="clearfix calTime">
                                                                                    <div class="col-xs-3">
                                                                                        <label for="adscheduleFrom">From</label>
                                                                                    </div>
                                                                                    <div class="col-xs-9">
                                                                                        <div class="input-group date datePickers" data-date-format="mm-dd-yyyy">
                                                                                            <asp:TextBox ID="txtScheduleFrom" runat="server" class="form-control datePickers"></asp:TextBox>
                                                                                            <span class="input-group-addon" id="Span1"><i class="icon-th"></i></span>
                                                                                        </div>
                                                                                    </div>
                                                                                </div>
                                                                                <div class="clearfix calTime">
                                                                                    <div class="col-xs-3">
                                                                                        <label for="<%=txtScheduleTo.ClientID %>">To</label>
                                                                                    </div>
                                                                                    <div class="col-xs-9">
                                                                                        <div class="input-group date datePickers" data-date-format="mm-dd-yyyy">
                                                                                            <asp:TextBox ID="txtScheduleTo" runat="server" class="form-control datePickers"></asp:TextBox>
                                                                                            <span class="input-group-addon" id="adscheduleFrom"><i class="icon-th"></i></span>
                                                                                        </div>
                                                                                    </div>
                                                                                </div>
                                                                            </div>
                                                                            <div class="col-xs-6">
                                                                                <div class="clearfix calTime">
                                                                                    <div class="col-xs-3">
                                                                                        <label for="<%=txtScheduleFromAt.ClientID %>">At</label>
                                                                                    </div>
                                                                                    <div class="col-xs-9">
                                                                                        <div class="bootstrap-timepicker input-group">
                                                                                            <asp:TextBox ID="txtScheduleFromAt" runat="server" class="form-control timePickers"></asp:TextBox>
                                                                                            <i class="icon-time"></i>
                                                                                        </div>
                                                                                    </div>
                                                                                </div>
                                                                                <div class="clearfix calTime">
                                                                                    <div class="col-xs-3">
                                                                                        <label for="<%=txtscheduleToAt.ClientID %>">At</label>
                                                                                    </div>
                                                                                    <div class="col-xs-9">
                                                                                        <div class="bootstrap-timepicker input-group">
                                                                                            <asp:TextBox ID="txtscheduleToAt" runat="server" class="form-control timePickers"></asp:TextBox>
                                                                                            <i class="icon-time"></i>
                                                                                        </div>
                                                                                    </div>
                                                                                </div>
                                                                            </div>
                                                                            <div class="col-xs-12 clearfix">
                                                                                <div class="col-xs-12">
                                                                                    <asp:RadioButton runat="server" Text="Active Across Event Window" ID="rdbAccessAcrossEventWindow" Checked="True" GroupName="adactiveWindow" />
                                                                                </div>
                                                                            </div>
                                                                            <div class="col-xs-12 clearfix">
                                                                                <div class="col-xs-12">
                                                                                    <asp:RadioButton runat="server" Text="Active Within Event Window" ID="rdbAccessWithinEventWindow" GroupName="adactiveWindow" />
                                                                                </div>
                                                                            </div>
                                                                        </fieldset>
                                                                    </div>
                                                                    <div class="fieldset nomargin">
                                                                        <fieldset>
                                                                            <legend>
                                                                                <asp:CheckBox Text="Schedule by Day of Week" ID="chkScheduleByDayOfWeek" runat="server" />
                                                                            </legend>
                                                                            <table class="table scheduleTable fieldSwitch">
                                                                                <tbody>
                                                                                    <tr>
                                                                                        <td>
                                                                                            <asp:CheckBox Text="Monday" runat="server" ID="chkMonday" />
                                                                                        </td>
                                                                                        <td>
                                                                                            <label for="<%=txtScheduleMondayFrom.ClientID %>" class="pull-left">From</label>
                                                                                            <div class="pull-right">
                                                                                                <div class="bootstrap-timepicker input-group">
                                                                                                    <asp:TextBox ID="txtScheduleMondayFrom" runat="server" class="form-control timePickers"></asp:TextBox>
                                                                                                    <i class="icon-time"></i>
                                                                                                </div>
                                                                                            </div>
                                                                                        </td>
                                                                                        <td>
                                                                                            <label for="<%=txtScheduleMondayTo.ClientID %>" class="pull-left">To</label>
                                                                                            <div class="pull-right">
                                                                                                <div class="bootstrap-timepicker input-group">
                                                                                                    <asp:TextBox ID="txtScheduleMondayTo" runat="server" class="form-control timePickers"></asp:TextBox>
                                                                                                    <i class="icon-time"></i>
                                                                                                </div>
                                                                                            </div>
                                                                                        </td>
                                                                                    </tr>
                                                                                    <tr>
                                                                                        <td>
                                                                                            <asp:CheckBox Text="Tuesday" runat="server" ID="chkTuesday" />
                                                                                        </td>
                                                                                        <td>
                                                                                            <label for="<%=txtScheduleTueFrom.ClientID %>" class="pull-left">From</label>
                                                                                            <div class="pull-right">
                                                                                                <div class="bootstrap-timepicker input-group">
                                                                                                    <asp:TextBox ID="txtScheduleTueFrom" runat="server" class="form-control timePickers"></asp:TextBox>
                                                                                                    <i class="icon-time"></i>
                                                                                                </div>
                                                                                            </div>
                                                                                        </td>
                                                                                        <td>
                                                                                            <label for="<%=txtScheduleTueTo.ClientID %>" class="pull-left">To</label>
                                                                                            <div class="pull-right">
                                                                                                <div class="bootstrap-timepicker input-group">
                                                                                                    <asp:TextBox ID="txtScheduleTueTo" runat="server" class="form-control timePickers"></asp:TextBox>
                                                                                                    <i class="icon-time"></i>
                                                                                                </div>
                                                                                            </div>
                                                                                        </td>
                                                                                    </tr>
                                                                                    <tr>
                                                                                        <td>
                                                                                            <asp:CheckBox Text="Wednesday" runat="server" ID="chkWednesday" />
                                                                                        </td>
                                                                                        <td>
                                                                                            <label for="<%=txtScheduleWedFrom.ClientID %>" class="pull-left">From</label>
                                                                                            <div class="pull-right">
                                                                                                <div class="bootstrap-timepicker input-group">
                                                                                                    <asp:TextBox ID="txtScheduleWedFrom" runat="server" class="form-control timePickers"></asp:TextBox>
                                                                                                    <i class="icon-time"></i>
                                                                                                </div>
                                                                                            </div>
                                                                                        </td>
                                                                                        <td>
                                                                                            <label for="<%=txtScheduleWedTo.ClientID %>" class="pull-left">To</label>
                                                                                            <div class="pull-right">
                                                                                                <div class="bootstrap-timepicker input-group">
                                                                                                    <asp:TextBox ID="txtScheduleWedTo" runat="server" class="form-control timePickers"></asp:TextBox>
                                                                                                    <i class="icon-time"></i>
                                                                                                </div>
                                                                                            </div>
                                                                                        </td>
                                                                                    </tr>
                                                                                    <tr>
                                                                                        <td>
                                                                                            <asp:CheckBox Text="Thursday" ID="chkThursday" runat="server" />
                                                                                        </td>
                                                                                        <td>
                                                                                            <label for="<%=txtScheduleThuFrom.ClientID %>" class="pull-left">From</label>
                                                                                            <div class="pull-right">
                                                                                                <div class="bootstrap-timepicker input-group">
                                                                                                    <asp:TextBox ID="txtScheduleThuFrom" runat="server" class="form-control timePickers"></asp:TextBox>
                                                                                                    <i class="icon-time"></i>
                                                                                                </div>
                                                                                            </div>
                                                                                        </td>
                                                                                        <td>
                                                                                            <label for="<%=txtScheduleThuTo.ClientID %>" class="pull-left">To</label>
                                                                                            <div class="pull-right">
                                                                                                <div class="bootstrap-timepicker input-group">
                                                                                                    <asp:TextBox ID="txtScheduleThuTo" runat="server" class="form-control timePickers"></asp:TextBox>
                                                                                                    <i class="icon-time"></i>
                                                                                                </div>
                                                                                            </div>
                                                                                        </td>
                                                                                    </tr>
                                                                                    <tr>
                                                                                        <td>
                                                                                            <asp:CheckBox Text="Friday" ID="chkFriday" runat="server" />
                                                                                        </td>
                                                                                        <td>
                                                                                            <label for="<%=txtScheduleFriFrom.ClientID %>" class="pull-left">From</label>
                                                                                            <div class="pull-right">
                                                                                                <div class="bootstrap-timepicker input-group">
                                                                                                    <asp:TextBox ID="txtScheduleFriFrom" runat="server" class="form-control timePickers"></asp:TextBox>
                                                                                                    <i class="icon-time"></i>
                                                                                                </div>
                                                                                            </div>
                                                                                        </td>
                                                                                        <td>
                                                                                            <label for="<%=txtScheduleFriTo.ClientID %>" class="pull-left">To</label>
                                                                                            <div class="pull-right">
                                                                                                <div class="bootstrap-timepicker input-group">
                                                                                                    <asp:TextBox ID="txtScheduleFriTo" runat="server" class="form-control timePickers"></asp:TextBox>
                                                                                                    <i class="icon-time"></i>
                                                                                                </div>
                                                                                            </div>
                                                                                        </td>
                                                                                    </tr>
                                                                                    <tr>
                                                                                        <td>
                                                                                            <asp:CheckBox Text="Saturday" ID="chkSaturday" runat="server" />
                                                                                        </td>
                                                                                        <td>
                                                                                            <label for="<%=txtScheduleSatFrom.ClientID %>" class="pull-left">From</label>
                                                                                            <div class="pull-right">
                                                                                                <div class="bootstrap-timepicker input-group">
                                                                                                    <asp:TextBox ID="txtScheduleSatFrom" runat="server" class="form-control timePickers"></asp:TextBox>
                                                                                                    <i class="icon-time"></i>
                                                                                                </div>
                                                                                            </div>
                                                                                        </td>
                                                                                        <td>
                                                                                            <label for="<%=txtScheduleSatTo.ClientID %>" class="pull-left">To</label>
                                                                                            <div class="pull-right">
                                                                                                <div class="bootstrap-timepicker input-group">
                                                                                                    <asp:TextBox ID="txtScheduleSatTo" runat="server" class="form-control timePickers"></asp:TextBox>
                                                                                                    <i class="icon-time"></i>
                                                                                                </div>
                                                                                            </div>
                                                                                        </td>
                                                                                    </tr>
                                                                                    <tr>
                                                                                        <td>
                                                                                            <asp:CheckBox Text="Sunday" ID="chkSunday" runat="server" />
                                                                                        </td>
                                                                                        <td>
                                                                                            <label for="<%=txtScheduleSunFrom.ClientID %>" class="pull-left">From</label>
                                                                                            <div class="pull-right">
                                                                                                <div class="bootstrap-timepicker input-group">
                                                                                                    <asp:TextBox ID="txtScheduleSunFrom" runat="server" class="form-control timePickers"></asp:TextBox>
                                                                                                    <i class="icon-time"></i>
                                                                                                </div>
                                                                                            </div>
                                                                                        </td>
                                                                                        <td>
                                                                                            <label for="<%=txtScheduleSunTo.ClientID %>" class="pull-left">To</label>
                                                                                            <div class="pull-right">
                                                                                                <div class="bootstrap-timepicker input-group">
                                                                                                    <asp:TextBox ID="txtScheduleSunTo" runat="server" class="form-control timePickers"></asp:TextBox>
                                                                                                    <i class="icon-time"></i>
                                                                                                </div>
                                                                                            </div>
                                                                                        </td>
                                                                                    </tr>
                                                                                </tbody>
                                                                            </table>
                                                                        </fieldset>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <asp:HiddenField runat="server" ID="hdnScheduleId" Value="0" />
                                                        </asp:Panel>
                                                    </div>
                                                    <!--Schedule Tab Ends-->

                                                    <!--Location Tab Starts-->

                                                    <div class="tab-pane fade" id="locationTab">
                                                        <div class="">
                                                            <div class="tabbable tabs-left">
                                                                <ul class="nav nav-tabs">
                                                                    <li id="liAreas" class="active col-xsm-32"><a data-toggle="tab" href="#locationAreaTab">Area</a></li>
                                                                    <li id="liSection" class="col-xsm-32"><a data-toggle="tab" href="#locationSectionTab">Section</a></li>
                                                                    <li id="liPosition" class="col-xsm-32"><a data-toggle="tab" href="#locationPositionTab">Position</a></li>
                                                                </ul>
                                                                <div class="tab-content">
                                                                    
                                                                    <!--Location Area Tab Starts-->
                                                                    <div id="locationAreaTab" class="tab-pane fade in active">
                                                                        <div class="tab-container clearfix">
                                                                            <div class="col-md-12">
                                                                                <div class="fieldset">
                                                                                    <fieldset>
                                                                                        <legend>
                                                                                            <asp:CheckBox Text="All Areas" runat="server" ID="chkLocationAllAreas" />
                                                                                        </legend>
                                                                                        <div class="row fieldSwitch">
                                                                                            <div class="col-md-12">
                                                                                                <div class="col-md-12">
                                                                                                    <label>Areas</label>
                                                                                                </div>
                                                                                            </div>
                                                                                            <asp:ListBox runat="server" ID="lstLocationAreas" SelectionMode="Multiple" CssClass="areaListBox col-md-12"></asp:ListBox>
                                                                                            <asp:HiddenField runat="server" ID="hdnSelectedLocationAreas" Value="0" />
                                                                                            <asp:HiddenField runat="server" ID="hdnLocationAreaFileName" Value="" />
                                                                                             <asp:HiddenField runat="server" ID="hdnIsLocationAreasReplaceUpdate" Value="" />
                                                                                            <uc1:CsvUploadControl runat="server" ID="uploadAreas" HeaderMessage="Upload Areas By CSV" />
                                                                                        </div>
                                                                                    </fieldset>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <!--Location Area Tab Ends-->

                                                                    <!--Location Section Tab Starts-->
                                                                    <div id="locationSectionTab" class="tab-pane fade">
                                                                        <div class="tab-container clearfix">
                                                                            <div class="col-md-12">
                                                                                <div class="fieldset">
                                                                                    <fieldset>
                                                                                        <legend>
                                                                                            <asp:CheckBox Text="All Sections" runat="server" ID="chkLocationAllSections" />
                                                                                        </legend>
                                                                                        <div class="row fieldSwitch">
                                                                                            <div class="col-md-12">
                                                                                                <div class="col-md-12">
                                                                                                    <label>Sections</label>
                                                                                                </div>
                                                                                            </div>
                                                                                            <asp:ListBox runat="server" ID="lstLocationSections" SelectionMode="Multiple" CssClass="sectionsListBox col-md-12"></asp:ListBox>
                                                                                            <asp:HiddenField runat="server" ID="hdnSelectedLocationSections" Value="0" />
                                                                                               <asp:HiddenField runat="server" ID="hdnLocationSectionsFileName" Value="" />
                                                                                              <asp:HiddenField runat="server" ID="hdnIsLocationSectionsReplaceUpdate" Value="" />
                                                                                            <uc1:CsvUploadControl runat="server" ID="uploadSections" HeaderMessage="Upload Sections By CSV" />
                                                                                        </div>
                                                                                    </fieldset>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <!--Location Section Tab Ends-->

                                                                    <!--Location Position Tab Starts-->
                                                                    <div id="locationPositionTab" class="tab-pane fade">
                                                                        <div class="tab-container clearfix">
                                                                            <div class="col-md-12">
                                                                                <div class="fieldset">
                                                                                    <fieldset>
                                                                                        <legend>
                                                                                            <asp:CheckBox Text="All Positions" runat="server" ID="chkLocationPosition" />
                                                                                        </legend>
                                                                                        <div class="row fieldSwitch">
                                                                                            <div class="col-md-12">
                                                                                                <div class="col-md-12">
                                                                                                    <label>Positions</label>
                                                                                                </div>
                                                                                            </div>
                                                                                            <asp:ListBox runat="server" ID="lstLocationPosition" SelectionMode="Multiple" CssClass="positionListBox col-md-12"></asp:ListBox>
                                                                                            <asp:HiddenField runat="server" ID="hdnSelectedLocationPosition" Value="0" />
                                                                                            <asp:HiddenField runat="server" ID="hdnLocationPositionFileName" Value="" />
                                                                                            <asp:HiddenField runat="server" ID="hdnIsLocationPositionReplaceUpdate" Value="" />
                                                                                            <uc1:CsvUploadControl runat="server" ID="uploadPosition" HeaderMessage="Upload Positions By CSV" />
                                                                                        </div>
                                                                                    </fieldset>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <!--Location Position Tab Ends-->

                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <!--Location Tab Ends-->

                                                    <!--Population Tab Starts-->
                                                    <div class="tab-pane fade" id="populationTab">
                                                        <div class="">
                                                            <div class="tabbable tabs-left">
                                                                <ul class="nav nav-tabs">
                                                                    <li id="liTiers" class="active col-xsm-2"><a data-toggle="tab" href="#populationTiersTab">Tiers</a></li>
                                                                    <li id="liList" class="col-xsm-2"><a data-toggle="tab" href="#populationListTab">List</a></li>
                                                                </ul>
                                                                <div class="tab-content">
                                                                    <div id="populationTiersTab" class="tab-pane fade in active">
                                                                        <div class="tab-container clearfix">
                                                                            <div class="col-md-12">
                                                                                <div class="fieldset">
                                                                                    <fieldset>
                                                                                        <legend>
                                                                                            <asp:CheckBox Text="All Tiers" runat="server" ID="chkPopulationAllTiers" />
                                                                                        </legend>
                                                                                        <div class="row fieldSwitch">
                                                                                            <div class="col-md-12">
                                                                                                <div class="col-md-12">
                                                                                                    <label>Tiers</label>
                                                                                                </div>
                                                                                            </div>
                                                                                            <asp:ListBox runat="server" ID="lstPopulationTiers" SelectionMode="Multiple" CssClass="tiersListBox col-md-12"></asp:ListBox>
                                                                                            <asp:HiddenField runat="server" ID="hdnSelectedPopulationTiers" Value="0" />
                                                                                        </div>
                                                                                    </fieldset>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <div id="populationListTab" class="tab-pane fade">
                                                                        <div class="tab-container clearfix">
                                                                            <div class="col-md-12">
                                                                                <div class="fieldset">
                                                                                    <fieldset>
                                                                                        <legend>
                                                                                            <asp:CheckBox Text="All Players" runat="server" ID="chkPopulationAllPlayers" />
                                                                                        </legend>
                                                                                        <div class="row fieldSwitch">
                                                                                            <div class="col-md-12">
                                                                                                <div class="col-md-12">
                                                                                                    <label>Players</label>
                                                                                                </div>
                                                                                            </div>
                                                                                            <asp:ListBox runat="server" ID="lstPopulationList" SelectionMode="Multiple" CssClass="populationPlayersListBox col-md-12"></asp:ListBox>
                                                                                            <asp:HiddenField runat="server" ID="hdnSelectedPopulationList" Value="0" />
                                                                                            <asp:HiddenField runat="server" ID="hdnPopulationListFileName" Value="" />
                                                                                            <asp:HiddenField runat="server" ID="hdnIsPopulationListReplaceUpdate" Value="" />
                                                                                            <uc1:CsvUploadControl runat="server" ID="uploadPlayers" HeaderMessage="Upload Players By CSV" />
                                                                                        </div>
                                                                                    </fieldset>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <!--Population Tab Ends-->
                                                </div>
                                            </div>
                                        </div>
                                        <!--<p>Details default content goes here...</p>-->
                                    </div>
                                    <!--Details Tab Ends-->


                                    <!--Message Tab Starts-->
                                    <div class="tab-pane" id="messageTab">
                                        <div class="">
                                            <div class="tabbable tabs-left">
                                                <ul class="nav nav-tabs">
                                                    <li id="liLeaderBoard" class="active col-xsm-32"><a href="#leaderBoardTab" data-toggle="tab">LeaderBoard</a></li>
                                                    <li id="liEnd" class="col-xsm-32"><a href="#endTab" data-toggle="tab">End</a></li>
                                                    <li id="liCelebrations" class="col-xsm-32"><a href="#celebrationTab" data-toggle="tab">Celebration</a></li>
                                                </ul>
                                                <div class="tab-content">

                                                    <div class="tab-pane fade in active" id="leaderBoardTab">
                                                        <p>LeaderBoard content...</p>
                                                    </div>
                                                    <div class="tab-pane fade" id="endTab">
                                                        <p>End content...</p>
                                                    </div>
                                                    <div class="tab-pane fade" id="celebrationTab">
                                                        <p>Celebration content...</p>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <p>Default content inside Message container...</p>
                                    </div>
                                    <!--Message Tab Ends-->
                                </div>
                            </div>
                        </div>
                        <div class="col-md-12 btnGroup">
                            <div id="dvFooterControls" class="btn-groupSpecial clearfix">
                                <asp:Button Text="Activate" ID="lnkBtnActivate" CssClass="results-control col-xsm-5" runat="server" OnClick="lnkBtnActivate_OnClick" />
                                <asp:Button Text="Copy" ID="lnkBtnCopy" CssClass="results-control col-xsm-5" runat="server"  OnClick="lnkBtnCopy_OnClick" />
                                <asp:Button Text="Save" ID="lnkBtnSave" CssClass="results-control col-xsm-5" OnClientClick="return FormValidations();" runat="server" OnClick="lnkBtnSave_OnClick" />
                                <asp:Button Text="Cancel" ID="lnkBtnCancel" CssClass="results-control col-xsm-5" runat="server"  OnClick="lnkBtnCancel_OnClick" />
                                <asp:Button Text="Delete" ID="lnkBtnDelete" CssClass="results-control col-xsm-5" runat="server" OnClientClick="return ConfirmMessage(3); " OnClick="lnkBtnDelete_OnClick" />
                            </div>
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
                            <button type="button" class="btn" id="btnOK" data-dismiss="modal">OK</button>
                        </div>
                    </div>
                </div>
            </div>

            <asp:HiddenField runat="server" ID="hdnSelectedTab" />
            <asp:HiddenField runat="server" ID="hdnTournamentId" Value="0" />
            <asp:HiddenField runat="server" ID="hdnIsCopy" Value="0" />
            <script type="text/javascript">
                function StartupScripts() {
                    RegisterListBoxes();
                    RegisterDateAndTimePickers();
                    SetActiveTab();
                    RegisterTabClick();
                    RegisterScrolling();
                    SetLeftContentHeight();
                    RegisterUploadControls();
                    RegisterDdlAwardsOnChange();
                    SetLeaderBoardProgress();
                    RegisterFieldSets();
                    SetExampleCalculation();
                    RegisterPointCalculationFactorBlur();
                    BindSpanClicks();
                    RegisterFilterableDropDownList();
                   
                }

                function RegisterListBoxes() {
                    //  Area list box
                    var areaListBox = $('.areaListBox').bootstrapDualListbox({
                        nonselectedlistlabel: 'Exclude',
                        selectedlistlabel: 'Include',
                        preserveselectiononmove: 'moved',
                        moveonselect: false,
                        hdnControlId: 'hdnSelectedLocationAreas',
                    });
                  
                    //  Section list box
                    var sectionsListBox = $('.sectionsListBox').bootstrapDualListbox({
                        nonselectedlistlabel: 'Exclude',
                        selectedlistlabel: 'Include',
                        preserveselectiononmove: 'moved',
                        moveonselect: false,
                        hdnControlId: 'hdnSelectedLocationSections'
                    });
                  
                    //  Position list box
                    var positionListBox = $('.positionListBox').bootstrapDualListbox({
                        nonselectedlistlabel: 'Exclude',
                        selectedlistlabel: 'Include',
                        preserveselectiononmove: 'moved',
                        moveonselect: false,
                        hdnControlId: 'hdnSelectedLocationPosition'
                    });
                   
                    //Population player list box
                    var populationPlayersListBox = $('.populationPlayersListBox').bootstrapDualListbox({
                        nonselectedlistlabel: 'Exclude',
                        selectedlistlabel: 'Include',
                        preserveselectiononmove: 'moved',
                        moveonselect: false,
                        hdnControlId: 'hdnSelectedPopulationList'
                    });

                    //  Tier list box
                    var tiersListBox = $('.tiersListBox').bootstrapDualListbox({
                        nonselectedlistlabel: 'Exclude',
                        selectedlistlabel: 'Include',
                        preserveselectiononmove: 'moved',
                        moveonselect: false,
                        hdnControlId: 'hdnSelectedPopulationTiers'
                    });
                  
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

                function FormValidations() {
                    var activeTab = $('input:hidden[id*="hdnSelectedTab"]').val();

                    if ($('#<%=txtTournamentName.ClientID%>').val() == '') {
                        document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please enter tournament name';
                        $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                        document.getElementById('<%=txtTournamentName.ClientID%>').focus();
                        return false;
                    }
                    if ($('#<%=txtTournamentDesc.ClientID%>').val() == '') {
                        document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please enter tournament description';
                        $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                        document.getElementById('<%=txtTournamentDesc.ClientID%>').focus();
                        return false;
                    }
                    if ($('#<%=txtLeaderBoardPos.ClientID%>').val() == '') {
                        document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please enter leaderboard position';
                        $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                        document.getElementById('<%=txtLeaderBoardPos.ClientID%>').focus();
                        return false;
                    }
                    switch (activeTab) {

                        case 'scheduleTab':
                            if (document.getElementById('<%=txtScheduleName.ClientID%>').value == '') {
                                document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please enter schedule name';
                                $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                                document.getElementById('<%=txtScheduleName.ClientID%>').focus();
                                return false;
                            }
                            if (document.getElementById('<%=txtScheduleFrom.ClientID%>').value == '') {
                                document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please enter schedule from date';
                                $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                                document.getElementById('<%=txtScheduleFrom.ClientID%>').focus();
                                return false;
                            }
                            if (document.getElementById('<%=txtScheduleFromAt.ClientID%>').value == '') {
                                document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please enter schedule from time';
                                $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                                document.getElementById('<%=txtScheduleFromAt.ClientID%>').focus();
                                return false;
                            }
                            if (document.getElementById('<%=txtScheduleTo.ClientID%>').value == '') {
                                document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please enter schedule to date';
                                $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                                document.getElementById('<%=txtScheduleTo.ClientID%>').focus();
                                return false;
                            }
                            if (document.getElementById('<%=txtscheduleToAt.ClientID%>').value == '') {
                                document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please enter schedule to time';
                                $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                                document.getElementById('<%=txtscheduleToAt.ClientID%>').focus();
                                return false;
                            }
                            if (Date.parse(document.getElementById('<%=txtScheduleTo.ClientID%>').value) < Date.parse(document.getElementById('<%=txtScheduleFrom.ClientID%>').value)) {
                                document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Invalid Date Range!\nStart Date cannot be after End Date!';
                                $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                                document.getElementById('<%=txtScheduleTo.ClientID%>').focus();
                                return false;
                            }
                            if ($('#<%=chkMonday.ClientID%>')[0].checked == true) {
                                if (document.getElementById('<%=txtScheduleMondayFrom.ClientID%>').value == '') {
                                    document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please enter monday from time';
                                    $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                                    document.getElementById('<%=txtScheduleMondayFrom.ClientID%>').focus();
                                    return false;
                                }
                                if (document.getElementById('<%=txtScheduleMondayTo.ClientID%>').value == '') {
                                    document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please enter monday to time';
                                    $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                                    document.getElementById('<%=txtScheduleMondayTo.ClientID%>').focus();
                                    return false;
                                }
                            }
                            else if (document.getElementById('<%=txtScheduleMondayFrom.ClientID%>').value != '' || document.getElementById('<%=txtScheduleMondayTo.ClientID%>').value != '') {
                                document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please select monday';
                                $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                                document.getElementById('<%=chkMonday.ClientID%>').focus();
                                return false;
                            }
                            if ($('#<%=chkTuesday.ClientID%>')[0].checked == true) {
                                if (document.getElementById('<%=txtScheduleTueFrom.ClientID%>').value == '') {
                                    document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please enter tuesday from time';
                                    $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                                    document.getElementById('<%=txtScheduleTueFrom.ClientID%>').focus();
                                    return false;
                                }
                                if (document.getElementById('<%=txtScheduleTueTo.ClientID%>').value == '') {
                                    document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please enter tuesday to time';
                                    $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                                    document.getElementById('<%=txtScheduleTueTo.ClientID%>').focus();
                                    return false;
                                }
                            }
                            else if (document.getElementById('<%=txtScheduleTueFrom.ClientID%>').value != '' || document.getElementById('<%=txtScheduleTueTo.ClientID%>').value != '') {

                                document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please select tuesday';
                                $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                                document.getElementById('<%=chkTuesday.ClientID%>').focus();
                                return false;
                            }
                            if ($('#<%=chkWednesday.ClientID%>')[0].checked == true) {
                                if (document.getElementById('<%=txtScheduleWedFrom.ClientID%>').value == '') {
                                    document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please enter wednesday from time';
                                    $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                                    document.getElementById('<%=txtScheduleWedFrom.ClientID%>').focus();
                                    return false;
                                }
                                if (document.getElementById('<%=txtScheduleWedTo.ClientID%>').value == '') {
                                    document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please enter wednesday to time';
                                    $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                                    document.getElementById('<%=txtScheduleWedTo.ClientID%>').focus();
                                    return false;
                                }
                            }
                            else if (document.getElementById('<%=txtScheduleWedFrom.ClientID%>').value != '' || document.getElementById('<%=txtScheduleWedTo.ClientID%>').value != '') {

                                document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please select wednesday';
                                $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                                document.getElementById('<%=chkWednesday.ClientID%>').focus();
                                return false;
                            }


                            if ($('#<%=chkThursday.ClientID%>')[0].checked == true) {
                                if (document.getElementById('<%=txtScheduleThuFrom.ClientID%>').value == '') {
                                    document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please enter thursday from time';
                                    $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                                    document.getElementById('<%=txtScheduleThuFrom.ClientID%>').focus();
                                    return false;
                                }
                                if (document.getElementById('<%=txtScheduleThuTo.ClientID%>').value == '') {
                                    document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please enter thursday to time';
                                    $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                                    document.getElementById('<%=txtScheduleThuTo.ClientID%>').focus();
                                    return false;
                                }
                            }
                            else if (document.getElementById('<%=txtScheduleThuFrom.ClientID%>').value != '' || document.getElementById('<%=txtScheduleThuTo.ClientID%>').value != '') {
                                document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please select thursday';
                                $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                                document.getElementById('<%=chkThursday.ClientID%>').focus();
                                return false;
                            }
                            if ($('#<%=chkFriday.ClientID%>')[0].checked == true) {
                                if (document.getElementById('<%=txtScheduleFriFrom.ClientID%>').value == '') {
                                    document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please enter friday from time';
                                    $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                                    document.getElementById('<%=txtScheduleFriFrom.ClientID%>').focus();
                                    return false;
                                }
                                if (document.getElementById('<%=txtScheduleFriTo.ClientID%>').value == '') {
                                    document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please enter friday to time';
                                    $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                                    document.getElementById('<%=txtScheduleFriTo.ClientID%>').focus();
                                    return false;
                                }
                            }
                            else if (document.getElementById('<%=txtScheduleFriFrom.ClientID%>').value != '' || document.getElementById('<%=txtScheduleFriTo.ClientID%>').value != '') {
                                document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please select friday';
                                $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                                document.getElementById('<%=chkFriday.ClientID%>').focus();
                                return false;
                            }
                            if ($('#<%=chkSaturday.ClientID%>')[0].checked == true) {
                                if (document.getElementById('<%=txtScheduleSatFrom.ClientID%>').value == '') {
                                    document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please enter saturday from time';
                                    $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                                    document.getElementById('<%=txtScheduleSatFrom.ClientID%>').focus();
                                    return false;
                                }
                                if (document.getElementById('<%=txtScheduleSatTo.ClientID%>').value == '') {
                                    document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please enter saturday to time';
                                    $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                                    document.getElementById('<%=txtScheduleSatTo.ClientID%>').focus();
                                    return false;
                                }
                            }
                            else if (document.getElementById('<%=txtScheduleSatFrom.ClientID%>').value != '' || document.getElementById('<%=txtScheduleSatTo.ClientID%>').value != '') {

                                document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please select saturday';
                                $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                                document.getElementById('<%=chkSaturday.ClientID%>').focus();
                                return false;
                            }

                            if ($('#<%=chkSunday.ClientID%>')[0].checked == true) {
                                if (document.getElementById('<%=txtScheduleSunFrom.ClientID%>').value == '') {
                                    document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please enter sunday from time';
                                    $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                                    document.getElementById('<%=txtScheduleSunFrom.ClientID%>').focus();
                                    return false;
                                }
                                if (document.getElementById('<%=txtScheduleSunTo.ClientID%>').value == '') {
                                    document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please enter sunday to time';
                                    $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                                    document.getElementById('<%=txtScheduleSunTo.ClientID%>').focus();
                                    return false;
                                }
                            }
                            else if (document.getElementById('<%=txtScheduleSunFrom.ClientID%>').value != '' || document.getElementById('<%=txtScheduleSunTo.ClientID%>').value != '') {

                                document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please select sunday';
                                $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                                document.getElementById('<%=chkSunday.ClientID%>').focus();
                                return false;
                            }
                            break;
                        case 'locationTab':
                        case 'locationAreaTab':
                            var status = $('#<%=chkLocationAllAreas.ClientID%>').is(':checked');
                            if (status == false && $('#MainContent_uploadAreas_txtValidRecords').val() == "" && ($('#<%=hdnSelectedLocationAreas.ClientID%>').val() == "" || $('#<%=hdnSelectedLocationAreas.ClientID%>').val() == "0")) {
                                alert('Please select a area');
                                return false;
                            }
                           
                            break;
                        case 'locationSectionTab':
                            var status = $('#<%=chkLocationAllSections.ClientID%>').is(':checked');
                            if (status == false && $('#MainContent_uploadSections_txtValidRecords').val() == "" && ($('#<%=hdnSelectedLocationSections.ClientID%>').val() == "" || $('#<%=hdnSelectedLocationSections.ClientID%>').val() == "0")) {
                                alert('Please select a section');
                                return false;
                            }
                           
                            break;
                        case 'locationPositionTab':
                            var status = $('#<%=chkLocationPosition.ClientID%>').is(':checked');
                            if (status == false && $('#MainContent_uploadPosition_txtValidRecords').val() == "" && ($('#<%=hdnSelectedLocationPosition.ClientID%>').val() == "" || $('#<%=hdnSelectedLocationPosition.ClientID%>').val() == "0")) {
                                alert('Please select a position');
                                return false;
                            }                           
                            break;
                        case 'populationTab':
                        case 'populationTiersTab':
                            var status = $('#<%=chkPopulationAllTiers.ClientID%>').is(':checked');
                            if (status == false && ($('#<%=hdnSelectedPopulationTiers.ClientID%>').val() == "" || $('#<%=hdnSelectedPopulationTiers.ClientID%>').val() == "0")) {
                                alert('Please select a tier');
                                return false;
                            }
                            break;
                        case 'populationListTab':
                            var status = $('#<%=chkPopulationAllPlayers.ClientID%>').is(':checked');
                            if (status == false && $('#MainContent_uploadPlayers_txtValidRecords').val() == "" && ($('#<%=hdnSelectedPopulationList.ClientID%>').val() == "" || $('#<%=hdnSelectedPopulationList.ClientID%>').val() == "0")) {
                                alert('Please select a player');
                                return false;
                            }                                                            
                            break;
                    }
                    GetUpdateReplaceCheckBoxValue();
                    var validation = ConfirmMessage(1);
                    if (validation == false) {
                        return false;
                    }
                    else {
                        return true;
                    }
                }
                ///Alert Message
                function ConfirmMessage(flag) {
                    var savemsg = 'Are you sure to save this tournament ?';
                    var cancelmsg = 'Are you sure to discard current changes?';
                    var deletemsg = 'Are you sure to delete this tournament ?';
                    var isChange = FormChanges('from1');

                    if (isChange != "") {
                        var message = '';
                        if (flag == 1) {
                            $('#<%=btnConfirmedSave.ClientID%>').show();
                            $('#<%=btnConfirmedCancel.ClientID%>').hide();
                            $('#<%=btnConfirmedDelete.ClientID%>').hide();
                            $('#<%=btnConfirmedActive.ClientID%>').hide();
                            $('#<%=btnConfirmedInActive.ClientID%>').hide();
                            $('#<%=btnConfirmedAll.ClientID%>').hide();

                            $('#ConfirmBoxMessage').html(savemsg);
                        }
                        else if (flag == 2) {
                            $('#<%=btnConfirmedSave.ClientID%>').hide();
                            $('#<%=btnConfirmedCancel.ClientID%>').show();
                            $('#<%=btnConfirmedDelete.ClientID%>').hide();
                            $('#<%=btnConfirmedActive.ClientID%>').hide();
                            $('#<%=btnConfirmedInActive.ClientID%>').hide();
                            $('#<%=btnConfirmedAll.ClientID%>').hide();
                            $('#ConfirmBoxMessage').html(cancelmsg);
                        }
                        else if (flag == 3) {
                            $('#<%=btnConfirmedSave.ClientID%>').hide();
                            $('#<%=btnConfirmedCancel.ClientID%>').hide();
                            $('#<%=btnConfirmedDelete.ClientID%>').show();
                            $('#<%=btnConfirmedActive.ClientID%>').hide();
                            $('#<%=btnConfirmedInActive.ClientID%>').hide();
                            $('#<%=btnConfirmedAll.ClientID%>').hide();
                            $('#ConfirmBoxMessage').html(deletemsg);
                        }
                        else if (flag == 4) {
                            $('#<%=btnConfirmedSave.ClientID%>').hide();
                            $('#<%=btnConfirmedCancel.ClientID%>').hide();
                            $('#<%=btnConfirmedDelete.ClientID%>').hide();
                            $('#<%=btnConfirmedActive.ClientID%>').show();
                            $('#<%=btnConfirmedInActive.ClientID%>').hide();
                            $('#<%=btnConfirmedAll.ClientID%>').hide();
                            $('#ConfirmBoxMessage').html(cancelmsg);
                        }
                        else if (flag == 5) {
                            $('#<%=btnConfirmedSave.ClientID%>').hide();
                            $('#<%=btnConfirmedCancel.ClientID%>').hide();
                            $('#<%=btnConfirmedDelete.ClientID%>').hide();
                            $('#<%=btnConfirmedActive.ClientID%>').hide();
                            $('#<%=btnConfirmedInActive.ClientID%>').show();
                            $('#<%=btnConfirmedAll.ClientID%>').hide();
                            $('#ConfirmBoxMessage').html(cancelmsg);
                        }
                        else if (flag == 6) {
                            $('#<%=btnConfirmedSave.ClientID%>').hide();
                            $('#<%=btnConfirmedCancel.ClientID%>').hide();
                            $('#<%=btnConfirmedDelete.ClientID%>').hide();
                            $('#<%=btnConfirmedActive.ClientID%>').hide();
                            $('#<%=btnConfirmedInActive.ClientID%>').hide();
                            $('#<%=btnConfirmedAll.ClientID%>').show();
                            $('#ConfirmBoxMessage').html(cancelmsg);
                        }
                        $('#ConfirmBox').modal({ backdrop: 'static', keyboard: false });
                        return false;
                    }
                    else if (flag == 3) {

                        $('#<%=btnConfirmedSave.ClientID%>').hide();
                        $('#<%=btnConfirmedCancel.ClientID%>').hide();
                        $('#<%=btnConfirmedDelete.ClientID%>').show();
                        $('#<%=btnConfirmedActive.ClientID%>').hide();
                        $('#<%=btnConfirmedInActive.ClientID%>').hide();
                        $('#<%=btnConfirmedAll.ClientID%>').hide();
                        $('#ConfirmBoxMessage').html(deletemsg);
                        $('#ConfirmBox').modal({ backdrop: 'static', keyboard: false });
                        return false;
                    }
                    return true;

                }
               
                function SetActiveTab() {
                    var activeTab = $('input:hidden[id*="hdnSelectedTab"]').val();
                    $('.nav-tabs li').removeClass('active');
                    $('.tab-content .tab-pane').removeClass('active');
                    switch (activeTab) {
                    case 'detailsTab':
                    case 'overviewTab':
                        $('li#liDetails').addClass('active');
                        $('div#detailsTab').addClass('active in');
                        $('li#liOverview').addClass('active');
                        $('div#overviewTab').addClass('active in');
                        ShowHideActivateCopyButtons(true);
                        break;
                    case 'definitionTab':
                        $('li#liDetails').addClass('active');
                        $('div#detailsTab').addClass('active in');
                        $('li#liDefinition').addClass('active');
                        $('div#definitionTab').addClass('active in');
                        ShowHideActivateCopyButtons(false);
                        break;
                    case 'scheduleTab':
                        $('li#liDetails').addClass('active');
                        $('div#detailsTab').addClass('active in');
                        $('li#liSchedule').addClass('active');
                        $('div#scheduleTab').addClass('active in');
                        ShowHideActivateCopyButtons(false);
                        break;
                    case 'locationTab':
                    case 'locationAreaTab':
                        $('li#liDetails').addClass('active');
                        $('div#detailsTab').addClass('active in');
                        $('li#liLocation').addClass('active');
                        $('div#locationTab').addClass('active in');
                        $('li#liAreas').addClass('active');
                        $('div#locationAreaTab').addClass('active in');
                        ShowHideActivateCopyButtons(false);
                        break;
                    case 'locationSectionTab':
                        $('li#liDetails').addClass('active');
                        $('div#detailsTab').addClass('active in');
                        $('li#liLocation').addClass('active');
                        $('div#locationTab').addClass('active in');
                        $('li#liSection').addClass('active');
                        $('div#locationSectionTab').addClass('active in');
                        ShowHideActivateCopyButtons(false);
                        break;
                    case 'locationPositionTab':
                        $('li#liDetails').addClass('active');
                        $('div#detailsTab').addClass('active in');
                        $('li#liLocation').addClass('active');
                        $('div#locationTab').addClass('active in');
                        $('li#liPosition').addClass('active');
                        $('div#locationPositionTab').addClass('active in');
                        ShowHideActivateCopyButtons(false);
                        break;
                    case 'populationTab':
                    case 'populationTiersTab':
                        $('li#liDetails').addClass('active');
                        $('div#detailsTab').addClass('active in');
                        $('li#liPopulation').addClass('active');
                        $('div#populationTab').addClass('active in');
                        $('li#liTiers').addClass('active');
                        $('div#populationTiersTab').addClass('active in');
                        ShowHideActivateCopyButtons(false);
                        break;
                    case 'populationListTab':
                        $('li#liDetails').addClass('active');
                        $('div#detailsTab').addClass('active in');
                        $('li#liPopulation').addClass('active');
                        $('div#populationTab').addClass('active in');
                        $('li#liList').addClass('active');
                        $('div#populationListTab').addClass('active in');
                        ShowHideActivateCopyButtons(false);
                        break;

                    case 'messageTab':
                    case 'leaderBoardTab':
                        $('li#liMessages').addClass('active');
                        $('div#messageTab').addClass('active in');
                        $('li#liLeaderBoard').addClass('active');
                        $('div#leaderBoardTab').addClass('active in');
                        ShowHideActivateCopyButtons(false);
                        break;
                    case 'endTab':
                        $('li#liMessages').addClass('active');
                        $('div#messageTab').addClass('active in');
                        $('li#liEnd').addClass('active');
                        $('div#endTab').addClass('active in');
                        ShowHideActivateCopyButtons(false);
                        break;
                    case 'celebrationTab':
                        $('li#liMessages').addClass('active');
                        $('div#messageTab').addClass('active in');
                        $('li#liCelebrations').addClass('active');
                        $('div#celebrationTab').addClass('active in');
                        ShowHideActivateCopyButtons(false);
                        break;
                    default:
                        $('li#liDetails').addClass('active');
                        $('li#liOverview').addClass('active');
                        $('div#detailsTab').addClass('active in');
                        $('div#overviewTab').addClass('active in');
                        ShowHideActivateCopyButtons(true);
                        break;
                    }
                    SetLeftContentHeight();
                }

                function RegisterScrolling() {
                    $('#ScrollableDiv').slimScroll({
                        alwaysVisible: true,
                        height: '500px',
                    });
                }
                function GetUpdateReplaceCheckBoxValue() {

                    $('.checkboxval').each(function () {

                        var isReplaceUpd = $(this).find('input:text[id*="txtValidRecords"]');
                        var associatedIsReplace = $(this).find('input:radio[id*="A_SEC_Po_PL_Replace"]');
                        var associatedIsUpdate = $(this).find('input:radio[id*="A_SEC_Po_PL_Update"]');

                        associatedIsReplace = $(associatedIsReplace).prop('id');
                        associatedIsUpdate = $(associatedIsUpdate).prop('id');
                       
                        if ($(isReplaceUpd).prop('id').toLowerCase().indexOf('area') > -1) {

                            if ($('#' + associatedIsReplace).is(':checked'))
                                $('#<%=hdnIsLocationAreasReplaceUpdate.ClientID%>').val('Replace');
                            if ($('#' + associatedIsUpdate).is(':checked'))

                                $('#<%=hdnIsLocationAreasReplaceUpdate.ClientID%>').val('Update');
                        }
                        if ($(isReplaceUpd).prop('id').toLowerCase().indexOf('area') > -1) {

                            if ($('#' + associatedIsReplace).is(':checked'))
                                $('#<%=hdnIsLocationSectionsReplaceUpdate.ClientID%>').val('Replace');
                            if ($('#' + associatedIsUpdate).is(':checked'))
                                $('#<%=hdnIsLocationSectionsReplaceUpdate.ClientID%>').val('Update');
                        }
                        if ($(isReplaceUpd).prop('id').toLowerCase().indexOf('area') > -1) {

                            if ($('#' + associatedIsReplace).is(':checked'))
                                $('#<%=hdnIsLocationPositionReplaceUpdate.ClientID%>').val('Replace');
                            if ($('#' + associatedIsUpdate).is(':checked'))
                                $('#<%=hdnIsLocationPositionReplaceUpdate.ClientID%>').val('Update');
                        }
                        if ($(isReplaceUpd).prop('id').toLowerCase().indexOf('player') > -1) {

                            if ($('#' + associatedIsReplace).is(':checked'))
                                $('#<%=hdnIsPopulationListReplaceUpdate.ClientID%>').val('Replace');
                            if ($('#' + associatedIsUpdate).is(':checked'))
                                $('#<%=hdnIsPopulationListReplaceUpdate.ClientID%>').val('Update');
                        }
                    });

                }
                function RegisterUploadControls() {
                    $('.UploadButton').each(function () {
                        var mainDiv = $(this).parent().parent();
                        var hdnValidRecordIds = $(mainDiv).find('input:hidden[id*="hdnValidRecordIds"]');
                        var hdnInValidRecordIds = $(mainDiv).find('input:hidden[id*="hdnInvalidRecordIds"]');
                        var hdnTotalRecordIds = $(mainDiv).find('input:hidden[id*="hdnTotalRecordIds"]'); 
                        var hdnFileName = $(mainDiv).find('input:hidden[id*="hdnFileName"]');
                        var dvLocationPopulationDisplay = $(mainDiv).find('div[id*="dvLocationPopulationDisplay"]');
                    
                        var textBoxDiv = $(mainDiv).next('div.col-md-6');
                        var isReplace = $(textBoxDiv).find('input:radio[id*="A_SEC_Po_PL_Replace"]');
                        var isUpdate = $(textBoxDiv).find('input:radio[id*="A_SEC_Po_PL_Update"]');
                        var txtValidRecords = $(textBoxDiv).find('input:text[id*="txtValidRecords"]');
                        var txtInvalidRecords = $(textBoxDiv).find('input:text[id*="txtInvalidRecords"]');
                        var txtTotalRecords = $(textBoxDiv).find('input:text[id*="txtTotalRecords"]');
                        var firstDiv = $(mainDiv).parent().parent().parent().parent();
                        var modalValidRecords = $(firstDiv).find('div[id*="modalValidRecords"]');
                        var modalInvalidRecords = $(firstDiv).find('div[id*="modalInvalidRecords"]');
                        var modalAllRecords = $(firstDiv).find('div[id*="modalAllRecords"]');

                        UploadControlHandler($(this), $(hdnValidRecordIds).prop('id'), $(hdnInValidRecordIds).prop('id'),
                            $(hdnTotalRecordIds).prop('id'), $(txtValidRecords).prop('id'), $(txtInvalidRecords).prop('id'),
                            $(txtTotalRecords).prop('id'), modalValidRecords, modalInvalidRecords, modalAllRecords, $(hdnFileName).prop('id'), $(isReplace).prop('id'), $(isUpdate).prop('id'), $(dvLocationPopulationDisplay).prop('id'));
                    });
                }

               
                function UploadControlHandler(control, associatedValidHf, associatedInvalidHf, associatedTotalHf, associatedValidTxt,
                    associatedInvalidTxt, associatedTotaltxt, modalValidRecords, modalInvalidRecords, modalAllRecords, associatedFileNameHf, associatedIsReplace, associatedIsUpdate, associatedHostDisplay) {
                    var data;
                    var tabName = '';
                    if (associatedValidHf.toLowerCase().indexOf('area') > -1) {
                        data = { method: "Area" };
                        tabName = "Area";
                    } else if (associatedValidHf.toLowerCase().indexOf('section') > -1) {
                        data = { method: "Section" };
                        tabName = "Section";
                    } else if (associatedValidHf.toLowerCase().indexOf('position') > -1) {
                        data = { method: "Position" };
                        tabName = "Position";
                    } else {
                        data = { method: "Player" };
                        tabName = "Player";
                    }
                    new AjaxUpload('#' + $(control).prop('id') + '', {
                        action: 'CsvUploadHandler.ashx',
                        data: data,
                        onComplete: function (file, response) {
                            var res = response.split('--');
                            var totalPositions = 0;
                            var showPercentage = '';

                            if (res[4] != '') {
                                totalPositions = parseInt(res[4]);
                            }
                            showPercentage = (res[2] + ' out of ' + totalPositions + ' assigned');
                            document.getElementById(''+associatedHostDisplay+'').style.width = '100%';
                            document.getElementById('' + associatedHostDisplay + '').innerHTML = showPercentage;

                            
                            $('#' + associatedValidHf).val(res[5]);
                            $('#' + associatedInvalidHf).val(res[6]);
                            $('#' + associatedTotalHf).val(res[7]);

                            $('#' + associatedValidTxt).val(res[2]);
                            $('#' + associatedInvalidTxt).val(res[3]);
                            $('#' + associatedTotaltxt).val(res[4]);

                            $('#' + associatedValidTxt).next('span').attr('href', '#' + $(modalValidRecords).prop('id'));
                            $('#' + associatedInvalidTxt).next('span').attr('href', '#' + $(modalInvalidRecords).prop('id'));
                            $('#' + associatedTotaltxt).next('span').attr('href', '#' + $(modalAllRecords).prop('id'));

                            if (tabName == 'Area') {
                                $('#<%=hdnLocationAreaFileName.ClientID%>').val(res[8]);
                                $('#<%=hdnSelectedLocationAreas.ClientID%>').val(res[5]);
                                if ($('#' + associatedIsReplace).is(':checked'))
                                    $('#<%=hdnIsLocationAreasReplaceUpdate.ClientID%>').val('Replace');
                                if ($('#' + associatedIsUpdate).is(':checked'))
                                    $('#<%=hdnIsLocationAreasReplaceUpdate.ClientID%>').val('Update');
                            }
                            if (tabName == 'Section') {
                                $('#<%=hdnLocationSectionsFileName.ClientID%>').val(res[8]);
                                $('#<%=hdnSelectedLocationSections.ClientID%>').val(res[5]);
                                if ($('#' + associatedIsReplace).is(':checked'))
                                    $('#<%=hdnIsLocationSectionsReplaceUpdate.ClientID%>').val('Replace');
                                if ($('#' + associatedIsUpdate).is(':checked'))
                                    $('#<%=hdnIsLocationSectionsReplaceUpdate.ClientID%>').val('Update');
                            }
                            if (tabName == 'Position') {
                                $('#<%=hdnLocationPositionFileName.ClientID%>').val(res[8]);
                                $('#<%=hdnSelectedLocationPosition.ClientID%>').val(res[5]);
                                if ($('#' + associatedIsReplace).is(':checked'))
                                    $('#<%=hdnIsLocationPositionReplaceUpdate.ClientID%>').val('Replace');
                                if ($('#' + associatedIsUpdate).is(':checked'))
                                    $('#<%=hdnIsLocationPositionReplaceUpdate.ClientID%>').val('Update');
                            }
                            if (tabName == 'Player') {
                                $('#<%=hdnPopulationListFileName.ClientID%>').val(res[8]);
                                $('#<%=hdnSelectedPopulationList.ClientID%>').val(res[5]);
                                if ($('#' + associatedIsReplace).is(':checked'))
                                    $('#<%=hdnIsPopulationListReplaceUpdate.ClientID%>').val('Replace');
                                if ($('#' + associatedIsUpdate).is(':checked'))
                                    $('#<%=hdnIsPopulationListReplaceUpdate.ClientID%>').val('Update');

                            }
                        },
                        onSubmit: function (file, ext) {

                            var showPercentage = '';
                            //showPercentage = ('1 out of ' + 0 + ' assigned');
                            document.getElementById('' + associatedHostDisplay + '').style.width = '0%';
                            document.getElementById('' + associatedHostDisplay + '').innerHTML = showPercentage;
                            if (!(ext && /^(csv|txt)$/.test(ext))) {document.getElementById('MainContent_UC_CsvUpload_dvHostDisplay')
                                alert('Invalid File Format.');
                                return false;
                            }
                        }
                    });
                }

                function BindSpanClicks() {
                    $('span.input-group-addon').click(function () {
                        var id = $(this).prop('id');
                        var parentDiv = $(this).parent().parent().prev('div.col-md-6');
                        var firstDiv = $(parentDiv).parent().parent().parent().parent();
                        switch (id) {
                        case 'validRecords':
                            var modalValidRecords = $(firstDiv).find('div[id*="modalValidRecords"]');
                            var hdnValidRecordIds = $(parentDiv).find('input:hidden[id*="hdnValidRecordIds"]');
                            BindDataTable(modalValidRecords, hdnValidRecordIds);
                            break;
                        case 'invalidRecords':
                            var modalInvalidRecords = $(firstDiv).find('div[id*="modalInvalidRecords"]');
                            var hdnInvalidRecordIds = $(parentDiv).find('input:hidden[id*="hdnInvalidRecordIds"]');
                            BindDataTable(modalInvalidRecords, hdnInvalidRecordIds);
                            break;
                        case 'totalRecords':
                            var modalAllRecords = $(firstDiv).find('div[id*="modalAllRecords"]');
                            var hdnTotalRecordIds = $(parentDiv).find('input:hidden[id*="hdnTotalRecordIds"]');
                            BindDataTable(modalAllRecords, hdnTotalRecordIds);
                            break;
                        default:
                            var modalValidRecords1 = $(firstDiv).find('div[id*="modalValidRecords"]');
                            var hdnValidRecordIds1 = $(parentDiv).find('input:hidden[id*="hdnValidRecordIds"]');
                            BindDataTable(modalValidRecords1, hdnValidRecordIds1);
                            break;
                        }
                    });
                }

                function BindDataTable(modal, hf) {
                    if ($(hf).val() != '' && $(hf).val() != '0') {
                        var table = $(modal).find('table.data-table');
                        var tblId = $(table).prop('id');
                        if ($('#' + tblId).hasClass('dataTable')) {
                            $('#' + tblId).dataTable().fnDestroy();
                        }
                        var records = $(hf).val();
                        $('#' + tblId).find('tbody').html('');
                        var record = records.split(',');
                        for (var i = 0; i < record.length; i++) {
                            $('#' + tblId).find('tbody').append('<tr><td>' + record[i] + '</td></tr>');
                        }

                        $('#' + tblId).dataTable({
                            'iDisplayLength': 5,
                            "sPaginationType": "scrolling"
                        });
                    }
                }

                function RegisterFieldSets() {
                    //  Inactive Fieldset
                    var fieldSwitch = $('.fieldSwitch');
                    var legendSwitch = $('.fieldset legend input');
                    //fieldSwitch.find('input, select, button').prop('disabled', false);
                    legendSwitch.each(function () {
                        if ($(this).prop('id').indexOf('chkScheduleByDayOfWeek') > -1) {
                            if ($(this).is(':checked')) {
                                $(this).parent().next('.fieldSwitch').find('input, select, button').prop('disabled', false);
                                $(this).parent().next('.fieldSwitch').find('div.row').find('input, select, button, span').prop('disabled', false);
                            }
                            else {
                                $(this).parent().next('.fieldSwitch').find('input, select, button').prop('disabled', true);
                                $(this).parent().next('.fieldSwitch').find('div.row').find('input, select, button, span').prop('disabled', true);
                            }
                        } else {
                            if ($(this).is(':checked')) {
                                $(this).parent().next('.fieldSwitch').find('input, select, button').prop('disabled', true);
                                $(this).parent().next('.fieldSwitch').find('div.row').find('input, select, button, span').prop('disabled', true);
                            }
                            else {
                                $(this).parent().next('.fieldSwitch').find('input, select, button').prop('disabled', false);
                                $(this).parent().next('.fieldSwitch').find('div.row').find('input, select, button, span').prop('disabled', false);
                            }
                        }
                    });
                    legendSwitch.on('click', function () {
                        if ($(this).prop('id').indexOf('chkScheduleByDayOfWeek') > -1) {
                            $(this).parent().next('.fieldSwitch').find('input:checkbox').prop('checked', false);
                            if ($(this).is(':checked')) {
                                $(this).parent().next('.fieldSwitch').find('input, select, button').prop('disabled', false);
                                $(this).parent().next('.fieldSwitch').find('div.row').find('input, select, button, span').prop('disabled', false);
                            }
                            else {
                                $(this).parent().next('.fieldSwitch').find('input, select, button').prop('disabled', true);
                                $(this).parent().next('.fieldSwitch').find('div.row').find('input, select, button, span').prop('disabled', true);
                            }
                        } else {
                            if ($(this).is(':checked')) {
                                $(this).parent().next('.fieldSwitch').find('input, select, button').prop('disabled', true);
                                $(this).parent().next('.fieldSwitch').find('div.row').find('input, select, button, span').prop('disabled', true);
                            }
                            else {
                                $(this).parent().next('.fieldSwitch').find('input, select, button').prop('disabled', false);
                                $(this).parent().next('.fieldSwitch').find('div.row').find('input, select, button, span').prop('disabled', false);
                            }
                        }
                    });
                }

                function RegisterTabClick() {
                    $('.nav-tabs li').on('click', function () {
                        $('input:hidden[id*="hdnSelectedTab"]').val($(this).find('a').prop('href').split('#')[1]);
                        SetActiveTab();
                    });
                }

                function ShowHideActivateCopyButtons(isShown) {
                    if (isShown) {
                        $('a[id*="lnkBtnActivate"], a[id*="lnkBtnCopy"]').show();
                        $('div#dvFooterControls a').removeClass('col-xsm-32');
                        $('div#dvFooterControls a').addClass('col-xsm-5');
                    } else {
                        $('a[id*="lnkBtnActivate"], a[id*="lnkBtnCopy"]').hide();
                        $('div#dvFooterControls a').removeClass('col-xsm-5');
                        $('div#dvFooterControls a').addClass('col-xsm-32');
                    }
                }

                function SetLeftContentHeight() {
                    $("#dvLeftTournamentGrid").height($('#dvRightContent').height());
                }

                function isNumber(evt) {
                    evt = (evt) ? evt : window.event;
                    var charCode = (evt.which) ? evt.which : evt.keyCode;
                    if (charCode > 31 && (charCode < 48 || charCode > 57)) {
                        return false;
                    }
                    return true;
                }

                function RegisterDdlAwardsOnChange() {
                    $('table tr td select').change(function () {
                        SetLeaderBoardProgress();
                    });
                }

                function SetLeaderBoardProgress() {
                  
                    var assigned = 0, sum = 0;
                    var totalPositions = 0;
                    $('table[id*="grdLeaderBoardPositions"] tr:has(td)').each(function () {
                        var ddlAwards = $(this).find('select');
                     
                        if (ddlAwards != undefined && $(ddlAwards).val() > 0) {
                            assigned++;
                            sum += parseFloat($(ddlAwards).find('option:selected').attr('awardValue'));
                           
                        }
                    });
                   
                    totalPositions = $('input:text[id*="txtLeaderBoardPos"]').val();
                    var percentage=0;
                    if (totalPositions == undefined || totalPositions == '' || totalPositions == 0) {
                        percentage = 0;
                    } else {
                        percentage = (assigned / totalPositions) * 100;
                    }
                    $('div.progress-bar').css('width', percentage + '%');

                    $('span.sr-only').text(assigned + ' out of ' + totalPositions + ' assigned');

                    $('input:text[id*="txtLeaderBoardAwardValue"]').val(sum);
                }

                function RegisterPointCalculationFactorBlur() {
                    $('input:text[id*="txtPointCalculationFactor"]').blur(function () {
                        SetExampleCalculation();
                    });
                    $('select[id*="ddlTournamentLeaderBoardBasis"]').change(function () {
                        SetExampleCalculation();
                    });
                }

                function SetExampleCalculation() {
                    if ($('input:text[id*="txtPointCalculationFactor"]').val() != '') {
                        var pointCalculationFactor = parseFloat($('input:text[id*="txtPointCalculationFactor"]').val());
                        $('textarea[id*="txtExampleCalculation"]').val(10 * pointCalculationFactor + ' ' +
                            $('select[id*="ddlTournamentLeaderBoardBasis"] option:selected').text() + ' = '
                            + pointCalculationFactor + ' Points');
                    } else {
                        $('textarea[id*="txtExampleCalculation"]').val('');
                    }
                }

                function ClearUploadedList(control) {
                    $(control).parent().parent().find('input:text').val('');
                    $(control).parent().parent().find('span').attr('href', '');
                    $(control).parent().parent().prev('div.col-md-6').find('input:hidden').val('');
                    return false;
                }

                function RegisterFilterableDropDownList() {
                    $('table tr td select[id*="ddlAwards"]').select2();
                }
            </script>

            <div id="AlertBox" class="modal fade bs-example-modal-sm" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>
                            <h4 class="modal-title">Alert</h4>
                        </div>
                        <div class="modal-body">
                            <p id="P1" runat="server"></p>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn" id="btnOK" data-dismiss="modal">OK</button>
                        </div>
                    </div>
                </div>
            </div>


            <!-- Modal Dialog -->
            <div id="ConfirmBox" class="modal fade" role="dialog" aria-labelledby="confirmDeleteLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>
                            <h4 class="modal-title">Confirm?</h4>
                        </div>
                        <div class="modal-body">
                            <p id="ConfirmBoxMessage"></p>
                        </div>
                        <div class="modal-footer">
                            <asp:Button ID="btnConfirmedSave" CssClass="btn btn-danger" runat="server" Text="OK" UseSubmitBehavior="false" data-dismiss="modal" OnClick="lnkBtnSave_OnClick" Style="display: none;"></asp:Button>
                            <asp:Button ID="btnConfirmedCancel" CssClass="btn btn-danger" runat="server" Text="OK" UseSubmitBehavior="false" data-dismiss="modal" OnClick="lnkBtnCancel_OnClick" Style="display: none;"></asp:Button>
                            <asp:Button ID="btnConfirmedDelete" CssClass="btn btn-danger" runat="server" Text="OK" UseSubmitBehavior="false" data-dismiss="modal" OnClick="lnkBtnDelete_OnClick" Style="display: none;"></asp:Button>
                            <asp:Button ID="btnConfirmedActive" CssClass="btn btn-danger" runat="server" Text="OK" UseSubmitBehavior="false" data-dismiss="modal" OnClick="lnkBtnActive_OnClick" Style="display: none;"></asp:Button>
                            <asp:Button ID="btnConfirmedInActive" CssClass="btn btn-danger" runat="server" Text="OK" UseSubmitBehavior="false" data-dismiss="modal" OnClick="lnkBtnInActive_OnClick" Style="display: none;"></asp:Button>
                            <asp:Button ID="btnConfirmedAll" CssClass="btn btn-danger" runat="server" Text="OK" UseSubmitBehavior="false" data-dismiss="modal" OnClick="lnkBtnAll_OnClick" Style="display: none;"></asp:Button>

                            <button type="button" class="btn" id="confirm" data-dismiss="modal">Cancel</button>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Dialog show event handler -->
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
