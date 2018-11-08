<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" EnableEventValidation="false" ValidateRequest="false" AutoEventWireup="true" CodeBehind="RapidReserveEvent.aspx.cs" Inherits="HAMobileWebAdmin.RapidReserveEvents" %>

<%@ Register Src="~/UserControl/UC_CsvUpload_PopulationListTabExt.ascx" TagPrefix="csv" TagName="UC_CsvUpload_PopulationListTabExtended" %>
<%@ Register Src="~/UserControl/UC_PopulationTypeTab.ascx" TagPrefix="listbox" TagName="UC_PopulationTypeTab" %>
<%@ Register TagPrefix="ig" Namespace="Infragistics.Web.UI.GridControls" Assembly="Infragistics4.Web.v14.1, Version=14.1.20141.2150, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <title>COG Mobile | RapidReserve Content Management</title>
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
            <asp:HiddenField runat="server" ID="hdnEventScheduleID" Value="0" />
            <asp:HiddenField runat="server" ID="hdnGvEventSelectedIndex" Value="0" />
            <asp:HiddenField runat="server" ID="hdnGvScheduleSelectedIndex" Value="0" />
            <asp:HiddenField runat="server" ID="hdnSelectedTab" Value="0" />
            <asp:HiddenField runat="server" ID="hdnIsShedule" Value="True" />
            <asp:HiddenField runat="server" ID="hdnButtonSatus" Value="0" />
            <asp:HiddenField runat="server" ID="hdnButtonPermission" Value="0" />
            <asp:HiddenField runat="server" ID="hdnIsPermissionDelete" Value="0" />
            <div class="row" id="slotInventory">
                <div class="col-sm-3">
                    <h5>RapidReserve</h5>
                    <div class="filterWrapper relative" id="dvLeftcontentdetail1">
                        <div class="clearfix">
                            <div class="pull-left">
                            </div>
                            <div class="pull-right">
                                <span class="addBtn">Add
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
                            <asp:GridView runat="server" CssClass="gridview" ID="grdEvents" ShowHeader="False" AutoGenerateColumns="False" DataKeyNames="EventId" AllowPaging="true" PageSize="15" OnPageIndexChanging="grdEvents_PageIndexChanging">
                                <Columns>
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <asp:Label ID="lblID" runat="server" Visible="false" Text='<%#Eval("EventID") %>' />
                                            <asp:LinkButton runat="server" ID="lnkBtnRREvent" CommandName="Select" OnClick="lnkBtnRREvent_Click" Text='<%#Eval("EventName") %>'></asp:LinkButton>
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
                                <asp:Button Text="Active" ID="lnkBtnActiveEvent" CssClass="results-control col-xs-4" OnClientClick="return ConfirmMessage(4);" OnClick="lnkbtnActiveEvent_Click" runat="server" />
                                <asp:Button Text="InActive" ID="lnkBtnInactiveEvent" CssClass="results-control col-xs-4" OnClientClick="return ConfirmMessage(5);" OnClick="lnkbtnInactiveEvent_Click" runat="server" />
                                <asp:Button Text="All" ID="lnkBtnAllEvent" CssClass="results-control col-xs-4" OnClientClick="return ConfirmMessage(6);" OnClick="lnkbtnAllEvent_Click" runat="server" />
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-sm-9">
                    <h5>RapidReserve Detail</h5>
                    <div class="row clearfix relative btnGroup btnGroup3" id="dvRightContent1">
                        <div class="col-md-12 clearfix">
                            <div class="tabControls">
                                <ul class="nav nav-tabs">
                                    <li class="active col-xsm-25 nav-tabs-content"><span class="linkDisabledsp">&nbsp;</span><a data-toggle="tab" href="#manageContentTab" onclick="SetSelectedTab('contentTab')">Content</a></li>
                                    <li class="col-xsm-25  nav-tabs-schedule"><span class="linkDisabledsp">&nbsp;</span><a data-toggle="tab" href="#manageScheduleTab" id="manageScheduleTabLink" onclick="SetSelectedTab('scheduleTab')">Schedule</a></li>
                                    <li class="col-xsm-25  nav-tabs-population"><span class="linkDisabledsp">&nbsp;</span><a data-toggle="tab" href="#managePopulationTab" id="managePopulationTabLink" onclick="SetSelectedTab('populationTab')">Population</a></li>
                                    <li class="col-xsm-25  nav-tabs-message"><span class="linkDisabledsp">&nbsp;</span><a data-toggle="tab" href="#manageMessageTab" id="manageMessageTabLink" onclick="SetSelectedTab('MessageTab')">Message</a></li>
                                </ul>
                                <div class="tab-content">

                                    <!-- Content Tab Starts -->
                                    <div class="tab-pane active fade in" id="manageContentTab">
                                        <div class="tab-container clearfix">
                                            <div class="col-md-12">
                                                <div class="col-md-8 no-padding">
                                                    <label>Event Name</label>
                                                    <asp:TextBox runat="server" ID="txtEventName" MaxLength="250" CssClass="form-control"></asp:TextBox>
                                                </div>

                                                <%--  <div class="col-md-4">
                                                    <label>&nbsp;</label>
                                                    <asp:CheckBox runat="server" ID="chkEventIsActive" />
                                                    <label for="<%=chkEventIsActive.ClientID %>">Active</label>
                                                </div>--%>
                                            </div>

                                            <div class="col-md-12">
                                                <div class="col-md-8 no-padding">
                                                    <label>Venue</label>
                                                    <asp:DropDownList runat="server" ID="ddlEventVenue" CssClass="form-control">
                                                    </asp:DropDownList>
                                                </div>
                                            </div>
                                            <!--Section 1 -->
                                            <div class="col-md-12 clearfix">
                                                <div class="shadedSingleBlock col-md-12">
                                                    <asp:CheckBox runat="server" ID="chkIsLocationRequired" />
                                                    <label for="<%=chkIsLocationRequired.ClientID %>">Requires Location</label>

                                                    <div id="dvIsLocationRequired">
                                                        <label>Select Geofence or Microlocation Beacon</label>
                                                        <asp:DropDownList runat="server" ID="ddlEventGeoFence" CssClass="form-control">
                                                        </asp:DropDownList>

                                                        <div class="col-md-10 no-padding">
                                                            <asp:CheckBox runat="server" ID="chkIsForfeitEnabled" />
                                                            <label for="<%=chkIsForfeitEnabled.ClientID %>">Forfeit place in line after N minutes of leaving assigned location without reentry</label>
                                                        </div>
                                                        <div class="col-md-2" id="dvIsForfeitEnabled">
                                                            <asp:TextBox runat="server" ID="txtForfeitMinute" MaxLength="5" Text="15" CssClass="form-control numeric"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                            <!--Section 2 -->
                                            <div class="col-md-12 clearfix">
                                                <div class="shadedSingleBlock col-md-12">
                                                    <asp:CheckBox runat="server" ID="chkIsAwardAssociated" />
                                                    <label for="<%=chkIsAwardAssociated.ClientID %>">Associate Award upon being confirmed as Seated</label>
                                                    <label></label>

                                                    <div id="dvIsAwardAssociated">
                                                        <label>Select Award</label>
                                                        <asp:DropDownList runat="server" ID="ddlAward" CssClass="form-control">
                                                        </asp:DropDownList>

                                                        <label>Maximum Frequency of Triggered Awards per Player</label>
                                                        <div class="col-md-12 no-padding">
                                                            <div class="col-md-2 no-padding">
                                                                <asp:TextBox runat="server" ID="txtMaxTriggerPerFrequency" MaxLength="5" CssClass="form-control numeric"></asp:TextBox>
                                                            </div>
                                                            <div class="col-md-2 ">times per </div>
                                                            <div class="col-md-2 ">
                                                                <asp:TextBox runat="server" ID="txtFrequencyCount" MaxLength="5" CssClass="form-control numeric"></asp:TextBox>
                                                            </div>
                                                            <div class="col-md-3 ">
                                                                <asp:DropDownList runat="server" ID="ddlFrequency" CssClass="form-control">
                                                                </asp:DropDownList>
                                                            </div>
                                                        </div>

                                                        <div class="col-md-12 no-padding">
                                                            <div id="dvIsPushNotificationEnabled">
                                                                <label>"Award Notification" to In App Inbox</label>
                                                                <asp:TextBox runat="server" ID="txtAwardNotificationText" TextMode="MultiLine" Height="150px" MaxLength="255" CssClass="form-control"></asp:TextBox>
                                                            </div>
                                                            <asp:CheckBox runat="server" ID="chkIsPushNotificationEnabled" />
                                                            <label for="<%=chkIsPushNotificationEnabled.ClientID %>">Send Push Notification with "Award Notification" in App Message</label>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="col-md-12 clearfix marginTop">
                                                <div class="col-md-5 no-padding">
                                                    <label>Staff: Wait time Update Reminder every N Minutes</label>
                                                </div>

                                                <div class="col-md-2">
                                                    <asp:TextBox runat="server" ID="txtStafReminderTime" MaxLength="5" Text="15" CssClass="form-control numeric"></asp:TextBox>
                                                </div>
                                            </div>
                                            <div class="col-md-12 clearfix marginTop">
                                                <label>Define Wait Time Ranges (Up to 10)</label>

                                                <asp:GridView ID="grdDefineWaitTimeRange" runat="server"
                                                    AutoGenerateColumns="False" DataKeyNames="OperationId"
                                                    OnRowCancelingEdit="grdDefineWaitTimeRange_RowCancelingEdit"
                                                    OnRowEditing="grdDefineWaitTimeRange_RowEditing"
                                                    OnRowUpdating="grdDefineWaitTimeRange_RowUpdating"
                                                    OnRowCommand="grdDefineWaitTimeRange_RowCommand"
                                                    ShowFooter="False"
                                                    ShowHeader="True"
                                                    GridLines="None"
                                                    CssClass="mGrid"
                                                    ShowHeaderWhenEmpty="True"
                                                    PagerStyle-CssClass="pgr"
                                                    AlternatingRowStyle-CssClass="alt">
                                                    <Columns>
                                                        <asp:TemplateField HeaderText="Minimum Minutes" HeaderStyle-HorizontalAlign="Left">
                                                            <EditItemTemplate>
                                                                <asp:HiddenField runat="server" ID="hdnOperationId" Value='<%# Bind("OperationId") %>' />
                                                                <asp:HiddenField runat="server" ID="hdnEventWaitTimeRangeId" Value='<%# Bind("eventWaitTimeRangeId") %>' />
                                                                <asp:TextBox ID="txtMinMinutes" runat="server" Text='<%# Bind("MinimumMinute") %>' MaxLength="5" CssClass="form-control numeric borderless-input nomargin no-padding"></asp:TextBox>
                                                            </EditItemTemplate>
                                                            <ItemTemplate>
                                                                <asp:HiddenField runat="server" ID="hdnOperationId1" Value='<%# Bind("OperationId") %>' />
                                                                <asp:Label ID="lblMinMinutes" runat="server" Text='<%# Bind("MinimumMinute") %>'></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Maximum Minutes" HeaderStyle-HorizontalAlign="Left">
                                                            <EditItemTemplate>
                                                                <asp:TextBox ID="txtMaxMinutes" runat="server" Text='<%# Bind("MaximumMinute") %>' MaxLength="5" CssClass="form-control numeric borderless-input nomargin no-padding"></asp:TextBox>
                                                            </EditItemTemplate>
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblMaxMinutes" runat="server" Text='<%# Bind("MaximumMinute") %>'></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="" ShowHeader="True" HeaderStyle-HorizontalAlign="Left">
                                                            <EditItemTemplate>
                                                                <asp:LinkButton ID="lbkUpdate" runat="server" CausesValidation="True" CommandName="Update" Text="Save" Width="50"></asp:LinkButton>
                                                                <asp:LinkButton ID="lnkCancel" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel"></asp:LinkButton>
                                                            </EditItemTemplate>
                                                            <ItemTemplate>
                                                                <asp:LinkButton ID="lnkEdit" runat="server" CausesValidation="False" CommandName="Edit" Text="Edit" Width="50"></asp:LinkButton>
                                                                <asp:LinkButton ID="lnkDelete" runat="server" CausesValidation="False" CommandName="DeleteRec" Text="Delete"></asp:LinkButton>
                                                            </ItemTemplate>
                                                            <HeaderStyle Width="105"></HeaderStyle>
                                                            <HeaderTemplate>
                                                                <asp:LinkButton ID="lbkAddNewRow" runat="server" CausesValidation="True" CommandName="ADDNEW" Text="Add Row" ForeColor="#ffffff"></asp:LinkButton>
                                                            </HeaderTemplate>
                                                        </asp:TemplateField>
                                                    </Columns>
                                                </asp:GridView>

                                            </div>
                                            <div class="col-md-12 clearfix marginTop">
                                                <label>Define Party Size (Up to 6)</label>

                                                <asp:GridView ID="grdDefinePartySize" runat="server"
                                                    AutoGenerateColumns="False" DataKeyNames="OperationId"
                                                    OnRowCancelingEdit="grdDefinePartySize_RowCancelingEdit"
                                                    OnRowEditing="grdDefinePartySize_RowEditing"
                                                    OnRowUpdating="grdDefinePartySize_RowUpdating"
                                                    OnRowCommand="grdDefinePartySize_RowCommand"
                                                    ShowFooter="False"
                                                    ShowHeader="True"
                                                    GridLines="None"
                                                    ShowHeaderWhenEmpty="True"
                                                    CssClass="mGrid"
                                                    PagerStyle-CssClass="pgr"
                                                    AlternatingRowStyle-CssClass="alt">
                                                    <Columns>
                                                        <asp:TemplateField HeaderText="Minimum Party Size" HeaderStyle-HorizontalAlign="Left">
                                                            <EditItemTemplate>
                                                                <asp:HiddenField runat="server" ID="hdnOperationId" Value='<%# Bind("OperationId") %>' />
                                                                <asp:HiddenField runat="server" ID="hdnEventPartySizeId" Value='<%# Bind("EventPartySizeId") %>' />
                                                                <asp:TextBox ID="txtMinPartySize" runat="server" Text='<%# Bind("MinimumSize") %>' MaxLength="5" CssClass="form-control numeric borderless-input nomargin no-padding"></asp:TextBox>
                                                            </EditItemTemplate>
                                                            <ItemTemplate>
                                                                <asp:HiddenField runat="server" ID="hdnOperationId1" Value='<%# Bind("OperationId") %>' />
                                                                <asp:Label ID="lblMinPartySize" runat="server" Text='<%# Bind("MinimumSize") %>'></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Maximum Party Size" HeaderStyle-HorizontalAlign="Left">
                                                            <EditItemTemplate>
                                                                <asp:TextBox ID="txtMaxPartySize" runat="server" Text='<%# Bind("MaximumSize") %>' MaxLength="5" CssClass="form-control numeric borderless-input nomargin no-padding"></asp:TextBox>
                                                            </EditItemTemplate>
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblMaxPartySize" runat="server" Text='<%# Bind("MaximumSize") %>'></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="" ShowHeader="True" HeaderStyle-HorizontalAlign="Left">
                                                            <EditItemTemplate>
                                                                <asp:LinkButton ID="lbkUpdate" runat="server" CausesValidation="True" CommandName="Update" Text="Save" Width="50"></asp:LinkButton>
                                                                <asp:LinkButton ID="lnkCancel" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel"></asp:LinkButton>
                                                            </EditItemTemplate>
                                                            <ItemTemplate>
                                                                <asp:LinkButton ID="lnkEdit" runat="server" CausesValidation="False" CommandName="Edit" Text="Edit" Width="50"></asp:LinkButton>
                                                                <asp:LinkButton ID="lnkDelete" runat="server" CausesValidation="False" CommandName="DeleteRec" Text="Delete"></asp:LinkButton>
                                                            </ItemTemplate>
                                                            <HeaderStyle Width="105"></HeaderStyle>
                                                            <HeaderTemplate>
                                                                <asp:LinkButton ID="lbkAddNewRow" runat="server" CausesValidation="True" CommandName="ADDNEW" Text="Add Row" ForeColor="#ffffff"></asp:LinkButton>
                                                            </HeaderTemplate>
                                                        </asp:TemplateField>
                                                    </Columns>
                                                </asp:GridView>
                                            </div>
                                            <div class="col-md-12 clearfix marginTop">
                                                <label>Define Special Requests (Up to 6)</label>

                                                <asp:GridView ID="grdDefineSpecialRequest" runat="server"
                                                    AutoGenerateColumns="False" DataKeyNames="OperationId"
                                                    OnRowCancelingEdit="grdDefineSpecialRequest_RowCancelingEdit"
                                                    OnRowEditing="grdDefineSpecialRequest_RowEditing"
                                                    OnRowUpdating="grdDefineSpecialRequest_RowUpdating"
                                                    OnRowCommand="grdDefineSpecialRequest_RowCommand"
                                                    ShowFooter="False"
                                                    ShowHeader="True"
                                                    GridLines="None"
                                                    CssClass="mGrid"
                                                    ShowHeaderWhenEmpty="True"
                                                    PagerStyle-CssClass="pgr"
                                                    AlternatingRowStyle-CssClass="alt">
                                                    <Columns>
                                                        <asp:TemplateField HeaderText="Special Requests" HeaderStyle-HorizontalAlign="Left">
                                                            <EditItemTemplate>
                                                                <asp:HiddenField runat="server" ID="hdnOperationId" Value='<%# Bind("OperationId") %>' />
                                                                <asp:HiddenField runat="server" ID="hdnEventSpecialRequestId" Value='<%# Bind("EventSpecialRequestId") %>' />
                                                                <asp:TextBox ID="txtSpecialRequestName" runat="server" Text='<%# Bind("SpecialRequestName") %>' MaxLength="100" CssClass="form-control borderless-input nomargin no-padding"></asp:TextBox>
                                                            </EditItemTemplate>
                                                            <ItemTemplate>
                                                                <asp:HiddenField runat="server" ID="hdnOperationId1" Value='<%# Bind("OperationId") %>' />
                                                                <asp:Label ID="lblSpecialRequestName" runat="server" Text='<%# Bind("SpecialRequestName") %>'></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="" ShowHeader="True" HeaderStyle-HorizontalAlign="Left">
                                                            <EditItemTemplate>

                                                                <asp:LinkButton ID="lbkUpdate" runat="server" CausesValidation="True" CommandName="Update" Text="Save" Width="50"></asp:LinkButton>
                                                                <asp:LinkButton ID="lnkCancel" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel"></asp:LinkButton>
                                                            </EditItemTemplate>
                                                            <ItemTemplate>
                                                                <asp:LinkButton ID="lnkEdit" runat="server" CausesValidation="False" CommandName="Edit" Text="Edit" Width="50"></asp:LinkButton>
                                                                <asp:LinkButton ID="lnkDelete" runat="server" CausesValidation="False" CommandName="DeleteRec" Text="Delete"></asp:LinkButton>
                                                            </ItemTemplate>
                                                            <HeaderStyle Width="105"></HeaderStyle>
                                                            <HeaderTemplate>
                                                                <asp:LinkButton ID="lbkAddNewRow" runat="server" CausesValidation="True" CommandName="ADDNEW" Text="Add Row" ForeColor="#ffffff"></asp:LinkButton>
                                                            </HeaderTemplate>
                                                        </asp:TemplateField>
                                                    </Columns>
                                                </asp:GridView>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Content Tab Ends -->

                                    <!-- Schedule Tab Starts -->
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
                                                                        <tr class="trmonday">
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
                                                                        <tr class="trfriday">
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
                                        </asp:Panel>
                                    </div>
                                    <!-- Schedule Tab Ends -->

                                    <!-- Population Tab Starts -->
                                    <div class="tab-pane fade" id="managePopulationTab">
                                        <div class="tabbable tabs-left">
                                            <ul class="nav nav-tabs">
                                                <li id="lipopulationTypeTab" class="active col-xsm-2"><a data-toggle="tab" href="#populationTypeTab" onclick="SetSelectedTab('populationTypeTab')">Type</a></li>
                                                <li id="lipopulationListTab" class="col-xsm-2"><a data-toggle="tab" href="#populationListTab" onclick="SetSelectedTab('populationListTab')">List</a></li>
                                            </ul>
                                            <div class="tab-content">

                                                <!-- Population Type Tab Starts-->
                                                <div class="tab-pane fade in active" id="populationTypeTab">
                                                    <listbox:UC_PopulationTypeTab runat="server" ID="UC_PopulationTypeTab" />
                                                </div>
                                                <!-- Population Type Tab Ends-->

                                                <!-- Population List Tab Starts-->
                                                <div class="tab-pane fade" id="populationListTab">
                                                    <div class="tab-container clearfix">
                                                        <div class="col-md-12">
                                                            <csv:UC_CsvUpload_PopulationListTabExtended runat="server" ID="UC_CsvUpload_PopulationListTabExt" />
                                                        </div>
                                                    </div>
                                                </div>
                                                <!-- Population List Tab Ends-->
                                            </div>
                                        </div>
                                    </div>
                                    <!-- Population Tab Ends -->

                                    <!-- Message Tab Starts -->
                                    <div class="tab-pane fade" id="manageMessageTab">
                                        <div class="tabbable tabs-left">
                                            <ul class="nav nav-tabs">
                                                <li id="liMessageLocationTab" class="active col-xsm-32"><a data-toggle="tab" id="AnchorMessageLocationTab" href="#MessageLocationTab" onclick="SetSelectedTab('MessageLocationTab')">Locations</a></li>
                                                <li id="liMessageAutoTab" class="col-xsm-32"><a data-toggle="tab" href="#MessageAutoTab" onclick="SetSelectedTab('MessageAutoTab')">Automatic Line Request</a></li>
                                                <li id="liMessageManualTab" class="col-xsm-32"><a data-toggle="tab" href="#MessageManualTab" onclick="SetSelectedTab('MessageManualTab')">Manually Triggered</a></li>
                                            </ul>
                                            <div class="tab-content">

                                                <!-- Message Location Tab Starts -->
                                                <div class="tab-pane fade in active" id="MessageLocationTab">
                                                    <div class="tab-container clearfix">
                                                        <div class="col-md-12">
                                                            <label>
                                                                <h4>In App Popup Alerts</h4>
                                                            </label>
                                                            <label>
                                                                Device Location Service is OFF
                                                                <img src="Content/img/help.png" data-toggle="modal" data-target="#HintBox" title="Dynamic Tags" />
                                                            </label>
                                                            <asp:TextBox runat="server" ID="txtServiceOffMessage" MaxLength="255" TextMode="MultiLine" CssClass="form-control" Height="150px"></asp:TextBox>
                                                        </div>


                                                        <div class="col-md-12">
                                                            <label>
                                                                User is Determined to be Outside Required Location
                                                                <img src="Content/img/help.png" data-toggle="modal" data-target="#HintBox" title="Dynamic Tags" />
                                                            </label>
                                                            <asp:TextBox runat="server" ID="txtAtLocationMessage" MaxLength="255" TextMode="MultiLine" CssClass="form-control" Height="150px"></asp:TextBox>
                                                        </div>

                                                        <div class="col-md-12">
                                                            <label>
                                                                Device Location Service is ON, but Unable to Determine Location
                                                                <img src="Content/img/help.png" data-toggle="modal" data-target="#HintBox" title="Dynamic Tags" />
                                                            </label>
                                                            <asp:TextBox runat="server" ID="txtUnknownLocationMessage" MaxLength="255" TextMode="MultiLine" CssClass="form-control" Height="150px"></asp:TextBox>
                                                        </div>

                                                        <div class="col-md-12 marginTop">
                                                            <label>
                                                                <h4>Batch Message Player Leaves Required Location
                                                                    <img src="Content/img/help.png" data-toggle="modal" data-target="#HintBox" title="Dynamic Tags" /></h4>
                                                            </label>
                                                            <div class="shadedSingleBlock col-md-12">
                                                                <asp:CheckBox runat="server" ID="chkInAppPendingReserveEnabled" />
                                                                <label for="<%=chkInAppPendingReserveEnabled.ClientID %>">Send to In App Inbox if Player Leaves Location or Turns Location Service OFF with Pending RapidReserve</label>

                                                                <asp:CheckBox runat="server" ID="chkOutAppPendingReserveEnabled" />
                                                                <label for="<%=chkOutAppPendingReserveEnabled.ClientID %>">Also Send as a Push Notification</label>

                                                                <asp:TextBox runat="server" ID="txtPendingReserveMessage" MaxLength="255" TextMode="MultiLine" CssClass="form-control" Height="150px"></asp:TextBox>
                                                            </div>
                                                        </div>

                                                    </div>
                                                </div>
                                                <!-- Message Location Tab Ends -->

                                                <!-- Message Auto Tab Starts-->
                                                <div class="tab-pane fade" id="MessageAutoTab">
                                                    <div class="tab-container clearfix">
                                                        <div class="col-md-12">
                                                            <label>
                                                                <h4>Confirmation In App Popup Message
                                                                    <img src="Content/img/help.png" data-toggle="modal" data-target="#HintBox" title="Dynamic Tags" />
                                                                </h4>
                                                            </label>
                                                            <asp:TextBox runat="server" ID="txtTableReadyMessage" MaxLength="255" TextMode="MultiLine" CssClass="form-control" Height="150px"></asp:TextBox>

                                                            <div class="shadedSingleBlock col-md-12 marginTop">
                                                                <asp:CheckBox runat="server" ID="chkTurnOffNeedMoreTimeEnabled" />
                                                                <label for="<%=chkTurnOffNeedMoreTimeEnabled.ClientID %>">Turn Off "Need More Time" Requests</label>

                                                                <div id="dvTurnOffNeedMoreTimeEnabled">
                                                                    <div class="col-md-12 no-padding">
                                                                        <div class="col-md-2 no-padding">
                                                                            <asp:TextBox runat="server" ID="txtTurnOffNeedMoreTimeBeforeEventInMin" MaxLength="5" CssClass="form-control numeric"></asp:TextBox>
                                                                        </div>
                                                                        <div class="col-md-8 ">Prevent N Minutes Prior to Schedule Event End Time</div>
                                                                    </div>
                                                                    <label>From</label>
                                                                    <asp:TextBox runat="server" ID="txtTurnOffNeedMoreTimeFrom" MaxLength="255" TextMode="SingleLine" CssClass="form-control"></asp:TextBox>

                                                                    <label>
                                                                        "Need More Time" Request (In App Popup Message)
                                                                    <img src="Content/img/help.png" data-toggle="modal" data-target="#HintBox" title="Dynamic Tags" />
                                                                    </label>
                                                                    <asp:TextBox runat="server" ID="txtTurnOffNeedMoreTimeMessage" MaxLength="255" TextMode="MultiLine" CssClass="form-control" Height="150px"></asp:TextBox>
                                                                </div>
                                                            </div>
                                                            <div class="shadedSingleBlock col-md-12 marginTop">
                                                                <asp:CheckBox runat="server" ID="chkAutoTableIsReadySMSEnabled" />
                                                                <label for="<%=chkAutoTableIsReadySMSEnabled.ClientID %>">Send Automated "Table is Ready" SMS Message</label>
                                                                <div id="dvAutoTableIsReadySMSEnabled">
                                                                    <asp:CheckBox runat="server" ID="chkAutoTableIsReadyPushMessageEnabled" />
                                                                    <label for="<%=chkAutoTableIsReadyPushMessageEnabled.ClientID %>">Also Send as Push Notification</label>


                                                                    <div class="col-md-12 no-padding">
                                                                        <div class="col-md-2 no-padding">
                                                                            <asp:TextBox runat="server" ID="txtAutoTableIsReadySMSBeforeInMin" MaxLength="5" CssClass="form-control numeric"></asp:TextBox>
                                                                        </div>
                                                                        <div class="col-md-8 ">Send N Minutes Prior to Estimated Seat Time</div>
                                                                    </div>
                                                                    <label>From</label>
                                                                    <asp:TextBox runat="server" ID="txtAutoTableIsReadyFrom" MaxLength="255" TextMode="SingleLine" CssClass="form-control"></asp:TextBox>

                                                                    <label>
                                                                        "Table is Ready" Message
                                                                    <img src="Content/img/help.png" data-toggle="modal" data-target="#HintBox" title="Dynamic Tags" />
                                                                    </label>
                                                                    <asp:TextBox runat="server" ID="txtAutoTableIsReadyMessage" MaxLength="255" TextMode="MultiLine" CssClass="form-control" Height="150px"></asp:TextBox>
                                                                </div>
                                                            </div>
                                                            <div class="shadedSingleBlock col-md-12 marginTop">
                                                                <asp:CheckBox runat="server" ID="chkAutoThankYouEnabled" />
                                                                <label for="<%=chkAutoThankYouEnabled.ClientID %>">Send Automated "Thank You" In App Message</label>

                                                                <div id="dvAutoThankYouEnabled">
                                                                    <asp:CheckBox runat="server" ID="chkAutoThankYouPushMessageEnabled" />
                                                                    <label for="<%=chkAutoThankYouPushMessageEnabled.ClientID %>">Also Send as Push Notification</label>


                                                                    <div class="col-md-12 no-padding">
                                                                        <div class="col-md-2 no-padding">
                                                                            <asp:TextBox runat="server" ID="txtAutoThankYouSMSBeforeInMin" MaxLength="5" CssClass="form-control numeric"></asp:TextBox>
                                                                        </div>
                                                                        <div class="col-md-8 ">Send N Minutes after Confirmed Seat Time</div>
                                                                    </div>
                                                                    <label>From</label>
                                                                    <asp:TextBox runat="server" ID="txtAutoThankYouFrom" MaxLength="255" TextMode="SingleLine" CssClass="form-control"></asp:TextBox>

                                                                    <label>
                                                                        "Thank You" Message
                                                                    <img src="Content/img/help.png" data-toggle="modal" data-target="#HintBox" title="Dynamic Tags" />
                                                                    </label>
                                                                    <asp:TextBox runat="server" ID="txtAutoThankYouMessage" MaxLength="255" TextMode="MultiLine" CssClass="form-control" Height="150px"></asp:TextBox>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <!-- Message Location Tab Ends -->

                                                <!-- Message Manual Tab Starts-->
                                                <div class="tab-pane fade" id="MessageManualTab">
                                                    <div class="tab-container clearfix">
                                                        <div class="col-md-12">
                                                            <div class="shadedSingleBlock col-md-12">
                                                                <label>
                                                                    <h4>Table is Available Now - SMS Message</h4>
                                                                </label>
                                                                <label>From</label>
                                                                <asp:TextBox runat="server" ID="txtTableIsReadySMSFrom" MaxLength="255" TextMode="SingleLine" CssClass="form-control"></asp:TextBox>

                                                                <label>
                                                                    Table Ready Message Body
                                                                    <img src="Content/img/help.png" data-toggle="modal" data-target="#HintBox" title="Dynamic Tags" />
                                                                </label>
                                                                <asp:TextBox runat="server" ID="txtTableIsReadySMSMessage" MaxLength="255" TextMode="MultiLine" CssClass="form-control" Height="150px"></asp:TextBox>

                                                                <asp:CheckBox runat="server" ID="chkTableIsReadyPushMessageEnabled" />
                                                                <label for="<%=chkTableIsReadyPushMessageEnabled.ClientID %>">Also Send as a Push Notification</label>
                                                            </div>

                                                            <div class="shadedSingleBlock col-md-12">
                                                                <label>
                                                                    <h4>"Experiencing Minor Delays" SMS Message</h4>
                                                                </label>
                                                                <label>From</label>
                                                                <asp:TextBox runat="server" ID="txtDelayedTextFrom" MaxLength="255" TextMode="SingleLine" CssClass="form-control"></asp:TextBox>

                                                                <label>
                                                                    "Experiencing Minor Delays" Message Body
                                                                    <img src="Content/img/help.png" data-toggle="modal" data-target="#HintBox" title="Dynamic Tags" />
                                                                </label>
                                                                <asp:TextBox runat="server" ID="txtDelayedTextMessage" MaxLength="255" TextMode="MultiLine" CssClass="form-control" Height="150px"></asp:TextBox>

                                                                <asp:CheckBox runat="server" ID="chkDelayedPushMessageEnabled" />
                                                                <label for="<%=chkDelayedPushMessageEnabled.ClientID %>">Also Send as a Push Notification</label>
                                                            </div>

                                                            <div class="shadedSingleBlock col-md-12">
                                                                <label>
                                                                    <h4>Custom SMS Message</h4>
                                                                </label>
                                                                <label>Custom SMS Message Button Label</label>
                                                                <asp:TextBox runat="server" ID="txtCustomSMSButtonlabel" MaxLength="255" TextMode="SingleLine" CssClass="form-control"></asp:TextBox>

                                                                <label>From</label>
                                                                <asp:TextBox runat="server" ID="txtCustomSMSFrom" MaxLength="255" TextMode="SingleLine" CssClass="form-control"></asp:TextBox>

                                                                <label>
                                                                    Custom Message Body
                                                                    <img src="Content/img/help.png" data-toggle="modal" data-target="#HintBox" title="Dynamic Tags" />
                                                                </label>
                                                                <asp:TextBox runat="server" ID="txtCustomSMSMessage" MaxLength="255" TextMode="MultiLine" CssClass="form-control" Height="150px"></asp:TextBox>

                                                                <asp:CheckBox runat="server" ID="chkCustomPushMessageEnabled" />
                                                                <label for="<%=chkCustomPushMessageEnabled.ClientID %>">Also Send as a Push Notification</label>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <!-- Message Manual Tab Ends -->
                                            </div>
                                        </div>
                                    </div>
                                    <!-- Message Tab Ends -->
                                </div>
                        </div>
                    </div>
                    <div class="col-md-12 btnGroup">
                        <div class="btn-groupSpecial clearfix">
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
                            RegisterDatePickersAndTimers();
                            RegisterDetectedFormChanges();
                            RegisterleftDivheight();
                            SetTabControls();
                            RegisterFieldSets();
                            RegisterCheckboxClick();
                            DisabledEnabledCheckbox();
                        }
                    });
                }

                $(document).ready(function () {
                    isNumber();
                    isNumberWithDecimal();
                    RegisterDatePickersAndTimers();
                    RegisterDetectedFormChanges();
                    RegisterleftDivheight();
                    SetTabControls();
                    RegisterFieldSets();
                    RegisterCheckboxClick();
                    DisabledEnabledCheckbox();

                });

                function RegisterleftDivheight() {
                    $("#dvLeftcontentdetail1").height($('#dvRightContent1').height());
                }
                function RegisterCheckboxClick() {
                    $('input:checkbox').on('change', function () {
                        ToggleEnablingDivOnCheckedChange($(this).prop('id'));
                    });
                }

                function ToggleEnablingDivOnCheckedChange(controlId) {
                    var status = $('input:checkbox[id*="' + controlId + '"]').is(':checked');

                    switch (controlId) {
                        case '<%=chkIsLocationRequired.ClientID %>':
                            ResetControls('#dvIsLocationRequired', status);
                            ToggleEnablingDivOnCheckedChange('<%=chkIsForfeitEnabled.ClientID %>');
                            break;
                        case '<%=chkIsForfeitEnabled.ClientID %>':
                            var parentStatus = $('input:checkbox[id*="<%=chkIsLocationRequired.ClientID %>"]').is(':checked');
                            if (parentStatus == false)
                                status = false;
                            ResetControls('#dvIsForfeitEnabled', status);
                            break;

                        case '<%=chkIsAwardAssociated.ClientID %>':
                            ResetControls('#dvIsAwardAssociated', status);
                            ToggleEnablingDivOnCheckedChange('<%=chkIsPushNotificationEnabled.ClientID %>');
                            break;                        
                        case '<%=chkTurnOffNeedMoreTimeEnabled.ClientID %>':
                            ResetControls('#dvTurnOffNeedMoreTimeEnabled', status);
                            break;
                        case '<%=chkAutoTableIsReadySMSEnabled.ClientID %>':
                            ResetControls('#dvAutoTableIsReadySMSEnabled', status);
                            break;
                        case '<%=chkAutoThankYouEnabled.ClientID %>':
                            ResetControls('#dvAutoThankYouEnabled', status);
                            break;
                    }
                }

                function DisabledEnabledCheckbox() {
                    var isLocationRequired = $('#<%=chkIsLocationRequired.ClientID%>')[0].checked;
                    var isForfeitEnabled = $('#<%=chkIsForfeitEnabled.ClientID%>')[0].checked;
                    var isPushNotificationEnabled = $('#<%=chkIsPushNotificationEnabled.ClientID%>')[0].checked;
                    var isAwardAssociated = $('#<%=chkIsAwardAssociated.ClientID%>')[0].checked;
                    var turnOffNeedMoreTimeEnabled = $('#<%=chkTurnOffNeedMoreTimeEnabled.ClientID%>')[0].checked;
                    var autoTableIsReadySmsEnabled = $('#<%=chkAutoTableIsReadySMSEnabled.ClientID%>')[0].checked;
                    var autoThankYouEnabled = $('#<%=chkAutoThankYouEnabled.ClientID%>')[0].checked;

                    ResetControls('#dvIsLocationRequired', isLocationRequired);
                    ResetControls('#dvIsForfeitEnabled', isForfeitEnabled);
                    ResetControls('#dvIsAwardAssociated', isAwardAssociated);                    
                    ResetControls('#dvTurnOffNeedMoreTimeEnabled', turnOffNeedMoreTimeEnabled);
                    ResetControls('#dvAutoTableIsReadySMSEnabled', autoTableIsReadySmsEnabled);
                    ResetControls('#dvAutoThankYouEnabled', autoThankYouEnabled);
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

                function FormValidation() {
                    var activeTab = $('input:hidden[id*="hdnSelectedTab"]').val();

                    if (myTrim($('#<%=txtEventName.ClientID%>').val()) == '') {
                        document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please enter event name';
                        $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                        document.getElementById('<%=txtEventName.ClientID%>').focus();
                        return false;
                    }

                    if ($('#<%=ddlEventVenue.ClientID%> option:selected').val() == '-1') {
                        document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please select venue';
                        $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                        document.getElementById('<%=ddlEventVenue.ClientID%>').focus();
                        return false;
                    }

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

                if (myTrim($('#<%=txtTableReadyMessage.ClientID%>').val()) == '') {
                        document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please enter Confirmation In App Message';
                    $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                    document.getElementById('<%=txtTableReadyMessage.ClientID%>').focus();
                    return false;
                }

                if ($('#<%=chkTurnOffNeedMoreTimeEnabled.ClientID%>')[0].checked == true) {
                        if ($('#<%=txtTurnOffNeedMoreTimeBeforeEventInMin.ClientID%>').val() == '') {
                        document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please enter Minutes Prior to Schedule Event End Time';
                            $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                            document.getElementById('<%=txtTurnOffNeedMoreTimeBeforeEventInMin.ClientID%>').focus();
                            return false;
                        }
                        if ($('#<%=txtTurnOffNeedMoreTimeMessage.ClientID%>').val() == '') {
                        document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please enter Need more time message';
                            $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                            document.getElementById('<%=txtTurnOffNeedMoreTimeMessage.ClientID%>').focus();
                            return false;
                        }
                    }

                    if ($('#<%=chkAutoTableIsReadySMSEnabled.ClientID%>')[0].checked == true) {
                        if ($('#<%=txtAutoTableIsReadySMSBeforeInMin.ClientID%>').val() == '') {
                            document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please enter Minutes Prior to Estimated Seat Time';
                            $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                            document.getElementById('<%=txtAutoTableIsReadySMSBeforeInMin.ClientID%>').focus();
                            return false;
                        }
                        if ($('#<%=txtAutoTableIsReadyMessage.ClientID%>').val() == '') {
                            document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please enter Table is ready message';
                            $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                            document.getElementById('<%=txtAutoTableIsReadyMessage.ClientID%>').focus();
                            return false;
                        }
                    }

                    if ($('#<%=chkAutoThankYouEnabled.ClientID%>')[0].checked == true) {
                        if ($('#<%=txtAutoThankYouSMSBeforeInMin.ClientID%>').val() == '') {
                            document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please enter Minutes after Confirmed Seat Time';
                            $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                            document.getElementById('<%=txtAutoThankYouSMSBeforeInMin.ClientID%>').focus();
                            return false;
                        }
                        if ($('#<%=txtAutoThankYouMessage.ClientID%>').val() == '') {
                            document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please enter Thank You message';
                            $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                            document.getElementById('<%=txtAutoThankYouMessage.ClientID%>').focus();
                            return false;
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
                    var isPermissionDelete = $("#<%=hdnIsPermissionDelete.ClientID %>").val();
                    switch (readTabValue) {
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
                            if ($('#<%=chkIsLocationRequired.ClientID%>')[0].checked == true) {
                                $('div#MessageLocationTab').addClass('active in');
                                $('#liMessageLocationTab').addClass('active in');
                                $('#liMessageLocationTab').removeClass('disabled');
                                $('#AnchorMessageLocationTab').attr("data-toggle", "tab");
                                $('#AnchorMessageLocationTab').attr("href", "#MessageLocationTab");
                                $('div#MessageAutoTab').removeClass('active in');
                                $('#liMessageAutoTab').removeClass('active in');
                                $('#AnchorMessageLocationTab').removeAttr("disabled");
                                $('div#MessageManualTab').removeClass('active in');
                                $('#liMessageManualTab').removeClass('active in');

                            } else {
                                $('div#MessageLocationTab').removeClass('active in');
                                $('#liMessageLocationTab').removeClass('active in');
                                $('#liMessageLocationTab').addClass('disabled');
                                $('#AnchorMessageLocationTab').removeAttr("data-toggle");
                                $('#AnchorMessageLocationTab').removeAttr("href");
                                $('#AnchorMessageLocationTab').removeAttr("onclick");
                                $('div#MessageAutoTab').addClass('active in');
                                $('#liMessageAutoTab').addClass('active in');
                                $('#AnchorMessageLocationTab').attr("disabled", "disabled");
                                $('div#MessageManualTab').removeClass('active in');
                                $('#liMessageManualTab').removeClass('active in');
                            }
                            $("#<%=lnkBtnDelete.ClientID %>").addClass('aspNetDisabled');
                            $("#<%=lnkBtnDelete.ClientID %>").attr("disabled", $("#<%=lnkBtnDelete.ClientID %>"));
                            break;

                        case 'MessageLocationTab':
                            $('div#MessageLocationTab').addClass('active in');
                            $('#liMessageLocationTab').addClass('active in');
                            $('div#MessageAutoTab').removeClass('active in');
                            $('#liMessageAutoTab').removeClass('active in');
                            $('div#MessageManualTab').removeClass('active in');
                            $('#liMessageManualTab').removeClass('active in');
                            $("#<%=lnkBtnDelete.ClientID %>").addClass('aspNetDisabled');
                            $("#<%=lnkBtnDelete.ClientID %>").attr("disabled", $("#<%=lnkBtnDelete.ClientID %>"));
                            break;
                        case 'MessageAutoTab':
                            $('div#MessageLocationTab').removeClass('active in');
                            $('#liMessageLocationTab').removeClass('active in');

                            $('div#MessageAutoTab').addClass('active in');
                            $('#liMessageAutoTab').addClass('active in');

                            $('div#MessageManualTab').removeClass('active in');
                            $('#liMessageManualTab').removeClass('active in');

                            if ($('#<%=chkIsLocationRequired.ClientID%>')[0].checked == true) {
                                $('#liMessageLocationTab').removeClass('disabled');
                                $('#AnchorMessageLocationTab').removeClass('disabled');
                                $('#AnchorMessageLocationTab').attr("data-toggle", "tab");
                                $('#AnchorMessageLocationTab').attr("href", "#MessageLocationTab");
                                $('#AnchorMessageLocationTab').removeAttr("disabled");
                            } else {
                                $('#liMessageLocationTab').addClass('disabled');
                                $('#AnchorMessageLocationTab').addClass('disabled');
                                $('#AnchorMessageLocationTab').removeAttr("data-toggle");
                                $('#AnchorMessageLocationTab').removeAttr("href");
                                $('#AnchorMessageLocationTab').removeAttr("onclick");
                                $('#AnchorMessageLocationTab').attr("disabled", "disabled");
                                $('div#MessageLocationTab').removeClass('active in');
                                $('#liMessageLocationTab').removeClass('active in');
                            }

                            $("#<%=lnkBtnDelete.ClientID %>").addClass('aspNetDisabled');
                            $("#<%=lnkBtnDelete.ClientID %>").attr("disabled", $("#<%=lnkBtnDelete.ClientID %>"));
                            break;
                        case 'MessageManualTab':
                            $('div#MessageLocationTab').removeClass('active in');
                            $('#liMessageLocationTab').removeClass('active in');

                            $('div#MessageAutoTab').removeClass('active in');
                            $('#liMessageAutoTab').removeClass('active in');

                            $('div#MessageManualTab').addClass('active in');
                            $('#liMessageManualTab').addClass('active in');

                            if ($('#<%=chkIsLocationRequired.ClientID%>')[0].checked == true) {
                                $('#liMessageLocationTab').removeClass('disabled');
                                $('#AnchorMessageLocationTab').removeClass('disabled');
                                $('#AnchorMessageLocationTab').attr("data-toggle", "tab");
                                $('#AnchorMessageLocationTab').attr("href", "#MessageLocationTab");
                                $('#AnchorMessageLocationTab').removeAttr("disabled");
                            } else {
                                $('#liMessageLocationTab').addClass('disabled');
                                $('#AnchorMessageLocationTab').addClass('disabled');
                                $('#AnchorMessageLocationTab').removeAttr("data-toggle");
                                $('#AnchorMessageLocationTab').removeAttr("href");
                                $('#AnchorMessageLocationTab').removeAttr("onclick");
                                $('#AnchorMessageLocationTab').attr("disabled", "disabled");
                                $('div#MessageLocationTab').removeClass('active in');
                                $('#liMessageLocationTab').removeClass('active in');
                            }
                            $("#<%=lnkBtnDelete.ClientID %>").addClass('aspNetDisabled');
                            $("#<%=lnkBtnDelete.ClientID %>").attr("disabled", $("#<%=lnkBtnDelete.ClientID %>"));
                            break;
                    }
                    RegisterleftDivheight();
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


                function ConfirmMessageSpeReqNew(flag) {
                    var saveWaitTime = 'Are you sure you would like to save this wait time?';
                    var delWaittime = 'Are you sure you would like to delete this wait time?';
                    var savePartySize = 'Are you sure you would like to save this party size?';
                    var delPartySize = 'Are you sure you would like to delete this party size?';
                    var saveSpeReqMsg = 'Are you sure you would like to save this special request?';
                    var delSpeReqmsg = 'Are you sure you would like to delete this special request?';

                    if (flag == 1) {
                        $('#<%=lnkBtnSaveWaitTime.ClientID%>').show();
                        $('#<%=lnkBtnDeleteWaitTime.ClientID%>').hide();
                        $('#<%=lnkBtnSavePartySize.ClientID%>').hide();
                        $('#<%=lnkBtnDeletePartySize.ClientID%>').hide();
                        $('#<%=lnkBtnSaveSepReq.ClientID%>').hide();
                        $('#<%=lnkBtnDeleteSepReq.ClientID%>').hide();
                        $('#ConfirmBoxMessageGrid').html(saveWaitTime);
                    }
                    else if (flag == 2) {
                        $('#<%=lnkBtnSaveWaitTime.ClientID%>').hide();
                        $('#<%=lnkBtnDeleteWaitTime.ClientID%>').show();
                        $('#<%=lnkBtnSavePartySize.ClientID%>').hide();
                        $('#<%=lnkBtnDeletePartySize.ClientID%>').hide();
                        $('#<%=lnkBtnSaveSepReq.ClientID%>').hide();
                        $('#<%=lnkBtnDeleteSepReq.ClientID%>').hide();
                        $('#ConfirmBoxMessageGrid').html(delWaittime);
                    }
                    else if (flag == 3) {
                        $('#<%=lnkBtnSaveWaitTime.ClientID%>').hide();
                        $('#<%=lnkBtnDeleteWaitTime.ClientID%>').hide();
                        $('#<%=lnkBtnSavePartySize.ClientID%>').show();
                        $('#<%=lnkBtnDeletePartySize.ClientID%>').hide();
                        $('#<%=lnkBtnSaveSepReq.ClientID%>').hide();
                        $('#<%=lnkBtnDeleteSepReq.ClientID%>').hide();
                        $('#ConfirmBoxMessageGrid').html(savePartySize);
                    } else if (flag == 4) {
                        $('#<%=lnkBtnSaveWaitTime.ClientID%>').hide();
                        $('#<%=lnkBtnDeleteWaitTime.ClientID%>').hide();
                        $('#<%=lnkBtnSavePartySize.ClientID%>').hide();
                        $('#<%=lnkBtnDeletePartySize.ClientID%>').show();
                        $('#<%=lnkBtnSaveSepReq.ClientID%>').hide();
                        $('#<%=lnkBtnDeleteSepReq.ClientID%>').hide();
                        $('#ConfirmBoxMessageGrid').html(delPartySize);
                    } else if (flag == 5) {
                        $('#<%=lnkBtnSaveWaitTime.ClientID%>').hide();
                        $('#<%=lnkBtnDeleteWaitTime.ClientID%>').hide();
                        $('#<%=lnkBtnSavePartySize.ClientID%>').hide();
                        $('#<%=lnkBtnDeletePartySize.ClientID%>').hide();
                        $('#<%=lnkBtnSaveSepReq.ClientID%>').show();
                        $('#<%=lnkBtnDeleteSepReq.ClientID%>').hide();
                        $('#ConfirmBoxMessageGrid').html(saveSpeReqMsg);
                    } else if (flag == 6) {
                        $('#<%=lnkBtnSaveWaitTime.ClientID%>').hide();
                        $('#<%=lnkBtnDeleteWaitTime.ClientID%>').hide();
                        $('#<%=lnkBtnSavePartySize.ClientID%>').hide();
                        $('#<%=lnkBtnDeletePartySize.ClientID%>').hide();
                        $('#<%=lnkBtnSaveSepReq.ClientID%>').hide();
                        $('#<%=lnkBtnDeleteSepReq.ClientID%>').show();
                        $('#ConfirmBoxMessageGrid').html(delSpeReqmsg);
                    }

    $('#ConfirmMessageNew').modal({ backdrop: 'static', keyboard: false });
    return false;
                    //return true;
}

function ConfirmMessage(flag) {
    var savemsg = 'Are you sure to save this RapidReserve Event?';
    var cancelmsg = 'Are you sure to discard current changes?';
    var deletemsg = 'Are you sure to delete this RapidReserve Event?';
    var copymsg = 'Are you sure to copy this RapidReserve Event?';
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
                            <h4 class="modal-title">Confirm?</h4>
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
                                    <h4 class="modal-title">Confirm?</h4>
                                </div>
                                <div class="modal-body">
                                    <p id="ConfirmBoxMessageGrid"></p>
                                </div>
                                <div class="modal-footer">
                                    <asp:Button ID="lnkBtnSaveWaitTime" CssClass="btn btn-danger" runat="server" Text="OK" UseSubmitBehavior="false" OnClick="lnkBtnSaveWaitTime_OnClick" data-dismiss="modal" Style="display: none;"></asp:Button>
                                    <asp:Button ID="lnkBtnDeleteWaitTime" CssClass="btn btn-danger" runat="server" Text="OK" UseSubmitBehavior="false" OnClick="lnkBtnDeleteWaitTime_OnClick" data-dismiss="modal" Style="display: none;"></asp:Button>
                                    <asp:Button ID="lnkBtnSavePartySize" CssClass="btn btn-danger" runat="server" Text="OK" UseSubmitBehavior="false" OnClick="lnkBtnSavePartySize_OnClick" data-dismiss="modal" Style="display: none;"></asp:Button>
                                    <asp:Button ID="lnkBtnDeletePartySize" CssClass="btn btn-danger" runat="server" Text="OK" UseSubmitBehavior="false" OnClick="lnkBtnDeletePartySize_OnClick" data-dismiss="modal" Style="display: none;"></asp:Button>
                                    <asp:Button ID="lnkBtnSaveSepReq" CssClass="btn btn-danger" runat="server" Text="OK" UseSubmitBehavior="false" OnClick="lnkBtnSaveSepReq_OnClick" data-dismiss="modal" Style="display: none;"></asp:Button>
                                    <asp:Button ID="lnkBtnDeleteSepReq" CssClass="btn btn-danger" runat="server" Text="OK" UseSubmitBehavior="false" OnClick="lnkBtnDeleteSepReq_OnClick" data-dismiss="modal" Style="display: none;"></asp:Button>
                                    <button type="button" class="btn" id="confirmSepReq" data-dismiss="modal">Cancel</button>
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
