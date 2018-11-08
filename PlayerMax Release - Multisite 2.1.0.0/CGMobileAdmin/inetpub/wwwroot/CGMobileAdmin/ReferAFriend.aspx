<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ReferAFriend.aspx.cs" Inherits="HAMobileWebAdmin.ReferAFriend" %>
<%@ Register Src="~/UC_CsvUpload_BM_AP_RAF.ascx" TagPrefix="uc2" TagName="UC_CsvUpload_BM_AP_RAF" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <script src="Scripts/CommonJS/datatables.min.js"></script>
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
    <asp:UpdatePanel runat="server" ID="updPnlRaf">
        <ContentTemplate>
            <div class="row" id="slotInventory">
                <div class="col-sm-3">
                    <h5>Refer a Friend</h5>
                    <div class="filterWrapper relative" id="dvLeftcontentdetail">
                        <div class="clearfix">
                            <div class="pull-left">
                                <label>Event</label>
                            </div>
                            <div class="pull-right">
                                <span class="addBtn">Add
                            <asp:Button ID="btnAdd" runat="server" OnClick="btnAdd_OnClick" CssClass="btn btn-add pull-right"></asp:Button>
                                </span>
                            </div>
                        </div>
                        <div class="input-group clearfix col-sm-12">
                            <asp:TextBox runat="server" ID="txtSearchText" CssClass="form-control height26" />
                            <span class="input-group-btn">
                                <asp:Button runat="server" ID="btnSearch" OnClick="btnSearch_OnClick" CssClass="btn btn-black glyphicons filter btn-icon white input-group-btnbtnmargin" /><i></i>
                            </span>
                        </div>
                        <div id="divgv">
                            <asp:GridView runat="server" CssClass="gridview" ID="grdReferrals" ShowHeader="False" AutoGenerateColumns="False" DataKeyNames="ReferAFriendID,IncludeAllTier,IncludeAllPlayer,Active" AllowPaging="true" PageSize="10" OnPageIndexChanging="grdReferrals_PageIndexChanging">
                                <Columns>
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <asp:LinkButton runat="server" ID="lnkBtnRaf" CommandName="Select" Text='<%#Eval("EventName") %>' OnClick="lnkBtnRaf_OnClick"></asp:LinkButton>
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
                            <div class="btn-groupSpecial">
                                <asp:Button Text="Active" ID="lnkBtnActive" CssClass="results-control col-xs-4" OnClientClick="return ConfirmMessage(4);" OnClick="lnkBtnActive_OnClick" runat="server" />
                                <asp:Button Text="InActive" ID="lnkBtnInactive" CssClass="results-control col-xs-4" OnClientClick="return ConfirmMessage(5);" OnClick="lnkBtnInactive_OnClick" runat="server" />
                                <asp:Button Text="All" ID="lnkBtnAll" CssClass="results-control col-xs-4" OnClientClick="return ConfirmMessage(6);" OnClick="lnkBtnAll_OnClick" runat="server" />
                            </div>
                        </div>
                    </div>
                </div>
                    <asp:HiddenField runat="server" ID="hdnIsPermissionDelete" Value="1"/>  
                <asp:HiddenField id="hdnButtonPermission" runat="server" Value="Active" />
                <div class="col-sm-9">
                    <h5>Refer a Friend Detail</h5>
                    <div class="row clearfix relative btnGroup btnGroup3" id="dvRightContent">
                        <div class="col-md-12 clearfix">
                            <div class="tabControls">
                                <ul class="nav nav-tabs">                
                                    <li class="active col-xsm-25 nav-tabs-property"><span class="linkDisabledsp">&nbsp;</span><a onclick="SetSelectedTab('property');" data-toggle="tab" href="#propertyTab">Property</a></li>
                                    <li class="col-xsm-25 nav-tabs-content"><span class="linkDisabledsp">&nbsp;</span><a data-toggle="tab" href="#manageContentTab" onclick="SetSelectedTab('contentTab')">Event Details</a></li>
                                    <li class="col-xsm-25  nav-tabs-schedule"><span class="linkDisabledsp">&nbsp;</span><a data-toggle="tab" href="#manageScheduleTab" id="manageScheduleTabLink" onclick="SetSelectedTab('scheduleTab')">Schedule</a></li>
                                    <li class="col-xsm-25  nav-tabs-population"><span class="linkDisabledsp">&nbsp;</span><a data-toggle="tab" href="#managePopulationTab" id="managePopulationTabLink" onclick="SetSelectedTab('populationTab')">Population</a></li>
                                </ul>
                                <div class="tab-content">
                                    <!--Property Tab Starts-->
                                        <div class="tab-pane fade in" id="propertyTab">
                                            <div class="tab-container clearfix">
                                                <div class="col-md-12">
                                                    <div class="row" id="dvTabLbl">
                                                        <div class="col-md-4 top-margin-one">
                                                            <label>Define Assigned Properties</label>
                                                        </div>
                                                    </div>
                                                    <div class="row" id="dvAllProperties">
                                                        <div class="col-md-4 top-margin-one">
                                                            <asp:CheckBox ID="chkAllProperties" Text="All Properties" AutoPostBack="true" ClientIDMode="Static"  Visible="True" runat="server" OnCheckedChanged="chkAllProperties_CheckedChanged" />
                                                        </div>
                                                    </div>
                                                    <div class="row" id="dvSelectPropertiesLbl">
                                                        <div class="col-md-8 top-margin-one">
                                                            <label for="lblStartScreen_plainTextUrl">Define Excluded/Included Properties</label>
                                                            <asp:ListBox ID="lstProperties" SelectionMode="Multiple" runat="server" CssClass="propertiesBox"></asp:ListBox>
                                                            <asp:HiddenField runat="server" ID="hdnSelectedProperties" Value="0" />
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <!--Property Tab Ends-->

                                    <!--RAF Event Tab Starts-->
                                    <div class="tab-pane active fade in" id="manageContentTab">
                                        <div class="tab-container clearfix">
                                            <div class="col-md-2">
                                                <label for="referFriendEventName">Event Name</label>
                                            </div>
                                            <div class="col-md-5">
                                                <asp:TextBox runat="server" ID="txtEventName" MaxLength="250" CssClass="form-control"></asp:TextBox>
                                            </div>                                           

                                            <!--Award for Referral on Account Link Starts-->
                                            <div class="col-md-12 clearfix">
                                                <div class="singleBlock col-md-12">
                                                    <div class="col-md-4">
                                                        <label for="<%=ddlAwardsReferralAccountLink.ClientID %>">Award for Referrer on Account Link</label>
                                                        <asp:DropDownList runat="server" ID="ddlAwardsReferralAccountLink" CssClass="form-control">
                                                        </asp:DropDownList>
                                                        <asp:HiddenField runat="server" ID="hdnAwardsReferralAccountLinkId" Value="2" />
                                                    </div>
                                                    <div class="col-md-3 col-md-offset-1">
                                                        <br />
                                                        <asp:CheckBox runat="server" ID="chkAwardsReferralAccountLink" />
                                                        <label for="<%=chkAwardsReferralAccountLink.ClientID %>">Limit Prizes</label>
                                                    </div>
                                                    <div id="divAwardsReferralAccountLink" class="col-md-4">
                                                        <label for="<%=txtReferralAccountLinkMaxValue.ClientID %>">Max Awards by Value</label>
                                                        <div class="input-group">
                                                            <span class="input-group-btn">
                                                                <asp:RadioButton runat="server" ID="rdbReferralAccountLinkMaxValue" GroupName="referralAccountLinkOptions" />
                                                                <label for="<%=rdbReferralAccountLinkMaxValue.ClientID %>">&nbsp;</label>
                                                            </span>
                                                            <asp:TextBox runat="server"  CssClass="form-control numericwithdecimal" ID="txtReferralAccountLinkMaxValue" MaxLength="5"/>
                                                        </div>
                                                        <label for="<%=txtReferralAccountLinkMaxCount.ClientID %>">Max Awards by Count</label>
                                                        <div class="input-group">
                                                            <span class="input-group-btn">
                                                                <asp:RadioButton runat="server" ID="rdbReferralAccountLinkMaxCount" GroupName="referralAccountLinkOptions" />
                                                                <label for="<%=rdbReferralAccountLinkMaxCount.ClientID %>">&nbsp;</label>
                                                            </span>
                                                            <asp:TextBox runat="server" CssClass="form-control numericwithdecimal" ID="txtReferralAccountLinkMaxCount" MaxLength="5" />
                                                        </div>
                                                        <asp:HiddenField runat="server" ID="hdnAwardsReferralAccountLinkDetailId" Value="0" />
                                                    </div>
                                                </div>
                                            </div>
                                            <!--Award for Referral on Account Link Ends-->

                                            <!--Award for Referee on Account Link Starts-->
                                            <div class="col-md-12 clearfix">
                                                <div class="singleBlock col-md-12">
                                                    <div class="col-md-4">
                                                        <label for="<%=ddlAwardsRefereeAccountLink.ClientID %>">Award for Referree on Account Link</label>
                                                        <asp:DropDownList runat="server" ID="ddlAwardsRefereeAccountLink" CssClass="form-control">
                                                        </asp:DropDownList>
                                                        <asp:HiddenField runat="server" ID="hdnAwardsRefereeAccountLinkId" Value="3" />
                                                    </div>
                                                    <div class="col-md-3 col-md-offset-1">
                                                        <br />
                                                        <asp:CheckBox runat="server" ID="chkAwardsRefereeAccountLink" />
                                                        <label for="<%=chkAwardsRefereeAccountLink.ClientID %>">Limit Prizes</label>
                                                    </div>
                                                    <div id="divAwardsRefereeAccountLink" class="col-md-4">
                                                        <label for="<%=txtRefereeAccountLinkMaxValue.ClientID %>">Max Awards by Value</label>
                                                        <div class="input-group">
                                                            <span class="input-group-btn">
                                                                <asp:RadioButton runat="server" ID="rdbRefereeAccountLinkMaxValue" GroupName="RefereeAccountLinkOptions" />
                                                                <label for="<%=rdbRefereeAccountLinkMaxValue.ClientID %>">&nbsp;</label>
                                                            </span>
                                                            <asp:TextBox runat="server" CssClass="form-control numericwithdecimal" ID="txtRefereeAccountLinkMaxValue" MaxLength="5"/>
                                                        </div>
                                                        <label for="<%=txtRefereeAccountLinkMaxCount.ClientID %>">Max Awards by Count</label>
                                                        <div class="input-group">
                                                            <span class="input-group-btn">
                                                                <asp:RadioButton runat="server" ID="rdbRefereeAccountLinkMaxCount" GroupName="RefereeAccountLinkOptions" />
                                                                <label for="<%=rdbRefereeAccountLinkMaxCount.ClientID %>">&nbsp;</label>
                                                            </span>
                                                            <asp:TextBox runat="server"  CssClass="form-control numericwithdecimal" ID="txtRefereeAccountLinkMaxCount"  MaxLength="5"/>
                                                        </div>
                                                        <asp:HiddenField runat="server" ID="hdnAwardsRefereeAccountLinkDetailId" Value="0" />
                                                    </div>
                                                </div>
                                            </div>
                                            <!--Award for Referral on Account Link Ends-->
                                        </div>
                                    </div>
                                    <!--RAF Event Tab Ends-->

                                    <!--RAF Schedule Tab Starts-->
                                    <%--<uc2:UC_ContentSchedule runat="server" ID="rafSchedules" />--%>
                                    <div class="tab-pane fade" id="manageScheduleTab">
                                        <asp:Panel runat="server" ID="pnlSchedule">
                                            <div class="tab-container clearfix">
                                                <div class="col-md-4">
                                                    <div class="filterWrapper filterWrapper2 relative">
                                                        <div class="row clearfix whiteBg">
                                                            <div class="col-xs-7">
                                                                <label>Schedule</label>
                                                            </div>
                                                            <div class="col-xs-5">
                                                                <span class="addBtn">Add
                                    <asp:Button ID="lnkbtnAddSchedule" runat="server" OnClick="btnAddSchedule_Click"   CssClass="btn btn-add pull-right "></asp:Button>
                                                                </span>
                                                            </div>
                                                        </div>
                                                        <div class="input-group">
                                                            <asp:TextBox runat="server" ID="txtSearchBox" CssClass="form-control height26" />
                                                            <span class="input-group-btn">
                                                                <asp:Button ID="btnSearchSchedule" OnClick="btnSearchSchedule_OnClick" CssClass="btn btn-black glyphicons filter btn-icon white refershedulebtn" runat="server" /><i></i>
                                                            </span>
                                                        </div>
                                                        <div class="filterWrapper filterWrapper2 relative schedulegridheight">
                                                        <div class="filterResults" style="top:0;">
                                                            <div id="div57">
                                                                <asp:GridView CssClass="gridview" ID="gvSchedules" DataKeyNames="EventScheduleID" runat="server" ShowHeader="False" AutoGenerateColumns="false" 
                                                                    AllowPaging="true" OnPageIndexChanging="grdReferralSchedule_PageIndexChanging">
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
                                                                <div id="Div58"></div>
                                                            </div>
                                                        </div></div>
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
                                                            <div class="col-xs-6">
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
                                                            <div class="col-xs-6">
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
                                                                <%--<input type="checkbox" class="control" id="adscheduleByDay"><label class="controlLabel" for="adscheduleByDay">Schedule by Day of Week</label>--%>
                                                            </legend>
                                                            <table class="table scheduleTable fieldSwitch">
                                                                <tbody>
                                                                    <tr  class="trmonday">
                                                                        <td>
                                                                            <asp:CheckBox Text="Monday" runat="server" ID="chkMonday" />
                                                                            <%--<input type="checkbox" id="adscheduleMonday"><label for="adscheduleMonday">Monday</label>--%></td>
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
                                                                            <%--<input type="checkbox" id="adscheduleTues"><label for="adscheduleTues">Tuesday</label>--%></td>
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
                                                                            <%--<input type="checkbox" id="adscheduleWed"><label for="adscheduleWed">Wednesday</label>--%></td>
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
                                                                            <%--<input type="checkbox" id="adscheduleThus"><label for="adscheduleThus">Thursday</label>--%></td>
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
                                                                    <tr  class="trfriday">
                                                                        <td>
                                                                            <asp:CheckBox Text="Friday" ID="chkFriday" runat="server" />
                                                                            <%--<input type="checkbox" id="adscheduleFri"><label for="adscheduleFri">Friday</label>--%></td>
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
                                                                            <%--<input type="checkbox" id="adscheduleSat"><label for="adscheduleSat">Saturday</label>--%></td>
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
                                                                            <%--<input type="checkbox" id="adscheduleSun"><label for="adscheduleSun">Sunday</label>--%></td>
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
                                            <asp:HiddenField runat="server" ID="hdnScheduleId" Value="0" />
                                            <asp:HiddenField runat="server" ID="hdnIsActive" Value="true" />
                                            
                                        </asp:Panel>
                                    </div>
                                    <!--RAF Schedule Tab Ends-->

                                    <!--RAF Population Tab Starts-->
                                    <div class="tab-pane fade" id="managePopulationTab">
                                        <div class="tabbable tabs-left">
                                            <ul class="nav nav-tabs">
                                                <li id="liTiers" class="active col-xsm-2"><a data-toggle="tab" href="#populationTiersTab" onclick="SetSelectedTab('populationTiersTab')">Tiers</a></li>
                                                    <li id="liList" class="col-xsm-2"><a data-toggle="tab" href="#populationListTab" onclick="SetSelectedTab('populationListTab')">List</a></li>
                                            </ul>
                                            <div class="tab-content">

                                                <!--adPression Population Tiers Tab Starts-->
                                                <div class="tab-pane fade in active" id="populationTiersTab">
                                                    <div class="tab-container clearfix">
                                                        <div class="col-md-12">
                                                            <div class="fieldset">
                                                                <fieldset>
                                                                    <legend>
                                                                        <asp:CheckBox ID="chkReferPopulationTiersAllPlayers" Text="All Tiers" runat="server" Checked="true" />
                                                                    </legend>
                                                                    <div id="divLstTiers" class="clearfix fieldSwitch">
                                                                        <asp:ListBox runat="server" ID="lstTiers" SelectionMode="Multiple" CssClass="referTiersBox" />
                                                                        <asp:HiddenField runat="server" ID="hdnTiersSelected" Value="0" />
                                                                    </div>
                                                                </fieldset>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <!--adPression Population Tiers Tab Ends-->

                                                <!--adPression Population List Tab Starts-->
                                                <div class="tab-pane fade" id="populationListTab">
                                                    <div class="tab-container clearfix">
                                                        <div class="col-md-12">
                                                            <div class="fieldset">
                                                                <fieldset>
                                                                    <legend>
                                                                        <asp:CheckBox Text="All Players" ID="chkReferPopulationListAllPlayers" runat="server" Checked="true" />
                                                                    </legend>
                                                                    <div id="divLstPlayers" class="clearfix fieldSwitch">
                                                                        <uc2:UC_CsvUpload_BM_AP_RAF runat="server" ID="UC_CsvUpload" />
                                                                    </div>
                                                                </fieldset>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <!--adPression Population List Tab Ends-->
                                            </div>
                                        </div>
                                    </div>
                                    <!--RAF Population Tab Ends-->

                                </div>
                            </div>
                        </div>
                        <div class="col-md-12 btnGroup">
                            <div class="btn-groupSpecial clearfix">
                                <asp:Button Text="Copy" runat="server" ID="lnkBtnCopy"  OnClick="lnkBtnCopy_OnClick" CssClass="results-control col-xsm-4" />
                                <asp:Button Text="Save" runat="server" ID="lnkBtnSave" OnClientClick="return FormValidation();" OnClick="lnkBtnSave_OnClick" CssClass="results-control col-xsm-4" />
                                <asp:Button Text="Cancel" runat="server" ID="lnkBtnCancel" OnClientClick="return ConfirmMessage(2);" OnClick="lnkBtnCancel_OnClick" CssClass="results-control col-xsm-4" />
                                <asp:Button Text="Delete" runat="server" ID="lnkBtnDelete" OnClientClick="return ConfirmMessage(3);" OnClick="lnkBtnDelete_OnClick" CssClass="results-control col-xsm-4" />
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            

            <asp:HiddenField runat="server" ID="hdnReferAFriendId" Value="0" />
            <asp:HiddenField runat="server" ID="hdnIsCopyActive" Value="0" />
            <asp:HiddenField runat="server" ID="hdnSelectedTab" Value="eventDetail" />
            <asp:HiddenField runat="server" ID="hdnTearList" Value="Tiers" />
            <script type="text/javascript">
               
                //On UpdatePanel Refresh
                var prm = Sys.WebForms.PageRequestManager.getInstance();
                if (prm != null) {
                    prm.add_endRequest(function (sender, e) {
                        if (sender._postBackSettings.panelsToUpdate != null) {
                                                      
                            RegisterDatePickersAndTimers();
                            RegisterListBoxes();                          
                            isNumberWithDecimal();                         
                            RegisterDetectedFormChanges();
                            SetTabControls();
                            RegisterFieldSets();
                            RegisterCheckboxCheckAndUncheck();
                        }
                    });
                }
                
                $(document).ready(function () {
                                                
                    isNumberWithDecimal();
                    RegisterDatePickersAndTimers();
                    RegisterListBoxes();
                    RegisterDetectedFormChanges();
                    SetTabControls();
                    RegisterFieldSets();
                    RegisterCheckboxCheckAndUncheck();
                    SetDefaultTab();
                });


                function RegisterCheckboxCheckAndUncheck()
                {
                   
                    ResetControls('#divMaxAwardsSendingReferral', $('input:checkbox[id*="chkAwardsSendingReferral"]').is(':checked'));
                    ResetControls('#divAwardsReferralAccountLink', $('input:checkbox[id*="chkAwardsReferralAccountLink"]').is(':checked'));
                    ResetControls('#divAwardsRefereeAccountLink', $('input:checkbox[id*="chkAwardsRefereeAccountLink"]').is(':checked'));

                    $('input:checkbox[id*="chkAwardsReferralAccountLink"]').on('change', function () {
                        $('#divAwardsReferralAccountLink').find('input:text,input:radio').prop('disabled', !$(this).is(':checked'));
                        $('#divAwardsReferralAccountLink').find('input:text').val("");
                        $('#divAwardsReferralAccountLink').find('input:radio').removeAttr('checked');
                    });
                    $('input:checkbox[id*="chkAwardsRefereeAccountLink"]').on('change', function () {
                        $('#divAwardsRefereeAccountLink').find('input:text,input:radio').prop('disabled', !$(this).is(':checked'));
                        $('#divAwardsRefereeAccountLink').find('input:text').val("");
                        $('#divAwardsRefereeAccountLink').find('input:radio').removeAttr('checked');
                    });
                    $('input:checkbox[id*="chkReferPopulationTiersAllPlayers"]').on('change', function () {
                        $('#divLstTiers').find('select, button, input:text').prop('disabled', $(this).is(':checked'));
                    });

                    $('input:checkbox[id*="chkReferPopulationListAllPlayers"]').on('change', function () {
                        $('#divLstPlayers').find('input:text, button, span').prop('disabled', $(this).is(':checked'));
                    });
                
                    $('#divLstTiers').find('select, button, input:text').prop('disabled', $('input:checkbox[id*="chkReferPopulationTiersAllPlayers"]').is(':checked'));

                    $('#divLstPlayers').find('input:text, button, span').prop('disabled', $('input:checkbox[id*="chkReferPopulationListAllPlayers"]').is(':checked'));
                }
                function SetTearList(val) {
                    $('#<%=hdnTearList.ClientID%>').val(val);
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
            function RegisterListBoxes() {
                //  Area list box
                var referTiersBox = $('.referTiersBox').bootstrapDualListbox({
                    nonselectedlistlabel: 'Exclude',
                    selectedlistlabel: 'Include',
                    preserveselectiononmove: 'moved',
                    moveonselect: false,
                    hdnControlId: 'hdnTiersSelected'
                });
            }
          
            $('#divLstTiers').find('select, button, input:text').prop('disabled', $('input:checkbox[id*="chkReferPopulationTiersAllPlayers"]').is(':checked'));

            $('#divLstPlayers').find('input:text, button, span').prop('disabled', $('input:checkbox[id*="chkReferPopulationListAllPlayers"]').is(':checked'));

            $('input:checkbox[id*="chkReferPopulationTiersAllPlayers"]').on('change', function () {
                $('#divLstTiers').find('select, button, input:text').prop('disabled', $(this).is(':checked'));
            });

            $('input:checkbox[id*="chkReferPopulationListAllPlayers"]').on('change', function () {
                $('#divLstPlayers').find('input:text, button, span').prop('disabled', $(this).is(':checked'));
            });

            

                function ResetControls(divId, status) {                   

                    $(divId).find('input:text').prop('disabled', !status);
                    $(divId).find('input:radio').prop('disabled', !status);
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

                function FormValidation()
                {
                    var activeTab = $('input:hidden[id*="hdnSelectedTab"]').val();

                    if (myTrim($('#<%=hdnSelectedProperties.ClientID%>').val()) == '' && 
                            $('#<%=chkAllProperties.ClientID%>').attr("checked") != "checked") {
                        document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please Include atleast one Property.';
                        $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                        document.getElementById('<%=chkAllProperties.ClientID%>').focus();
                        SetDefaultTab();
                        return false;
                    }
                    if (myTrim($('#<%=txtEventName.ClientID%>').val()) == '') {
                        document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please enter event name';
                        $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                        SetSelectedTab('contentTab');
                        document.getElementById('<%=txtEventName.ClientID%>').focus();
                        return false;
                    }
                    if ($('#<%=chkAwardsReferralAccountLink.ClientID%>')[0].checked == true && $('#<%=txtReferralAccountLinkMaxValue.ClientID%>').val() == '' && $('#<%=txtReferralAccountLinkMaxCount.ClientID%>').val() == '') {
                        document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please enter max awards by value or max awards by count';
                         $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                         document.getElementById('<%=txtReferralAccountLinkMaxValue.ClientID%>').focus();
                        return false;
                    }
                    if ($('#<%=chkAwardsRefereeAccountLink.ClientID%>')[0].checked == true && $('#<%=txtRefereeAccountLinkMaxValue.ClientID%>').val() == '' && $('#<%=txtRefereeAccountLinkMaxCount.ClientID%>').val() == '') {
                        document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please enter max awards by value or max awards by count';
                         $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                         document.getElementById('<%=txtReferralAccountLinkMaxValue.ClientID%>').focus();
                         return false;
                     }
                    if (myTrim(document.getElementById('<%=txtScheduleName.ClientID%>').value) != '' || activeTab == 'scheduleTab')
                    {
                        if (myTrim(document.getElementById('<%=txtScheduleName.ClientID%>').value) == '') {

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
                    }
                    if (activeTab == 'population') {
                        if ($('#<%=hdnTearList.ClientID%>').val() == 'Tiers') {
                            var status = $('#<%=chkReferPopulationTiersAllPlayers.ClientID%>').is(':checked');
                            if (status == false) {
                                if ($('#<%=hdnTiersSelected.ClientID%>').val() == "" || $('#<%=hdnTiersSelected.ClientID%>').val() == "0") {
                                    alert('Please select a tier');
                                    return false;
                                }

                            }
                            return true;
                        }
                        else if (activeTab == 'List') {
                            var status = $('#<%=chkReferPopulationListAllPlayers.ClientID%>').is(':checked');
                            if (status == false) {
                                if ($('#divLstPlayers').find('input:text[id*="txtValidRecords"]').val() == "") {
                                    alert('Please select csv file');
                                    return false;
                                }

                            }
                            return true;
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
                    var rowscount = $("#<%=grdReferrals.ClientID %> tr").length;
                    var isPermissionDelete = $("#<%=hdnIsPermissionDelete.ClientID %>").val(); 
                    switch (readTabValue) {
                        case 'property':
                            $('.nav-tabs li').removeClass('active');
                            $('.nav-tabs li.nav-tabs-property').addClass('active');
                            $('.tab-content .tab-pane').removeClass('active in');
                            $('#propertyTab').addClass('active in');
                            $("#<%=lnkBtnDelete.ClientID %>").addClass('aspNetDisabled');
                            $("#<%=lnkBtnDelete.ClientID %>").attr("disabled", $("#<%=lnkBtnDelete.ClientID %>"));
                            $("#dvLeftcontentdetail").height($('#dvRightContent').height());
                           
                            break;
                        case 'contentTab':
                            $('.nav-tabs li').removeClass('active');
                            $('.nav-tabs li.nav-tabs-content').addClass('active');
                            $('.tab-content .tab-pane').removeClass('active in');
                            $('#manageContentTab').addClass('active in');

                            if (isTab == "InActive" || isTab == "All") {
                                $("#<%=lnkBtnDelete.ClientID %>").addClass('aspNetDisabled');
                              $("#<%=lnkBtnDelete.ClientID %>").addClass('disabled');
                          }
                            else {
                                if (rowscount > 0 && isPermissionDelete==1) {
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
                            $('div#populationTiersTab').addClass('active in');
                            $('div#managePopulationTab').addClass('active in');
                            $('#liTiers').removeClass('active');
                            $('#liTiers').addClass('active in');
                            $("#<%=lnkBtnDelete.ClientID %>").addClass('aspNetDisabled');
                            $("#<%=lnkBtnDelete.ClientID %>").attr("disabled", $("#<%=lnkBtnDelete.ClientID %>"));

                            break;
                        case 'populationTiersTab':
                            $('.nav-tabs li').removeClass('active');
                            $('.nav-tabs li.nav-tabs-population').addClass('active in');
                            $('.tab-content .tab-pane').removeClass('active in');
                            $('div#populationListTab').removeClass('active');
                            $('div#populationTiersTab').addClass('active in');
                            $('div#managePopulationTab').addClass('active in');
                            $('li#liTiers').addClass('active in');
                            $("#<%=lnkBtnDelete.ClientID %>").addClass('aspNetDisabled');
                            $("#<%=lnkBtnDelete.ClientID %>").attr("disabled", $("#<%=lnkBtnDelete.ClientID %>"));

                            break;
                        case 'populationListTab':
                            $('.nav-tabs li').removeClass('active');
                            $('.nav-tabs li.nav-tabs-population').addClass('active');
                            $('.tab-content .tab-pane').removeClass('active in');
                            $('div#populationTiersTab').removeClass('active');
                            $('div#populationListTab').addClass('active in');
                            $('div#managePopulationTab').addClass('active in');
                            $('li#liList').addClass('active');
                            break;
                            $("#<%=lnkBtnDelete.ClientID %>").addClass('aspNetDisabled');
                            $("#<%=lnkBtnDelete.ClientID %>").attr("disabled", $("#<%=lnkBtnDelete.ClientID %>"));   
                    }
                    $("#dvLeftcontentdetail").height($('#dvRightContent').height());
                }

                ///Set Default tab on pageload
                function SetDefaultTab() {
                    $('.nav-tabs li').removeClass('active');
                    $('.nav-tabs li.nav-tabs-property').addClass('active');
                    $('.tab-content .tab-pane').removeClass('active in');
                    $('#propertyTab').addClass('active in');
                    //SetSelectedTab('propertyTab');
                }
                function SetSelectedTab(selectedTab) {
                    $('input:hidden[id*="hdnSelectedTab"]').val(selectedTab);
                    SetTabControls();
                }

                //  Area list box
                function RegisterListBox() {
                    //$("#dvLeftcontentdetail").height($('#dvRightContent').height());
                    var permissionBox = $('.permissionBox').bootstrapDualListbox({
                        nonselectedlistlabel: 'Exclude',
                        selectedlistlabel: 'Include',
                        preserveselectiononmove: 'moved',
                        moveonselect: false,
                        hdnControlId: 'hdnFunctionIDs'
                    });
                }

                function RegisterDetectedFormChanges() {
                    $.each($("input:text"), function (index, element) {
                        element.defaultValue = $(element).val();
                    });
                }
               
                function RegisterFieldSets() {

                    if ($('.fieldset legend input[type="checkbox"]')[0].checked == true) {
                        $('.fieldSwitch input[type="checkbox"]').prop('disabled', false);
                    }
                    else
                    {
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
                       
                        if ($('.fieldset legend input[type="checkbox"]')[0].checked==true) {
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

                function ConfirmMessage(flag) {
                    var savemsg = 'Are you sure to save this Refer a Friend?';
                    var cancelmsg = 'Are you sure to discard current changes?';
                    var deletemsg = 'Are you sure to delete this Refer a Friend?';
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
                
                function myTrim(x) {
                    return x.replace(/\s/g, '').replace('-', '');
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
                            <asp:Button ID="btnConfirmedInActive" CssClass="btn btn-danger" runat="server" Text="OK" UseSubmitBehavior="false" data-dismiss="modal" OnClick="lnkBtnInactive_OnClick" Style="display: none;"></asp:Button>
                            <asp:Button ID="btnConfirmedAll" CssClass="btn btn-danger" runat="server" Text="OK" UseSubmitBehavior="false" data-dismiss="modal" OnClick="lnkBtnAll_OnClick" Style="display: none;"></asp:Button>
                            <button type="button" class="btn" id="confirm" data-dismiss="modal">Cancel</button>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Dialog show event handler -->
        <script type="text/javascript">

            //  Area list box
            function RegisterListBox() {
                var propertiesBox = $('.propertiesBox').bootstrapDualListbox({
                    nonselectedlistlabel: 'Exclude',
                    selectedlistlabel: 'Include',
                    preserveselectiononmove: 'moved',
                    moveonselect: false,
                    hdnControlId: 'hdnSelectedProperties'
                });
            }

            function EnableDisableProperties() {
                if (document.getElementById("<%=chkAllProperties.ClientID%>").checked) {
                    $('#dvSelectPropertiesLbl').find('select, button, input:text').prop('disabled', true);
                } else {
                    $('#dvSelectPropertiesLbl').find('select, button, input:text').prop('disabled', false);
                }
            }

            function RefreshProperties() {
                propertiesBox.bootstrapDualListbox('refresh', true);
            }

            </script>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
