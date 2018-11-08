<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" EnableEventValidation="false" ValidateRequest="false" CodeBehind="AvtBonusing.aspx.cs" Inherits="HAMobileWebAdmin.AvtBonusing" %>

<%@ Register Src="~/UserControl/UC_CsvUpload_PopulationListTabExt.ascx" TagPrefix="csv" TagName="UC_CsvUpload_PopulationListTabExtended" %>
<%@ Register Src="~/UserControl/UC_PopulationTypeTab.ascx" TagPrefix="listbox" TagName="UC_PopulationTypeTab" %>
<%@ Register TagPrefix="ig" Namespace="Infragistics.Web.UI.GridControls" Assembly="Infragistics4.Web.v14.1, Version=14.1.20141.2150, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <title>COG Mobile | AvT Bonusing</title>
    <link href="Content/css/select2.css" rel="stylesheet" />
    <script src="Scripts/CommonJS/datatables.min.js"></script>
    <link rel="stylesheet" href="Content/css/bootstrap-multiselect.css" type="text/css" />
    <script type="text/javascript" src="Scripts/CommonJS/bootstrap-multiselect.js"></script>

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
    <asp:UpdatePanel runat="server" ID="updPnlRREvent" UpdateMode="Conditional">
        <Triggers>
            <asp:PostBackTrigger ControlID="btnConfirmedSave" runat="server" />
        </Triggers>
        <ContentTemplate>
            <asp:HiddenField runat="server" ID="hdnEventId" Value="0" />
            <asp:HiddenField runat="server" ID="hdEventName" Value="" />
            <asp:HiddenField runat="server" ID="hdnEventScheduleID" Value="0" />
            <asp:HiddenField runat="server" ID="hdnrewardType" Value="-1" />
            <asp:HiddenField runat="server" ID="hdnGvEventSelectedIndex" Value="0" />
            <asp:HiddenField runat="server" ID="hdnGvScheduleSelectedIndex" Value="0" />
            <asp:HiddenField runat="server" ID="hdnSelectedTab" Value="0" />
            <asp:HiddenField runat="server" ID="hdnIsShedule" Value="True" />
            <asp:HiddenField runat="server" ID="hdnButtonSatus" Value="0" />
            <asp:HiddenField runat="server" ID="hdnButtonPermission" Value="0" />
            <asp:HiddenField runat="server" ID="hdnIsPermissionDelete" Value="0" />
            <div class="row" id="slotInventory">
                <div class="col-sm-3">
                    <h3>AvT Bonusing</h3>
                    <div class="filterWrapper relative" id="dvLeftcontentdetail1">
                        <div class="clearfix">
                            <div class="pull-left">
                                <span cssclass="form-control height26">AvT Bonusing Event</span>
                            </div>
                            <div class="pull-right">
                                <span>
                                    <asp:Button ID="btnAdd" runat="server" CssClass="btn btn-add pull-right" OnClick="btnAdd_OnClick"></asp:Button>
                                </span>
                            </div>
                        </div>
                        <div class="input-group clearfix col-sm-12">
                            <asp:TextBox runat="server" ID="txtSearchText" CssClass="form-control height26" />
                            <span class="input-group-btn">
                                <asp:Button runat="server" ID="btnSearch" CssClass="btn btn-black glyphicons filter btn-icon white input-group-btnbtnmargin" OnClick="btnSearch_OnClick" /><i></i>
                            </span>
                        </div>
                        <div id="divgv">
                            <asp:GridView runat="server" CssClass="gridview" ID="grdEvents" ShowHeader="False" AutoGenerateColumns="False" DataKeyNames="AvtEventId" AllowPaging="true" PageSize="15" OnPageIndexChanging="grdEvents_PageIndexChanging">
                                <Columns>
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <asp:Label ID="lblID" runat="server" Visible="false" Text='<%#Eval("AvtEventId") %>' />
                                            <asp:LinkButton runat="server" ID="lnkBtnRREvent" CommandName="Select" OnClick="lnkBtnRREvent_Click" Text='<%#Eval("AvtEventName") %>'></asp:LinkButton>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                                <PagerStyle CssClass="gridview-pager"></PagerStyle>
                                <SelectedRowStyle CssClass="gvSelectedRow" />
                            </asp:GridView>
                            <div id="content">
                            </div>
                        </div>
                        <div class="filterResults relative btnGroup" id="dvLeftContent">
                            <div class="btn-groupSpecial" style="bottom: -3px;">
                                <asp:Button Text="Active" ID="lnkBtnActiveEvent" CssClass="results-control col-xs-4" OnClick="lnkbtnActiveEvent_Click" runat="server" Enabled="True" />
                                <asp:Button Text="InActive" ID="lnkBtnInactiveEvent" CssClass="results-control col-xs-4" OnClick="lnkbtnInactiveEvent_Click" runat="server" Enabled="True" />
                                <asp:Button Text="All" ID="lnkBtnAllEvent" CssClass="results-control col-xs-4" OnClick="lnkbtnAllEvent_Click" runat="server" Enabled="True" />
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-sm-9">
                    <h3>AvT Bonusing Detail </h3>
                    <div class="row clearfix relative btnGroup btnGroup3" id="dvRightContent1">
                        <div class="col-md-12 clearfix">
                            <div class="tabControls">
                                <ul class="nav nav-tabs">
                                    <li class="active col-xsm-25 nav-tabs-content"><span class="linkDisabledsp">&nbsp;</span><a data-toggle="tab" href="#manageEventDetailTab" onclick="SetSelectedTab('contentTab')">Event Details</a></li>
                                    <li class="col-xsm-25  nav-tabs-schedule"><span class="linkDisabledsp">&nbsp;</span><a data-toggle="tab" href="#manageScheduleTab" id="manageScheduleTabLink" onclick="SetSelectedTab('scheduleTab')">Schedule</a></li>
                                    <li class="col-xsm-25  nav-tabs-population"><span class="linkDisabledsp">&nbsp;</span><a data-toggle="tab" href="#managePopulationTab" id="managePopulationTabLink" onclick="SetSelectedTab('populationTab')">Population</a></li>
                                    <li class="col-xsm-25  nav-tabs-message"><span class="linkDisabledsp">&nbsp;</span><a data-toggle="tab" href="#manageMessageTab" id="manageMessageTabLink" onclick="SetSelectedTab('MessageTab')">Message</a></li>
                                </ul>
                                <div class="tab-content">

                                    <!-- Event Details Tab Starts -->
                                    <div class="tab-pane active fade in" id="manageEventDetailTab">
                                        <div class="tab-container  clearfix">
                                            <div class="col-md-8">
                                                <label>Define Qualification for an AvT Bonus</label>
                                            </div>
                                            <div>
                                                <asp:CheckBox runat="server" ID="chkStatus" Visible="False" />
                                                <asp:HiddenField runat="server" ID="hdnActualLoss" />
                                                <asp:HiddenField runat="server" ID="hdnMinRewardValue" />
                                            </div>
                                            <div class="col-md-12">
                                                <div class="col-md-5 no-padding">
                                                    <label>AvT Bonus Event Name</label>
                                                    <asp:TextBox runat="server" ID="txtEventName" MaxLength="50" CssClass="form-control" TabIndex="1"></asp:TextBox>
                                                </div>
                                            </div>

                                            <div class="col-md-12">
                                                <div class="col-md-5 no-padding">
                                                    <label>Minimum Player Theoretical  Loss Today</label>
                                                    <asp:TextBox runat="server" ID="txtTLossToday" MaxLength="8" onblur="addDollarSign(this);" CssClass="form-control avtNumericWithDecimal" TabIndex="2"></asp:TextBox>
                                                </div>
                                            </div>

                                            <div class="col-md-12">
                                                <div class="col-md-5 no-padding">
                                                    <label>Minimum Player AvT Multiple</label>
                                                    <asp:TextBox runat="server" ID="txtMinPlAvtMultiple" MaxLength="8" CssClass="form-control avtNumericWithDecimal" TabIndex="3"></asp:TextBox>
                                                </div>
                                                <div class="col-md-1 no-padding">
                                                </div>
                                                <div class="col-md-5 no-padding">
                                                    <label>Minimum Player Actual Loss Today</label>
                                                    <asp:TextBox runat="server" ID="txtPlActualLoss" MaxLength="8" CssClass="form-control avtNumericWithDecimal" ReadOnly="true" TabIndex="4"></asp:TextBox>
                                                </div>
                                            </div>

                                            <div class="col-md-12">
                                                <div class="col-md-10 no-padding">
                                                    <label>Maximum Sessions within N Minutes (Optional)</label>
                                                    <div class=" col-md-1 no-padding  ">
                                                        <asp:CheckBox runat="server" ID="chkMaxSession" OnCheckedChanged="chkMaxSession_OnCheckedChanged" AutoPostBack="True" />
                                                        <label for="<%=chkMaxSession.ClientID %>" tabindex="5" style="display: inline-block; padding: 0; width: 20px;">&nbsp;</label>
                                                    </div>
                                                    <div class=" col-md-2 no-padding">
                                                        <asp:TextBox runat="server" ID="txtslot" MaxLength="3" CssClass="form-control numeric" Enabled="False" TabIndex="6"></asp:TextBox>
                                                    </div>
                                                    <div class="col-md-3 no-padding" style="width: auto;">
                                                        <label style="margin-left: 10px;">Slot Sessions within</label>
                                                    </div>
                                                    <div class="col-md-2 no-padding" style="margin-left: 10px;">
                                                        <asp:TextBox runat="server" ID="txtminute" MaxLength="3" CssClass="form-control numeric" Enabled="False" TabIndex="7"></asp:TextBox>
                                                    </div>
                                                    <div class="col-md-2 no-padding">
                                                        <label style="margin-left: 10px;">Minutes</label>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="col-md-12">
                                                <div class="col-md-5 no-padding">
                                                    <label>Maximum Player Awards per Period</label>
                                                    <div class="col-md-2 no-padding">
                                                        <asp:TextBox runat="server" ID="txtPlayerNum" MaxLength="3" CssClass="form-control numeric" TabIndex="8"></asp:TextBox>
                                                    </div>
                                                    <div class="col-md-1 no-padding">
                                                        &nbsp;&nbsp;&nbsp;&nbsp;/
                                                    </div>
                                                    <div class="col-md-3 no-padding">
                                                        <asp:DropDownList runat="server" ID="ddlPeriod" CssClass="form-control" TabIndex="8">
                                                        </asp:DropDownList>
                                                    </div>
                                                </div>
                                            </div>
                                            <div>
                                            </div>
                                            <div class="col-md-12 clearfix">
                                                <div class="col-md-5 no-padding">
                                                    <label>Define AvT Bonus</label>
                                                </div>
                                            </div>
                                            <div>
                                            </div>
                                            <div class="col-md-12">
                                                <div class="col-md-12 no-padding">
                                                    <label>Reward Type</label>
                                                    <div class="col-md-4 no-padding">
                                                        <asp:DropDownList runat="server" ID="ddlRewardType" OnSelectedIndexChanged="ddlRewardType_OnSelectedIndexChanged" TabIndex="9" CssClass="form-control" AutoPostBack="True">
                                                        </asp:DropDownList>
                                                    </div>
                                                </div>
                                            </div>
                                            <!-- Prize Event -->
                                            <asp:Panel runat="server" ID="PnlPrizeEvent" Visible="False">
                                                <div class="col-md-12">
                                                    <div class="col-md-5 no-padding">
                                                        <label>Prize Name</label>
                                                        <asp:TextBox runat="server" ID="txtPrizeName" MaxLength="50" CssClass="form-control" TabIndex="10"></asp:TextBox>
                                                    </div>
                                                </div>

                                                <div class="col-md-12">
                                                    <div class="col-md-5 no-padding">
                                                        <label>Reward %</label>
                                                        <asp:TextBox runat="server" ID="txtPrizeReward" MaxLength="4" CssClass="form-control numeric" Enabled="false" TabIndex="11"></asp:TextBox>
                                                    </div>

                                                </div>
                                                <div class="col-md-12">
                                                    <div class="col-md-5 no-padding">
                                                        <label>Maximum Reward Value</label>
                                                        <asp:TextBox runat="server" ID="txtPrizeMaxRewardVal" MaxLength="8" CssClass="form-control avtNumericWithDecimal" Enabled="False" TabIndex="12"></asp:TextBox>
                                                    </div>
                                                </div>

                                            </asp:Panel>

                                            <!-- Free Slot Play -->
                                            <asp:Panel runat="server" ID="PnlFreeSlotPlay" Visible="False">
                                                <div class="col-md-12">
                                                    <div class="col-md-5 no-padding">
                                                        <label>Free Slot per $1 in Rewards</label>
                                                        <asp:TextBox runat="server" ID="txtFreeCompDollar" onblur="addDollarSign(this);" MaxLength="6" CssClass="form-control numeric" TabIndex="13"></asp:TextBox>
                                                    </div>
                                                </div>

                                                <div class="col-md-12">
                                                    <div class="col-md-5 no-padding">
                                                        <label>Reward %</label>
                                                        <asp:TextBox runat="server" ID="txtFreeReward" MaxLength="6" onblur="addPercentageSign(this);" CssClass="form-control numeric" TabIndex="14"></asp:TextBox>
                                                    </div>
                                                    <div class="col-md-1 no-padding">
                                                    </div>
                                                    <div class="col-md-5 no-padding">
                                                        <label>Minimum Reward Guide</label>
                                                        <asp:TextBox runat="server" ID="txtFreeMinReward" onblur="addDollarSign(this);" MaxLength="8" CssClass="form-control avtNumericWithDecimal" TabIndex="15" ReadOnly="True"></asp:TextBox>
                                                    </div>
                                                </div>
                                                <div class="col-md-12">
                                                    <div class="col-md-5 no-padding">
                                                        <label>Maximum Reward Value</label>
                                                        <asp:TextBox runat="server" ID="txtFreeMaxReward" onblur="addDollarSign(this);" MaxLength="8" CssClass="form-control avtNumericWithDecimal" TabIndex="16"></asp:TextBox>
                                                    </div>
                                                </div>

                                            </asp:Panel>

                                            <!-- Comp Dollar Panel -->

                                            <asp:Panel runat="server" ID="pnlCompDollar" Visible="False">
                                                <div class="col-md-12">
                                                    <div class="col-md-5 no-padding">
                                                        <label>Comp Dollars per $1 in Rewards</label>
                                                        <asp:TextBox runat="server" ID="txtCompDollar" onblur="addDollarSign(this);" MaxLength="8" CssClass="form-control numeric" TabIndex="17"></asp:TextBox>
                                                    </div>
                                                </div>

                                                <div class="col-md-12">
                                                    <div class="col-md-5 no-padding">
                                                        <label>Reward %</label>
                                                        <asp:TextBox runat="server" ID="txtCompReward" MaxLength="6" onblur="addPercentageSign(this);" CssClass="form-control numeric" TabIndex="18"></asp:TextBox>
                                                    </div>
                                                    <div class="col-md-1 no-padding">
                                                    </div>
                                                    <div class="col-md-5 no-padding">
                                                        <label>Minimum Reward Guide</label>
                                                        <asp:TextBox runat="server" ID="txtCompMinReward" onblur="addDollarSign(this);" MaxLength="8" CssClass="form-control avtNumericWithDecimal" TabIndex="19" ReadOnly="True"></asp:TextBox>
                                                    </div>
                                                </div>
                                                <div class="col-md-12">
                                                    <div class="col-md-5 no-padding">
                                                        <label>Maximum Reward Value</label>
                                                        <asp:TextBox runat="server" ID="txtCompMaxReward" onblur="addDollarSign(this);" MaxLength="8" CssClass="form-control avtNumericWithDecimal" TabIndex="20"></asp:TextBox>
                                                    </div>
                                                </div>

                                            </asp:Panel>

                                            <!-- Point Panel Event -->
                                            <asp:Panel runat="server" ID="pnlPointEvent" Visible="False">
                                                <div class="col-md-12">
                                                    <div class="col-md-5 no-padding">
                                                        <label>Points per $1 in Rewards</label>
                                                        <asp:TextBox runat="server" ID="txtPointDollar" MaxLength="8" CssClass="form-control numeric" TabIndex="21"></asp:TextBox>
                                                    </div>
                                                </div>

                                                <div class="col-md-12">
                                                    <div class="col-md-5 no-padding">
                                                        <label>Reward %</label>
                                                        <asp:TextBox runat="server" ID="txtPointReward" MaxLength="6" onblur="addPercentageSign(this);" CssClass="form-control numeric" TabIndex="22"></asp:TextBox>
                                                    </div>
                                                    <div class="col-md-1 no-padding">
                                                    </div>
                                                    <div class="col-md-5 no-padding">
                                                        <label>Minimum Reward Guide</label>
                                                        <asp:TextBox runat="server" ID="txtPointMinReward" onblur="addDollarSign(this);" MaxLength="8" CssClass="form-control avtNumericWithDecimal" TabIndex="23" ReadOnly="True"></asp:TextBox>
                                                    </div>
                                                </div>
                                                <div class="col-md-12">
                                                    <div class="col-md-5 no-padding">
                                                        <label>Maximum Reward Value</label>
                                                        <asp:TextBox runat="server" ID="txtPointMaxRewardVal" onblur="addDollarSign(this);" MaxLength="8" CssClass="form-control avtNumericWithDecimal" TabIndex="24"></asp:TextBox>
                                                    </div>
                                                </div>

                                            </asp:Panel>


                                            <!--Section 1 -->
                                            <!-- Content Tab Ends -->

                                            <!-- Schedule Tab Starts -->
                                        </div>
                                    </div>

                                    <!-- Content Tab Ends -->

                                    <!-- Schedule Tab Starts -->
                                    <div class="tab-pane fade" id="manageScheduleTab">
                                        <div class=" tab-container clearfix">
                                            <asp:Panel runat="server" ID="pnlSchedule">
                                                <div class="clearfix">
                                                    <div class="col-md-4">
                                                        <div class="filterWrapper filterWrapper2 relative">
                                                            <div class="row clearfix whiteBg">
                                                                <div class="col-xs-7">
                                                                    <label>Schedule</label>
                                                                </div>
                                                                <div class="col-xs-5">
                                                                    <span class="addBtn">Add
                                                                    <asp:Button ID="lnkbtnAddSchedule" runat="server" CssClass="btn btn-add pull-right " OnClick="lnkbtnAddSchedule_OnClick"></asp:Button>
                                                                    </span>
                                                                </div>
                                                            </div>
                                                            <div class="input-group">
                                                                <asp:TextBox runat="server" ID="txtScheduleSearch" CssClass="form-control height26" />
                                                                <span class="input-group-btn">
                                                                    <asp:Button ID="btnSearchSchedule" CssClass="btn btn-black glyphicons filter btn-icon white refershedulebtn" runat="server" OnClick="btnSearchSchedule_OnClick" /><i></i>
                                                                </span>
                                                            </div>
                                                            <div class="filterWrapper filterWrapper2 relative schedulegridheight">
                                                                <div class="filterScheduleResults">

                                                                    <asp:GridView CssClass="gridview" ID="gvSchedules" DataKeyNames="EventScheduleID" runat="server" ShowHeader="False" AutoGenerateColumns="false" OnPageIndexChanging="gvSchedules_PageIndexChanging"
                                                                        AllowPaging="true">
                                                                        <Columns>
                                                                            <asp:TemplateField>
                                                                                <ItemTemplate>
                                                                                    <asp:LinkButton ID="lnkBtnScheduleName" runat="server" Text='<%#Eval("ScheduleName") %>' OnClick="lnkBtnScheduleName_Click" />
                                                                                </ItemTemplate>
                                                                            </asp:TemplateField>
                                                                        </Columns>
                                                                        <SelectedRowStyle CssClass="gvSelectedRow" />
                                                                        <PagerStyle CssClass="gridview-pager"></PagerStyle>
                                                                    </asp:GridView>

                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-8">
                                                        <label for="adscheduleName">Schedule Name</label>
                                                        <asp:TextBox ID="txtScheduleName" runat="server" CssClass="form-control" MaxLength="250"></asp:TextBox>
                                                        <div id="dvScheduleControls">
                                                            <div class="fieldset">
                                                                <fieldset>
                                                                    <legend>
                                                                        <label>Schedule</label>
                                                                    </legend>
                                                                    <div class="col-xs-5">
                                                                        <div class="clearfix calTime">
                                                                            <div class="col-xs-3">
                                                                                <label for="adscheduleFrom">From</label>
                                                                            </div>
                                                                            <div class="col-xs-9">
                                                                                <div class="input-group date datePickers" data-date-format="mm/dd/yyyy">
                                                                                    <asp:TextBox ID="txtScheduleFrom" runat="server" class="form-control datePickers"></asp:TextBox>
                                                                                    <span class="input-group-addon" id="Span1"><i class="icon-th"></i></span>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                        <div class="clearfix calTime">
                                                                            <div class="col-xs-3">
                                                                                <label for="adscheduleTo">To</label>
                                                                            </div>
                                                                            <div class="col-xs-9">
                                                                                <div class="input-group date datePickers" data-date-format="mm/dd/yyyy">
                                                                                    <asp:TextBox ID="txtScheduleTo" runat="server" class="form-control datePickers"></asp:TextBox>
                                                                                    <span class="input-group-addon" id="adscheduleFrom"><i class="icon-th"></i></span>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <div class="col-xs-4">
                                                                        <div class="clearfix calTime">
                                                                            <div class="col-xs-3">
                                                                                <label for="adscheduleFromAt">At</label>
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
                                                                                <label for="adscheduleToAt">At</label>
                                                                            </div>
                                                                            <div class="col-xs-9">
                                                                                <div class="bootstrap-timepicker input-group">
                                                                                    <asp:TextBox ID="txtscheduleToAt" runat="server" class="form-control timePickers"></asp:TextBox>
                                                                                    <i class="icon-time"></i>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <%--<div class="col-xs-3 lblrd">
                                                                        <asp:RadioButtonList ID="rdEventWindows" runat="server">
                                                                            <asp:ListItem Text="Across Event Windows" Value="1"></asp:ListItem>
                                                                            <asp:ListItem Text="Within Event Windows" Value="0"></asp:ListItem>
                                                                        </asp:RadioButtonList>
                                                                    </div>--%>
                                                                </fieldset>
                                                            </div>
                                                            <div class="fieldset nomargin">
                                                                <fieldset>
                                                                    <legend>
                                                                        <asp:CheckBox Text="Schedule by Day of Week" ID="chkScheduleByDayOfWeek" runat="server" /></legend>
                                                                    <table class="table scheduleTable fieldSwitch">
                                                                        <tbody>
                                                                            <tr class="trmonday">
                                                                                <td>
                                                                                    <asp:CheckBox Text="Monday" runat="server" ID="chkMonday" />
                                                                                <td>
                                                                                    <label for="adscheduleMondayFrom" class="pull-left">From</label>
                                                                                    <div class="pull-right">
                                                                                        <div class="bootstrap-timepicker input-group">
                                                                                            <asp:TextBox ID="txtScheduleMondayFrom" runat="server" class="form-control timePickers"></asp:TextBox>
                                                                                            <i class="icon-time"></i>
                                                                                        </div>
                                                                                    </div>
                                                                                </td>
                                                                                <td>
                                                                                    <label for="adscheduleMondayTo" class="pull-left">To</label>
                                                                                    <div class="pull-right">
                                                                                        <div class="bootstrap-timepicker input-group">
                                                                                            <asp:TextBox ID="txtScheduleMondayTo" runat="server" class="form-control timePickers"></asp:TextBox>
                                                                                            <i class="icon-time"></i>
                                                                                        </div>
                                                                                    </div>
                                                                                </td>
                                                                            </tr>
                                                                            <tr class="trtuesday">
                                                                                <td>
                                                                                    <asp:CheckBox Text="Tuesday" runat="server" ID="chkTuesday" />
                                                                                <td>
                                                                                    <label for="adscheduleTuesFrom" class="pull-left">From</label>
                                                                                    <div class="pull-right">
                                                                                        <div class="bootstrap-timepicker input-group">
                                                                                            <asp:TextBox ID="txtScheduleTueFrom" runat="server" class="form-control timePickers"></asp:TextBox>
                                                                                            <i class="icon-time"></i>
                                                                                        </div>
                                                                                    </div>
                                                                                </td>
                                                                                <td>
                                                                                    <label for="adscheduleTuesTo" class="pull-left">To</label>
                                                                                    <div class="pull-right">
                                                                                        <div class="bootstrap-timepicker input-group">
                                                                                            <asp:TextBox ID="txtScheduleTueTo" runat="server" class="form-control timePickers"></asp:TextBox>
                                                                                            <i class="icon-time"></i>
                                                                                        </div>
                                                                                    </div>
                                                                                </td>
                                                                            </tr>
                                                                            <tr class="trwednesday">
                                                                                <td>
                                                                                    <asp:CheckBox Text="Wednesday" runat="server" ID="chkWednesday" />
                                                                                <td>
                                                                                    <label for="adscheduleWedFrom" class="pull-left">From</label>
                                                                                    <div class="pull-right">
                                                                                        <div class="bootstrap-timepicker input-group">
                                                                                            <asp:TextBox ID="txtScheduleWedFrom" runat="server" class="form-control timePickers"></asp:TextBox>
                                                                                            <i class="icon-time"></i>
                                                                                        </div>
                                                                                    </div>
                                                                                </td>
                                                                                <td>
                                                                                    <label for="adscheduleWedTo" class="pull-left">To</label>
                                                                                    <div class="pull-right">
                                                                                        <div class="bootstrap-timepicker input-group">
                                                                                            <asp:TextBox ID="txtScheduleWedTo" runat="server" class="form-control timePickers"></asp:TextBox>
                                                                                            <i class="icon-time"></i>
                                                                                        </div>
                                                                                    </div>
                                                                                </td>
                                                                            </tr>
                                                                            <tr class="trthursday">
                                                                                <td>
                                                                                    <asp:CheckBox Text="Thursday" ID="chkThursday" runat="server" />
                                                                                <td>
                                                                                    <label for="adscheduleThusFrom" class="pull-left">From</label>
                                                                                    <div class="pull-right">
                                                                                        <div class="bootstrap-timepicker input-group">
                                                                                            <asp:TextBox ID="txtScheduleThuFrom" runat="server" class="form-control timePickers"></asp:TextBox>
                                                                                            <i class="icon-time"></i>
                                                                                        </div>
                                                                                    </div>
                                                                                </td>
                                                                                <td>
                                                                                    <label for="adscheduleThusTo" class="pull-left">To</label>
                                                                                    <div class="pull-right">
                                                                                        <div class="bootstrap-timepicker input-group">
                                                                                            <asp:TextBox ID="txtScheduleThuTo" runat="server" class="form-control timePickers"></asp:TextBox>
                                                                                            <i class="icon-time"></i>
                                                                                        </div>
                                                                                    </div>
                                                                                </td>
                                                                            </tr>
                                                                            <tr class="trfriday">
                                                                                <td>
                                                                                    <asp:CheckBox Text="Friday" ID="chkFriday" runat="server" />
                                                                                <td>
                                                                                    <label for="adschelblWebAppLoginScreenBrandingmage1duleFriFrom" class="pull-left">From</label>
                                                                                    <div class="pull-right">
                                                                                        <div class="bootstrap-timepicker input-group">
                                                                                            <asp:TextBox ID="txtScheduleFriFrom" runat="server" class="form-control timePickers"></asp:TextBox>
                                                                                            <i class="icon-time"></i>
                                                                                        </div>
                                                                                    </div>
                                                                                </td>
                                                                                <td>
                                                                                    <label for="adscheduleFriTo" class="pull-left">To</label>
                                                                                    <div class="pull-right">
                                                                                        <div class="bootstrap-timepicker input-group">
                                                                                            <asp:TextBox ID="txtScheduleFriTo" runat="server" class="form-control timePickers"></asp:TextBox>
                                                                                            <i class="icon-time"></i>
                                                                                        </div>
                                                                                    </div>
                                                                                </td>
                                                                            </tr>
                                                                            <tr class="trsaturday">
                                                                                <td>
                                                                                    <asp:CheckBox Text="Saturday" ID="chkSaturday" runat="server" />
                                                                                <td>
                                                                                    <label for="adscheduleSatFrom" class="pull-left">From</label>
                                                                                    <div class="pull-right">
                                                                                        <div class="bootstrap-timepicker input-group">
                                                                                            <asp:TextBox ID="txtScheduleSatFrom" runat="server" class="form-control timePickers"></asp:TextBox>
                                                                                            <i class="icon-time"></i>
                                                                                        </div>
                                                                                    </div>
                                                                                </td>
                                                                                <td>
                                                                                    <label for="adscheduleSatTo" class="pull-left">To</label>
                                                                                    <div class="pull-right">
                                                                                        <div class="bootstrap-timepicker input-group">
                                                                                            <asp:TextBox ID="txtScheduleSatTo" runat="server" class="form-control timePickers"></asp:TextBox>
                                                                                            <i class="icon-time"></i>
                                                                                        </div>
                                                                                    </div>
                                                                                </td>
                                                                            </tr>
                                                                            <tr class="trsunday">
                                                                                <td>
                                                                                    <asp:CheckBox Text="Sunday" ID="chkSunday" runat="server" />
                                                                                <td>
                                                                                    <label for="adscheduleSunFrom" class="pull-left">From</label>
                                                                                    <div class="pull-right">
                                                                                        <div class="bootstrap-timepicker input-group">
                                                                                            <asp:TextBox ID="txtScheduleSunFrom" runat="server" class="form-control timePickers"></asp:TextBox>
                                                                                            <i class="icon-time"></i>
                                                                                        </div>
                                                                                    </div>
                                                                                </td>
                                                                                <td>
                                                                                    <label for="adscheduleSunTo" class="pull-left">To</label>
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
                                                </div>
                                            </asp:Panel>
                                        </div>
                                    </div>
                                    <!-- Schedule Tab Ends -->

                                    <!-- Population Tab Starts -->
                                    <div class="tab-pane fade" id="managePopulationTab">
                                        <div class=" tab-container  clearfix">
                                            <div class="col-md-12">
                                                <div class="col-md-6 ">
                                                    <label>Players by Type</label>
                                                    <asp:DropDownList ID="ddlTierType" runat="server" AutoPostBack="true"
                                                        OnSelectedIndexChanged="ddlTierType_SelectedIndexChanged"
                                                        CssClass="form-control jq-selectbox" onchange="RegisterDisabledTypeListBox()">
                                                    </asp:DropDownList>
                                                </div>
                                                <div class="row" id="dvlstTier">
                                                    <div class="col-md-12">
                                                        <div class="col-md-12">
                                                            <label>Players by Tier</label>
                                                        </div>
                                                        <div class="col-md-12">
                                                            <label>Tiers</label>
                                                        </div>
                                                    </div>
                                                    <asp:ListBox runat="server" ID="lstPopulationTiers" SelectionMode="Multiple" CssClass="tiersListBox col-md-12"></asp:ListBox>
                                                    <asp:HiddenField runat="server" ID="hdnSelectedPopulationTiers" Value="0" />
                                                </div>
                                                <div class="col-md-10 ">
                                                    <asp:CheckBox Text="Enrollment Date" ID="chkEnrolmentDate" runat="server" onchange="EnableDDlEnrollType()" />
                                                    <asp:DropDownList ID="ddlEnrolmentType" runat="server" AutoPostBack="true"
                                                        OnSelectedIndexChanged="ddlEnrolmentType_SelectedIndexChanged"
                                                        CssClass="form-control jq-selectbox">
                                                    </asp:DropDownList>
                                                </div>
                                                <div class="col-md-10" runat="server" id="dvMessage">
                                                    <asp:Label ID="lblunknownmessage" runat="server" Text="Today" Visible="false" Style="font-weight: bold"></asp:Label>
                                                    <br />
                                                    <asp:TextBox runat="server" ID="txtUnknownMessage" MaxLength="4" CssClass="form-control numeric" Height="30px" Visible="false"></asp:TextBox>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- Population Tab Ends -->

                                    <!-- Message Tab Starts -->
                                    <div class="tab-pane fade" id="manageMessageTab">
                                        <!-- Message Auto Tab Starts-->
                                        <div class="tab-container clearfix">
                                            <div class="col-md-12 shadedSingleBlock">
                                                <label>
                                                    Define Messaging for an AvT Bonus
                                                </label>
                                                <br />
                                                <label>
                                                    From
                                                </label>

                                                <asp:TextBox runat="server" ID="txtFrom" CssClass="form-control" Height="34px"></asp:TextBox>
                                                <br />
                                                <label>
                                                    Message on Award of AvT Bonus
                                                </label>

                                                <asp:TextBox runat="server" ID="txtTableReadyMessage" MaxLength="255" TextMode="MultiLine" CssClass="form-control" Height="140px"></asp:TextBox>
                                                <div><i>Enter "@Award" to insert the patron's award amount or prize name in a specific place of the award message.</i></div>
                                                <div><i>User will receive this message as an in-app notification and website inbox, if available.</i></div>

                                                <br />
                                                <div>
                                                    <asp:CheckBox runat="server" ID="chkTurnOffNeedMoreTimeEnabled" onchange="EnablePushNotification()" Text="Enable as Push Notification" />
                                                </div>

                                                <div><i>If selected ,user will also receive this message as a push notification ,hardware and device configuration permitting.</i></div>

                                                <div>
                                                    <label>
                                                        Define Push Notification Text
                                                    </label>

                                                    <asp:TextBox runat="server" ID="txtDefinePushNotificationText" TextMode="MultiLine" CssClass="form-control" Height="140px"></asp:TextBox>
                                                </div>

                                                <!-- Message Location Tab Ends -->

                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <!-- Message Tab Ends -->
                            </div>
                        </div>
                    </div>
                    <div class="col-md-12 btnGroup">
                        <div class="btn-groupSpecial clearfix" style="bottom: 1px;">
                            <asp:Button Text="Copy" runat="server" ID="lnkBtnCopy" OnClientClick="return ConfirmMessage(7);" OnClick="lnkBtnCopy_OnClick" CssClass="results-control col-xsm-4" />
                            <asp:Button Text="Save" runat="server" ID="lnkBtnSave" OnClientClick="return FormValidation();" OnClick="lnkBtnSave_Click" CssClass="results-control col-xsm-4" />
                            <asp:Button Text="Cancel" runat="server" ID="lnkBtnCancel" OnClientClick="return ConfirmMessage(2);" OnClick="lnkBtnCancel_OnClick" CssClass="results-control col-xsm-4" />
                            <asp:Button Text="Delete" runat="server" ID="lnkBtnDelete" OnClientClick="return ConfirmMessage(3);" OnClick="lnkBtnDelete_OnClick" CssClass="results-control col-xsm-4" />

                        </div>
                    </div>
                </div>
            </div>
            </div>

            <script type="text/javascript">
                //On UpdatePanel Refresh

                var prm = Sys.WebForms.PageRequestManager.getInstance();
                if (prm != null) {
                    prm.add_endRequest(function (sender, e) {
                        if (sender._postBackSettings.panelsToUpdate != null) {
                            isNumber();
                            isNumberWithDecimal();
                            avTNumericWithDecimal();
                            RegisterDatePickersAndTimers();
                            RegisterDetectedFormChanges();
                            RegisterleftDivheight();
                            SetTabControls();
                            RegisterFieldSets();
                            RegisterCheckboxClick();
                            DisabledEnabledCheckbox();
                            LossTodayCal();
                            ActualLossCal();
                            MinimumRewardGuidCal();
                            MinRewardGuide();
                        }
                    });
                }

                $(document).ready(function () {
                    isNumber();
                    isNumberWithDecimal();

                    avTNumericWithDecimal();
                    RegisterDatePickersAndTimers();
                    RegisterDetectedFormChanges();
                    RegisterleftDivheight();
                    SetTabControls();
                    RegisterFieldSets();
                    RegisterCheckboxClick();
                    DisabledEnabledCheckbox();
                    LossTodayCal();
                    ActualLossCal();
                    MinimumRewardGuidCal();
                });

                function LossTodayCal() {
                    var LossToday = 0;
                    $('#MainContent_txtTLossToday').change(function () {
                        LossToday = $('#MainContent_txtTLossToday').val().replace('$', '');
                        var num = parseFloat(LossToday * $('#MainContent_txtMinPlAvtMultiple').val());
                        $('#MainContent_txtPlActualLoss').val("$" + num.toFixed(2));
                        document.getElementById('<%=hdnActualLoss.ClientID%>').value = num.toFixed(2);
                        MinRewardGuide();
                    });

                    $('#MainContent_txtMinPlAvtMultiple').change(function () {
                        LossToday = $('#MainContent_txtTLossToday').val().replace('$', '');
                        var num = parseFloat(LossToday * $('#MainContent_txtMinPlAvtMultiple').val());
                        $('#MainContent_txtPlActualLoss').val("$" + num.toFixed(2));
                        document.getElementById('<%=hdnActualLoss.ClientID%>').value = num.toFixed(2);
                        MinRewardGuide();
                    });
                }
                function ActualLossCal() {
                    if (document.getElementById('<%=hdnActualLoss.ClientID%>').value != "") {
                        $('#MainContent_txtPlActualLoss').val("$" + document.getElementById('<%=hdnActualLoss.ClientID%>').value);
                    }

                }

                function MinimumRewardGuidCal() {
                    var LossToday;
                    var ActualLoss;
                    var num;
                    var rewardType = document.getElementById('<%=hdnrewardType.ClientID%>').value;
                    if (rewardType == "2") {
                        $('#MainContent_txtCompReward').change(function () {
                            LossToday = $('#MainContent_txtTLossToday').val().replace('$', '');
                            ActualLoss = document.getElementById('<%=hdnActualLoss.ClientID%>').value;
                            num = parseFloat((ActualLoss - LossToday) * 0.01 * $('#MainContent_txtCompReward').val().replace('%', ''));
                            $('#MainContent_txtCompMinReward').val("$" + num.toFixed(2));
                            document.getElementById('<%=hdnMinRewardValue.ClientID%>').value = num.toFixed(2);
                        });
                    }
                    else if (rewardType == "3") {
                        $('#MainContent_txtFreeReward').change(function () {
                            LossToday = $('#MainContent_txtTLossToday').val().replace('$', '');
                            ActualLoss = document.getElementById('<%=hdnActualLoss.ClientID%>').value;
                            num = parseFloat((ActualLoss - LossToday) * 0.01 * $('#MainContent_txtFreeReward').val().replace('%', ''));
                            $('#MainContent_txtFreeMinReward').val("$" + num.toFixed(2));
                            document.getElementById('<%=hdnMinRewardValue.ClientID%>').value = num.toFixed(2);
                        });
                    }
                    else if (rewardType == "4") {
                        $('#MainContent_txtPointReward').change(function () {
                            LossToday = $('#MainContent_txtTLossToday').val().replace('$', '');
                            ActualLoss = document.getElementById('<%=hdnActualLoss.ClientID%>').value;
                            num = parseFloat((ActualLoss - LossToday) * 0.01 * $('#MainContent_txtPointReward').val().replace('%', ''));
                            $('#MainContent_txtPointMinReward').val("$" + num.toFixed(2));
                            document.getElementById('<%=hdnMinRewardValue.ClientID%>').value = num.toFixed(2);
                        });
                    }

        }

        function MinRewardGuide() {

            var rewardType = document.getElementById('<%=hdnrewardType.ClientID%>').value;
            var ActualLoss;
            var LossToday;
            var num;
            if (rewardType == "2") {
                ActualLoss = document.getElementById('<%=hdnActualLoss.ClientID%>').value;
                LossToday = $('#MainContent_txtTLossToday').val().replace('$', '');
                num = parseFloat((ActualLoss - LossToday) * 0.01 * $('#MainContent_txtCompReward').val().replace('%', ''));
                $('#MainContent_txtCompMinReward').val("$" + num.toFixed(2));
                document.getElementById('<%=hdnMinRewardValue.ClientID%>').value = num.toFixed(2);
            }
            else if (rewardType == "3") {
                ActualLoss = document.getElementById('<%=hdnActualLoss.ClientID%>').value;
                LossToday = $('#MainContent_txtTLossToday').val().replace('$', '');
                num = parseFloat((ActualLoss - LossToday) * 0.01 * $('#MainContent_txtFreeReward').val().replace('%', ''));
                $('#MainContent_txtFreeMinReward').val("$" + num.toFixed(2));
                document.getElementById('<%=hdnMinRewardValue.ClientID%>').value = num.toFixed(2);
            }
            else if (rewardType == "4") {
                ActualLoss = document.getElementById('<%=hdnActualLoss.ClientID%>').value;
                LossToday = $('#MainContent_txtTLossToday').val().replace('$', '');
                num = parseFloat((ActualLoss - LossToday) * 0.01 * $('#MainContent_txtPointReward').val().replace('%', ''));
                $('#MainContent_txtPointMinReward').val("$" + num.toFixed(2));
                document.getElementById('<%=hdnMinRewardValue.ClientID%>').value = num.toFixed(2);
            }
}

