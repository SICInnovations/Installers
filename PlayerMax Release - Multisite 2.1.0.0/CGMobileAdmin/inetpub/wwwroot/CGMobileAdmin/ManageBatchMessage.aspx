<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="ManageBatchMessage.aspx.cs" Inherits="HAMobileWebAdmin.ManageBatchMessage" EnableEventValidation="false" %>

<%@ Register Src="~/UserControl/ImageUploadControl.ascx" TagPrefix="img" TagName="ImageUploadControl" %>
<%@ Register Src="~/UserControl/UC_CsvUpload_PopulationListTab.ascx" TagPrefix="csv" TagName="UC_CsvUpload_PopulationListTab" %>
<%@ Register Src="~/UserControl/UC_PopulationTypeTab.ascx" TagPrefix="listbox" TagName="UC_PopulationTypeTab" %>

<asp:Content runat="server" ID="Content1" ContentPlaceHolderID="HeadContent">
    <title>COG Mobile | Manage Batch Message</title>
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
    <asp:UpdatePanel ID="updpnlContentDetail" runat="server" UpdateMode="Conditional">
        <ContentTemplate>
            <div class="row">
                <asp:HiddenField runat="server" ID="hdnBatchMessageID" Value="" />
                <asp:HiddenField runat="server" ID="hdnFileID" Value="" />
                <asp:HiddenField runat="server" ID="hdnActive" Value="Active" />
                <asp:HiddenField runat="server" ID="hdnGvBatchMessageSelectedIndex" Value="0" />
                <asp:HiddenField runat="server" ID="hdnIsPopulation" Value="False" />
                <asp:HiddenField runat="server" ID="hdnIsShedule" Value="True" />
                <asp:HiddenField runat="server" ID="hdnSelectedTab" Value="contentTab" />
                <asp:HiddenField runat="server" ID="hdnIsImageUpdated" Value="0" />
                <asp:HiddenField runat="server" ID="hdnButtonSatus" Value="Active" />
                <asp:HiddenField runat="server" ID="hdnBatchMessageScheduleID" Value="" />
                <asp:HiddenField runat="server" ID="hdnBatchMessagePopulationID" Value="" />
                <asp:HiddenField runat="server" ID="hdnGeofenceIds" Value="" />
                <asp:HiddenField runat="server" ID="hdnGvScheduleSelectedIndex" Value="0" />
                <asp:HiddenField runat="server" ID="hdnIsActive" Value="true" />
                <asp:HiddenField runat="server" ID="hdnDectedGeofenceChange" Value="0" />
                <asp:HiddenField runat="server" ID="hdnIsPermissionDelete" Value="1" />
                <asp:HiddenField runat="server" ID="hdnAdGroups" Value="" />
                <div class="col-sm-3">
                    <h5>Batch Messages</h5>
                    <div class="filterWrapper relative" id="dvLeftcontentdetail1">
                        <div class="clearfix ">
                            <div class="pull-left">
                                <label>Messages</label>
                            </div>
                            <div class="pull-right">
                                <span class="addBtn">Add
                                <asp:Button ID="btnAddNewMessage" runat="server" CssClass="btn btn-add pull-right" OnClick="btnAddNewMessage_Click"></asp:Button>
                                </span>
                            </div>
                        </div>
                        <div class="input-group clearfix col-sm-12">
                            <asp:TextBox CssClass="form-control height26" ID="txtSearchName" runat="server"  MaxLength="250"></asp:TextBox>
                            <span class="input-group-btn">
                                <asp:Button ID="btnSearch" runat="server" CssClass="btn btn-black glyphicons filter btn-icon white input-group-btnbtnmargin" OnClick="btnSearch_Click"></asp:Button>
                                <i></i></span>
                        </div>
                        <div id="divgv">
                            <asp:GridView CssClass="gridview" ID="gvBatchMessage" runat="server" DataKeyNames="BatchMessageID" PageSize="14"
                                OnPageIndexChanging="gvBatchMessage_PageIndexChanging" ShowHeader="False" AutoGenerateColumns="false" AllowPaging="true" >
                                <Columns>
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <asp:Label ID="lblID" runat="server" Visible="false" Text='<%#Eval("BatchMessageID") %>' />
                                            <asp:LinkButton ID="lnkBtnShowContentDetail" runat="server" Text='<%#Eval("MessageFrom") %>' CommandName="Select" OnClick="lnkBtnMessageForm_Click" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                                <PagerStyle CssClass="gridview-pager"></PagerStyle>
                                <SelectedRowStyle CssClass="gvSelectedRow" />
                            </asp:GridView>
                            <div id="content"></div>
                        </div>
                        <div class="filterResults relative btnGroup">
                            <div class="btn-groupSpecial">
                                <asp:Button ID="lnkbtnActiveMessage" runat="server" Text="Active" OnClientClick="return ConfirmMessage(4); " CssClass="results-control col-xs-4 active" OnClick="lnkbtnActiveMessage_Click"></asp:Button>
                                <asp:Button ID="lnkbtnInactiveMessage" runat="server" Text="InActive" OnClientClick="return ConfirmMessage(5);" CssClass="results-control col-xs-4" OnClick="lnkbtnInactiveMessage_Click"></asp:Button>
                                <asp:Button ID="lnkbtnAllMessage" runat="server" Text="All" CssClass="results-control col-xs-4" OnClientClick="return ConfirmMessage(6);" OnClick="lnkbtnAllMessage_Click"></asp:Button>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-sm-9">
                    <h5>Message Detail</h5>
                    <div class="row clearfix relative btnGroup btnGroup3 " id="dvRightContent1">
                        <div class="col-md-12 clearfix">
                            <div class="tabControls">
                                <ul class="nav nav-tabs">
                                    <li class="active col-xsm-25 nav-tabs-property"><span class="linkDisabledsp">&nbsp;</span><a onclick="SetSelectedTab('propertyTabLink');" data-toggle="tab" href="#propertyTabLink">Property</a></li>
                                    <li class="col-xsm-25 nav-tabs-content"><span class="linkDisabledsp">&nbsp;</span><a data-toggle="tab" href="#manageContentTab" onclick="SetSelectedTab('contentTab')">Message Content</a></li>
                                    <li class="col-xsm-25  nav-tabs-schedule"><span class="linkDisabledsp">&nbsp;</span><a data-toggle="tab" href="#manageScheduleTab" id="manageScheduleTabLink" onclick="SetSelectedTab('scheduleTab')">Message Schedule</a></li>
                                    <li class="col-xsm-25  nav-tabs-population"><span class="linkDisabledsp">&nbsp;</span><a data-toggle="tab" href="#managePopulationTab" id="managePopulationTabLink" onclick="SetSelectedTab('populationTab')">Population</a></li>
                                </ul>
                                <div class="tab-content">
                                    <!--Property Tab Starts-->
                                    <div class="tab-pane fade in" id="propertyTabLink">
                                        <div class="tab-container clearfix">
                                            <div class="col-md-12">
                                                <div class="row" id="dvTabLbl">
                                                    <div class="col-md-4 top-margin-one">
                                                        <label>Define Assigned Properties</label>
                                                    </div>
                                                </div>
                                                <div class="row" id="dvAllProperties">
                                                    <div class="col-md-4 top-margin-one">
                                                        <asp:CheckBox ID="chkAllProperties" Text="All Properties" AutoPostBack="true" ClientIDMode="Static" OnCheckedChanged="chkAllProperties_AllPropertiesChanged" Visible="True" runat="server" />
                                                    </div>
                                                </div>
                                                <div class="row" id="dvSelectPropertiesLbl">
                                                    <div class="col-md-8 top-margin-one">
                                                        <label for="lblStartScreen_plainTextUrl">Define Excluded/Included Properties</label>
                                                        <asp:ListBox ID="lstProperties" SelectionMode="Multiple" runat="server" CssClass="permissionBox"></asp:ListBox>
                                                        <asp:HiddenField runat="server" ID="hdnSelectedProperties" Value="0" />
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <!--Property Tab Ends-->
                                    <!--Content Tab Starts-->
                                    <div class="tab-pane active fade in" id="manageContentTab">
                                        <div class="tab-container clearfix">
                                            <div class="col-md-12 html-editor-spacing">
                                                <div class="row">
                                                    <div class="col-md-12">
                                                        <label for="contentItem">Message Sender</label>
                                                        <asp:TextBox ID="txtMessageForm" class="form-control" runat="server"  MaxLength="50"/>
                                                    </div>
                                                </div>

                                                <!--HTML Text Starts-->
                                                <label>Message Body</label>                                            
                                                 <asp:TextBox TextMode="MultiLine" CssClass="form-control" runat="server" ID="txtMessageBody" MaxLength="1000"  height="150px" Width="100%"></asp:TextBox>
                                            </div>
                                            <!--HTML Text Ends-->

                                            <div class="meassge-seg clearfix">
                                                <div class="pull-left col-md-5 three-column">
                                                    <label>Message Image<br />(Upload Image 636 x 740 Pixels)</label>
                                                    <img:ImageUploadControl runat="server" ID="UploadMessageImage" />
                                                </div>
                                                <div class="pull-right  col-sm-7  col-xs-12">
                                                    <div class="form-group">
                                                        <div class="row">
                                                            <div class="pull-left col-sm-5">
                                                                <div class="row">
                                                                    <div class="pull-left col-md-2">
                                                                        <asp:CheckBox ID="chkMessageAward" runat="server" />
                                                                        <label class="award" for="<%=chkMessageAward.ClientID %>"></label>
                                                                    </div>
                                                                    <div class="pull-left col-md-10">
                                                                        <b>Associate Award Upon
                                                                            <br />
                                                                            Being Read</b>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="pull-right col-sm-7">
                                                                <div class="row" id="dvMessageAward">
                                                                    <div class="col-md-12">
                                                                        <asp:DropDownList runat="server" ID="ddlMessageAward" CssClass="form-control jq-selectbox">
                                                                        </asp:DropDownList>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <div class="row">
                                                            <div class="pull-left col-sm-5">
                                                                <div class="row">
                                                                    <div class="pull-left col-md-2">
                                                                        <asp:CheckBox ID="chkMessagePushNotificationEnabled" runat="server" />
                                                                        <label class="award" for="<%=chkMessagePushNotificationEnabled.ClientID %>"></label>
                                                                    </div>
                                                                    <div class="pull-left col-md-10">
                                                                        <b>Send Push Notification with
                                                                            <br />
                                                                            In App Message</b>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="pull-right col-sm-7">
                                                                <div class="row">
                                                                    <div class="col-md-12 warning">
                                                                        Note: The push notification will send only the text from the Message Body, it will NOT include Barcode or Award information.
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <!-- event triger section starts here -->

                                                    <div class="event_triger col-md-12" >
                                                        <div class="event-rigger-header clearfix">
                                                            <div class="pull-left">
                                                                <asp:CheckBox ID="chkEventTrigger" runat="server" />
                                                                <label class="award" for="<%=chkEventTrigger.ClientID %>"></label>
                                                            </div>
                                                            <div class="pull-left"><b>Event Trigger</b> </div>
                                                        </div>
                                                        <div id="dvEventType">
                                                            <div class="row">
                                                                <div class="col-md-5">
                                                                    <label>Trigger Message Based On</label>
                                                                    <asp:DropDownList runat="server" OnSelectedIndexChanged="ddlTriggerType_SelectedIndexChanged" AutoPostBack="false" ID="ddlTriggerType" CssClass="form-control jq-selectbox">
                                                                    </asp:DropDownList>
                                                                </div>
                                                        <div  class="col-md-7 pull-right dvOffsetGeofenceTrigger " style="display: none">
                                                                    <div>
                                                                        <label>Offset Geofence Trigger</label>
                                                                        <div class="pull-left col-md-12">
                                                                        <div class="row" >
                                                                                <div class="col-md-8">
                                                                                <div class="row" >
                                                                                     <label ></label>
                                                                                        <asp:RadioButton ID="rdEntryPlusNMin" Checked="true" GroupName="NMinutes" runat="server" />
                                                                                        <label for="<%=rdEntryPlusNMin.ClientID %>">Entry +N Minutes</label>
                                                                                    </div>
                                                                                </div>
                                                                                <div class="pull-right col-md-4" id="dvEntryPlusNMin">
                                                                                <asp:TextBox runat="server" class="form-control numeric" ID="txtEntryPlusNMin"  MaxLength="5"></asp:TextBox>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                        <div class="pull-left col-md-12">
                                                                        <div class="row" >
                                                                            <div class="col-md-8">
                                                                                <div class="row">
                                                                                    <asp:RadioButton runat="server"  GroupName="NMinutes" ID="rdExitPlusNMin" />
                                                                                    <label for="<%=rdExitPlusNMin.ClientID %>" class="spacing">Exit +N Minutes</label>
                                                                                </div>
                                                                            </div>
                                                                            <div class="pull-right col-md-4" id="dvExitPlusNMin">
                                                                                <asp:TextBox runat="server" class="form-control numeric" ID="txtExitPlusNMin"  MaxLength="5"></asp:TextBox>
                                                                            </div>
                                                                        </div>
                                                                        
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div id="dvBIRTHDAY" class="box" style="display: none;">
                                                                <div class="row">
                                                                    <div class="col-md-6">
                                                                        <div class="row">
                                                                            <div class="col-md-6">
                                                                                <label>N Days Before</label>
                                                                            <asp:TextBox runat="server" class="form-control numeric" ID="txtBirthdayTriggerBeforeDays"  MaxLength="5" />
                                                                            </div>
                                                                            <div class="col-md-6">
                                                                                <label>At</label>
                                                                                <div class="bootstrap-timepicker input-group">
                                                                                    <asp:TextBox runat="server" class="form-control timePickers" ID="txtBirthdayTriggerTime" />
                                                                                    <i class="icon-time"></i>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <!-- aniversary section -->
                                                            <div id="dvANNIVERSARY" class="box" style="display: none;">
                                                                <div class="col-md-6">
                                                                    <div class="row">
                                                                        <div class="col-md-6">
                                                                            <label>N Days Before</label>
                                                                        <asp:TextBox runat="server" class="form-control numeric" ID="txtAnniversaryTriggerBeforeDays" MaxLength="5"/>
                                                                        </div>
                                                                        <div class="col-md-6">
                                                                            <label>At</label>
                                                                            <div class="bootstrap-timepicker input-group">
                                                                                <asp:TextBox runat="server" class="form-control timePickers" ID="txtAnniversaryTriggerTime"></asp:TextBox>
                                                                                <i class="icon-time"></i>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <!-- geofence section -->
                                                            <div class="clearfix"></div>
                                                            <div id="dvGEOFENCE" class="box" style="display: none;">
                                                                <div class="row">
                                                                    <div class="col-md-5 mt10">
                                                                        <label>Select one or more </label>
                                                                        <label>Geolocation</label>
                                                                        <asp:DropDownList runat="server" ID="ddlGeofence" multiple="multiple" name="data[]" CssClass="form-control " onchange="RegisterGetGeolocation()">
                                                                        </asp:DropDownList>
                                                                    </div>
                                                                    <div class="col-md-7">
                                                                        <label runat="server" id="lblDelayGeofenceTrigger">Enters N Times within the Schedule</label>
                                                                    <asp:TextBox runat="server" class="form-control numeric" ID="txtTriggerPerNEntry"   MaxLength="5"/>
                                                                </div>
                                                            </div>
                                                            <div class="row">
                                                                <div class="col-md-11">
                                                                    <div class="row">
                                                                        <div class="col-md-12">
                                                                            <label>Maximum Frequency of Triggered Awards per Player</label>
                                                                            <div class="row">
                                                                                <div class="pull-left col-md-2">
                                                                                    <asp:TextBox runat="server" ID="txtMaxTriggerPerFrequency" class="form-control numeric"    MaxLength="5"/>
                                                                                </div>
                                                                                <div class="pull-left col-md-5">
                                                                                    <div class="pull-left col-md-5">
                                                                                        <label class="row">time every </label>
                                                                                    </div>
                                                                                    <div class="pull-left col-md-4">
                                                                                        <div class="row">
                                                                                            <asp:TextBox runat="server" ID="txtFrequency" class="form-control numeric"  MaxLength="5"/>
                                                                                        </div>
                                                                                    </div>
                                                                                </div>
                                                                                <div class="col-md-5">
                                                                                    <div class="row">
                                                                                        <asp:DropDownList runat="server" ID="ddlFrequency" CssClass="form-control jq-selectbox"> </asp:DropDownList>

                                                                                        </div>
                                                                                    </div>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        
                                                            <div id="dvDATETIME" class="box" style="display: none;">
                                                                <div class="col-md-12">
                                                                    <div class="row">
                                                                        <div class="col-md-4">
                                                                            <div class="row">
                                                                                <label>Date</label>
                                                                                <div class="input-group date datePickers" data-date-format="mm-dd-yyyy">
                                                                                    <asp:TextBox runat="server" ID="txtDateTimeTriggerDate" class="form-control datePickers"></asp:TextBox>
                                                                                    <span class="input-group-addon" id="adscheduleFrom1"><i class="icon-th"></i></span>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                        <div class="col-md-6">
                                                                            <label>At</label>
                                                                            <div class="bootstrap-timepicker input-group">
                                                                                <asp:TextBox runat="server" ID="txtDateTimeTriggerTime" class="form-control timePickers"></asp:TextBox>

                                                                                <i class="icon-time"></i>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                        </div>
                                                        <!-- event triger section ends here -->
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <!--Content Tab Ends-->

                                    <!--Schedule Tab Starts-->
                                    <div class="tab-pane fade" id="manageScheduleTab">
                                        <div class=" clearfix tab-container">
                                            <div class="col-md-4">
                                                <div class=" clearfix whiteBg">
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
                                                    <asp:TextBox runat="server" ID="txtScheduleSearch"  CssClass="form-control height26" />
                                                    <span class="input-group-btn">
                                                        <asp:Button ID="btnContentScheduleSearch" OnClick="btnContentScheduleSearch_OnClick" CssClass="btn btn-black glyphicons filter btn-icon white BatchMessagebtnmarginwidth" runat="server" />
                                                        <i></i></span>
                                                </div>
                                                <div class="filterWrapper filterWrapper2 relative schedulegridheight batchMesage">
                                                    <div class="filterResults0">
                                                        <div id="div62">
                                                                   <asp:GridView CssClass="gridview" DataKeyNames="BatchMessageScheduleID" ID="gvSchedules" runat="server" ShowHeader="False" AutoGenerateColumns="false"
                                                                    AllowPaging="true"  PageSize="12"  OnPageIndexChanging="gvBatchMessageSchedule_PageIndexChanging">
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
                                                            <div id="Div63"></div>
                                                        </div>
                                                    </div>
                                                </div>

                                            </div>
                                            <div class="col-md-8">
                                                <label for="adscheduleName">Schedule Name</label>
                                                <asp:TextBox ID="txtScheduleName" runat="server" CssClass="form-control"  MaxLength="250"></asp:TextBox>
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

                                    </div>
                                    <!-- Schedule Tab Ends-->

                                    <!--Population Tab Starts-->
                                    <div class="tab-pane fade" id="managePopulationTab">
                                        <div class="">
                                            <div class="tabbable tabs-left">
                                                <ul class="nav nav-tabs">
                                                    <li id="liTiers" class="active col-xsm-2"><a data-toggle="tab" href="#populationTiersTab" onclick="SetSelectedTab('populationTiersTab')">Tiers</a></li>
                                                    <li id="liList" class="col-xsm-2"><a data-toggle="tab" href="#populationListTab" onclick="SetSelectedTab('populationListTab')">List</a></li>
                                                </ul>
                                                <div class="tab-content">
                                                    <div id="populationTiersTab" class="tab-pane fade in active" style="padding-bottom: 50px;">
                                                        <listbox:UC_PopulationTypeTab runat="server" ID="UC_PopulationTypeTab" />
                                                    </div>
                                                    <div id="populationListTab" class="tab-pane fade">
                                                        <csv:UC_CsvUpload_PopulationListTab runat="server" ID="UC_CsvUpload_PopulationListTab" />
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <!--Population Tab Ends-->
                            </div>  <div class="col-md-12 btnGroup2">
                                <div class="btn-groupSpecial clearfix">
                                    <asp:Button ID="lnkbtnSave" OnClientClick="return FormValidation(); " runat="server" OnClick="lnkbtnSave_Click" Text="Save" CssClass="results-control col-xsm-32"></asp:Button>
                                    <asp:Button ID="lnkbtnCancel" runat="server" OnClientClick=" return ConfirmMessage(2);" OnClick="lnkbtnCancel_Click" Text="Cancel" CssClass="results-control col-xsm-32"></asp:Button>
                                    <asp:Button ID="lnkbtnDelete" runat="server" OnClientClick=" return ConfirmMessage(3);" OnClick="lnkbtnDelete_Click" Text="Delete" CssClass="results-control col-xsm-32"></asp:Button>
                                </div>
                            </div>
                        </div>

                    </div>
                </div>
            </div>
            <asp:HiddenField ID="hndSelectedTab" runat="server" />
            <script type="text/javascript">
                Sys.WebForms.PageRequestManager.getInstance().add_endRequest(EndRequestHandler);
                function EndRequestHandler(sender, args) {
                    if (args.get_error() != undefined) {
                        args.set_errorHandled(true);
                    }
                }
            </script>

            <script>
                //***************************************Start On UpdatePanel Refresh Register ImageUpload/Common Functions ********************************************************8

                var prm = Sys.WebForms.PageRequestManager.getInstance();
                if (prm != null) {
                    prm.add_endRequest(function (sender, e) {
                        if (sender._postBackSettings.panelsToUpdate != null) {
                            RegisterDateAndTimePickers();
                            RegisterUploadControls();
                            RegisterleftDivheight();
                            RegisterEventTriggerType();
                            SetActiveTab();
                            RegisterCheckboxClick();
                            RegisterFieldSets();
                            RegisterDisabledTypeListBox();
                            DisabledEnabledCheckbox();
                            isNumber();

                            GetGeofence();
                            RegisterDetectedFormChanges();

                            var hndSelectedTab = $('#<%=hndSelectedTab.ClientID%>').val();

                            if (hndSelectedTab != "") {
                                SetDefaultTab();
                            }
                        }
                    });
                };

                ///**************************************End On UpdatePanel Refresh Register ImageUpload/Common Functions******************************************
                ////*************************************************Start Page load functionality.***********************************

                $(document).ready(function () {
                    RegisterDateAndTimePickers();
                    RegisterUploadControls();
                    RegisterleftDivheight();
                    RegisterEventTriggerType();
                    SetActiveTab();
                    RegisterCheckboxClick();
                    RegisterDisabledTypeListBox();
                    RegisterFieldSets();
                    DisabledEnabledCheckbox();
                    isNumber();
                    GetGeofence();
                    RegisterDetectedFormChanges();
                    SetDefaultTab();
                });

                function SetDefaultTab() {
                  
                    $('.nav-tabs li').removeClass('active');
                    $('.nav-tabs li.nav-tabs-property').addClass('active');
                    $('.tab-content .tab-pane').removeClass('active in');
                    $('#propertyTabLink').addClass('active in');
                    RegisterleftDivheight();
                }
                function DisableAndResetListBox() {
                    if ($("#chkAllProperties").prop('checked')) {
                        $('#dvSelectPropertiesLbl').find('select, button, input:text').prop('disabled', true);
                    }
                    else {
                        $('#dvSelectPropertiesLbl').find('select, button, input:text').prop('disabled', false);
                    }
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
                    var isAward = $('#<%=chkMessageAward.ClientID%>')[0].checked;
                    var isEventTrigger = $('#<%=chkEventTrigger.ClientID%>')[0].checked;
                    var isEntryPlusNMin = $('#<%=rdEntryPlusNMin.ClientID%>')[0].checked;
                    var isExitPlusNMin = $('#<%=rdExitPlusNMin.ClientID%>')[0].checked;
                    if (isExitPlusNMin == true)
                        $('#<%=lblDelayGeofenceTrigger.ClientID%>').text("Exits N times within the schedule");
                    ResetControls('#dvMessageAward', isAward);
                    ResetControls('#dvEventType', isEventTrigger);
                    ResetControls('#dvEntryPlusNMin', isEntryPlusNMin);
                    ResetControls('#dvExitPlusNMin', isExitPlusNMin);

                }

                function ToggleEnablingDivOnCheckedChange(controlId) {
                    var status = $('input:checkbox[id*="' + controlId + '"]').is(':checked');
                    switch (controlId) {
                        case '<%=chkMessageAward.ClientID %>':
                            ResetControls('#dvMessageAward', status);
                            break;
                        case '<%=chkEventTrigger.ClientID %>':
                            ResetControls('#dvEventType', status);
                            break;
                    }
                }
                function ResetControls(divId, status) {
                    $(divId).find('input:text,select').prop('disabled', !status);
                    $(divId).find('input:checkbox').prop('disabled', !status);
                }
                function RegisterEventTriggerType() {
                    $('#<%=ddlTriggerType.ClientID%>').change(function () {

                        var divid = $('#<%=ddlTriggerType.ClientID%> option:selected').val();
                        $('.box').hide();
                        $('.dvOffsetGeofenceTrigger').hide();
                        switch (divid) {
                            case BatchMessageTriggerTypeConstants.BIRTHDAY:
                                $('#<%=hdnIsShedule.ClientID%>').val('true');
                                $('#dvBIRTHDAY').show();
                                break;
                            case BatchMessageTriggerTypeConstants.ANNIVERSARY:
                                $('#<%=hdnIsShedule.ClientID%>').val('true');
                                $('#dvANNIVERSARY').show();
                                break;
                            case BatchMessageTriggerTypeConstants.DATETIME:
                                $('#<%=hdnIsShedule.ClientID%>').val('false');
                                $('#dvDATETIME').show();
                                break;
                            case BatchMessageTriggerTypeConstants.GEOFENCE:
                                $('#<%=hdnIsShedule.ClientID%>').val('true');
                                $('.dvOffsetGeofenceTrigger').show();
                                $('#dvGEOFENCE').show();
                                break;
                            case BatchMessageTriggerTypeConstants.NOW:
                                $('#<%=hdnIsShedule.ClientID%>').val('false');
                                $('#dvNOW').show();
                                break;
                        }
                        RegisterleftDivheight();

                    });

                    var divid = $('#<%=ddlTriggerType.ClientID%> option:selected').val();
                    $('.box').hide();
                    $('.dvOffsetGeofenceTrigger').hide();
                    switch (divid) {
                        case BatchMessageTriggerTypeConstants.BIRTHDAY:
                            $('#<%=hdnIsShedule.ClientID%>').val('true');
                            $('#dvBIRTHDAY').show();
                            break;
                        case BatchMessageTriggerTypeConstants.ANNIVERSARY:
                            $('#<%=hdnIsShedule.ClientID%>').val('true');
                            $('#dvANNIVERSARY').show();
                            break;
                        case BatchMessageTriggerTypeConstants.DATETIME:
                            $('#<%=hdnIsShedule.ClientID%>').val('false');
                            $('#dvDATETIME').show();
                            break;
                        case BatchMessageTriggerTypeConstants.GEOFENCE:
                            $('#<%=hdnIsShedule.ClientID%>').val('true');
                            $('.dvOffsetGeofenceTrigger').show();
                            $('#dvGEOFENCE').show();
                            break;
                        case BatchMessageTriggerTypeConstants.NOW:
                            $('#<%=hdnIsShedule.ClientID%>').val('false');
                            $('#dvNOW').show();
                            break;
                    }
                }
                function myTrim(x) {
                    return x.replace(/\s/g, '').replace('-', '');
                }

                //Upload Image
                function RegisterUploadControls() {
                    $('.UploadButton1').each(function () {
                        var mainDiv = $(this).parent().parent();
                        var hdnImageUrl = $(mainDiv).find('input:hidden[id*="hdnImageUrl"]');
                        var hdnSetImageUrl = $(mainDiv).find('input:hidden[id*="hdnSetDefaultImageUrl"]');
                        var imgImageUrl = $(this).parent().parent().find('img[id*="imgImageUrl"]');
                        UploadControlHandler($(this), $(hdnImageUrl).prop('id'), $(imgImageUrl).prop('id'), $(hdnSetImageUrl).prop('id'));
                    });
                }
                function UploadControlHandler(control, ImageUrlHf, ImageUrlImg, ImageSetUrlImg) {

                    new AjaxUpload('#' + $(control).prop('id') + '', {
                        action: 'FileUpload.ashx',
                        onComplete: function (file, response) {
                            var res = response.split('-');
                            var img = new Image();
                            img.src = res[2];

                            setTimeout(function () {
                                if (img.height > 740) {
                                    document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'File height should not exceed 740.';
                                    $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                                }
                                else if (img.width > 636) {
                                    document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'File width should not exceed 636.';
                                      $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                                  }
                                  else {
                                      $('#' + ImageUrlHf).val(response);
                                      $('#' + ImageUrlImg).attr('src', res[2]);
                                      $('#' + ImageSetUrlImg).val(res[2]);
                                  }
                                $('#<%=hdnIsImageUpdated.ClientID%>').val('1');

                            }, 100);

                        },
                        onSubmit: function (file, ext) {

                            if (!(ext && /^(jpg|png|jpeg|gif)$/.test(ext))) {
                                document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Invalid File Format.';
                                $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                                return false;
                            }

                        }
                    });
                }


                function SetSelectedTab(selectedTab) {
                    var selected = selectedTab;
                    $('#<%=hdnSelectedTab.ClientID%>').val(selectedTab);
                    SetActiveTab();
                    RegisterleftDivheight();
                }
                function SetActiveTab() {
                    var activeTab = $('input:hidden[id*="hdnSelectedTab"]').val();

                    var isTab = $("#<%=hdnButtonSatus.ClientID %>").val();
                    var rowscount = $("#<%=gvBatchMessage.ClientID %> tr").length;
                    var isPermissionDelete = $("#<%=hdnIsPermissionDelete.ClientID %>").val();
                    switch (activeTab) {
                        case 'propertyTabLink':
                            $('.nav-tabs li').removeClass('active');
                            $('.nav-tabs li.nav-tabs-property').addClass('active');
                            $('.tab-content .tab-pane').removeClass('active in');
                            $('#propertyTabLink').addClass('active in');
                            $('li#liTiers').addClass('active in');
                            RegisterleftDivheight();
                            break;
                        case 'contentTab':
                            $('.nav-tabs li').removeClass('active');
                            $('.nav-tabs li.nav-tabs-content').addClass('active');
                            $('.tab-content .tab-pane').removeClass('active in');
                            $('#manageContentTab').addClass('active in');
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
                            RegisterleftDivheight();
                            break;
                        case 'scheduleTab':

                            $('.nav-tabs li').removeClass('active');
                            $('.nav-tabs li.nav-tabs-schedule').addClass('active');
                            $('.tab-content .tab-pane').removeClass('active in');
                            $('#manageScheduleTab').addClass('active in');
                            $("#<%=lnkbtnDelete.ClientID %>").addClass('aspNetDisabled');
                            $("#<%=lnkbtnDelete.ClientID %>").attr("disabled", $("#<%=lnkbtnDelete.ClientID %>"));
                            RegisterleftDivheight();
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
                            $("#<%=lnkbtnDelete.ClientID %>").addClass('aspNetDisabled');
                            $("#<%=lnkbtnDelete.ClientID %>").attr("disabled", $("#<%=lnkbtnDelete.ClientID %>"));
                            RegisterleftDivheight();
                            break;
                        case 'populationTiersTab':
                            $('.nav-tabs li').removeClass('active');
                            $('.nav-tabs li.nav-tabs-population').addClass('active in');
                            $('.tab-content .tab-pane').removeClass('active in');
                            $('div#populationListTab').removeClass('active');
                            $('div#populationTiersTab').addClass('active in');
                            $('div#managePopulationTab').addClass('active in');
                            $('li#liTiers').addClass('active in');
                            $("#<%=lnkbtnDelete.ClientID %>").addClass('aspNetDisabled');
                            $("#<%=lnkbtnDelete.ClientID %>").attr("disabled", $("#<%=lnkbtnDelete.ClientID %>"));
                            RegisterleftDivheight();
                            break;
                        case 'populationListTab':
                            $('.nav-tabs li').removeClass('active');
                            $('.nav-tabs li.nav-tabs-population').addClass('active');
                            $('.tab-content .tab-pane').removeClass('active in');
                            $('div#populationTiersTab').removeClass('active');
                            $('div#populationListTab').addClass('active in');
                            $('div#managePopulationTab').addClass('active in');
                            $('li#liList').addClass('active');
                            RegisterleftDivheight();
                            break;
                            $("#<%=lnkbtnDelete.ClientID %>").addClass('aspNetDisabled');
                            $("#<%=lnkbtnDelete.ClientID %>").attr("disabled", $("#<%=lnkbtnDelete.ClientID %>"));
                    }
                    var value = $('#<%=ddlTriggerType.ClientID%> option:selected').text();
                    $('#<%=hdnIsShedule.ClientID%>').val('true');
                    if (myTrim(value) == 'DateTime' || myTrim(value) == 'Now') {

                        $('#manageScheduleTab').removeClass('active in');
                        $('#<%=hdnIsShedule.ClientID%>').val('false');
                        $('.nav-tabs-schedule').addClass('linkDisabled');

                    }
                    RegisterleftDivheight();

                }

                //  Area list box
                function RegisterListBox() {
                    //$("#dvLeftcontentdetail").height($('#dvRightContent').height());
                    var permissionBox = $('.permissionBox').bootstrapDualListbox({
                        nonselectedlistlabel: 'Exclude',
                        selectedlistlabel: 'Include',
                        preserveselectiononmove: 'moved',
                        moveonselect: false,
                        hdnControlId: 'hdnSelectedProperties'
                    });
                }

                //Set Left content height.
                function RegisterleftDivheight() {

                    $("#dvLeftcontentdetail1").height(($('#dvRightContent1').height()));

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

                    var selectedItem = '';
                    var triggerTypeVal = myTrim($('#<%=ddlTriggerType.ClientID%> option:selected').val());
                    var activeTab = $('input:hidden[id*="hdnSelectedTab"]').val();

                    if (myTrim($('#<%=txtMessageForm.ClientID%>').val()) == '') {
                        document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please enter message sender';
                        $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                        document.getElementById('<%=txtMessageForm.ClientID%>').focus();
                        return false;
                    }

                    if ($('#MainContent_UploadMessageImage_hdnImageUrl').val() != '' && $('#MainContent_UC_CsvUpload_PopulationListTab_hdnBarCodeID').val() != '') {

                        if ($('#<%=hdnIsImageUpdated.ClientID%>').val() == '1')
                            document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'If you attach a BarCodeID, then an Image may not be uploaded.';
                        else
                            document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'If you attach an Image, then a BarCodeID may not be uploaded.';
                        $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                        return false;
                    }
                    if ($('#<%=chkMessageAward.ClientID%>')[0].checked == true) {
                        if ($('#<%=ddlMessageAward.ClientID%> option:selected').val() == "-1") {
                            document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please select associate award upon being read';
                            $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                            document.getElementById('<%=ddlMessageAward.ClientID%>').focus();
                            return false;
                        }
                    }
                    if ($('#<%=ddlTriggerType.ClientID%> option:selected').val() == "-1") {
                        document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please select trigger message based on';
                        $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                        document.getElementById('<%=ddlTriggerType.ClientID%>').focus();
                        return false;
                    }
                    if ($('#<%=chkEventTrigger.ClientID%>')[0].checked == false) {
                        document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please select event trigger';
                        $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                        document.getElementById('<%=chkEventTrigger.ClientID%>').focus();
                        return false;
                    }
                    if (triggerTypeVal == "2") {
                        if ($('#<%=txtAnniversaryTriggerBeforeDays.ClientID%>').val() == '') {
                            document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please enter  n days before';
                            $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                            document.getElementById('<%=txtAnniversaryTriggerBeforeDays.ClientID%>').focus();
                            return false;
                        }
                        if ($('#<%=txtAnniversaryTriggerTime.ClientID%>').val() == '') {
                            document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please enter time';
                            $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                            document.getElementById('<%=txtAnniversaryTriggerTime.ClientID%>').focus();
                            return false;
                        }
                    }
                    if (triggerTypeVal == "1") {
                        if ($('#<%=txtBirthdayTriggerBeforeDays.ClientID%>').val() == '') {
                            document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please enter n days before';
                            $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                            document.getElementById('<%=txtBirthdayTriggerBeforeDays.ClientID%>').focus();
                            return false;
                        }
                        if ($('#<%=txtBirthdayTriggerTime.ClientID%>').val() == '') {
                            document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please enter time';
                            $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                            document.getElementById('<%=txtBirthdayTriggerTime.ClientID%>').focus();
                            return false;
                        }
                    }
                    if (triggerTypeVal == "4") {
                        if ($('#<%=txtDateTimeTriggerDate.ClientID%>').val() == '') {
                            document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please enter date';
                            $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                            document.getElementById('<%=txtDateTimeTriggerDate.ClientID%>').focus();
                            return false;
                        }
                        if ($('#<%=txtDateTimeTriggerTime.ClientID%>').val() == '') {
                            document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please enter time';
                            $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                            document.getElementById('<%=txtDateTimeTriggerTime.ClientID%>').focus();
                            return false;
                        }
                    }
                    if (triggerTypeVal == "3") {

                        var values = $('#<%=ddlGeofence.ClientID%>').val();
                        if (values != '' && values != null) {
                            for (var x = 0; x < values.length; x++) {
                                if (x < values.length) {
                                    if (values[x] != 'multiselect-all')
                                        selectedItem += values[x] + ',';
                                }
                            }
                            $('#<%=hdnGeofenceIds.ClientID%>').val(selectedItem.substring(0, selectedItem.length - 1));
                        }
                        if ($('#<%=hdnGeofenceIds.ClientID%>').val() == '') {
                            document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please select one or more geolocation';
                            $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                            document.getElementById('<%=ddlGeofence.ClientID%>').focus();
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
                        if ($('#<%=txtTriggerPerNEntry.ClientID%>').val() == '') {
                            document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please enter n times within the schedule';
                            $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                            document.getElementById('<%=txtTriggerPerNEntry.ClientID%>').focus();
                            return false;
                        }
                        if ($('#<%=txtMaxTriggerPerFrequency.ClientID%>').val() == '') {
                            document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please enter maximum frequency of triggered awards per player';
                            $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                            document.getElementById('<%=txtMaxTriggerPerFrequency.ClientID%>').focus();
                            return false;
                        }
                        if ($('#<%=txtFrequency.ClientID%>').val() == '') {
                            document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please enter time every';
                            $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                            document.getElementById('<%=txtFrequency.ClientID%>').focus();
                            return false;
                        }
                        if ($('#<%=ddlFrequency.ClientID%> option:selected').val() == "-1") {
                            document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please select period';
                            $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                            document.getElementById('<%=ddlFrequency.ClientID%>').focus();
                            return false;
                        }


                    }
                    //Schedule
                    if (myTrim(document.getElementById('<%=txtScheduleName.ClientID%>').value) != '' || activeTab == 'scheduleTab') {
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
                                document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please enter from time for Monday';
                                $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                                document.getElementById('<%=txtScheduleMondayFrom.ClientID%>').focus();
                                return false;
                            }
                            if (document.getElementById('<%=txtScheduleMondayTo.ClientID%>').value == '') {

                                document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please enter to time for Monday';
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
                            document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please enter from time for Tuesday';
                                $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                                document.getElementById('<%=txtScheduleTueFrom.ClientID%>').focus();
                                return false;
                            }
                            if (document.getElementById('<%=txtScheduleTueTo.ClientID%>').value == '') {
                            document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please enter to time for Tuesday';
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
                            document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please enter from time for Wednesday';
                                $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                                document.getElementById('<%=txtScheduleWedFrom.ClientID%>').focus();
                                return false;
                            }
                            if (document.getElementById('<%=txtScheduleWedTo.ClientID%>').value == '') {

                            document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please enter to time for Wednesday';
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

                            document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please enter from time for Thursday';
                                $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                                document.getElementById('<%=txtScheduleThuFrom.ClientID%>').focus();
                                return false;
                            }
                            if (document.getElementById('<%=txtScheduleThuTo.ClientID%>').value == '') {
                            document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please enter to time for Thursday';
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
                            document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please enter from time for Friday';
                                $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                                document.getElementById('<%=txtScheduleFriFrom.ClientID%>').focus();
                                return false;
                            }
                            if (document.getElementById('<%=txtScheduleFriTo.ClientID%>').value == '') {
                            document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please enter to time for Friday';
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
                            document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please enter from time for Saturday';
                                $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                                document.getElementById('<%=txtScheduleSatFrom.ClientID%>').focus();
                                return false;
                            }
                            if (document.getElementById('<%=txtScheduleSatTo.ClientID%>').value == '') {
                            document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please enter to time for Saturday';
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
                            document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please enter from time for Sunday';
                                $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                                document.getElementById('<%=txtScheduleSunFrom.ClientID%>').focus();
                                return false;
                            }
                            if (document.getElementById('<%=txtScheduleSunTo.ClientID%>').value == '') {
                            document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please enter to time for Sunday';
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

                var validation = ConfirmMessage(1);
                if (validation == false) {
                    return false;
                }
                else {
                    return true;
                }
            }
            function ConfirmMessage(flag) {
                var savemsg = 'Are you sure to save this BatchMessage?';
                var cancelmsg = 'Are you sure to discard current changes?';
                var deletemsg = 'Are you sure to delete this BatchMessage?';
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

function RegisterDetectedFormChanges() {
    $.each($("input:text"), function (index, element) {
        element.defaultValue = $(element).val();
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
function GetGeofence() {
    $('.preloaderNew').show();
    var markup = '';
    var index = 0;
    var selectedItem = '';
    var messageId = 0;
    var messageSender = '';
    var adGroups = '';
    var status = 0;
    var values = $('#<%=ddlGeofence.ClientID%>').children('option').map(function (i, e) { return e.value; }).get();
                var texts = $('#<%=ddlGeofence.ClientID%>').children('option').map(function (i, e) { return e.text; }).get();

                if ($('#<%=hdnBatchMessageID.ClientID%>').val() != '' && $('#<%=hdnDectedGeofenceChange.ClientID%>').val() == 0) {
                    messageId = $('#<%=hdnBatchMessageID.ClientID%>').val();
                        if ($('#<%=txtSearchName.ClientID%>').val() != '')
                            messageSender = $('#<%=txtSearchName.ClientID%>').val();
                        if ($('#<%=hdnIsActive.ClientID%>').val() != '')
                            status = $('#<%=hdnIsActive.ClientID%>').val();
                        if ($('#<%=hdnAdGroups.ClientID%>').val() != '')
                            adGroups = $('#<%=hdnAdGroups.ClientID%>').val();
                        if (status == 'true')
                            status = 1;
                        else
                            status = 0;

                        $.ajax({
                            type: "POST",
                            url: "ManageBatchMessage.aspx/GetGeofences",
                            data: "{messageID: " + messageId + ",messageSender:'" + messageSender + "',status:" + status + ",aDGroups:'" + adGroups + "'}",
                            contentType: "application/json; charset=utf-8",
                            //dataType: "json",
                            success: function (data) {
                                var markup = '';
                                var index = 0;
                                for (var x = 0; x < values.length; x++) {

                                    if (index < data.d.length) {
                                        if (jQuery.inArray(values[x], data.d) > -1) {
                                            markup += '<option value="' + values[x] + '" selected="selected">' + texts[x] + '</option>';
                                            selectedItem = values[x] + '-' + selectedItem + ',';
                                            index++;
                                        }
                                        else { markup += '<option value="' + values[x] + '">' + texts[x] + '</option>'; }
                                    }
                                    else { markup += '<option value="' + values[x] + '">' + texts[x] + '</option>'; }

                                }
                                $('#<%=ddlGeofence.ClientID%>').html('');
                                $('#<%=ddlGeofence.ClientID%>').html(markup);
                                $('#<%=hdnGeofenceIds.ClientID%>').val(selectedItem.substring(0, selectedItem.length - 1));

                                RegisterMultiDropDown();
                                //Set Default value for Monitor function.
                                $.each($("input:checkbox"), function (index, element) {
                                    element.defaultChecked = element.checked;
                                });
                                $.each($("input:radio"), function (index, element) {
                                    element.defaultChecked = element.checked;
                                });

                            },
                            error: function (xhr, status, err) {

                                $('.preloaderNew').hide();
                                var err = eval("(" + xhr.responseText + ")");
                                alert(err.Message);
                            }
                        });
                    }
                    else {
                        if ($('#<%=hdnGeofenceIds.ClientID%>').val() != '') {
                            var sp = $('#<%=hdnGeofenceIds.ClientID%>').val().split(',');
                            for (var x = 0; x < values.length; x++) {
                                if (index < sp.length) {
                                    if (sp[index] == values[x]) {
                                        markup += '<option value="' + values[x] + '" selected="selected">' + texts[x] + '</option>';
                                        index++;
                                    }
                                    else { markup += '<option value="' + values[x] + '">' + texts[x] + '</option>'; }
                                }
                                else { markup += '<option value="' + values[x] + '">' + texts[x] + '</option>'; }
                            }
                            $('#<%=ddlGeofence.ClientID%>').html('');
                            $('#<%=ddlGeofence.ClientID%>').html(markup);
                        }
                        RegisterMultiDropDown();
                    }
                    $('.preloaderNew').hide();
                }
                function RegisterMultiDropDown() {
                    $('#<%=ddlGeofence.ClientID%>').multiselect({
                        includeSelectAllOption: true
                    });
                    $('#<%=ddlGeofence.ClientID%>').multiselect();

                }
                function RegisterGetGeolocation() {
                    $('#<%=hdnDectedGeofenceChange.ClientID%>').val('1');
                    $('#<%=hdnGeofenceIds.ClientID%>').val($('#<%=ddlGeofence.ClientID%>').val());
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
                            <asp:Button ID="btnConfirmedSave" CssClass="btn btn-danger" runat="server" Text="OK" UseSubmitBehavior="false" data-dismiss="modal" OnClick="lnkbtnSave_Click" Style="display: none;"></asp:Button>
                            <asp:Button ID="btnConfirmedCancel" CssClass="btn btn-danger" runat="server" Text="OK" UseSubmitBehavior="false" data-dismiss="modal" OnClick="lnkbtnCancel_Click" Style="display: none;"></asp:Button>
                            <asp:Button ID="btnConfirmedDelete" CssClass="btn btn-danger" runat="server" Text="OK" UseSubmitBehavior="false" data-dismiss="modal" OnClick="lnkbtnDelete_Click" Style="display: none;"></asp:Button>
                            <asp:Button ID="btnConfirmedActive" CssClass="btn btn-danger" runat="server" Text="OK" UseSubmitBehavior="false" data-dismiss="modal" OnClick="lnkbtnActiveMessage_Click" Style="display: none;"></asp:Button>
                            <asp:Button ID="btnConfirmedInActive" CssClass="btn btn-danger" runat="server" Text="OK" UseSubmitBehavior="false" data-dismiss="modal" OnClick="lnkbtnInactiveMessage_Click" Style="display: none;"></asp:Button>
                            <asp:Button ID="btnConfirmedAll" CssClass="btn btn-danger" runat="server" Text="OK" UseSubmitBehavior="false" data-dismiss="modal" OnClick="lnkbtnAllMessage_Click" Style="display: none;"></asp:Button>
                            <button type="button" class="btn" id="confirm" data-dismiss="modal">Cancel</button>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Dialog show event handler -->

        </ContentTemplate>

    </asp:UpdatePanel>
</asp:Content>
