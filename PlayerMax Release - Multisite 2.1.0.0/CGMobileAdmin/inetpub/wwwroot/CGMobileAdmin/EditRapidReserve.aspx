<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="EditRapidReserve.aspx.cs" Inherits="HAMobileWebAdmin.EditRapidReserve" %>

<%@ Register TagPrefix="My" TagName="ServerTime" Src="~/UserControl/ServerTime.ascx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <link href="Content/css/ig_shared.css" rel="stylesheet" />

    <script type="text/javascript">
        function SetTimePopUp() {
            $('#SetTimePopUp').modal({ backdrop: 'static', keyboard: false });
            return false;
        }
    </script>
    <style>
        .grdnotes td {
            word-break: break-all;
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
                <asp:HiddenField runat="server" ID="hdnSelectedTab" Value=" " />
                <asp:HiddenField runat="server" ID="hdnButtonSatus" Value=" " />
            </div>
            <div class="col-md-12 clearfix">
                <div class="tabControls">
                    <ul class="nav ">
                        <li class="col-xsm-32 activeTabBg uppernav" style="width: 100%; text-align: center">
                            <asp:Label ForeColor="White" runat="server" ID="lblEditRapidReserveHeader" Text="Edit Standard RapidReserve" /></li>
                    </ul>
                    <ul class="nav nav-tabs">
                        <li id="liDetailTab" class="col-xsm-32 activeTabBg nav-tabs-content ltab"><span class="linkDisabledsp">&nbsp;</span><a onclick="SetSelectedTab('detailTab');" data-toggle="tab" href="#detailTab">Rapid Reserve Details</a></li>
                        <li id="liRequestTab" class="col-xsm-32 nav-tabs-schedule activeTabBg ltab"><span class="linkDisabledsp">&nbsp;</span><a onclick="SetSelectedTab('requestTab');" data-toggle="tab" href="#requestTab">Special Requests</a></li>
                        <li id="liNotesTab" class="col-xsm-32 nav-tabs-schedule activeTabBg ltab"><span class="linkDisabledsp">&nbsp;</span><a data-toggle="tab" onclick="SetSelectedTab('notesTab');" href="#notesTab">Notes</a></li>
                    </ul>
                    <div class="tab-content">
                        <!--Manage Queue Tab Starts-->
                        <div class="tab-pane active active in" id="detailTab">
                            <div class="tab-container clearfix form-horizontal mt20">
                                <asp:HiddenField ID="hidnTierId" runat="server" />
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label for="txtRapidReserveID" class="col-sm-4 col-md-4 control-label text-right" id="lblRapidReserveID">RapidReserve ID</label>
                                            <div class="col-sm-6 col-md-6">
                                                <asp:TextBox ID="txtRapidReserveID" Style="text-align: center;" Enabled="false" runat="server" CssClass="form-control fmcontrol"></asp:TextBox>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-6 col-sm-12">
                                        <div class="form-group">
                                            <label for="txtPlayerClubID" class="col-sm-4 col-md-4 control-label text-right" id="lblPlayerClubID">Player Club ID</label>
                                            <div class="col-sm-6 col-md-6">
                                                <asp:TextBox ID="txtPlayerClubID" Style="text-align: center;" MaxLength="50" Enabled="false" runat="server" CssClass="form-control fmcontrol txtEditable numeric" AutoPostBack="true" OnTextChanged="btnPlayerClubID_TextChanged"></asp:TextBox>
                                            </div>
                                            <div id="divImgPlayerClubId" runat="server">
                                                <div class="input-group-addon edit_icon ">
                                                    <img alt="" id="imgEditPlayerClubID" class="edit-icon" src="Content/img/edit_button.png" />
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-6  col-sm-12">
                                        <div class="form-group">
                                            <label for="txtPlayerName" class="col-sm-4 col-md-4 control-label text-right" id="">Player Name</label>
                                            <div class="col-sm-6 col-md-6">
                                                <asp:TextBox ID="txtPlayerName" MaxLength="150" Style="text-align: center;" Enabled="false" runat="server" CssClass="form-control fmcontrol "></asp:TextBox>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label for="txtPartySize" class="col-sm-4 col-md-4 control-label text-right" id="lblPartySize">Party Size</label>
                                            <div class="col-sm-6 col-xs-9 col-md-7">
                                                <asp:TextBox ID="txtPartySize" Style="text-align: center;" MaxLength="4" AutoPostBack="true" OnTextChanged="txtPartySize_TextChanged" Enabled="false" runat="server" CssClass="form-control fmcontrol txtEditable numeric"></asp:TextBox>
                                            </div>
                                            <div class="input-group-addon edit_icon ">
                                                <img alt="" id="imgEditPartSize" class="edit-icon" src="Content/img/edit_button.png" />
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-6 col-sm-12">
                                        <div class="form-group">
                                            <label for="txtVenue" class="col-sm-4  col-md-4 control-label text-right" id="lblMobile">Venue </label>
                                            <div class="col-sm-6 col-xs-9  col-md-7">
                                                <asp:TextBox ID="txtVenue" Style="text-align: center;" disabled="disabled" runat="server" class="form-control fmcontrol"></asp:TextBox>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-6 col-sm-12">
                                        <div class="form-group">
                                            <label for="txtMobile" class="col-sm-4  col-md-4 control-label text-right" id="lblMobile">Mobile # for SMS</label>
                                            <div class="col-sm-6 col-xs-9  col-md-7">
                                                <asp:TextBox ID="txtMobile" Style="text-align: center;" MaxLength="13" Enabled="false" runat="server" onblur="return PHoneFormat(this.value);" CssClass="form-control fmcontrol  txtEditable numeric"></asp:TextBox>

                                            </div>
                                            <div class="input-group-addon edit_icon ">
                                                <img alt="" id="imgEditMobile" class="edit-icon" src="Content/img/edit_button.png" />
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-6 col-sm-12">
                                        <div class="form-group">
                                            <label for="txtReason" class="col-sm-4  col-md-4 control-label text-right" id="lblReason">Reason</label>
                                            <div class="col-sm-6 col-xs-9  col-md-7">
                                                <asp:TextBox ID="txtReason" Style="text-align: center;" Enabled="false" MaxLength="40" runat="server" CssClass="form-control fmcontrol txtEditable"></asp:TextBox>

                                            </div>
                                            <div class="input-group-addon edit_icon ">
                                                <img alt="" id="imgEditReason" style="text-align: center;" class="edit-icon" src="Content/img/edit_button.png" />
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label for="txtEstSeatingTime" class="col-sm-4 col-md-4  control-label text-right" id="lblSeatingTime">Est. Seating Time</label>
                                            <div class="col-sm-6 col-xs-9 col-md-4">
                                                <div class="input-group bootstrap-timepicker">
                                                    <asp:TextBox ID="txtEstSeatingTime" Style="text-align: center;" Enabled="false" runat="server" CssClass="form-control fmcontrol timePickers txtEditable"></asp:TextBox>
                                                    <span class="add-on"><i class="icon-time"></i></span>
                                                </div>
                                            </div>
                                            <div class="input-group-addon edit_icon ">
                                                <img id="imgbtnEstSeatingTime" class="edit-icon" src="Content/img/edit_button.png" />
                                                <asp:Button ID="btnEstSeatingTime" runat="server" OnClick="btnEstSeatingTime_Click" Style="display: none" />
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-12 EditControlButons">
                                    <div class="col-md-12 icons-control-btn clearfix">
                                        <div class="col-md-2 col-sm-4 pull-right col-xs-12">
                                            <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn btn-icon-cancel pull-right btn-Gray  btn-block" OnClick="btnCancel_Click"></asp:Button>
                                        </div>
                                        <div class="col-md-2 col-sm-4 pull-right col-xs-12    ">
                                            <asp:Button ID="btnDelete" runat="server" Text="Delete" CssClass="btn btn-icon-cancel pull-right btn-Gray   btn-block"></asp:Button>
                                        </div>
                                        <div class="col-md-2 col-sm-4 pull-right col-xs-12 ">
                                            <asp:Button ID="btnSave" runat="server" Text="Save" CssClass="btn btn-icon-cancel pull-right btn-Gray  btn-block" OnClientClick="return formValidation();" OnClick="btnSave_Click"></asp:Button>
                                        </div>
                                        <div class="col-md-2 col-sm-4 pull-left col-xs-12">
                                            <asp:Button ID="btnHomeRapidReserve" runat="server" Text="Home" CssClass="btn btn-icon-cancel pull-right btn-Gray  btn-block" OnClick="btnHomeRapidReserve_OnClick"></asp:Button>
                                        </div>
                                    </div>
                                </div>

                            </div>
                        </div>
                        <!--Special Request Tab Starts-->
                        <div class="tab-pane fade" id="requestTab">
                            <div class="tab-container clearfix" style="align-content: center;">
                                <div class="col-md-8 col-md-offset-2">
                                    <div class="blockbtn ">

                                        <div class="table-responsive">
                                            <asp:DataList runat="server" ID="dlSpecialRequestItem" RepeatColumns="4" OnItemDataBound="dlSpecialRequestItem_ItemDataBound" OnItemCommand="dlSpecialRequestItem_ItemCommand">
                                                <ItemTemplate>
                                                    <asp:Button ID="btnSpecialRequestItem" Style="margin: 5px; padding: 11px;" Width="140px" CssClass="btn toggle-out" runat="server" CommandArgument='<%# Eval("EventSpecialRequestId") %>' CommandName="Toggle" Text='<%#Eval("SpecialRequestName") %>' />
                                                    &nbsp;&nbsp;
                                                </ItemTemplate>
                                            </asp:DataList>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-12 EditControlButons">
                                    <div class="col-md-12 icons-control-btn clearfix">
                                        <div class="col-md-2 col-sm-4 pull-left col-xs-12" style="margin-top: 200px;">
                                            <asp:Button ID="btnHomeSpcialRequest" runat="server" Text="Home" CssClass="btn btn-icon-cancel pull-right btn-Gray  btn-block" OnClick="btnHomeSpcialRequest_OnClick"></asp:Button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!--note Tab Starts-->
                        <div class="tab-pane fade " id="notesTab">
                            <div class="clearfix">
                                <asp:UpdatePanel ID="updpnlNotes" runat="server" UpdateMode="Conditional">
                                    <ContentTemplate>
                                        <div class="col-lg-12 noteBg clearfix">

                                            <div class="col-md-12 col-sm-7  col-xs-12">
                                                <div class="col-md-6 col-sm-4 col-xs-3">
                                                    <label style="color: #fff">Note List</label>
                                                </div>
                                                <div class="col-md-1 col-sm-4 col-xs-3">
                                                    <asp:LinkButton ID="lbtnAddNote" runat="server" CssClass="btn  btn-large tabBtn ">Add Note</asp:LinkButton>
                                                </div>
                                                <div class="col-md-1 col-sm-4 col-xs-3">
                                                    <label class="pull-right" style="color: #fff; right: 40%">Note Detail</label>
                                                </div>
                                            </div>

                                        </div>
                                        <div class="row">
                                            <div class="col-lg-6">
                                                <asp:GridView ID="grdNotes" runat="server" AutoGenerateColumns="false" ShowHeader="false" CssClass="table gridview  grdnotes table-striped table-bordered" BorderWidth="0">
                                                    <Columns>
                                                        <asp:TemplateField ItemStyle-Width="75%">
                                                            <ItemTemplate>
                                                                <asp:HiddenField runat="server" ID="lblqueuenoteid" Value='<%#Eval("QueueNoteId")%>'></asp:HiddenField>
                                                                <asp:HiddenField runat="server" ID="lblnotetext" Value='<%#Eval("NoteText")%>'></asp:HiddenField>
                                                                <asp:HiddenField runat="server" ID="lblcreated" Value='<%#Eval("Created")%>'></asp:HiddenField>
                                                                <asp:HiddenField runat="server" ID="lblupdated" Value='<%#Eval("Updated")%>'></asp:HiddenField>
                                                                <asp:Label runat="server" ID="lblShortText" Text='<%#Eval("ShortNoteText")%>'></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:BoundField HeaderText="Date" DataField="StrUpdatedDate" ItemStyle-Width="25%" />
                                                    </Columns>
                                                </asp:GridView>
                                            </div>
                                            <div class="col-lg-6">
                                                <div class="row">
                                                    <div class="col-lg-3" style="clear: left;">
                                                        <label>Created:</label>
                                                    </div>
                                                    <div class="col-lg-9">
                                                        <asp:Label ID="lblNoteCreated" runat="server"></asp:Label>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-lg-3">
                                                        <label>Updated:</label>
                                                    </div>
                                                    <div class="col-lg-9">
                                                        <asp:Label ID="lblNoteUpdated" runat="server"></asp:Label>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-lg-12">
                                                        <asp:TextBox TextMode="MultiLine" ID="txtNote" runat="server" Rows="10" Width="98%" CssClass="text-area"></asp:TextBox>
                                                    </div>
                                                </div>
                                                <asp:HiddenField ID="hidnNoteId" Value="0" runat="server" />
                                            </div>
                                        </div>

                                        <div class="EditControlButons">
                                            <div class="col-md-12 icons-control-btn clearfix row">
                                                <div class="col-lg-6 pull-right pd0">
                                                    <div class="col-md-4 col-sm-4 col-xs-9 ">
                                                        <asp:Button ID="lbtnSaveNote" runat="server" CssClass="btn btn-icon-cancel pull-right btn-Gray " OnClick="lbtnSaveNote_Click" Text="Save" />
                                                    </div>
                                                    <div class="col-md-4 col-sm-4 col-xs-9">
                                                        <asp:Button ID="lbtnDeleteNote" runat="server" CssClass="btn btn-icon-cancel pull-right btn-Gray" Text="Delete" />
                                                    </div>

                                                    <div class="col-md-4 col-sm-4 col-xs-9 ">
                                                        <asp:Button ID="lbtnCancelNote" runat="server" CssClass="btn btn-icon-cancel pull-right btn-Gray " Text="Cancel" />
                                                    </div>


                                                </div>
                                                <div class="col-lg-6  pull-left">
                                                    <div class="col-md-4 col-sm-4 pull-left col-xs-9 row pd0">
                                                        <asp:Button ID="btnHomeNotes" runat="server" Text="Home" CssClass="btn btn-icon-cancel pull-right btn-Gray" OnClick="btnHomeNotes_OnClick"></asp:Button>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <!-- Modal Dialog -->
                                        <div id="NotesConfirmBox" class="modal fade" role="dialog" aria-labelledby="confirmDeleteLabel" aria-hidden="true">
                                            <div class="modal-dialog">
                                                <div class="modal-content">
                                                    <div class="modal-header">
                                                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>
                                                        <h4 class="modal-title">Confirm?</h4>
                                                    </div>
                                                    <div class="modal-body">
                                                        <p id="NotesConfirmBoxMessage">Are you sure you want to delete the selected note?</p>
                                                    </div>
                                                    <div class="modal-footer">
                                                        <asp:Button ID="btnConfirmedDelete" runat="server" CssClass="btn btn-danger" Text="Ok" OnClick="lbtnDeleteNote_Click"></asp:Button>
                                                        <button type="button" class="btn" id="confirm" data-dismiss="modal">Cancel</button>
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
            </div>
            <div id="UpdateWaitTimePopUp" class="modal fade" role="dialog" aria-labelledby="confirmDeleteLabel">
                <div class="modal-dialog">
                    <div class="modal-content clearfix bgclr">
                        <div class="modal-body">
                            <asp:HiddenField runat="server" ID="hidnEventWaitTimeRangeId" />
                            <h4 class="modal-title text-center">
                                <asp:Label ID="lblUpdateWaitTimePopupHeader" runat="server" Text="Set Wait Time for Party Size " Font-Size="Medium" Font-Bold="true"></asp:Label></h4>
                            <br />
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="col-md-8">
                                        <div class="form-group">
                                            <asp:TextBox ID="lblUpdateWaitTimePopupWaitTimeText" CssClass="form-control  text-center" Width="100%" runat="server" ReadOnly="true" Style="font-weight: bold; height: 40px; border-radius: 4px !important;"></asp:TextBox>
                                            <asp:DataList runat="server" ID="dlWaitTimes" RepeatDirection="Horizontal" HorizontalAlign="Justify" RepeatLayout="Flow" OnItemDataBound="dlWaitTimes_ItemDataBound">
                                                <HeaderTemplate>
                                                    <div class="clearfix dvLeftSpacing text-center">
                                                </HeaderTemplate>
                                                <SeparatorTemplate>
                                                    </div><div class="clearfix dvLeftSpacing text-center">
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
                                        <asp:Button ID="btnUpdateWaitTime" OnClick="btnUpdateWaitTime_Click" runat="server" Text="SAVE" CssClass="btn btn-danger btn-primary Clearsave" />
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

            <div id="SetTimePopUp" class="modal fade" role="dialog" aria-labelledby="confirmDeleteLabel">
                <div class="modal-dialog">
                    <div class="modal-content clearfix bgclr">
                        <br />
                        <h4 class="modal-title text-center" id="myModalLabel">Set Wait Time for Special Requests</h4>
                        <div class="modal-body">
                            <div class="container-fluid">
                                <div class="col-md-12">
                                    <div class="col-md-8">
                                        <div class="form-group">
                                            <asp:HiddenField ID="hidncalculatedtime" runat="server" />
                                            <asp:HiddenField ID="hidnprevioustime" runat="server" />
                                            <asp:TextBox ID="calculatedTime" CssClass="form-control  text-center" runat="server" ReadOnly="true" Text="" Style="font-weight: bold; height: 40px; border-radius: 4px !important;"></asp:TextBox>
                                            <asp:DataList runat="server" ID="dlCalculator" RepeatDirection="Horizontal" HorizontalAlign="Justify" RepeatLayout="Flow" OnItemDataBound="dlCalculator_ItemDataBound">
                                                <HeaderTemplate>
                                                    <div class="clearfix dvLeftSpacing text-center">
                                                </HeaderTemplate>
                                                <SeparatorTemplate>
                                                    </div><div class="clearfix dvLeftSpacing text-center">
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

            <!-- Modal Dialog -->
            <div id="QueueConfirmBox" class="modal fade" role="dialog" aria-labelledby="confirmDeleteLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>
                            <h4 class="modal-title">Confirm?</h4>
                        </div>
                        <div class="modal-body">
                            <p id="QueueConfirmBoxMessage">Are you sure about to delete the Selected Queue?</p>
                        </div>
                        <div class="modal-footer">
                            <asp:Button ID="btnDeleteQueue" runat="server" CssClass="btn btn-danger okbtn" Text="Ok" OnClick="btnDelete_Click"></asp:Button>
                            <button type="button" class="btn btn-danger cancelbtn" id="qconfirm" data-dismiss="modal">Cancel</button>
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
                            <button type="button" class="btn btn-danger cancelbtn" id="btnOK" data-dismiss="modal">OK</button>
                        </div>
                    </div>
                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>

    <script>

        //On UpdatePanel Refresh
        var prm = Sys.WebForms.PageRequestManager.getInstance();
        if (prm != null) {
            prm.add_endRequest(function (sender, e) {
                if (sender._postBackSettings.panelsToUpdate != null) {
                    SetActiveTab();
                    editDetail();
                    notes();

                    UpdateWaitTimeItems();
                    isNumber();
                }
            });
        };

        $(document).ready(function () {
            $('#<%=btnSave.ClientID%>').attr('disabled', 'disabled').addClass('aspNetDisabled');
            SetSelectedTab('detailTab');
            editDetail();

            UpdateWaitTimeItems();
            isNumber();

            PHoneFormat($('#<%=txtMobile.ClientID%>').val());
        });
        $(document).ready(function () {
            $('.timePickers').timepicker(
                        {
                            template: false,
                            showInputs: false,
                            minuteStep: 5,
                            defaultTime: false
                        });
        });

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
        function editDetail() {
            $(function () {
                $('#<%=txtPlayerClubID.ClientID%>, #<%=txtReason.ClientID%>, #<%=txtPartySize.ClientID%>, #<%=txtMobile.ClientID%>, #<%=txtEstSeatingTime.ClientID%>').change(function () {
                    $('#<%=btnSave.ClientID%>').removeAttr('disabled').removeClass('aspNetDisabled');
                });
            });
            $('.edit-icon').click(function () {
                var id = this.id;
                $('.txtEditable').prop("disabled", "disabled");
                if (id == 'imgEditPlayerClubID') {
                    $('#<%=txtPlayerClubID.ClientID%>').prop("disabled", "");
                    $('#<%=txtPlayerClubID.ClientID%>').removeClass("aspNetDisabled ");
                    $('#<%=txtPlayerClubID.ClientID%>').focus();
                }
                else if (id == 'imgEditPartSize') {
                    $('#<%=txtPartySize.ClientID%>').prop("disabled", "");
                    $('#<%=txtPartySize.ClientID%>').removeClass("aspNetDisabled ");
                    $('#<%=txtPartySize.ClientID%>').focus();
                }
                else if (id == 'imgEditMobile') {
                    var phone = 0;
                    $('#<%=txtMobile.ClientID%>').prop("disabled", "");
                    $('#<%=txtMobile.ClientID%>').removeClass("aspNetDisabled ");
                    $('#<%=txtMobile.ClientID%>').focus();
                    phone = document.getElementById('<%=txtMobile.ClientID%>').value;
                    phone = phone.replace("(", "").replace(")", "").replace("-", "").replace(" ", "");
                    document.getElementById('<%=txtMobile.ClientID%>').value = phone;
                }
                else if (id == 'imgEditReason') {
                    $('#<%=txtReason.ClientID%>').prop("disabled", "");
                    $('#<%=txtReason.ClientID%>').removeClass("aspNetDisabled ");
                    $('#<%=txtReason.ClientID%>').focus();
                }
                else if (id == 'imgEstSeatingTime') {
                    $('#<%=txtEstSeatingTime.ClientID%>').prop("disabled", "");
                    $('#<%=txtEstSeatingTime.ClientID%>').removeClass("aspNetDisabled ");
                    $('#<%=txtEstSeatingTime.ClientID%>').focus();
                }
            });
}

$(document).ready(function () {
    notes();
    SetActiveTab();
    $('#<%=txtNote.ClientID%>').attr("disabled", "disabled");
    $('#<%=lbtnDeleteNote.ClientID%>').attr("disabled", "disabled");
    $('#<%=lbtnSaveNote.ClientID%>').attr("disabled", "disabled");
    $('#<%=lbtnDeleteNote.ClientID%>').addClass("aspNetDisabled");
    $('#<%=lbtnSaveNote.ClientID%>').addClass("aspNetDisabled");

});


function SetSelectedTab(selectedTab) {
    var selected = selectedTab;
    $('#<%=hdnSelectedTab.ClientID%>').val(selected);
    SetActiveTab();
}
function SetActiveTab() {
    var activeTab = $('input:hidden[id*="hdnSelectedTab"]').val();
    var isTab = $("#<%=hdnButtonSatus.ClientID %>").val();


    switch (activeTab) {
        case 'detailTab':
            $('#liDetailTab').addClass('active');
            $('#liRequestTab').removeClass('active');
            $('#liNotesTab').removeClass('active');

            $('#detailTab').addClass('active in');
            $('#notesTab').removeClass('active in');
            $('#requestTab').removeClass('active in');
            break;
        case 'requestTab':
            $('#liDetailTab').removeClass('active');
            $('#liRequestTab').addClass('active');
            $('#liNotesTab').removeClass('active');

            $('#requestTab').addClass('active in');
            $('#notesTab').removeClass('active in');
            $('#detailTab').removeClass('active in');
            break;
        case 'notesTab':
            $('#liDetailTab').removeClass('active');
            $('#liRequestTab').removeClass('active');
            $('#liNotesTab').addClass('active');

            $('#notesTab').addClass('active in');
            $('#detailTab').removeClass('active in');
            $('#requestTab').removeClass('active in');
            break;
    }

}

//Notes
function notes() {
    $('#<%=btnDelete.ClientID%>').click(function () {
        $('#QueueConfirmBox').modal({ backdrop: 'static', keyboard: false });
        return false;
    });
    $('#<%=lbtnDeleteNote.ClientID%>').click(function () {
        $('#NotesConfirmBox').modal({ backdrop: 'static', keyboard: false });
        return false;
    });
    $('#<%=lbtnCancelNote.ClientID%>').click(function (e) {
        e.preventDefault();
        $('#<%=hidnNoteId.ClientID%>').val('0');
        $('#<%=txtNote.ClientID%>').val('');
        $('#<%=lblNoteCreated.ClientID%>').text('');
        $('#<%=lblNoteUpdated.ClientID%>').text('');
        $('#<%=txtNote.ClientID%>').attr("disabled", "disabled");
        $('#<%=lbtnSaveNote.ClientID%>').attr("disabled", "disabled");
        $('#<%=lbtnDeleteNote.ClientID%>').attr("disabled", "disabled");
        $('#<%=lbtnSaveNote.ClientID%>').addClass("aspNetDisabled");
        $('#<%=lbtnDeleteNote.ClientID%>').addClass("aspNetDisabled");
    });

    $('#<%=lbtnAddNote.ClientID%>').click(function (e) {
        e.preventDefault();
        $('#<%=hidnNoteId.ClientID%>').val('0');
        $('#<%=txtNote.ClientID%>').val('');
        $('#<%=txtNote.ClientID%>').focus();
        $('#<%=lblNoteCreated.ClientID%>').text('');
        $('#<%=lblNoteUpdated.ClientID%>').text('');
        $('#<%=txtNote.ClientID%>').removeAttr('disabled');
        $('#<%=lbtnSaveNote.ClientID%>').attr("disabled", "disabled");
        $('#<%=lbtnDeleteNote.ClientID%>').attr("disabled", "disabled");
    });

    $('.grdnotes tr').click(function (e) {
        $('#<%=txtNote.ClientID%>').val($(this).find('input[id^=MainContent_grdNotes_lblnotetext]').val());
        $('#<%=lblNoteCreated.ClientID%>').text($(this).find('input[id^=MainContent_grdNotes_lblcreated]').val());
        $('#<%=lblNoteUpdated.ClientID%>').text($(this).find('input[id^=MainContent_grdNotes_lblupdated]').val());
        $('#<%=hidnNoteId.ClientID%>').val($(this).find('input[id^=MainContent_grdNotes_lblqueuenoteid]').val());
        $('#<%=txtNote.ClientID%>').removeAttr("disabled");
        $('#<%=lbtnDeleteNote.ClientID%>').removeAttr("disabled");
        $('#<%=lbtnDeleteNote.ClientID%>').removeClass("aspNetDisabled");
    });

    $('#<%=txtNote.ClientID%>').keydown(function () {
        if ($(this).val().length >= 0) {
            $('#<%=lbtnSaveNote.ClientID%>').removeAttr("disabled");
            $('#<%=lbtnSaveNote.ClientID%>').removeClass("aspNetDisabled");
        }
    });
}
    </script>
    <script type="text/javascript">
        function formValidation() {

            if (document.getElementById('<%=txtPlayerClubID.ClientID%>').value == "") {
                document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please enter Player Club ID';
                    $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                    document.getElementById('<%=txtPlayerClubID.ClientID%>').focus();
                    return false;
                }
               
                if (document.getElementById('<%=txtPartySize.ClientID%>').value == "") {
                    document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please enter Party Size';
                    $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                    document.getElementById('<%=txtPartySize.ClientID%>').focus();
                    return false;
                }
           
                if (document.getElementById('<%=txtMobile.ClientID%>').value == "") {
                    document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please enter Mobile Number';
                    $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                    document.getElementById('<%=txtMobile.ClientID%>').focus();
                    return false;
                }
           
        }


        function PHoneFormat(phonenum) {
            $('#<%=txtMobile.ClientID%>').prop("disabled", "disabled");
            if (document.getElementById('<%=txtMobile.ClientID%>').value.length > 10 && document.getElementById('<%=txtMobile.ClientID%>').value.indexOf('(') === -1) {
                document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Phone number cannot be more than 10 digit.';
                $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                document.getElementById('<%=txtMobile.ClientID%>').value = '';
                $('#<%=txtMobile.ClientID%>').prop("disabled", "");
                return false;
            }
            if (document.getElementById('<%=txtMobile.ClientID%>').value.length < 10) {
                document.getElementById('<%=txtMobile.ClientID%>').value = phonenum;
            }
            else {
                if (document.getElementById('<%=txtMobile.ClientID%>').value.length == 10 || document.getElementById('<%=txtMobile.ClientID%>').value != "") {
                    var regexObj = /^(?:\+?1[-. ]?)?(?:\(?([0-9]{3})\)?[-. ]?)?([0-9]{3})[-. ]?([0-9]{4})$/;
                    if (regexObj.test(phonenum)) {
                        var parts = phonenum.match(regexObj);
                        var phone = "";
                        if (parts[1]) { phone += "(" + parts[1] + ") "; }
                        phone += parts[2] + "-" + parts[3];
                        document.getElementById('<%=txtMobile.ClientID%>').value = phone;
                        return phone;
                    }
                    else {
                        document.getElementById('<%=txtMobile.ClientID%>').value = phonenum;
                        return phonenum;
                    }
                }
            }
        }

        function UpdateWaitTimeItems() {
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

            $('#imgbtnEstSeatingTime').click(function () {
                var btn = $('#<%= btnEstSeatingTime.ClientID %>');
                btn.click();
            });
        }
    </script>
</asp:Content>