function RegisterleftDivheight() {
    $("#dvLeftcontentdetail1").height($('#dvRightContent1').height());
}
function RegisterCheckboxClick() {
    $('input:checkbox').on('change', function () {
        ToggleEnablingDivOnCheckedChange($(this).prop('id'));
    });
}

function ToggleEnablingDivOnCheckedChange(controlId) {
}

function DisabledEnabledCheckbox() {
}

function ResetControls(divId, status) {
    $(divId).find('input:text,select,input:checkbox').prop('disabled', !status);
    $(divId).find('textarea').prop('disabled', !status);
}

function RegisterDatePickersAndTimers() {
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

function avTNumericWithDecimal() {

    $('.avtNumericWithDecimal').keydown(function (event) {
        // Allow special chars + arrows 
        if (event.keyCode == 46 || event.keyCode == 8 || event.keyCode == 9
            || event.keyCode == 27 || event.keyCode == 13
            || event.keyCode == 110 || event.keyCode == 190
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

// THE SCRIPT THAT CHECKS IF THE KEY PRESSED IS A NUMERIC OR DECIMAL VALUE.
function isNumberAvT(evt, element) {

    var charCode = (evt.which) ? evt.which : event.keyCode;

    if (charCode != 46 && charCode > 31 && (charCode < 48 || charCode > 57))
        return false;

    return true;
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

function isNumberWithDecimal() {
    $('.numericwithdecimal').keydown(function (event) {
        // Allow special chars + arrows 

        if (event.keyCode == 46 || event.keyCode == 110 || event.keyCode == 8 || event.keyCode == 9
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
    $(".numericwithdecimal").bind("paste", function (e) {
        return false;
    });
    $(".numericwithdecimal").bind("drop", function (e) {
        return false;
    });
}

function EnableDDlEnrollType() {
    if ($('#<%=chkEnrolmentDate.ClientID%>')[0].checked == true) {
                $('#<%= ddlEnrolmentType.ClientID %>').prop('disabled', false);
                $('#<%= ddlEnrolmentType.ClientID %>').removeClass('aspNetDisabled');
                if ($('#<%=ddlEnrolmentType.ClientID%>').val() != 1) {
                    $('#<%= txtUnknownMessage.ClientID %>').prop('disabled', false);
                }
                else {
                    $('#<%= txtUnknownMessage.ClientID %>').prop('disabled', true);
                }
            }
            else {
                $('#<%= ddlEnrolmentType.ClientID %>').prop('disabled', true);
                $('#<%= txtUnknownMessage.ClientID %>').prop('disabled', true);
            }

        }

        function EnablePushNotification() {
            if ($('#<%=chkTurnOffNeedMoreTimeEnabled.ClientID%>')[0].checked == true) {
                $('#<%= txtDefinePushNotificationText.ClientID %>').prop('disabled', false);
                $('#<%= txtDefinePushNotificationText.ClientID %>').removeClass('aspNetDisabled');

            }
            else {
                $('#<%= txtDefinePushNotificationText.ClientID %>').prop('disabled', true);
                $('#<%= txtDefinePushNotificationText.ClientID %>').val('');
            }

        }

        function FormValidation() {
            var activeTab = $('input:hidden[id*="hdnSelectedTab"]').val();

            // Start EventDetails Validation

            if (myTrim(document.getElementById('<%=txtEventName.ClientID%>').value) == '') {

                document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please Enter Bonus Event Name.';
                $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                document.getElementById('<%=txtEventName.ClientID%>').focus();
                return false;
            }

            if (myTrim(document.getElementById('<%=txtTLossToday.ClientID%>').value) == '' || myTrim(document.getElementById('<%=txtTLossToday.ClientID%>').value) == '$') {

                document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please Enter Player Theoretical Loss Today.';
                        $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                        document.getElementById('<%=txtTLossToday.ClientID%>').focus();
                    return false;
                }

                if (myTrim(document.getElementById('<%=txtMinPlAvtMultiple.ClientID%>').value) == '') {

                document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please Enter Minimum Player AvT Multiple.';
                $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                document.getElementById('<%=txtMinPlAvtMultiple.ClientID%>').focus();
                    return false;
                }

                if (myTrim(document.getElementById('<%=txtPlActualLoss.ClientID%>').value) == '') {

                document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please Enter Minimum Player Actual Loss Today';
                        $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                        document.getElementById('<%=txtPlActualLoss.ClientID%>').focus();
                        return false;
                    }

                    if ($('#<%=chkMaxSession.ClientID%>')[0].checked == true) {
                if ($('#<%=txtslot.ClientID%>').val() == '') {
                            document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please Enter Slot Session Value.';
                    $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                    document.getElementById('<%=txtslot.ClientID%>').focus();
                            return false;
                        }
                        if ($('#<%=txtminute.ClientID%>').val() == '') {
                            document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please Enter Minute.';
                        $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                        document.getElementById('<%=txtminute.ClientID%>').focus();
                    return false;
                }
            }

            if (myTrim(document.getElementById('<%=txtPlayerNum.ClientID%>').value) == '') {

                document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please Enter Maximum Player Awards per Period Value';
                    $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                    document.getElementById('<%=txtPlayerNum.ClientID%>').focus();
                        return false;
                    }

                    if ($('#<%=ddlPeriod.ClientID%> option:selected').val() == '-1') {
                document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please select Period.';
                        $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                        document.getElementById('<%=ddlPeriod.ClientID%>').focus();
                        return false;
                    }

                    if ($('#<%=ddlRewardType.ClientID%> option:selected').val() == '-1') {
                document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please select Reward Type.';
                        $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                        document.getElementById('<%=ddlRewardType.ClientID%>').focus();
                        return false;
                    }
            // Prize Panel
                    if ($('#<%=ddlRewardType.ClientID%> option:selected').val() == '1') {
                if (myTrim(document.getElementById('<%=txtPrizeName.ClientID%>').value) == '') {
                            document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please Enter Prize Name.';
                    $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                    document.getElementById('<%=txtPrizeName.ClientID%>').focus();
                            return false;
                        }

                    }

            // Comp Dollar Panel
                    if ($('#<%=ddlRewardType.ClientID%> option:selected').val() == '2') {
                if (myTrim(document.getElementById('<%=txtCompDollar.ClientID%>').value) == '' || myTrim(document.getElementById('<%=txtCompDollar.ClientID%>').value) == '%') {
                        document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please Enter Value for Comp Dollar Per Reward.';
                    $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                    document.getElementById('<%=txtCompDollar.ClientID%>').focus();
                            return false;
                        }

                        if (myTrim(document.getElementById('<%=txtCompReward.ClientID%>').value) == '') {
                        document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please Enter Reward  Percentage.';
                        $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                        document.getElementById('<%=txtCompReward.ClientID%>').focus();
                    return false;
                }

                if (myTrim(document.getElementById('<%=txtCompMinReward.ClientID%>').value) == '' || myTrim(document.getElementById('<%=txtCompMinReward.ClientID%>').value) == '$') {
                        document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please Enter Minimum Reward Guide Value.';
                        $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                        document.getElementById('<%=txtCompMinReward.ClientID%>').focus();
                            return false;
                        }

                        if (myTrim(document.getElementById('<%=txtCompMaxReward.ClientID%>').value) == '' || myTrim(document.getElementById('<%=txtCompMaxReward.ClientID%>').value) == '$') {
                        document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please Enter Maximum Reward Value.';
                            $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                            document.getElementById('<%=txtCompMaxReward.ClientID%>').focus();
                            return false;
                        }

                    }

            // Free Slot Panel

                    if ($('#<%=ddlRewardType.ClientID%> option:selected').val() == '3') {
                if (myTrim(document.getElementById('<%=txtFreeCompDollar.ClientID%>').value) == '' || myTrim(document.getElementById('<%=txtFreeCompDollar.ClientID%>').value) == '$') {
                            document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please Enter Value for Free Slot Per Reward.';
                    $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                    document.getElementById('<%=txtFreeCompDollar.ClientID%>').focus();
                            return false;
                        }

                        if (myTrim(document.getElementById('<%=txtFreeReward.ClientID%>').value) == '' || myTrim(document.getElementById('<%=txtFreeReward.ClientID%>').value) == '%') {
                            document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please Enter Reward  Percentage.';
                        $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                        document.getElementById('<%=txtFreeReward.ClientID%>').focus();
                    return false;
                }

                if (myTrim(document.getElementById('<%=txtFreeMinReward.ClientID%>').value) == '' || myTrim(document.getElementById('<%=txtFreeMinReward.ClientID%>').value) == '$') {
                            document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please Enter Minimum Reward Guide Value.';
                        $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                        document.getElementById('<%=txtFreeMinReward.ClientID%>').focus();
                            return false;
                        }

                        if (myTrim(document.getElementById('<%=txtFreeMaxReward.ClientID%>').value) == '' || myTrim(document.getElementById('<%=txtFreeMaxReward.ClientID%>').value) == '$') {
                            document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please Enter Maximum Reward Value.';
                            $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                            document.getElementById('<%=txtFreeMaxReward.ClientID%>').focus();
                            return false;
                        }

                    }
            // Point Panel
                    if ($('#<%=ddlRewardType.ClientID%> option:selected').val() == '4') {
                if (myTrim(document.getElementById('<%=txtPointDollar.ClientID%>').value) == '') {
                            document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please Enter Value for Point Per Reward.';
                    $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                    document.getElementById('<%=txtPointDollar.ClientID%>').focus();
                            return false;
                        }

                        if (myTrim(document.getElementById('<%=txtPointReward.ClientID%>').value) == '' || myTrim(document.getElementById('<%=txtPointReward.ClientID%>').value) == '%') {
                            document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please Enter Reward  Percentage.';
                        $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                        document.getElementById('<%=txtPointReward.ClientID%>').focus();
                    return false;
                }

                if (myTrim(document.getElementById('<%=txtPointMinReward.ClientID%>').value) == '' || myTrim(document.getElementById('<%=txtPointMinReward.ClientID%>').value) == '$') {
                            document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please Enter Minimum Reward Guide Value.';
                        $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                        document.getElementById('<%=txtPointMinReward.ClientID%>').focus();
                            return false;
                        }

                        if (myTrim(document.getElementById('<%=txtPointMaxRewardVal.ClientID%>').value) == '' || myTrim(document.getElementById('<%=txtPointMaxRewardVal.ClientID%>').value) == '$') {
                            document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please Enter Maximum Reward Value.';
                            $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                            document.getElementById('<%=txtPointMaxRewardVal.ClientID%>').focus();
                            return false;
                        }
                    }

            // End EventDetails Validation

            //Start Validation Message

                    if (myTrim($('#<%=txtTableReadyMessage.ClientID%>').val()) == '') {
                document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please enter Message on Award of AvT Bonus';
                        $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                        document.getElementById('<%=txtTableReadyMessage.ClientID%>').focus();
                        return false;
                    }
            <%--if (myTrim($('#<%=txtFrom.ClientID%>').val()) == '') {
                document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please enter name of the Message sender on Award of AvT Bonus';
                $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                document.getElementById('<%=txtFrom.ClientID%>').focus();
                        return false;
                    }--%>

            if (myTrim($('#<%=txtScheduleName.ClientID%>').val()) == '') {
                document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please Enter Schedule Name.';
                $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                document.getElementById('<%=txtScheduleName.ClientID%>').focus();
                        return false;
                    }
            // End Validation Message
            // Start Schedule Validation
                    if (document.getElementById('<%=txtScheduleFrom.ClientID%>').value != '' || document.getElementById('<%=txtScheduleTo.ClientID%>').value != '' || document.getElementById('<%=txtScheduleFromAt.ClientID%>').value != '' || document.getElementById('<%=txtscheduleToAt.ClientID%>').value != '' || $('#<%=chkScheduleByDayOfWeek.ClientID%>')[0].checked == true) {
                if (myTrim(document.getElementById('<%=txtScheduleName.ClientID%>').value) == '') {
                        document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please Enter Schedule Name.';
                    $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                    document.getElementById('<%=txtScheduleName.ClientID%>').focus();
                            return false;
                        }
                    }
                    if (myTrim(document.getElementById('<%=txtScheduleName.ClientID%>').value) != '') {
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
                        var scheduleFromAt = document.getElementById('<%=txtScheduleFromAt.ClientID%>').value;
                    var scheduleToAt = document.getElementById('<%=txtscheduleToAt.ClientID%>').value;
                    if (Date.parse(document.getElementById('<%=txtScheduleTo.ClientID%>').value + ' ' + scheduleToAt) < Date.parse(document.getElementById('<%=txtScheduleFrom.ClientID%>').value + ' ' + scheduleFromAt)) {
                        document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Invalid Date Range!\nStart Date Time  cannot be after End Date Time!';
                    $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                    document.getElementById('<%=txtScheduleTo.ClientID%>').focus();
                        return false;
                    }
                    if (($('#<%=chkScheduleByDayOfWeek.ClientID%>')[0].checked == true) && ($('#<%=chkMonday.ClientID%>')[0].checked == false) && ($('#<%=chkTuesday.ClientID%>')[0].checked == false) &&
                    ($('#<%=chkWednesday.ClientID%>')[0].checked == false) && ($('#<%=chkThursday.ClientID%>')[0].checked == false) && ($('#<%=chkFriday.ClientID%>')[0].checked == false) &&
                        ($('#<%=chkSaturday.ClientID%>')[0].checked == false) && ($('#<%=chkSunday.ClientID%>')[0].checked == false)) {
                            document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please select atleast one Day of Week';
                            $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                            document.getElementById('<%=chkScheduleByDayOfWeek.ClientID%>').focus();
                            return false;
                        }
                        if ($('#<%=chkMonday.ClientID%>')[0].checked == true) {
                        if (document.getElementById('<%=txtScheduleMondayFrom.ClientID%>').value == '') {
                                document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please enter Monday from time';
                        $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                        document.getElementById('<%=txtScheduleMondayFrom.ClientID%>').focus();
                            return false;
                        }
                        if (document.getElementById('<%=txtScheduleMondayTo.ClientID%>').value == '') {

                                document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please enter Monday to time';
                                $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                                document.getElementById('<%=txtScheduleMondayTo.ClientID%>').focus();
                                return false;
                            }

                            var scheduleMonFromAt = document.getElementById('<%=txtScheduleMondayFrom.ClientID%>').value;
                            var scheduleMonToAt = document.getElementById('<%=txtScheduleMondayTo.ClientID%>').value;
                            if (Date.parse(document.getElementById('<%=txtScheduleFrom.ClientID%>').value + ' ' + scheduleMonToAt) < Date.parse(document.getElementById('<%=txtScheduleFrom.ClientID%>').value + ' ' + scheduleMonFromAt)) {
                                document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Invalid Time Range!\n Start Time cannot be after End Time!';
                                $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                                document.getElementById('<%=txtScheduleMondayTo.ClientID%>').focus();
                                return false;
                            }
                        }
                        else if (document.getElementById('<%=txtScheduleMondayFrom.ClientID%>').value != '' || document.getElementById('<%=txtScheduleMondayTo.ClientID%>').value != '') {
                            document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please select Monday';
                        $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                        document.getElementById('<%=chkMonday.ClientID%>').focus();
                        return false;
                    }
                if ($('#<%=chkTuesday.ClientID%>')[0].checked == true) {
                        if (document.getElementById('<%=txtScheduleTueFrom.ClientID%>').value == '') {
                        document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please enter Tuesday from time';
                        $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                        document.getElementById('<%=txtScheduleTueFrom.ClientID%>').focus();
                            return false;
                        }
                        if (document.getElementById('<%=txtScheduleTueTo.ClientID%>').value == '') {
                        document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please enter Tuesday to time';
                                $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                                document.getElementById('<%=txtScheduleTueTo.ClientID%>').focus();
                                return false;
                            }
                            var scheduleTueFromAt = document.getElementById('<%=txtScheduleTueFrom.ClientID%>').value;
                    var scheduleTueToAt = document.getElementById('<%=txtScheduleTueTo.ClientID%>').value;
                    if (Date.parse(document.getElementById('<%=txtScheduleFrom.ClientID%>').value + ' ' + scheduleTueToAt) < Date.parse(document.getElementById('<%=txtScheduleFrom.ClientID%>').value + ' ' + scheduleTueFromAt)) {
                        document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Invalid Time Range!\n Start Time cannot be after End Time!';
                    $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                    document.getElementById('<%=txtScheduleTueTo.ClientID%>').focus();
                    return false;
                }
            }
            else if (document.getElementById('<%=txtScheduleTueFrom.ClientID%>').value != '' || document.getElementById('<%=txtScheduleTueTo.ClientID%>').value != '') {

                    document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please select Tuesday';
                    $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                    document.getElementById('<%=chkTuesday.ClientID%>').focus();
                    return false;
                }
            if ($('#<%=chkWednesday.ClientID%>')[0].checked == true) {
                        if (document.getElementById('<%=txtScheduleWedFrom.ClientID%>').value == '') {
                    document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please enter Wednesday from time';
                        $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                        document.getElementById('<%=txtScheduleWedFrom.ClientID%>').focus();
                            return false;
                        }
                        if (document.getElementById('<%=txtScheduleWedTo.ClientID%>').value == '') {

                    document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please enter Wednesday to time';
                                $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                                document.getElementById('<%=txtScheduleWedTo.ClientID%>').focus();
                                return false;
                            }
                            var scheduleWedFromAt = document.getElementById('<%=txtScheduleWedFrom.ClientID%>').value;
                var scheduleWedToAt = document.getElementById('<%=txtScheduleWedTo.ClientID%>').value;
                if (Date.parse(document.getElementById('<%=txtScheduleFrom.ClientID%>').value + ' ' + scheduleWedToAt) < Date.parse(document.getElementById('<%=txtScheduleFrom.ClientID%>').value + ' ' + scheduleWedFromAt)) {
                    document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Invalid Time Range!\n Start Time cannot be after End Time!';
                    $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                    document.getElementById('<%=txtScheduleWedTo.ClientID%>').focus();
                    return false;
                }
            }
            else if (document.getElementById('<%=txtScheduleWedFrom.ClientID%>').value != '' || document.getElementById('<%=txtScheduleWedTo.ClientID%>').value != '') {

                document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please select Wednesday';
                    $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                    document.getElementById('<%=chkWednesday.ClientID%>').focus();
                    return false;
                }


            if ($('#<%=chkThursday.ClientID%>')[0].checked == true) {
                        if (document.getElementById('<%=txtScheduleThuFrom.ClientID%>').value == '') {

                    document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please enter Thursday from time';
                        $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                        document.getElementById('<%=txtScheduleThuFrom.ClientID%>').focus();
                            return false;
                        }
                        if (document.getElementById('<%=txtScheduleThuTo.ClientID%>').value == '') {
                    document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please enter Thursday to time';
                                $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                                document.getElementById('<%=txtScheduleThuTo.ClientID%>').focus();
                                return false;
                            }
                            var scheduleThuFromAt = document.getElementById('<%=txtScheduleThuFrom.ClientID%>').value;
                var scheduleThuToAt = document.getElementById('<%=txtScheduleThuTo.ClientID%>').value;
                if (Date.parse(document.getElementById('<%=txtScheduleFrom.ClientID%>').value + ' ' + scheduleThuToAt) < Date.parse(document.getElementById('<%=txtScheduleFrom.ClientID%>').value + ' ' + scheduleThuFromAt)) {
                    document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Invalid Time Range!\n Start Time cannot be after End Time!';
                    $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                    document.getElementById('<%=txtScheduleThuTo.ClientID%>').focus();
                    return false;
                }
            }
            else if (document.getElementById('<%=txtScheduleThuFrom.ClientID%>').value != '' || document.getElementById('<%=txtScheduleThuTo.ClientID%>').value != '') {
                document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please select Thursday';
                    $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                    document.getElementById('<%=chkThursday.ClientID%>').focus();
                    return false;
                }
            if ($('#<%=chkFriday.ClientID%>')[0].checked == true) {
                        if (document.getElementById('<%=txtScheduleFriFrom.ClientID%>').value == '') {
                    document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please enter Friday from time';
                        $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                        document.getElementById('<%=txtScheduleFriFrom.ClientID%>').focus();
                            return false;
                        }
                        if (document.getElementById('<%=txtScheduleFriTo.ClientID%>').value == '') {
                    document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please enter Friday to time';
                                $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                                document.getElementById('<%=txtScheduleFriTo.ClientID%>').focus();
                                return false;
                            }
                            var scheduleFriFromAt = document.getElementById('<%=txtScheduleFriFrom.ClientID%>').value;
                var scheduleFriToAt = document.getElementById('<%=txtScheduleFriTo.ClientID%>').value;
                if (Date.parse(document.getElementById('<%=txtScheduleFrom.ClientID%>').value + ' ' + scheduleFriToAt) < Date.parse(document.getElementById('<%=txtScheduleFrom.ClientID%>').value + ' ' + scheduleFriFromAt)) {
                    document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Invalid Time Range!\n Start Time cannot be after End Time!';
                    $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                    document.getElementById('<%=txtScheduleFriTo.ClientID%>').focus();
                    return false;
                }
            }
            else if (document.getElementById('<%=txtScheduleFriFrom.ClientID%>').value != '' || document.getElementById('<%=txtScheduleFriTo.ClientID%>').value != '') {
                document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please select Friday';
                    $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                    document.getElementById('<%=chkFriday.ClientID%>').focus();
                    return false;
                }
            if ($('#<%=chkSaturday.ClientID%>')[0].checked == true) {
                        if (document.getElementById('<%=txtScheduleSatFrom.ClientID%>').value == '') {
                    document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please enter Saturday from time';
                        $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                        document.getElementById('<%=txtScheduleSatFrom.ClientID%>').focus();
                            return false;
                        }
                        if (document.getElementById('<%=txtScheduleSatTo.ClientID%>').value == '') {
                    document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please enter Saturday to time';
                                $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                                document.getElementById('<%=txtScheduleSatTo.ClientID%>').focus();
                                return false;
                            }
                            var scheduleSatFromAt = document.getElementById('<%=txtScheduleSatFrom.ClientID%>').value;
                var scheduleSatToAt = document.getElementById('<%=txtScheduleSatTo.ClientID%>').value;
                if (Date.parse(document.getElementById('<%=txtScheduleFrom.ClientID%>').value + ' ' + scheduleSatToAt) < Date.parse(document.getElementById('<%=txtScheduleFrom.ClientID%>').value + ' ' + scheduleSatFromAt)) {
                    document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Invalid Time Range!\n Start Time cannot be after End Time!';
                    $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                    document.getElementById('<%=txtScheduleSatTo.ClientID%>').focus();
                    return false;
                }
            }
            else if (document.getElementById('<%=txtScheduleSatFrom.ClientID%>').value != '' || document.getElementById('<%=txtScheduleSatTo.ClientID%>').value != '') {

                document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please select Saturday';
                    $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                    document.getElementById('<%=chkSaturday.ClientID%>').focus();
                    return false;
                }

            if ($('#<%=chkSunday.ClientID%>')[0].checked == true) {
                        if (document.getElementById('<%=txtScheduleSunFrom.ClientID%>').value == '') {
                    document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please enter Sunday from time';
                        $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                        document.getElementById('<%=txtScheduleSunFrom.ClientID%>').focus();
                            return false;
                        }
                        if (document.getElementById('<%=txtScheduleSunTo.ClientID%>').value == '') {
                    document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please enter Sunday to time';
                                $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                                document.getElementById('<%=txtScheduleSunTo.ClientID%>').focus();
                                return false;
                            }
                            var scheduleSunFromAt = document.getElementById('<%=txtScheduleSunFrom.ClientID%>').value;
                var scheduleSunToAt = document.getElementById('<%=txtScheduleSunTo.ClientID%>').value;
                if (Date.parse(document.getElementById('<%=txtScheduleFrom.ClientID%>').value + ' ' + scheduleSunToAt) < Date.parse(document.getElementById('<%=txtScheduleFrom.ClientID%>').value + ' ' + scheduleSunFromAt)) {
                    document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Invalid Time Range!\n Start Time cannot be after End Time!';
                    $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                    document.getElementById('<%=txtScheduleSunTo.ClientID%>').focus();
                    return false;
                }
            }
            else if (document.getElementById('<%=txtScheduleSunFrom.ClientID%>').value != '' || document.getElementById('<%=txtScheduleSunTo.ClientID%>').value != '') {

                document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please select Sunday';
                    $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                    document.getElementById('<%=chkSunday.ClientID%>').focus();
                    return false;
                }
        }

        if ($('#<%=ddlTierType.ClientID%> option:selected').val() != '-1') {
                if ($('#<%=chkEnrolmentDate.ClientID%>')[0].checked == true) {
                if ($('#<%=ddlEnrolmentType.ClientID%>').val() != 1) {

                        if ($('#<%=txtUnknownMessage.ClientID%>').val() == "") {
                        if ($('#<%=ddlEnrolmentType.ClientID%>').val() != 2)
                                        document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please enter minimum of n days since enrollment';
                        else
                            document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please enter days past';

                        $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                        document.getElementById('<%=txtUnknownMessage.ClientID%>').focus();
                            return false;
                        }
                    }
                }
            }

            var validation = ConfirmMessage(1);
            if (validation == false) {
                return false;
            }
            else {
                return true;
            }

        }

        function SetTabControls() {
            var readTabValue = $('input:hidden[id*="hdnSelectedTab"]').val();
            var isTab = $("#<%=hdnButtonPermission.ClientID %>").val();
            var rowscount = $("#<%=grdEvents.ClientID %> tr").length;
            // Code is comment because permission is not implemented, when imlemented we can remove the comment code.
            var isPermissionDelete = $("#<%=hdnIsPermissionDelete.ClientID %>").val();
            switch (readTabValue) {
                case 'contentTab':
                    $('.nav-tabs li').removeClass('active');
                    $('.nav-tabs li.nav-tabs-content').addClass('active');
                    $('.tab-content .tab-pane').removeClass('active in');
                    $('#manageEventDetailTab').addClass('active in');

                    if (isTab == "InActive" || isTab == "All") {
                        $("#<%=lnkBtnDelete.ClientID %>").addClass('aspNetDisabled');
                        $("#<%=lnkBtnDelete.ClientID %>").attr("disabled", $("#<%=lnkBtnDelete.ClientID %>"));
                    }
                    else {
                        if (rowscount > 0 && isPermissionDelete == 1) {
                            $("#<%=lnkBtnDelete.ClientID %>").removeClass('aspNetDisabled');
                            $("#<%=lnkBtnDelete.ClientID %>").removeAttr("disabled");
                        }
                    }
                    break;
                case 'scheduleTab':
                    $('.nav-tabs li').removeClass('active');
                    $('.nav-tabs li.nav-tabs-schedule').addClass('active');
                    $('.tab-content .tab-pane').removeClass('active in');
                    $('#manageScheduleTab').addClass('active in');
                    $("#<%=lnkBtnDelete.ClientID %>").addClass('aspNetDisabled');
                    $("#<%=lnkBtnDelete.ClientID %>").attr("disabled", $("#<%=lnkBtnDelete.ClientID %>"));
                    break;
                case 'populationTab':
                    $('.nav-tabs li').removeClass('active');
                    $('.nav-tabs li.nav-tabs-population').addClass('active');
                    $('.tab-content .tab-pane').removeClass('active in');
                    $('div#populationListTab').removeClass('active');
                    $('div#populationTypeTab').addClass('active in');
                    $('div#managePopulationTab').addClass('active in');
                    $('#lipopulationTypeTab').removeClass('active');
                    $('#lipopulationTypeTab').addClass('active in');
                    $("#<%=lnkBtnDelete.ClientID %>").addClass('aspNetDisabled');
                            $("#<%=lnkBtnDelete.ClientID %>").attr("disabled", $("#<%=lnkBtnDelete.ClientID %>"));
                            break;
                        case 'populationTypeTab':
                            $('.nav-tabs li').removeClass('active');
                            $('.nav-tabs li.nav-tabs-population').addClass('active in');
                            $('.tab-content .tab-pane').removeClass('active in');
                            $('div#populationListTab').removeClass('active');
                            $('div#populationTypeTab').addClass('active in');
                            $('div#managePopulationTab').addClass('active in');
                            $('li#lipopulationTypeTab').addClass('active in');
                            $("#<%=lnkBtnDelete.ClientID %>").addClass('aspNetDisabled');
                            $("#<%=lnkBtnDelete.ClientID %>").attr("disabled", $("#<%=lnkBtnDelete.ClientID %>"));
                            break;
                        case 'populationListTab':
                            $('.nav-tabs li').removeClass('active');
                            $('.nav-tabs li.nav-tabs-population').addClass('active');
                            $('.tab-content .tab-pane').removeClass('active in');
                            $('div#populationTypeTab').removeClass('active');
                            $('div#populationListTab').addClass('active in');
                            $('div#managePopulationTab').addClass('active in');
                            $('li#lipopulationListTab').addClass('active');
                            $("#<%=lnkBtnDelete.ClientID %>").addClass('aspNetDisabled');
                        $("#<%=lnkBtnDelete.ClientID %>").attr("disabled", $("#<%=lnkBtnDelete.ClientID %>"));
                        break;
                    case 'MessageTab':
                        $('.nav-tabs li').removeClass('active');
                        $('.nav-tabs li.nav-tabs-message').addClass('active');
                        $('.tab-content .tab-pane').removeClass('active in');
                        $('div#manageMessageTab').addClass('active in');
                        $("#<%=lnkBtnDelete.ClientID %>").addClass('aspNetDisabled');
                        $("#<%=lnkBtnDelete.ClientID %>").attr("disabled", $("#<%=lnkBtnDelete.ClientID %>"));
                        break;
                }
                RegisterleftDivheight();
            }
            function addDollarSign(obj) {
                var inputValue = document.getElementById(obj.id);
                if (inputValue.value.indexOf("$") != 0) {
                    inputValue.value = "$" + inputValue.value;
                }
            }

            function addPercentageSign(obj) {
                var inputValue = document.getElementById(obj.id);
                if (inputValue.value.lastIndexOf("%") == -1) {
                    inputValue.value = inputValue.value + "%";
                }
            }

            function SetSelectedTab(selectedTab) {
                $('input:hidden[id*="hdnSelectedTab"]').val(selectedTab);
                SetTabControls();
            }

            function RegisterDetectedFormChanges() {
                $.each($("input:text"), function (index, element) {
                    element.defaultValue = $(element).val();
                });
            }

            function EventNameExists() {

                document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Event name already exists';
                $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                document.getElementById('<%=txtScheduleSunFrom.ClientID%>').focus();
                    return false;
                }

                function SaveMsg(msg) {
                    document.getElementById('<%=alertMessage.ClientID%>').innerHTML = msg;
                    $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                    document.getElementById('<%=txtScheduleSunFrom.ClientID%>').focus();
                    return false;
                }

                function RegisterFieldSets() {

                    if ($('.fieldset legend input[type="checkbox"]')[0].checked == true) {
                        $('.fieldSwitch input[type="checkbox"]').prop('disabled', false);
                    }
                    else {
                        $('.fieldSwitch input[type="checkbox"]').prop('disabled', true);
                    }
                    //Onpageload
                    if ($('.trmonday input[type="checkbox"]').is(':checked')) {
                        $('.trmonday').find('input[type="text"]').prop('disabled', false);
                        $('.trmonday').find('input[type="checkbox"]').prop('disabled', false);
                    }
                    else
                        $('.trmonday').find('input[type="text"], select').prop('disabled', true);

                    if ($('.trtuesday input[type="checkbox"]').is(':checked')) {
                        $('.trtuesday').find('input[type="text"]').prop('disabled', false);
                        $('.trtuesday').find('input[type="checkbox"]').prop('disabled', false);
                    }
                    else
                        $('.trtuesday').find('input[type="text"]').prop('disabled', true);
                    if ($('.trwednesday input[type="checkbox"]').is(':checked')) {
                        $('.trwednesday').find('input[type="text"]').prop('disabled', false);
                        $('.trwednesday').find('input[type="checkbox"]').prop('disabled', false);
                    }
                    else
                        $('.trwednesday').find('input[type="text"]').prop('disabled', true);
                    if ($('.trthursday input[type="checkbox"]').is(':checked')) {
                        $('.trthursday').find('input[type="text"]').prop('disabled', false);
                        $('.trthursday').find('input[type="checkbox"]').prop('disabled', false);
                    }
                    else
                        $('.trthursday').find('input[type="text"]').prop('disabled', true);
                    if ($('.trfriday input[type="checkbox"]').is(':checked')) {
                        $('.trfriday').find('input[type="text"]').prop('disabled', false);
                        $('.trfriday').find('input[type="checkbox"]').prop('disabled', false);
                    }
                    else
                        $('.trfriday').find('input[type="text"]').prop('disabled', true);

                    if ($('.trsaturday input[type="checkbox"]').is(':checked')) {
                        $('.trsaturday').find('input[type="text"]').prop('disabled', false);
                        $('.trsaturday').find('input[type="checkbox"]').prop('disabled', false);
                    }
                    else
                        $('.trsaturday').find('input[type="text"]').prop('disabled', true);

                    if ($('.trsunday input[type="checkbox"]').is(':checked')) {
                        $('.trsunday').find('input[type="text"]').prop('disabled', false);
                        $('.trsunday').find('input[type="checkbox"]').prop('disabled', false);
                    }
                    else
                        $('.trsunday').find('input[type="text"]').prop('disabled', true);

                    /// End Pageload

                    //Onchange
                    $(' .fieldset legend input[type="checkbox"]').change(function () {

                        if ($('.fieldset legend input[type="checkbox"]')[0].checked == true) {
                            $('.fieldSwitch input[type="checkbox"]').prop('disabled', false);
                        }
                        else {
                            $(".scheduleTable input:checkbox").attr("checked", false);
                            $(".scheduleTable input:checkbox").attr("disabled", true);
                            $(".scheduleTable input[type='text']").val("");
                            $('.fieldSwitch input[type="text"]').prop('disabled', true);
                        }

                    });

                    $(' .trmonday input[type="checkbox"]').change(function () {
                        if ($('.trmonday input[type="checkbox"]').is(':checked')) {
                            $('.trmonday').find('input[type="text"]').prop('disabled', false);
                        }
                        else {
                            $('.trmonday').find('input[type="text"]').prop('disabled', true);
                            $('.trmonday input[type="text"]').val("");
                        }
                    });
                    $(' .trtuesday input[type="checkbox"]').change(function () {
                        if ($('.trtuesday input[type="checkbox"]').is(':checked')) {
                            $('.trtuesday').find('input[type="text"]').prop('disabled', false);
                        }
                        else {
                            $('.trtuesday').find('input[type="text"]').prop('disabled', true);
                            $('.trtuesday input[type="text"]').val("");
                        }
                    });
                    $(' .trwednesday input[type="checkbox"]').change(function () {
                        if ($('.trwednesday input[type="checkbox"]').is(':checked')) {
                            $('.trwednesday').find('input[type="text"]').prop('disabled', false);
                        }
                        else {
                            $('.trwednesday').find('input[type="text"]').prop('disabled', true);
                            $('.trwednesday input[type="text"]').val("");
                        }
                    });
                    $(' .trthursday input[type="checkbox"]').change(function () {
                        if ($('.trthursday input[type="checkbox"]').is(':checked')) {
                            $('.trthursday').find('input[type="text"]').prop('disabled', false);
                        }
                        else {
                            $('.trthursday').find('input[type="text"]').prop('disabled', true);
                            $('.trthursday input[type="text"]').val("");
                        }
                    });
                    $(' .trfriday input[type="checkbox"]').change(function () {
                        if ($('.trfriday input[type="checkbox"]').is(':checked')) {
                            $('.trfriday').find('input[type="text"]').prop('disabled', false);
                        }
                        else {
                            $('.trfriday').find('input[type="text"]').prop('disabled', true);
                            $('.trfriday input[type="text"]').val("");
                        }
                    });
                    $(' .trsaturday input[type="checkbox"]').change(function () {
                        if ($('.trsaturday input[type="checkbox"]').is(':checked')) {
                            $('.trsaturday').find('input[type="text"]').prop('disabled', false);
                        }
                        else {
                            $('.trsaturday').find('input[type="text"]').prop('disabled', true);
                            $('.trsaturday input[type="text"]').val("");
                        }
                    });
                    $(' .trsunday input[type="checkbox"]').change(function () {
                        if ($('.trsunday input[type="checkbox"]').is(':checked')) {
                            $('.trsunday').find('input[type="text"]').prop('disabled', false);
                        }
                        else {
                            $('.trsunday').find('input[type="text"]').prop('disabled', true);
                            $('.trsunday input[type="text"]').val("");
                        }
                    });
                }


                function ConfirmMessageSpeReqNew(flag) { }



                function ConfirmMessage(flag) {
                    var savemsg = 'Are you sure you want to save this AvT Bonusing Event?';
                    var cancelmsg = 'Are you sure you want to discard current changes?';
                    var deletemsg = 'Are you sure you want to delete this AvT Bonusing Event?';
                    var copymsg = 'Are you sure you want to copy this AvT Bonusing Event?';
                    var isChange = FormChanges('from1');
                    if (flag == 7) {
                        $('#<%=btnConfirmedSave.ClientID%>').hide();
                        $('#<%=btnConfirmedCancel.ClientID%>').hide();
                        $('#<%=btnConfirmedDelete.ClientID%>').hide();
                        $('#<%=btnConfirmedActive.ClientID%>').hide();
                        $('#<%=btnConfirmedInActive.ClientID%>').hide();
                        $('#<%=btnConfirmedAll.ClientID%>').hide();
                        $('#<%=btnConfirmedCopy.ClientID%>').show();
                        $('#ConfirmBoxMessage').html(copymsg);
                        $('#ConfirmBox').modal({ backdrop: 'static', keyboard: false });
                        return false;
                    }
                    if (isChange != "") {
                        var message = '';
                        if (flag == 1) {
                            $('#<%=btnConfirmedSave.ClientID%>').show();
                            $('#<%=btnConfirmedCancel.ClientID%>').hide();
                            $('#<%=btnConfirmedDelete.ClientID%>').hide();
                            $('#<%=btnConfirmedActive.ClientID%>').hide();
                            $('#<%=btnConfirmedInActive.ClientID%>').hide();
                            $('#<%=btnConfirmedAll.ClientID%>').hide();
                            $('#<%=btnConfirmedCopy.ClientID%>').hide();
                            $('#ConfirmBoxMessage').html(savemsg);
                        }
                        else if (flag == 2) {
                            $('#<%=btnConfirmedSave.ClientID%>').hide();
                            $('#<%=btnConfirmedCancel.ClientID%>').show();
                            $('#<%=btnConfirmedDelete.ClientID%>').hide();
                            $('#<%=btnConfirmedActive.ClientID%>').hide();
                            $('#<%=btnConfirmedInActive.ClientID%>').hide();
                            $('#<%=btnConfirmedAll.ClientID%>').hide();
                            $('#<%=btnConfirmedCopy.ClientID%>').hide();
                            $('#ConfirmBoxMessage').html(cancelmsg);
                        }
                        else if (flag == 3) {
                            $('#<%=btnConfirmedSave.ClientID%>').hide();
                        $('#<%=btnConfirmedCancel.ClientID%>').hide();
                        $('#<%=btnConfirmedDelete.ClientID%>').show();
                        $('#<%=btnConfirmedActive.ClientID%>').hide();
                        $('#<%=btnConfirmedInActive.ClientID%>').hide();
                        $('#<%=btnConfirmedAll.ClientID%>').hide();
                        $('#<%=btnConfirmedCopy.ClientID%>').hide();
                        $('#ConfirmBoxMessage').html(deletemsg);
                    }
                    else if (flag == 4) {
                        $('#<%=btnConfirmedSave.ClientID%>').hide();
                            $('#<%=btnConfirmedCancel.ClientID%>').hide();
                            $('#<%=btnConfirmedDelete.ClientID%>').hide();
                            $('#<%=btnConfirmedActive.ClientID%>').show();
                            $('#<%=btnConfirmedInActive.ClientID%>').hide();
                            $('#<%=btnConfirmedAll.ClientID%>').hide();
                            $('#<%=btnConfirmedCopy.ClientID%>').hide();
                            $('#ConfirmBoxMessage').html(cancelmsg);
                        }
                        else if (flag == 5) {
                            $('#<%=btnConfirmedSave.ClientID%>').hide();
                    $('#<%=btnConfirmedCancel.ClientID%>').hide();
                    $('#<%=btnConfirmedDelete.ClientID%>').hide();
                    $('#<%=btnConfirmedActive.ClientID%>').hide();
                    $('#<%=btnConfirmedInActive.ClientID%>').show();
                    $('#<%=btnConfirmedAll.ClientID%>').hide();
                    $('#<%=btnConfirmedCopy.ClientID%>').hide();
                    $('#ConfirmBoxMessage').html(cancelmsg);
                }
                else if (flag == 6) {
                    $('#<%=btnConfirmedSave.ClientID%>').hide();
                            $('#<%=btnConfirmedCancel.ClientID%>').hide();
                            $('#<%=btnConfirmedDelete.ClientID%>').hide();
                            $('#<%=btnConfirmedActive.ClientID%>').hide();
                            $('#<%=btnConfirmedInActive.ClientID%>').hide();
                            $('#<%=btnConfirmedAll.ClientID%>').show();
                            $('#<%=btnConfirmedCopy.ClientID%>').hide();
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

function myTrim(x) {
    return x.replace(/\s/g, '').replace('-', '');
}
RegisterDisabledTypeListBox();
function RegisterDisabledTypeListBox() {
    $('#dvlstTier').find('select, button, input:text').prop('disabled', true);
    if ($("#<%=ddlTierType.ClientID%> option:selected").val() == "4" || $("#<%=ddlTierType.ClientID%> option:selected").val() == "2")
    { $('#dvlstTier').find('select, button, input:text').prop('disabled', false); }
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
                            <p id="alertMessage" runat="server"></p>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn" id="btnOK" data-dismiss="modal">OK</button>
                        </div>
                    </div>
                </div>
            </div>

            <div id="ConfirmBox" class="modal fade" role="dialog" aria-labelledby="confirmDeleteLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>
                            <h4 class="modal-title">Confirm</h4>
                        </div>
                        <div class="modal-body">
                            <p id="ConfirmBoxMessage"></p>
                        </div>
                        <div class="modal-footer">
                            <asp:Button ID="btnConfirmedSave" CssClass="btn btn-danger" runat="server" Text="OK" UseSubmitBehavior="false" OnClick="lnkBtnSave_Click" data-dismiss="modal" Style="display: none;"></asp:Button>
                            <asp:Button ID="btnConfirmedCancel" CssClass="btn btn-danger" runat="server" Text="OK" UseSubmitBehavior="false" OnClick="lnkBtnCancel_OnClick" data-dismiss="modal" Style="display: none;"></asp:Button>
                            <asp:Button ID="btnConfirmedDelete" CssClass="btn btn-danger" runat="server" Text="OK" UseSubmitBehavior="false" OnClick="lnkBtnDelete_OnClick" data-dismiss="modal" Style="display: none;"></asp:Button>
                            <asp:Button ID="btnConfirmedActive" CssClass="btn btn-danger" runat="server" Text="OK" UseSubmitBehavior="false" OnClick="lnkbtnActiveEvent_Click" data-dismiss="modal" Style="display: none;"></asp:Button>
                            <asp:Button ID="btnConfirmedInActive" CssClass="btn btn-danger" runat="server" Text="OK" UseSubmitBehavior="false" OnClick="lnkbtnInactiveEvent_Click" data-dismiss="modal" Style="display: none;"></asp:Button>
                            <asp:Button ID="btnConfirmedAll" CssClass="btn btn-danger" runat="server" Text="OK" UseSubmitBehavior="false" OnClick="lnkbtnAllEvent_Click" data-dismiss="modal" Style="display: none;"></asp:Button>

                            <asp:Button ID="btnConfirmedCopy" CssClass="btn btn-danger" runat="server" Text="OK" UseSubmitBehavior="false" OnClick="lnkBtnCopy_OnClick" data-dismiss="modal" Style="display: none;"></asp:Button>
                            <button type="button" class="btn" id="confirm" data-dismiss="modal">Cancel</button>
                        </div>
                    </div>
                </div>
            </div>
            <asp:UpdatePanel ID="updpnlSepRequest" runat="server" UpdateMode="Conditional">
                <ContentTemplate>
                    <div id="ConfirmMessageNew" class="modal fade" role="dialog" aria-labelledby="confirmDeleteLabel" aria-hidden="true">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>
                                    <h4 class="modal-title">Confirm</h4>
                                </div>
                                <div class="modal-body">
                                    <p id="ConfirmBoxMessageGrid"></p>
                                </div>
                                <div class="modal-footer">
                                    <%-- <asp:Button ID="lnkBtnSaveWaitTime" CssClass="btn btn-danger" runat="server" Text="OK" UseSubmitBehavior="false" OnClick="lnkBtnSaveWaitTime_OnClick" data-dismiss="modal" Style="display: none;"></asp:Button>
                                    <asp:Button ID="lnkBtnDeleteWaitTime" CssClass="btn btn-danger" runat="server" Text="OK" UseSubmitBehavior="false" OnClick="lnkBtnDeleteWaitTime_OnClick" data-dismiss="modal" Style="display: none;"></asp:Button>
                                    <asp:Button ID="lnkBtnSavePartySize" CssClass="btn btn-danger" runat="server" Text="OK" UseSubmitBehavior="false" OnClick="lnkBtnSavePartySize_OnClick" data-dismiss="modal" Style="display: none;"></asp:Button>
                                    <asp:Button ID="lnkBtnDeletePartySize" CssClass="btn btn-danger" runat="server" Text="OK" UseSubmitBehavior="false" OnClick="lnkBtnDeletePartySize_OnClick" data-dismiss="modal" Style="display: none;"></asp:Button>
                                    <asp:Button ID="lnkBtnSaveSepReq" CssClass="btn btn-danger" runat="server" Text="OK" UseSubmitBehavior="false" OnClick="lnkBtnSaveSepReq_OnClick" data-dismiss="modal" Style="display: none;"></asp:Button>
                                    <asp:Button ID="lnkBtnDeleteSepReq" CssClass="btn btn-danger" runat="server" Text="OK" UseSubmitBehavior="false" OnClick="lnkBtnDeleteSepReq_OnClick" data-dismiss="modal" Style="display: none;"></asp:Button>
                                    <button type="button" class="btn" id="confirmSepReq" data-dismiss="modal">Cancel</button>--%>
                                </div>
                            </div>
                        </div>
                    </div>
                </ContentTemplate>
            </asp:UpdatePanel>

            <div id="HintBox" class="modal fade bs-example-modal-sm" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>
                            <h4 class="modal-title">Replacement Variables</h4>
                        </div>
                        <div class="modal-body">
                            Use the following dynamic tags 
                            <ul>

                                <li><b>&#60VenueName&#62</b> is the venue associated with the RapidReserve event.</li>

                                <li><b>&#60ScheduleDayEndTime&#62</b> is the end date associated current day of week associated with the schedule for the RapidReserve event. 
    For example, if the event schedule Day of Week for the current day of week is 8:00 PM, that’s the value for ScheduleDayEndTime.
                                </li>
                                <li><b>&#60CasinoName&#62</b> is the name of the operation.</li>
                                <li><b>&#60CurrentDate&#62</b> is the current date formatted as “mm/dd/yyyy”</li>
                                <li><b>&#60CurrentDateTime&#62</b> is the current date and time formatted as, “mm/dd/yyyy at hh:mm”</li>
                                <li><b>&#60Tier&#62</b> is the player’s Tier</li>
                                <li><b>&#60FirstName&#62</b> is the Player’s First Name</li>
                                <li><b>&#60LastName&#62</b> is the Player’s Last Name</li>
                            </ul>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn" id="btnHintOK" data-dismiss="modal">Close</button>
                        </div>
                    </div>
                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
