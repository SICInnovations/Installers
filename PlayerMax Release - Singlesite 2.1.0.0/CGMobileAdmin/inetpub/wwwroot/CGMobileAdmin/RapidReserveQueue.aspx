<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="RapidReserveQueue.aspx.cs" Inherits="HAMobileWebAdmin.RapidReserveQueue" %>

<%@ Register TagPrefix="My" TagName="ServerTime" Src="~/UserControl/ServerTime.ascx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <link href="Content/css/ig_shared.css" rel="stylesheet" />
    <script src="Scripts/Timer/jquery.timer.js"></script>
    <style>
   .contentPopup{
       width:400px;
     position:absolute;
     left:50%;
     top:50px;
     margin-left:-200px;
     z-index:100000;
   }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="row">
        <div class="col-sm-12">
            <div class="col-sm-6 pull-right">
                <My:ServerTime runat="server" ID="ServerTime" />
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


    <asp:UpdatePanel ID="updpnlContentDetail" runat="server" UpdateMode="Conditional">
        <ContentTemplate>
            <div class="row">
                <asp:HiddenField runat="server" ID="hdnSelectedTab" Value="queueTab" />
                <asp:HiddenField runat="server" ID="hdnButtonSatus" Value="queueTab" />
            </div>
            <asp:Panel ID="pnlPageContent" runat="server">
                <div class="col-md-12 clearfix">
                    <div class="tabControls">
                        <ul class="nav nav-tabs">
                            <li id="liQueueTab" class="active col-xsm-32 activeTabBg nav-tabs-content lTab" style="width: 50%;"><span class="linkDisabledsp">&nbsp;</span><a onclick="SetSelectedTab('queueTab');" data-toggle="tab" href="#manageQueueTab">Manage Queue</a></li>
                            <li id="liWaitTab" class="col-xsm-32 nav-tabs-schedule activeTabBg ltab" style="width: 50%;"><span class="linkDisabledsp">&nbsp;</span><a data-toggle="tab" onclick="SetSelectedTab('waittimeTab');" href="#manageWaitTimeTab">Manage Wait Times</a></li>

                        </ul>
                        <div class="tab-content">
                            <!--Manage Queue Tab Starts-->
                            <!-- Modified Nacupido 8/15/16 New field -->
                            <div class="tab-pane active fade in" id="manageQueueTab">
                                <div class="clearfix">
                                    <asp:Button ID="btnAll" Text="All" class="active col-xsm-32 activeTabBg nav-tabs-content ltab" runat="server" OnClick="btnAll_Click" />
                                    <asp:Button ID="btnVIP" Text="VIP Only" class="col-xsm-32 activeTabBg nav-tabs-content ltab" runat="server" OnClick="btnVIP_Click" />
                                    <asp:Button ID="btnStandard" Text="Standard" class="col-xsm-32 activeTabBg nav-tabs-content ltab" runat="server" OnClick="btnStandard_Click" />


                                    <asp:UpdatePanel ID="updpnlReserveQueue" runat="server" UpdateMode="Conditional">
                                        <ContentTemplate>
                                            <div class="dvmessageTable table-responsive">
                                                <asp:Timer ID="timerQueue" runat="server" Interval="60000" OnTick="timerQueue_Tick"></asp:Timer>
                                                <asp:HiddenField ID="hidnSelectedNoShowQueueId" runat="server" />
                                                <asp:GridView CssClass="gridview" ShowHeaderWhenEmpty="true" ID="gvReserveQueue" runat="server" DataKeyNames="QueueId" AutoGenerateColumns="False" OnRowCommand="gvReserveQueue_RowCommand">
                                                    <Columns>
                                                        <asp:BoundField AccessibleHeaderText="Name" HeaderText="Name" DataField="PlayerName" />
                                                        <asp:BoundField AccessibleHeaderText="Tier" HeaderText="Tier" DataField="TierName" />
                                                        <asp:BoundField AccessibleHeaderText="# of Party" HeaderText="# of Party" DataField="PartySize" />
                                                        <asp:BoundField AccessibleHeaderText="RR Request" HeaderText="RR Request" DataField="RequestedTime" DataFormatString="{0:M/d  h:mm tt}" />
                                                        <asp:BoundField AccessibleHeaderText="Est. Seating" HeaderText="Est. Seating" DataField="EstimatedSeatingTime" DataFormatString="{0:h:mm tt}" />
                                                        <asp:BoundField AccessibleHeaderText="Notified" HeaderText="Notified" DataField="NotifiedCount" />
                                                        <asp:TemplateField>
                                                            <HeaderTemplate>
                                                                <asp:Button ID="btnAddVIP" CssClass="btn newbtn" Width="220px" runat="server" CommandArgument='<%# Eval("EventId") %>' CommandName="AddVIP" Text="Add VIP" />
                                                            </HeaderTemplate>
                                                            <ItemTemplate>
                                                                <asp:Button ID="btnSMS" CssClass="btn newbtn" Width="100px" runat="server" CommandArgument='<%# Eval("QueueId") %>' CommandName="SMS" Text="SMS" />
                                                                &nbsp;
                                                         <asp:Button ID="btnSeat" CssClass="btn newbtn" Width="100px" runat="server" CommandArgument='<%# Eval("QueueId") %>' CommandName="SEAT" Text="Seat" />
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField>
                                                            <HeaderTemplate>
                                                                <asp:Button ID="btnAddStandard" CssClass="btn newbtn" Width="220px" runat="server" CommandArgument='<%# Eval("EventId") %>' CommandName="AddStandard" Text="Add Standard" />
                                                            </HeaderTemplate>
                                                            <ItemTemplate>
                                                                <asp:Button ID="btnNoShow" CssClass="btn newbtnGray" Width="100px" runat="server" CommandArgument='<%# Eval("QueueId") %>' CommandName="NoShow" Text="No Show" />
                                                                &nbsp;
                                                         <asp:Button ID="btnEdit" CssClass="btn newbtnGray" Width="100px" runat="server" CommandArgument='<%# Eval("QueueId") %>' CommandName="QueueEdit" Text="Edit" />
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                    </Columns>
                                                    <HeaderStyle HorizontalAlign="Center" />
                                                    <RowStyle HorizontalAlign="Center" />
                                                    <SelectedRowStyle CssClass="gvSelectedRow" />
                                                </asp:GridView>
                                            </div>

                                            <div id="QueueConfirmBox" class="modal fade" role="dialog" aria-labelledby="confirmDeleteLabel" aria-hidden="true">
                                                <div class="modal-dialog">
                                                    <div class="modal-content">
                                                        <div class="modal-header">
                                                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>
                                                            <h4 class="modal-title">Confirm?</h4>
                                                        </div>
                                                        <div class="modal-body">
                                                            <p id="QueueConfirmBoxMessage">Are you sure to mark the selected guest as a 'No Show' and cancel this RapidReserve event?</p>
                                                        </div>
                                                        <div class="modal-footer">
                                                            <asp:Button ID="btnNoShowQueueQueue" runat="server" CssClass="btn btn-danger okbtn" Text="Ok" OnClick="btnNoShowQueue_Click"></asp:Button>
                                                            <button type="button" class="btn btn-danger cancelbtn" id="qconfirm" data-dismiss="modal">Cancel</button>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                </div>
                            </div>

                            <!--Manage WaitTime Tab Starts-->
                            <div class="tab-pane fade in" id="manageWaitTimeTab">

                                <div class="clearfix">

                                    <asp:Button ID="btnWaitTimeVIP" Text="VIP" class="col-xsm-32 activeTabBg nav-tabs-content ltab"  Style="width: 50%;" runat="server" OnClick="btnWaitTimeVIP_Click" />
                                    <asp:Button ID="btnWaitTimeStandard" Text="Standard" class="active col-xsm-32 activeTabBg nav-tabs-content ltab"  Style="width: 50%;" runat="server" OnClick="btnWaitTimeStandard_Click" />

                                    <asp:UpdatePanel ID="updpnlWaitTime" runat="server" UpdateMode="Conditional">
                                        <ContentTemplate>
                                            <div class="dvmessageTable table-responsive">
                                                <asp:Timer ID="timerWaitTime" runat="server" Interval="60000" OnTick="timerWaitTime_Tick"></asp:Timer>
                                                <asp:GridView CssClass="gridview th-bg" ShowHeaderWhenEmpty="true" ID="gvWaitTime" runat="server" AutoGenerateColumns="False" OnRowCommand="gvWaitTime_RowCommand">
                                                    <Columns>
                                                        <asp:BoundField HeaderText="Party Size" DataField="PartySize" ControlStyle-CssClass="th_bg" ItemStyle-HorizontalAlign="Center" />
                                                        <asp:BoundField HeaderText="Estimated Wait Times(Min.)" DataField="WaitTime" ItemStyle-HorizontalAlign="Center" />

                                                        <asp:TemplateField>
                                                            <ItemTemplate>
                                                                <asp:Button ID="btnUpdatelWT" CssClass="btn redBtn" runat="server" CommandArgument='<%# Eval("EventPartySizeId") + "," + Eval("EventWaitTimeRangeId") %>' CommandName="UpdatelWT" Text="UPDATE" />
                                                                &nbsp;
                                                                <asp:Button ID="btnNoChangeWT" CssClass="btn grayBtn" runat="server" CommandArgument='<%# Eval("EventPartySizeId") + "," + Eval("EventWaitTimeRangeId") %>' CommandName="NoChangeWT" Text="NO CHANGE" />
                                                            </ItemTemplate>
                                                        </asp:TemplateField>

                                                        <asp:BoundField HeaderText="# in Queue" DataField="InQueue" ItemStyle-HorizontalAlign="Center" />
                                                        <asp:BoundField HeaderText="Change Since Last Update" DataField="SinceLastUpdate" ItemStyle-HorizontalAlign="Center" />
                                                    </Columns>
                                                    <SelectedRowStyle CssClass="gvSelectedRow" />
                                                </asp:GridView>

                                                <div id="UpdateWaitTimePopUp" class="modal fade" role="dialog" aria-labelledby="confirmDeleteLabel">
                                                    <div class="modal-dialog">
                                                        <div class="modal-content clearfix bgclr">
                                                            <div class="modal-body">
                                                                <asp:HiddenField runat="server" ID="hidnSelectedEventPartySizeId" />
                                                                <asp:HiddenField runat="server" ID="hidnEventWaitTimeRangeId" />
                                                                <h3 class="modal-title text-center">
                                                                    <asp:Label ID="lblUpdateWaitTimePopupHeader" runat="server" Text="Set Wait Time for Party Size " Font-Size="Medium" Font-Bold="true"></asp:Label></h3>
                                                                <br />
                                                                <div class="row">
                                                                    <div class="col-md-12">
                                                                        <div class="col-md-8">
                                                                            <div class="form-group">
                                                                                <asp:TextBox ID="lblUpdateWaitTimePopupWaitTimeText" CssClass="form-control text-center heightpopuptextbox" Width="100%" runat="server" ReadOnly="true" Style="font-weight: bold; border-radius: 4px !important;"></asp:TextBox>
                                                                                <asp:DataList runat="server" ID="dlWaitTimes" RepeatDirection="Horizontal" HorizontalAlign="Justify" RepeatLayout="Flow" OnItemDataBound="dlWaitTimes_ItemDataBound">
                                                                                    <HeaderTemplate>
                                                                                        <div class=" clearfix dvLeftSpacing text-center">
                                                                                    </HeaderTemplate>
                                                                                    <SeparatorTemplate>
                                                                                        </div><div class=" clearfix dvLeftSpacing text-center">
                                                                                    </SeparatorTemplate>
                                                                                    <ItemTemplate>
                                                                                        <button id='btnWaitTimeRange<%#Eval("EventWaitTimeRangeId") %>' data-waittimerangeid='<%#Eval("EventWaitTimeRangeId") %>' data-rangetext='<%#Eval("WaitTimeRangeMinuteText") %>' class="btn btn-danger pop-upBtn btnwaittimerange "><%#Eval("WaitTimeRange") %></button>
                                                                                    </ItemTemplate>
                                                                                    <FooterTemplate>
                                                                                        </div>
                                                                                    </FooterTemplate>
                                                                                </asp:DataList>
                                                                            </div>
                                                                        </div>
                                                                        <div class="col-md-4">
                                                                            <asp:Button ID="btnUpdateWaitTime" OnClick="btnUpdateWaitTime_Click" runat="server" Text="Save" CssClass="btn btn-danger btn-primary Clearsave" Style="margin-top: 110px;" />
                                                                            <asp:Button ID="Button4" runat="server" Text="CANCEL" CssClass="btn btn-primary Clearcancel" data-dismiss="modal" />
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="modal-footer">
                                                                <p id="lblUpdateWaitTimePopupCurrentWaitTimeText" runat="server" class="modal-title text-center"></p>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                    <asp:UpdatePanel ID="updpnlSpecialRequestMin" runat="server" UpdateMode="Conditional">
                                        <ContentTemplate>
                                            <div class="shadedSingleBlock radius container">

                                                <div><strong>Special Request</strong></div>
                                                <div class="row mt10">
                                                    <div class="col-md-12">
                                                        <div class="col-md-8">
                                                            Add
                                                            <asp:Label runat="server" Width="25px" Text="15" Style="text-align: center; margin-top: 3px; font-weight: bold;" ID="lblSpecialreqTime"></asp:Label>
                                                            minutes to wait times for special requests
                                                        </div>

                                                        <div class="col-md-4">
                                                            <div class="control-group pull-right">
                                                                <asp:Button ID="btnUpdateSpecialWT" runat="server" class="btn btn-danger redBtn" Text="UPDATE" OnClick="btnUpdateSpecialWT_Click" />
                                                                &nbsp;
                                                            <asp:Button ID="btnNoChangeSpecialWT" CssClass="btn grayBtn" runat="server" OnClick="btnNoChangeSpecialWT_Click" Text="NO CHANGE" />
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div id="SetTimePopUp" class="modal fade" role="dialog" aria-labelledby="confirmDeleteLabel">
                                                <div class="modal-dialog">
                                                    <div class="modal-content clearfix bgclr">
                                                        <br />
                                                        <h3 class="modal-title text-center" id="myModalLabel">Set Wait Time for Special Requests</h3>
                                                        <div class="modal-body">
                                                            <div class="container-fluid">
                                                                <div class="col-md-12">
                                                                    <div class="col-md-8">
                                                                        <div class="form-group">
                                                                            <asp:HiddenField ID="hidncalculatedtime" runat="server" />
                                                                            <asp:HiddenField ID="hidnprevioustime" runat="server" />
                                                                            <asp:TextBox ID="calculatedTime" CssClass="form-control  text-center" ReadOnly="true" runat="server" Text="" Style="font-weight: bold; height: 40px; border-radius: 4px !important;"></asp:TextBox>
                                                                            <asp:DataList runat="server" ID="dlCalculator" RepeatDirection="Horizontal" HorizontalAlign="Justify" RepeatLayout="Flow" OnItemDataBound="dlCalculator_ItemDataBound">
                                                                                <HeaderTemplate>
                                                                                    <div class=" clearfix dvLeftSpacing text-center">
                                                                                </HeaderTemplate>
                                                                                <SeparatorTemplate>
                                                                                    </div><div class=" clearfix dvLeftSpacing text-center">
                                                                                </SeparatorTemplate>
                                                                                <ItemTemplate>
                                                                                    <button id='btnCalculatorPress<%#Eval("name") %>' class="btn btn-danger pop-upBtn btnCal" data-value='<%#Eval("name") %>'><%#Eval("name") %></button>
                                                                                </ItemTemplate>
                                                                                <FooterTemplate>
                                                                                    </div>
                                                                                </FooterTemplate>
                                                                            </asp:DataList>
                                                                        </div>
                                                                    </div>
                                                                    <div class="col-md-4">
                                                                        <button id="btnClearSRT" class="btn btn-primary ClearBtn">CLEAR</button>
                                                                        <asp:Button ID="btnSaveSRT" OnClick="btnSaveSRT_Click" runat="server" Text="SAVE" CssClass="btn btn-danger btn-primary Clearsave" />
                                                                        <asp:Button ID="btnCancelSRT" runat="server" Text="CANCEL" CssClass="btn btn-primary Clearcancel" data-dismiss="modal" />
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="modal-footer">
                                                                <p class="modal-title text-center" id="footerminutetext" runat="server"></p>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>

                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </asp:Panel>
            <asp:Panel ID="pnlVenue" Height="180px" Width="50%" runat="server" BackColor="#F2F2F2" Style="padding: 20px; position: absolute; margin: auto; top: 0; bottom: 0; left: 0; right: 0; border-radius: 5px;">

                <div class="row" style="text-align: center">
                    <span id="spnHeading" style="color: black; font-size: 25px; vertical-align: central;">Select Venue</span>
                </div>
                <div class="row" style="text-align: center">
                    <asp:DropDownList ID="ddlVenue" CssClass="form-control fmcontrol" runat="server">
                    </asp:DropDownList>
                </div>
                <br />
                <div class="row" style="text-align: center">
                    <asp:Button ID="btnPop" class="btn btn-danger okbtn" runat="server" Text="OK" OnClick="btnPop_Click" />

                </div>
            </asp:Panel>

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
                            <button type="button" class="btn btn-danger cancelbtn" id="btnOK" data-dismiss="modal">OK</button>
                        </div>
                    </div>
                </div>
            </div>
            <div id="AlertBoxTimerPopUpWaitTime" class="modal fade bs-example-modal-sm" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content contentPopup">
                        <div class="modal-header">
                            <button type="button" id="btnPopupOK" class="close" data-dismiss="modal" aria-hidden="true">x</button>
                            <h4 class="modal-title">Update Wait Times</h4>
                        </div>
                        <div class="modal-body">
                            <p id="P1" style="font-weight: bold;" runat="server">Wait times are now enabled for adjustment if needed.</p>
                        </div>
                        <div class="modal-footer">
                            <button type="button" style="margin-right: 120px; width: 100px; height: 40px;" class="btn btn-danger cancelbtn" id="btn_OK" data-dismiss="modal">OK</button>
                        </div>
                    </div>
                </div>
            </div>
            <div id="divId" style="display: none;"></div>
        </ContentTemplate>
    </asp:UpdatePanel>
    <script>

        
      
        //On UpdatePanel Refresh
        var prm = Sys.WebForms.PageRequestManager.getInstance();
        if (prm != null) {
            prm.add_endRequest(function (sender, e) {
                SetActiveTab();
                UpdateWaitTimeItems();
                
            });
        };

        $(document).ready(function () {
            SetSelectedTab('queueTab');
            UpdateWaitTimeItems();
            UpdatePoppupInerval();
        });


        function UpdatePoppupInerval() {
            
            if (!IsPanelVisible()) {
                var eventInterval = '<%= this.UpdatePopUpInerval %>' +'m';
                $('#divId').timer({                  
                    duration: eventInterval,
                    callback: function () {
                        $('#divId').timer('pause');
                        $('#AlertBoxTimerPopUpWaitTime').modal({ backdrop: 'static', keyboard: false });
                    },
                    repeat: true //repeatedly call the callback
                });

                $('#btnPopupOK, #btn_OK').click(function () {
                    $('#divId').timer('resume');
                });
            }
            
            function IsPanelVisible() {
                return <%= pnlVenue.Visible.ToString().ToLower() %>
            };

        }
        
        function SetSelectedTab(selectedTab) {
            var selected = selectedTab;
            $('#<%=hdnSelectedTab.ClientID%>').val(selectedTab);
            SetActiveTab();
        }
        function SetActiveTab() {
            var activeTab = $('input:hidden[id*="hdnSelectedTab"]').val();
            var isTab = $("#<%=hdnButtonSatus.ClientID %>").val();
            $('.lTab').removeClass('active');
            switch (activeTab) {
            case 'queueTab':
                $('.nav-tabs li').removeClass('active');
                $('.nav-tabs li.nav-tabs-content').addClass('active');
                $('#manageQueueTab').addClass('active in');
                $('#manageWaitTimeTab').removeClass('active in');

                break;
            case 'waittimeTab':
                $('.nav-tabs li').removeClass('active');
                $('.nav-tabs li.nav-tabs-schedule').addClass('active');
                $('#manageQueueTab').removeClass('active in');
                $('#manageWaitTimeTab').addClass('active in');
                break;
            }

        }


        function UpdateWaitTimeItems() {
            $('#<%=ddlVenue.ClientID%>').selectbox({
                onOpen: function (inst) {
                    $('.sbOptions').css({ 'top': '50px' });
                }
            });
            $('.sbHolder').css({ 'width': '100%', 'padding': '20px', 'height': '50px' }).find('a').css({ 'padding': '15px', 'font-size': '20px' });
            $('.sbSelector').css({ 'height': '50px' });
            $('.sbToggle').css({ 'margin-top': '10px' });

            if ($('#SetTimePopUp .btn_margin:last .btn').length == 1) {
                $('.btn_margin:last .btn').addClass('blck-center');
            }

            if ($('#UpdateWaitTimePopUp .btn_margin:last .btn').length == 1) {
                $('.btn_margin:last .btn').addClass('blck-center');
            }

            $('.btnwaittimerange').each(function (i, obj) {
                if ($('#<%=hidnEventWaitTimeRangeId.ClientID%>').val() == $(obj).data('waittimerangeid')) {
                    $(obj).removeClass('btn-danger').removeClass('pop-upBtn').addClass('pop-upBtnGray');
                    $(obj).attr('disabled', 'disabled');
                    $(obj).addClass('aspNetDisabled');
                }
            });


            $('#btnClearSRT').click(function (e) {
                e.preventDefault();
                $('#<%=hidncalculatedtime.ClientID%>').val('0');

                $('#<%=calculatedTime.ClientID%>').val('');
                $('#<%=btnSaveSRT.ClientID%>').attr('disabled', 'disabled');
                $('#<%=btnSaveSRT.ClientID%>').addClass('aspNetDisabled');
            });

            $(document).off('click', '.btnCal').on('click', '.btnCal', function () {
                var btnVal = $(this).data('value');
                var previousval = $('#<%=hidnprevioustime.ClientID%>').val();
                var calcVal = $('#<%=hidncalculatedtime.ClientID%>').val();
                if (calcVal >= 1000) { return false; }
                if (btnVal == 0 && calcVal == 0) { return false; }
                if (previousval == calcVal) {
                    $('#<%=hidncalculatedtime.ClientID%>').val(btnVal);
                }
                else {
                    if (calcVal == 0)
                        $('#<%=hidncalculatedtime.ClientID%>').val(btnVal);
                    else
                        $('#<%=hidncalculatedtime.ClientID%>').val(calcVal + '' + btnVal);
                }
                $('#<%=calculatedTime.ClientID%>').val($('#<%=hidncalculatedtime.ClientID%>').val() + ' ' + 'Minutes');
                $('#<%=btnSaveSRT.ClientID%>').removeAttr('disabled');
                $('#<%=btnSaveSRT.ClientID%>').removeClass('aspNetDisabled');
                return false;
            });


            $('.btnwaittimerange').click(function (e) {
                e.preventDefault();
                $('#<%=lblUpdateWaitTimePopupWaitTimeText.ClientID%>').val($(this).data('rangetext'));
                $('#<%=hidnEventWaitTimeRangeId.ClientID%>').val($(this).data('waittimerangeid'));
                $('.btnwaittimerange').addClass('btn-danger').addClass('pop-upBtn').removeClass('pop-upBtnGray').removeClass('aspNetDisabled').removeAttr('disabled');
                $(this).removeClass('btn-danger').removeClass('pop-upBtn').addClass('pop-upBtnGray').addClass('aspNetDisabled').attr('disabled', 'disabled');
                $('#<%=btnUpdateWaitTime.ClientID%>').removeClass('aspNetDisabled').removeAttr('disabled');
            });
        }

    </script>
</asp:Content>
