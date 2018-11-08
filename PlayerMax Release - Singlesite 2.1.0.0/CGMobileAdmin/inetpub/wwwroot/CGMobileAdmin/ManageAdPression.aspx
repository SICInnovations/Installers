<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="ManageAdPression.aspx.cs" Inherits="HAMobileWebAdmin.ManageAdPression" %>

<%@ Register Src="~/UserControl/UC_CsvUpload_PopulationListTab_WithOutBarCodeID.ascx" TagPrefix="csv" TagName="UC_CsvUpload_PopulationListTab_WithOutBarCodeID" %>
<%@ Register Src="~/UserControl/UC_PopulationTypeTab.ascx" TagPrefix="listbox" TagName="UC_PopulationTypeTab" %>

<asp:Content runat="server" ID="Content1" ContentPlaceHolderID="HeadContent">
    <title>COG Mobile | Manage adPression</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <link href="Content/css/scroll.css" rel="stylesheet" />
    <link href="Content/css/select2.css" rel="stylesheet" />
    <script src="Scripts/CommonJS/datatables.min.js"></script>
    <script src="Scripts/CommonJS/scroll.js"></script>
    <script src="Scripts/select2.js"></script>

    <asp:UpdatePanel ID="updpnlContentDetail" runat="server" UpdateMode="Conditional">
        <ContentTemplate>
            <div class="row">
                <asp:HiddenField runat="server" ID="hdnadPressionID" Value="" />
                <asp:HiddenField runat="server" ID="hdnActive" Value="Active" />
                <asp:HiddenField runat="server" ID="hdnButtonSatus" Value="Active" />
                <asp:HiddenField runat="server" ID="hdnGvScheduleSelectedIndex" Value="0" />
                <asp:HiddenField runat="server" ID="hdnGvadPressionSelectedIndex" Value="0" />
                <asp:HiddenField runat="server" ID="hdnIsPopulation" Value="False" />
                <asp:HiddenField runat="server" ID="hdnIsShedule" Value="True" />
                <asp:HiddenField runat="server" ID="hdnSelectedTab" Value="contentTab" />
                <asp:HiddenField runat="server" ID="hdnVideoUrl" />
                <asp:HiddenField runat="server" ID="hdnIsActive" />
                <asp:HiddenField runat="server" ID="hdnIsPermissionDelete" Value="1" />
                <div class="col-sm-3">
                    <h5>adPression Event</h5>
                    <div class="filterWrapper relative" id="dvLeftcontentdetail">
                        <div class="clearfix whiteBg">
                            <div class="pull-left">
                                <label>Event</label>
                            </div>
                            <div class="pull-right">
                                <span class="addBtn">Add
                <asp:Button ID="btnAddNewadPression" runat="server" OnClick="btnAddNewadPression_Click" CssClass="btn btn-add pull-right"></asp:Button>
                                </span>
                            </div>
                        </div>
                        <div class="input-group clearfix col-sm-12">
                            <asp:TextBox CssClass="form-control height26" ID="txtSearchName" runat="server"></asp:TextBox>
                            <span class="input-group-btn">
                                <asp:Button ID="btnSearch" runat="server" OnClick="btnSearch_Click" CssClass="btn btn-black glyphicons filter btn-icon white input-group-btnbtnmargin"></asp:Button>
                                <i></i></span>
                        </div>
                        <div class="new-select">
                            <asp:DropDownList runat="server" ID="ddlAdPressionEventTypeFilter" AutoPostBack="true" OnSelectedIndexChanged="ddlAdPressionEventTypeFilter_SelectedIndexChanged" CssClass="form-control jq-selectbox"></asp:DropDownList>
                        </div>
                        <div id="divgv">
                            <asp:GridView CssClass="gridview" ID="gvAdPression" runat="server" ShowHeader="False" AutoGenerateColumns="false"
                                DataKeyNames="AdPressionID" AllowPaging="true" PageSize="12"
                                OnPageIndexChanging="gvadPression_PageIndexChanging">
                                <Columns>

                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <asp:Label ID="lblAdPressionID" runat="server" Visible="false" Text='<%#Eval("AdPressionID") %>' />
                                            <asp:LinkButton ID="lnkBtnAdPressionName" runat="server" Text='<%#Eval("AdPressionName") %>' OnClick="lnkBtnadPressionForm_Click" />


                                        </ItemTemplate>

                                    </asp:TemplateField>
                                </Columns>
                                <SelectedRowStyle CssClass="gvSelectedRow" />
                                <PagerStyle CssClass="gridview-pager"></PagerStyle>


                            </asp:GridView>
                            <div id="content"></div>
                        </div>
                        <div class="filterResults relative btnGroup">
                            <div class="btn-groupSpecial">
                                <asp:Button ID="lnkbtnActiveadPression" OnClick="lnkbtnActiveadPression_Click" runat="server" Text="Active"  CssClass="results-control col-xs-4 active"></asp:Button>
                                <asp:Button ID="lnkbtnInactiveadPression" OnClick="lnkbtnInactiveadPression_Click" runat="server" Text="InActive" CssClass="results-control col-xs-4"></asp:Button>
                                <asp:Button ID="lnkbtnAlladPression" OnClick="lnkbtnAlladPression_Click" runat="server" Text="All" CssClass="results-control col-xs-4" ></asp:Button>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-sm-9">
                    <h5>adPression Event Details</h5>
                    <div class="row clearfix relative btnGroup btnGroup3" id="dvRightContent">
                        <div class="col-md-12 clearfix">
                            <div class="tabControls">
                                <div class="tab-pane">
                                    <ul class="nav nav-tabs">
                                        <li class="active col-xsm-32 nav-tabs-content"><span class="linkDisabledsp">&nbsp;</span><a data-toggle="tab" href="#adPressionEventTab" id="manageContentTabLink" onclick="SetSelectedTab('contentTab')">Event Details</a></li>
                                        <li class="col-xsm-32  nav-tabs-schedule"><span class="linkDisabledsp">&nbsp;</span><a data-toggle="tab" href="#adPressionScheduleTab" id="manageScheduleTabLink" onclick="SetSelectedTab('scheduleTab')">Schedule</a></li>
                                        <li class="col-xsm-32  nav-tabs-population"><span class="linkDisabledsp">&nbsp;</span><a data-toggle="tab" href="#adPressionPopulationTab" id="managePopulationTabLink" onclick="SetSelectedTab('populationTab')">Population</a></li>
                                    </ul>
                                    <div class="tab-content">

                                        <!--adPression Event Tab Starts-->
                                        <div class="tab-pane active fade in" id="adPressionEventTab">
                                            <div class="tab-container clearfix">
                                                <div class="col-md-4">
                                                    <label for="adPressionEvent">adPression Event Name</label>
                                                    <asp:TextBox ID="txtAdPressionName" runat="server" CssClass="form-control" MaxLength="250"></asp:TextBox>

                                                    <!-- schedule tab data starts here -->
                                                    <div id="Scheduled">
                                                        <label for="adPressionEventType">adPression Event Trigger</label>
                                                        <asp:DropDownList runat="server" ID="ddlAdPressionEventType" AutoPostBack="true" OnSelectedIndexChanged="ddlAdPressionEventType_SelectedIndexChanged" CssClass="form-control jq-selectbox"></asp:DropDownList>

                                                        <!-- days casino tab data starts here -->
                                                        <div id="dvDAYSFROMLASTCASINOCARDEDVISIT" class="contenrt_areas">
                                                            <div class="">
                                                                <div class="row">
                                                                    <div class="col-md-12">
                                                                        <label for="adPressionEvent">Days from Last Casino Carded Visit</label>
                                                                        <asp:TextBox ID="txtDaysfromLastCasinoCardedVisit" runat="server" CssClass="form-control numeric" MaxLength="15"></asp:TextBox>
                                                                    </div>

                                                                </div>
                                                            </div>

                                                        </div>
                                                        <!-- days casino tab data ends here -->

                                                        <!--schedule birthday inner conent starts here-->
                                                        <div class="row contenrt_areas " id="dvBIRTHDAY" style="display: none;">
                                                            <div class="col-md-12">
                                                                <div class="row">
                                                                    <div class="col-md-5">
                                                                        <label>N Days Before</label>
                                                                        <asp:TextBox ID="txtBirthdayNDaysBefore" runat="server" CssClass="form-control numeric" MaxLength="5"></asp:TextBox>
                                                                    </div>
                                                                    <div class="col-md-7">
                                                                        <label>At</label>
                                                                        <div class="bootstrap-timepicker input-group">
                                                                            <asp:TextBox ID="txtBirthdayAt" runat="server" CssClass="form-control timePickers"></asp:TextBox>
                                                                            <i class="icon-time"></i>
                                                                        </div>

                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>

                                                        <!--schedule inner conent ends here-->

                                                        <!--schedule anniversary inner conent starts here-->

                                                        <div class="row contenrt_areas" id="dvANNIVERSARY" style="display: none;">
                                                            <div class="col-md-12">
                                                                <div class="row">
                                                                    <div class="col-md-5">
                                                                        <label>N Days Before</label>
                                                                        <asp:TextBox ID="txtAnniversaryNDaysBefore" runat="server" CssClass="form-control numeric" MaxLength="5"></asp:TextBox>
                                                                    </div>
                                                                    <div class="col-md-7">
                                                                        <label>At</label>
                                                                        <div class="bootstrap-timepicker input-group">
                                                                            <asp:TextBox ID="txtAnniversaryAt" runat="server" CssClass="form-control timePickers"></asp:TextBox>
                                                                            <i class="icon-time"></i>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>

                                                        <!--schedule inner conent ends here-->

                                                        <!--schedule anniversary inner conent starts here-->

                                                        <div class="row contenrt_areas" id="dvGEOFENCED" style="display: none;">
                                                            <div class="col-md-12">


                                                                <div>
                                                                    <label for="award2">Geolocation Trigger</label>
                                                                    <asp:DropDownList runat="server" ID="ddlGeofenceTrigger" CssClass="form-control jq-selectbox"></asp:DropDownList>

                                                                </div>
                                                                <div>
                                                                    <label for="award2">Delay Geofence Trigger</label>


                                                                    <div class="row">

                                                                        <div class="col-md-5">
                                                                            <label></label>
                                                                            <asp:RadioButton ID="rdEntryPlusNMin" Checked="true" GroupName="NMinutes" runat="server" />
                                                                            <label for="<%=rdEntryPlusNMin.ClientID %>">Entry +</label>
                                                                        </div>

                                                                        <div class="col-md-4" id="dvEntryPlusNMin">
                                                                            <asp:TextBox runat="server" class="form-control numeric" ID="txtEntryPlusNMin" MaxLength="15"></asp:TextBox>
                                                                        </div>
                                                                        <div class="col-md-2">Minutes</div>
                                                                    </div>
                                                                    <div class="row">
                                                                        <div class="col-md-5">
                                                                            <label></label>
                                                                            <asp:RadioButton runat="server" GroupName="NMinutes" ID="rdExitPlusNMin" />
                                                                            <label for="<%=rdExitPlusNMin.ClientID %>" class="spacing ">Exit +</label>
                                                                        </div>

                                                                        <div class="col-md-4" id="dvExitPlusNMin">
                                                                            <asp:TextBox runat="server" class="form-control numeric" ID="txtExitPlusNMin" MaxLength="15"></asp:TextBox>
                                                                        </div>
                                                                        <div class="col-md-2">Minutes</div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="col-md-12">
                                                                <div class="row">
                                                                    <div class="col-md-12">
                                                                        <label runat="server" id="lblDelayGeofenceTrigger">Enters N Times within the Schedule</label>
                                                                        <asp:TextBox runat="server" class="form-control numeric" ID="txtEntersNTimeswithintheSchedule" MaxLength="15" />
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>

                                                        <!--schedule scheduled inner conent starts here-->

                                                        <div class="row contenrt_areas" id="dvSCHEDULED" style="display: none;">
                                                            <div class="col-md-12">
                                                                <div class="row">
                                                                    <div class="col-md-7">
                                                                        <label>On</label>
                                                                        <div class="input-group date datePickers">
                                                                            <asp:TextBox ID="txtScheduledOn" runat="server" CssClass="form-control datePickers"></asp:TextBox>
                                                                            <span class="input-group-addon"><i class="icon-th"></i></span>
                                                                        </div>
                                                                    </div>
                                                                    <div class="col-md-5">
                                                                        <label>At</label>
                                                                        <div class="bootstrap-timepicker input-group">
                                                                            <asp:TextBox runat="server" class="form-control timePickers" ID="txtScheduledAt"></asp:TextBox>
                                                                            <i class="icon-time"></i>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>

                                                        <!--schedule inner conent ends here-->

                                                        <!-- Non-Usage of Application starts here -->
                                                        <div id="dvNONUSAGEOFAPPLICATION" class="contenrt_areas" style="display: none;">
                                                            <div class="col-md-12">
                                                                <div class="row">

                                                                    <label for="adPressionEvent">Count of days of Non-Usage</label>
                                                                    <asp:TextBox runat="server" class="form-control numeric" ID="txtCountofMinutesofNonUsage" MaxLength="15" />
                                                                </div>
                                                            </div>

                                                        </div>
                                                        <!-- Non-Usage of Application ends here -->

                                                        <!-- Number of Touches in All Sessions starts here -->
                                                        <div id="dvNUMBEROFTOUCHESINALLSESSIONS" class="contenrt_areas" style="display: none;">
                                                            <div class="col-md-12">
                                                                <div class="row">

                                                                    <label for="adPressionEvent">Count of Touches in All Sessions</label>
                                                                    <asp:TextBox runat="server" class="form-control numeric" ID="txtCountofTouchesinAllSessions" MaxLength="15" />
                                                                </div>
                                                            </div>

                                                        </div>
                                                        <!-- Number of Touches in All Sessions ends here -->

                                                        <!-- Number of Touches in Single Session starts here -->
                                                        <div id="dvNUMBEROFTOUCHESINSINGLESESSION" class="contenrt_areas" style="display: none;">
                                                            <div class="col-md-12">
                                                                <div class="row">

                                                                    <label for="adPressionEvent">Count of Touches in Single Session</label>
                                                                    <asp:TextBox runat="server" class="form-control numeric" ID="txtCountofTouchesinSingleSession" MaxLength="15" />
                                                                </div>
                                                            </div>

                                                        </div>
                                                        <!-- Number of Touches in Single Session ends here -->

                                                        <!-- Time Active in Application starts here -->
                                                        <div id="dvTIMEACTIVEINAPPLICATION" class="contenrt_areas" style="display: none;">
                                                            <div class="col-md-12">
                                                                <div class="row">

                                                                    <label for="adPressionEvent">Number of Minutes Active across all Sessions</label>
                                                                    <asp:TextBox runat="server" class="form-control numeric" ID="txtTimeActivenNApplication" MaxLength="15" />
                                                                </div>
                                                            </div>

                                                        </div>
                                                        <!-- Time Active in Application ends here -->
                                                    </div>
                                                    <!-- schedule tab data ends here -->

                                                </div>
                                                <div class="col-md-8">
                                                    <div id="dvMediaAsset">
                                                        <label>Media Asset</label>
                                                        <asp:DropDownList runat="server" ID="ddlAdPressionMediaAsset" AutoPostBack="true" onchange=" RegisterLeftDivheight()" OnSelectedIndexChanged="ddlAdPressionMediaAsset_SelectedIndexChanged" CssClass="form-control jq-selectbox"></asp:DropDownList>

                                                    </div>
                                                    <label>Media Preview</label>
                                                    <video height="300px" width="100%" controls>
                                                        <source src="<%=hdnVideoUrl.Value %>" type="video/mp4">
                                                        Your browser does not support the video tag.
                                                    </video>
                                                </div>
                                                <!-- award and notify section starts here-->
                                                <div class="row clearfix" id="dvAwardNotify">
                                                    <div class="col-md-12">
                                                        <div class="col-md-1">
                                                            <label>&nbsp;</label>
                                                            <asp:CheckBox ID="chkAward" runat="server" Checked="true" Style="display: none" />
                                                            <label for="<%=chkAward.ClientID%>" class="award" style="display: none"></label>
                                                        </div>
                                                        <div class="col-md-11" id="dvAward">
                                                            <label>Award</label>
                                                            <asp:DropDownList runat="server" ID="ddlAdPressionAwardPoints" CssClass="form-control jq-selectbox"></asp:DropDownList>
                                                            </select>
                                                        <div class="row">
                                                            <div class="col-md-12">
                                                                <div class="col-md-4 row">
                                                                    <label>Maximum Triggers per Day</label>
                                                                    <div class="">
                                                                        <asp:TextBox ID="txtMaximumTriggersperDay" MaxLength="5" CssClass="form-control numeric" runat="server" />
                                                                    </div>
                                                                </div>
                                                                <div class="col-md-8 pull-right row">
                                                                    <label>Maximum Frequency of Triggered Awards per Player</label>
                                                                    <div class="row">
                                                                        <div class="col-md-2">
                                                                            <asp:TextBox ID="txtMaximumFrequencyofTriggeredAwardsperPlayer" MaxLength="5" CssClass="form-control numeric" runat="server" />
                                                                        </div>
                                                                        <label class="col-md-2">time every</label>
                                                                        <div class="col-md-2">
                                                                            <asp:TextBox ID="txtTimeEvery" CssClass="form-control numeric" runat="server" MaxLength="5" />
                                                                        </div>
                                                                        <div class="col-md-6">
                                                                            <asp:DropDownList runat="server" ID="ddlAdPressionPeriod" CssClass="form-control jq-selectbox"></asp:DropDownList>

                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        </div>
                                                    </div>
                                                    <!-- notify section starts here -->

                                                    <div class="col-md-12">
                                                        <div class="col-md-1">
                                                            <label>Notify?</label>
                                                            <asp:CheckBox ID="chkNotify" runat="server" Checked="true" />
                                                            <label for="<%=chkNotify.ClientID%>" class="award"></label>
                                                        </div>
                                                        <div class="col-md-11" id="dvNotify">
                                                            <label>Award Notification if Out of App</label>
                                                            <asp:TextBox ID="txtAwardNotificationifOutofApp" MaxLength="250" CssClass="form-control" runat="server" />
                                                            <label>Award Notification if In App</label>
                                                            <asp:TextBox ID="txtAwardNotificationifInApp" MaxLength="250" CssClass="form-control" runat="server" />
                                                        </div>
                                                    </div>
                                                    <!-- notify section ends here -->

                                                </div>
                                            </div>

                                            <!-- award and notify section ends here-->

                                        </div>

                                        <!--adPression Event Tab Ends-->

                                        <!--adPression Schedule Tab Starts-->
                                        <div class="tab-pane fade" id="adPressionScheduleTab">
                                            <asp:Panel runat="server" ID="pnlSchedule">
                                                <div class=" clearfix tab-container">
                                                    <div class="col-md-4">
                                                        <div class="clearfix whiteBg">
                                                            <div class="pull-left">
                                                                <label>Schedule</label>
                                                            </div>
                                                            <div class="pull-right">
                                                                <span class="addBtn">Add
                                    <asp:Button ID="lnkbtnAddSchedule" runat="server" OnClick="btnAddSchedule_Click" CssClass="btn btn-add pull-right input-group-shedulebtnbtnmargin"></asp:Button>
                                                                </span>
                                                            </div>
                                                        </div>
                                                        <div class="input-group">
                                                            <asp:TextBox runat="server" ID="txtScheduleSearch" CssClass="form-control height26" MaxLength="250" />
                                                            <span class="input-group-btn">
                                                                <asp:Button ID="btnSearchSchedule" OnClick="btnContentScheduleSearch_OnClick" CssClass="btn btn-black glyphicons filter btn-icon white filtericonwidth" runat="server" /><i></i>
                                                            </span>
                                                        </div>
                                                        <div class="filterWrapper filterWrapper2 relative schedulegridheight">
                                                            <div>
                                                                <div id="div57">
                                                                    <asp:GridView CssClass="gridview" ID="gvSchedules" DataKeyNames="EventScheduleID" runat="server" ShowHeader="False" AutoGenerateColumns="false"
                                                                        AllowPaging="true" PageSize="12" OnPageIndexChanging="gvAdPressionSchedule_PageIndexChanging">
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
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-8">
                                                        <label for="adscheduleName">Schedule Name</label>
                                                        <asp:TextBox ID="txtScheduleName" runat="server" CssClass="form-control" MaxLength="250"></asp:TextBox>
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
                                                                        <tr class="trmonday">
                                                                            <td>
                                                                                <asp:CheckBox Text="Monday" runat="server" ID="chkMonday" />
                                                                                <%--<input type="checkbox" id="adscheduleMonday"><label for="adscheduleMonday">Monday</label>--%>
                                                                            </td>
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
                                                                                <%--<input type="checkbox" id="adscheduleTues"><label for="adscheduleTues">Tuesday</label>--%>
                                                                            </td>
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
                                                                                <%--<input type="checkbox" id="adscheduleWed"><label for="adscheduleWed">Wednesday</label>--%>
                                                                            </td>
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
                                                                                <%--<input type="checkbox" id="adscheduleThus"><label for="adscheduleThus">Thursday</label>--%>
                                                                            </td>
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
                                                                                <%--<input type="checkbox" id="adscheduleFri"><label for="adscheduleFri">Friday</label>--%>
                                                                            </td>
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
                                                                                <%--<input type="checkbox" id="adscheduleSat"><label for="adscheduleSat">Saturday</label>--%>
                                                                            </td>
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
                                                                                <%--<input type="checkbox" id="adscheduleSun"><label for="adscheduleSun">Sunday</label>--%>
                                                                            </td>
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
                                                <asp:HiddenField runat="server" ID="hdnScheduleId" Value="0" />
                                            </asp:Panel>
                                        </div>
                                        <!--adPression Schedule Tab Ends-->

                                        <!--adPression Population Tab Starts-->
                                        <div class="tab-pane fade" id="adPressionPopulationTab">
                                            <div class="tabbable tabs-left">
                                                <ul class="nav nav-tabs">
                                                    <li class="col-xsm-2 active nav-tabs-population" id="liTiers"><a data-toggle="tab" href="#adPressionPopulationTiersTab" onclick="SetSelectedTab('populationTiersTab')">Tiers</a></li>
                                                    <li class="col-xsm-2 list" id="liList"><a data-toggle="tab" href="#adPressionPopulationListTab" onclick="SetSelectedTab('populationListTab')">List</a></li>
                                                </ul>
                                                <div class="tab-content">

                                                    <!--adPression Population Tiers Tab Starts-->
                                                    <div class="tab-pane fade in active nav-tabs-population" id="adPressionPopulationTiersTab">
                                                        <listbox:UC_PopulationTypeTab runat="server" ID="UC_PopulationTypeTab" />
                                                    </div>
                                                    <!--adPression Population Tiers Tab Ends-->

                                                    <!--adPression Population List Tab Starts-->
                                                    <div class="tab-pane fade" id="adPressionPopulationListTab">
                                                        <csv:UC_CsvUpload_PopulationListTab_WithOutBarCodeID runat="server" ID="UC_CsvUpload_PopulationListTab_WithOutBarCodeID" />
                                                    </div>
                                                    <!--adPression Population List Tab Ends-->
                                                </div>
                                            </div>
                                        </div>
                                        <!--adPression Population Tab Ends-->
                                    </div>
                            </div></div>
                            <div class="col-md-12 btnGroup2">
                                <div class="btn-groupSpecial clearfix">
                                    <asp:Button ID="lnkbtnSave" runat="server" Text="Save" OnClientClick="return FormValidation();" CssClass="results-control col-xsm-32" OnClick="lnkbtnSave_Click"></asp:Button>
                                    <asp:Button ID="lnkbtnCancel" runat="server" OnClientClick=" return ConfirmMessage(2);" OnClick="lnkbtnCancel_Click" Text="Cancel" CssClass="results-control col-xsm-32"></asp:Button>
                                    <asp:Button ID="lnkbtnDelete" runat="server" OnClientClick=" return ConfirmMessage(3);" OnClick="lnkbtnDelete_Click" Text="Delete" CssClass="results-control col-xsm-32"></asp:Button>

                                </div>
                            </div>
                        </div>

                    </div>
                </div>
            </div>
            <script type="text/javascript">
                //***************************************Start On UpdatePanel Refresh Register ImageUpload/Common Functions ********************************************************8

                var prm = Sys.WebForms.PageRequestManager.getInstance();
                if (prm != null) {
                    prm.add_endRequest(function (sender, e) {
                        if (sender._postBackSettings.panelsToUpdate != null) {

                            RegisterDateAndTimePickers();
                            SetDefaultTab();
                            SetActiveTab();
                            RegisterAdPressionEventDiv();
                            DisabledEnabledCheckbox();
                            RegisterCheckboxClick();
                            RegisterFieldSets();
                            RegisterDisabledTypeListBox();
                            RegisterLeftDivheight();
                            isNumber();
                            RegisterDetectedFormChanges();
                        }
                    });
                };

                ///**************************************End On UpdatePanel Refresh Register ImageUpload/Common Functions******************************************
                ////*************************************************Start Page load functionality.***********************************

                $(document).ready(function () {

                    SetDefaultTab();
                    RegisterDateAndTimePickers();
                    RegisterAdPressionEventDiv();
                    DisabledEnabledCheckbox();
                    RegisterCheckboxClick();
                    RegisterFieldSets();
                    RegisterDisabledTypeListBox();
                    RegisterLeftDivheight();
                    isNumber();
                    RegisterDetectedFormChanges();
                });
                function RegisterModel() {
                    $('#ConfirmBox').on('show.bs.modal', function (e) {
                    });
                }
                //Set Left content height.
                function RegisterLeftDivheight() {
                    $("#dvLeftcontentdetail").height($('#dvRightContent').height());
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
                function SetDefaultTab() {
                    $('.nav-tabs li').removeClass('active');
                    $('.nav-tabs li.nav-tabs-content').addClass('active');
                    $('.tab-content .tab-pane').removeClass('active in');
                    $('#adPressionEventTab').addClass('active in');

                }


                function RegisterCheckboxClick() {
                    $('input:checkbox').on('change', function () {
                        ToggleEnablingDivOnCheckedChange($(this).prop('id'));
                    });
                    $('#<%=rdExitPlusNMin.ClientID%>').on('change', function () {
                        $('#dvEntryPlusNMin').find('input:text').prop('disabled', true)
                        $('#dvExitPlusNMin').find('input:text').prop('disabled', false)
                        $('#<%=txtExitPlusNMin.ClientID%>').removeClass('aspNetDisabled');
                        $('#dvEntryPlusNMin').find('input:text').val("");
                        $('#<%=lblDelayGeofenceTrigger.ClientID%>').text("Exits N times within the schedule");
                    });
                    $('#<%=rdEntryPlusNMin.ClientID%>').on('change', function () {
                        $('#dvEntryPlusNMin').find('input:text').prop('disabled', false)
                        $('#dvExitPlusNMin').find('input:text').prop('disabled', true)
                        $('#<%=txtEntryPlusNMin.ClientID%>').removeClass('aspNetDisabled');
                        $('#dvExitPlusNMin').find('input:text').val("");
                        $('#<%=lblDelayGeofenceTrigger.ClientID%>').text("Enters N Times within the Schedule");

                    });
                }

                function DisabledEnabledCheckbox() {
                    var isAward = $('#<%=chkAward.ClientID%>')[0].checked;
                    var isNotify = $('#<%=chkNotify.ClientID%>')[0].checked;
                    var isEntryPlusNMin = $('#<%=rdEntryPlusNMin.ClientID%>')[0].checked;
                    var isExitPlusNMin = $('#<%=rdExitPlusNMin.ClientID%>')[0].checked;
                    if (isExitPlusNMin == true)
                        $('#<%=lblDelayGeofenceTrigger.ClientID%>').text("Exits N times within the schedule");
                    ResetControls('#dvEntryPlusNMin', isEntryPlusNMin);
                    ResetControls('#dvExitPlusNMin', isExitPlusNMin);
                    ResetControls('#dvAward', isAward);
                    ResetControls('#dvNotify', isNotify);

                }

                function ToggleEnablingDivOnCheckedChange(controlId) {
                    var status = $('input:checkbox[id*="' + controlId + '"]').is(':checked');
                    switch (controlId) {
                        case '<%=chkAward.ClientID %>':
                            ResetControls('#dvAward', status);
                            break;
                        case '<%=chkNotify.ClientID %>':
                            ResetControls('#dvNotify', status);
                            break;

                    }
                }
                function ResetControls(divId, status) {
                    $(divId).find('input:text,select').prop('disabled', !status);
                    $(divId).find('input:checkbox').prop('disabled', !status);
                }
                function SetSelectedTab(selectedTab) {
                    var selected = selectedTab;
                    $('#<%=hdnSelectedTab.ClientID%>').val(selectedTab);
                    SetActiveTab();
                }
                function SetActiveTab()
                {
                    var rowscount = $("#<%=gvAdPression.ClientID %> tr").length;
                    var activeTab = $('input:hidden[id*="hdnSelectedTab"]').val();
                    var isTab = $("#<%=hdnButtonSatus.ClientID %>").val();
                    var isPermissionDelete = $("#<%=hdnIsPermissionDelete.ClientID %>").val();
                    switch (activeTab) {
                        case 'contentTab':
                            $('.nav-tabs li').removeClass('active');
                            $('.nav-tabs li.nav-tabs-content').addClass('active');
                            $('.tab-content .tab-pane').removeClass('active in');
                            $('#adPressionEventTab').addClass('active in');
                            if (isTab == "InActive" || isTab == "All") {
                                $("#<%=lnkbtnDelete.ClientID %>").addClass('aspNetDisabled');
                                $("#<%=lnkbtnDelete.ClientID %>").addClass('disabled');
                            }
                            else {
                                if (rowscount > 0 && isPermissionDelete == 1) {
                                    $("#<%=lnkbtnDelete.ClientID %>").removeClass('aspNetDisabled');
                                    $("#<%=lnkbtnDelete.ClientID %>").removeAttr("disabled");
                                }
                            }
                            break;
                        case 'scheduleTab':

                            $('.nav-tabs li').removeClass('active');
                            $('.nav-tabs li.nav-tabs-schedule').addClass('active');
                            $('.tab-content .tab-pane').removeClass('active in');
                            $('#adPressionScheduleTab').addClass('active in');
                            $("#<%=lnkbtnDelete.ClientID %>").addClass('aspNetDisabled');
                            $("#<%=lnkbtnDelete.ClientID %>").attr("disabled", $("#<%=lnkbtnDelete.ClientID %>"));
                            break;
                        case 'populationTab':
                            $('.nav-tabs li').removeClass('active');
                            $('.nav-tabs li.nav-tabs-population').addClass('active');
                            $('.tab-content .tab-pane').removeClass('active in');
                            $('div#adPressionPopulationListTab').removeClass('active');
                            $('div#adPressionPopulationTiersTab').addClass('active in');
                            $('div#adPressionPopulationTab').addClass('active in');
                            $("#<%=lnkbtnDelete.ClientID %>").addClass('aspNetDisabled');
                            $("#<%=lnkbtnDelete.ClientID %>").attr("disabled", $("#<%=lnkbtnDelete.ClientID %>"));

                            break;
                        case 'populationTiersTab':
                            $('.nav-tabs li').removeClass('active');
                            $('.nav-tabs li.nav-tabs-population').addClass('active in');
                            $('.tab-content .tab-pane').removeClass('active in');
                            $('div#adPressionPopulationListTab').removeClass('active');
                            $('div#adPressionPopulationTiersTab').addClass('active in');
                            $('div#adPressionPopulationTab').addClass('active in');
                            $('li#liTiers').addClass('active in');
                            $('li#liList').removeClass('active in');
                            $("#<%=lnkbtnDelete.ClientID %>").addClass('aspNetDisabled');
                            $("#<%=lnkbtnDelete.ClientID %>").attr("disabled", $("#<%=lnkbtnDelete.ClientID %>"));
                            break;
                        case 'populationListTab':
                            $('.nav-tabs li').removeClass('active');
                            $('.nav-tabs li.nav-tabs-population').addClass('active');
                            $('.tab-content .tab-pane').removeClass('active in');
                            $('div#adPressionPopulationTiersTab').removeClass('active');
                            $('div#adPressionPopulationListTab').addClass('active in');
                            $('div#adPressionPopulationTab').addClass('active in');
                            $('li#liTiers').removeClass('active in');
                            $('li#liList').addClass('active in');
                            $("#<%=lnkbtnDelete.ClientID %>").addClass('aspNetDisabled');
                            $("#<%=lnkbtnDelete.ClientID %>").attr("disabled", $("#<%=lnkbtnDelete.ClientID %>"));
                            break;
                    }
                    RegisterLeftDivheight();
                }
                function RegisterAdPressionEventDiv()
                {

                    var divid = $('#<%=ddlAdPressionEventType.ClientID%> option:selected').val();
                    $('.contenrt_areas').hide();

                    switch (divid) {
                        case AdPressionTriggerTypeConstants.NONUSAGEOFAPPLICATION:
                            $('#dvNONUSAGEOFAPPLICATION').show();
                            break;
                        case AdPressionTriggerTypeConstants.NUMBEROFTOUCHESINALLSESSIONS:
                            $('#dvNUMBEROFTOUCHESINALLSESSIONS').show();
                            break;
                        case AdPressionTriggerTypeConstants.NUMBEROFTOUCHESINSINGLESESSION:
                            $('#dvNUMBEROFTOUCHESINSINGLESESSION').show();
                            break;
                        case AdPressionTriggerTypeConstants.TIMEACTIVEINAPPLICATION:
                            $('#dvTIMEACTIVEINAPPLICATION').show();
                            break;
                        case AdPressionTriggerTypeConstants.DAYSFROMLASTCASINOCARDEDVISIT:
                            $('#dvDAYSFROMLASTCASINOCARDEDVISIT').show();
                            break;
                        case AdPressionTriggerTypeConstants.BIRTHDAY:
                            $('#dvBIRTHDAY').show();
                            break;
                        case AdPressionTriggerTypeConstants.ANNIVERSARY:
                            $('#dvANNIVERSARY').show();
                            break;
                        case AdPressionTriggerTypeConstants.SCHEDULED:
                            $('#dvSCHEDULED').show();
                            $('#manageScheduleTab').removeClass('active in');
                            $('#<%=hdnIsShedule.ClientID%>').val('false');
                            //$('.nav-tabs-schedule').addClass('linkDisabled');

                            break;
                        case AdPressionTriggerTypeConstants.GEOFENCED:
                            $('#dvGEOFENCED').show();
                            break;
                    }
                    //Onchange
                    $('#<%=ddlAdPressionEventType.ClientID%>').change(function () {

                        var divid = $('#<%=ddlAdPressionEventType.ClientID%> option:selected').val();
                        $('.contenrt_areas').hide();
                        switch (divid) {

                            case AdPressionTriggerTypeConstants.NONUSAGEOFAPPLICATION:
                                $('#dvNONUSAGEOFAPPLICATION').show();
                                break;
                            case AdPressionTriggerTypeConstants.NUMBEROFTOUCHESINALLSESSIONS:
                                $('#dvNUMBEROFTOUCHESINALLSESSIONS').show();
                                break;
                            case AdPressionTriggerTypeConstants.NUMBEROFTOUCHESINSINGLESESSION:
                                $('#dvNUMBEROFTOUCHESINSINGLESESSION').show();
                                break;
                            case AdPressionTriggerTypeConstants.TIMEACTIVEINAPPLICATION:
                                $('#dvTIMEACTIVEINAPPLICATION').show();
                                break;
                            case AdPressionTriggerTypeConstants.DAYSFROMLASTCASINOCARDEDVISIT:
                                $('#dvDAYSFROMLASTCASINOCARDEDVISIT').show();
                                break;
                            case AdPressionTriggerTypeConstants.BIRTHDAY:
                                $('#dvBIRTHDAY').show();
                                break;
                            case AdPressionTriggerTypeConstants.ANNIVERSARY:
                                $('#dvANNIVERSARY').show();
                                break;
                            case AdPressionTriggerTypeConstants.SCHEDULED:
                                $('#dvSCHEDULED').show();
                                break;
                            case AdPressionTriggerTypeConstants.GEOFENCED:
                                $('#dvGEOFENCED').show();
                                break;
                        }
                    });
                }
                function FormValidation() {

                    var triggerTypeval = myTrim($('#<%=ddlAdPressionEventType.ClientID%> option:selected').val());
                    var activeTab = $('input:hidden[id*="hdnSelectedTab"]').val();

                    if (myTrim($('#<%=txtAdPressionName.ClientID%>').val()) == '') {
                        document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please enter adPression name';
                        $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                        document.getElementById('<%=txtAdPressionName.ClientID%>').focus();
                        return false;
                    }
                    if ($('#<%=ddlAdPressionEventType.ClientID%> option:selected').val() == '-1') {
                        document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please select adPression event trigger ';
                        $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                        document.getElementById('<%=ddlAdPressionEventType.ClientID%>').focus();
                         return false;
                     }
                     if ($('#<%=txtCountofMinutesofNonUsage.ClientID%>').val() == '' && triggerTypeval == "2") {
                        document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please enter count of days of non-usage of APP';
                        $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                        document.getElementById('<%=txtCountofMinutesofNonUsage.ClientID%>').focus();
                        return false;
                    }
                    if ($('#<%=txtCountofTouchesinAllSessions.ClientID%>').val() == '' && triggerTypeval == "3") {
                        document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please enter count of touches in all sessions';
                        $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                        document.getElementById('<%=txtCountofTouchesinAllSessions.ClientID%>').focus();
                        return false;
                    }
                    if ($('#<%=txtCountofTouchesinSingleSession.ClientID%>').val() == '' && triggerTypeval == "4") {
                        document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please enter count of touches in single session';
                        $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                        document.getElementById('<%=txtCountofTouchesinSingleSession.ClientID%>').focus();
                        return false;
                    }
                    if ($('#<%=txtTimeActivenNApplication.ClientID%>').val() == '' && triggerTypeval == "6") {
                        document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please enter number of minutes active across all sessions';
                        $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                        document.getElementById('<%=txtTimeActivenNApplication.ClientID%>').focus();
                        return false;
                    }
                    if ($('#<%=txtDaysfromLastCasinoCardedVisit.ClientID%>').val() == '' && triggerTypeval == "7") {
                        document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please enter days from last casino carded visit';
                        $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                        document.getElementById('<%=txtDaysfromLastCasinoCardedVisit.ClientID%>').focus();
                        return false;
                    }
                    if (triggerTypeval == "9") {
                        if ($('#<%=txtAnniversaryNDaysBefore.ClientID%>').val() == '') {
                            document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please enter  n days before';
                            $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                            document.getElementById('<%=txtAnniversaryNDaysBefore.ClientID%>').focus();
                            return false;
                        }
                        if ($('#<%=txtAnniversaryAt.ClientID%>').val() == '') {
                            document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please enter time';
                            $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                            document.getElementById('<%=txtAnniversaryAt.ClientID%>').focus();
                            return false;
                        }
                    }
                    if (triggerTypeval == "8") {
                        if ($('#<%=txtBirthdayNDaysBefore.ClientID%>').val() == '') {
                            document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please enter n days before';
                            $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                            document.getElementById('<%=txtBirthdayNDaysBefore.ClientID%>').focus();
                            return false;
                        }
                        if ($('#<%=txtBirthdayAt.ClientID%>').val() == '') {
                            document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please enter time';
                            $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                            document.getElementById('<%=txtBirthdayAt.ClientID%>').focus();
                            return false;
                        }
                    }
                    if (triggerTypeval == "10")
                    {
                        if ($('#<%=txtScheduledOn.ClientID%>').val() == '') {
                            document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please enter date';
                            $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                            document.getElementById('<%=txtScheduledOn.ClientID%>').focus();
                            return false;
                        }
                        if ($('#<%=txtScheduledAt.ClientID%>').val() == '') {
                            document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please enter time';
                            $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                            document.getElementById('<%=txtScheduledAt.ClientID%>').focus();
                            return false;
                        }
                    }
                    if (triggerTypeval == "11") {
                        if ($('#<%=ddlGeofenceTrigger.ClientID%> option:selected').val() == '-1') {
                            document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please select geolocation trigger';
                            $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                            document.getElementById('<%=ddlGeofenceTrigger.ClientID%>').focus();
                            return false;
                        }
                        if ($('#<%=rdEntryPlusNMin.ClientID%>')[0].checked && $('#<%=txtEntryPlusNMin.ClientID%>').val() == '') {
                            document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please enter entry plus n minutes';
                            $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                            document.getElementById('<%=txtEntryPlusNMin.ClientID%>').focus();
                            return false;
                        }
                        if ($('#<%=rdExitPlusNMin.ClientID%>')[0].checked && $('#<%=txtExitPlusNMin.ClientID%>').val() == '') {
                            document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please enter exit plus n minutes';
                            $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                            document.getElementById('<%=txtExitPlusNMin.ClientID%>').focus();
                            return false;
                        }
                        if (!$('#<%=rdEntryPlusNMin.ClientID%>')[0].checked && !$('#<%=rdExitPlusNMin.ClientID%>')[0].checked) {
                            document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please select delay geofence trigger';
                            $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                            return false;
                        }
                        if ($('#<%=txtEntersNTimeswithintheSchedule.ClientID%>').val() == '') {
                            document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please enter n times within the schedule';
                            $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                            document.getElementById('<%=txtEntersNTimeswithintheSchedule.ClientID%>').focus();
                            return false;
                        }
                    }
                    if ($('#<%=chkAward.ClientID%>')[0].checked == true) {

                        if ($('#<%=ddlAdPressionAwardPoints.ClientID%> option:selected').val() == '-1') {
                            document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please select award';
                            $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                            document.getElementById('<%=ddlAdPressionAwardPoints.ClientID%>').focus();
                            return false;
                        }
                        if ($('#<%=txtMaximumTriggersperDay.ClientID%>').val() == '') {
                            document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please enter maximum triggers per day';
                            $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                            document.getElementById('<%=txtMaximumTriggersperDay.ClientID%>').focus();
                            return false;
                        }
                        if ($('#<%=txtMaximumFrequencyofTriggeredAwardsperPlayer.ClientID%>').val() == '') {
                            document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please enter maximum frequency of triggered awards per player';
                            $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                            document.getElementById('<%=txtMaximumFrequencyofTriggeredAwardsperPlayer.ClientID%>').focus();
                            return false;
                        }
                        if ($('#<%=txtTimeEvery.ClientID%>').val() == '') {
                            document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please enter time every';
                            $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                            document.getElementById('<%=txtTimeEvery.ClientID%>').focus();
                            return false;
                        }
                        if ($('#<%=ddlAdPressionPeriod.ClientID%> option:selected').val() == '-1') {
                            document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please select period';
                            $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                            document.getElementById('<%=ddlAdPressionPeriod.ClientID%>').focus();
                            return false;
                        }
                    }
                    if ($('#<%=chkNotify.ClientID%>')[0].checked == true) {
                        if ($('#<%=txtAwardNotificationifOutofApp.ClientID%>').val() == '') {
                            document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please enter award notification if out of app?';
                            $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                            document.getElementById('<%=txtAwardNotificationifOutofApp.ClientID%>').focus();
                            return false;
                        }
                        if ($('#<%=txtAwardNotificationifInApp.ClientID%>').val() == '') {
                            document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please enter award notification if in app';
                            $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                            document.getElementById('<%=txtAwardNotificationifInApp.ClientID%>').focus();
                            return false;
                        }
                    }
                    //Schedule
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
                var validation = ConfirmMessage(1);
                if (validation == false) {
                    return false;
                }
                else {
                    return true;
                }
            }
            function ConfirmMessage(flag) {
                var savemsg = 'Are you sure to save this adPression?';
                var cancelmsg = 'Are you sure to discard current changes?';
                var deletemsg = 'Are you sure to delete this adPression?';
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
                    //RegisterModel();
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
                    //RegisterModel();
                    return false;

                }
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
        function RegisterDetectedFormChanges() {
            $.each($("input:text"), function (index, element) {
                element.defaultValue = $(element).val();
            });
        }

        function RegisterFieldSets() {

            if ($('.fieldset legend input[type="checkbox"]').is(':checked')) {
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
                if ($('.fieldset legend input[type="checkbox"]').is(':checked')) {
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


            <div style="text-align: center;">
                <asp:UpdateProgress ID="updateProgress" runat="server">
                    <ProgressTemplate>
                        <div style="position: fixed; text-align: center; height: 100%; width: 100%; top: 0; right: 0; left: 0; z-index: 9999999; background-color: #000000; opacity: 0.7;">
                            <asp:Image ID="imgUpdateProgress" runat="server" ImageUrl="Content/img/loader.gif" AlternateText="Loading ..." ToolTip="Loading ..." Style="padding: 10px; position: fixed; top: 45%; left: 50%;" />
                        </div>
                    </ProgressTemplate>

                </asp:UpdateProgress>
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
                            <asp:Button ID="btnConfirmedSave" CssClass="btn btn-danger" runat="server" Text="OK" UseSubmitBehavior="false" data-dismiss="modal" OnClick="lnkbtnSave_Click" Style="display: none;"></asp:Button>
                            <asp:Button ID="btnConfirmedCancel" CssClass="btn btn-danger" runat="server" Text="OK" UseSubmitBehavior="false" data-dismiss="modal" OnClick="lnkbtnCancel_Click" Style="display: none;"></asp:Button>
                            <asp:Button ID="btnConfirmedDelete" CssClass="btn btn-danger" runat="server" Text="OK" UseSubmitBehavior="false" data-dismiss="modal" OnClick="lnkbtnDelete_Click" Style="display: none;"></asp:Button>
                            <asp:Button ID="btnConfirmedActive" CssClass="btn btn-danger" runat="server" Text="OK" UseSubmitBehavior="false" data-dismiss="modal" OnClick="lnkbtnActiveadPression_Click" Style="display: none;"></asp:Button>
                            <asp:Button ID="btnConfirmedInActive" CssClass="btn btn-danger" runat="server" Text="OK" UseSubmitBehavior="false" data-dismiss="modal" OnClick="lnkbtnInactiveadPression_Click" Style="display: none;"></asp:Button>
                            <asp:Button ID="btnConfirmedAll" CssClass="btn btn-danger" runat="server" Text="OK" UseSubmitBehavior="false" data-dismiss="modal" OnClick="lnkbtnAlladPression_Click" Style="display: none;"></asp:Button>
                            <button type="button" class="btn" id="confirm" data-dismiss="modal">Cancel</button>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Dialog show event handler -->
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
