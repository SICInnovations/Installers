<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="Site.Master" CodeBehind="ManageBeacons.aspx.cs" Inherits="HAMobileWebAdmin.ManageBeacons" %>

<asp:Content runat="server" ID="Content1" ContentPlaceHolderID="HeadContent">
    <title>COG Mobile | Manage Beacons Detail</title>
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
                <asp:HiddenField runat="server" ID="hdnBeaconID" Value="" />
                <asp:HiddenField runat="server" ID="hdnButtonSatus" Value="Active" />
                <asp:HiddenField runat="server" ID="hdnActive" Value="true" />
                <asp:HiddenField runat="server" ID="hdnGvBeaconsSelectedIndex" Value="0" />
                <asp:HiddenField runat="server" ID="hdnGimbleID" Value="" />
                <asp:HiddenField runat="server" ID="hdnButtonPermission" Value="0" />
                <asp:HiddenField runat="server" ID="hdnSelectedTab" Value="0" />
                <asp:HiddenField runat="server" ID="hdnSelectedProperties" Value="0" />
                <asp:HiddenField runat="server" ID="hdnAchievementDetailID" />
                <div class="col-sm-3">
                    <h5>Beacons</h5>
                    <div class="filterWrapper relative" id="dvLeftcontentdetail">
                        <div class=" clearfix whiteBg">
                            <div class="pull-left">
                            </div>
                            <div class="pull-right">
                                <span class="addBtn">Add
                                    <asp:Button ID="lnkbtnAdd" runat="server" OnClick="lnkbtnAdd_Click" CssClass="btn btn-add pull-right"></asp:Button></span>

                            </div>
                        </div>
                        <div class="input-group clearfix col-sm-12">
                            <asp:TextBox CssClass="form-control height26" ID="txtSearch" runat="server"></asp:TextBox>
                            <span class="input-group-btn">
                                <asp:Button ID="btnSearch" runat="server" OnClick="btnSearch_Click" CssClass="btn btn-black glyphicons filter btn-icon white  input-group-btnbtnmargin"></asp:Button>
                                <i></i>
                            </span>
                        </div>

                        <div id="divgv">
                            <asp:GridView CssClass="gridview" ID="gvBeacons" runat="server" ShowHeader="False" AutoGenerateColumns="false" DataKeyNames="BeaconID" AllowPaging="true" PageSize="8" OnPageIndexChanging="gvBeacons_PageIndexChanging">
                                <Columns>
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <asp:Label ID="lblID" runat="server" Visible="false" Text='<%#Eval("BeaconID") %>' />
                                            <asp:LinkButton ID="lnkBtnShowBeacons" runat="server" Text='<%#Eval("BeaconName") %>' CommandName="Select" OnClick="lnkBtnShowBeacons_Click" />

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
                                <asp:Button ID="lnkbtnActive" runat="server" Text="Active" OnClick="lnkbtnActive_Click" OnClientClick="return ConfirmMessage(4);" CssClass="results-control col-xs-4 active"></asp:Button>
                                <asp:Button ID="lnkbtnInActive" runat="server" Text="InActive" OnClick="lnkbtnInActive_Click" OnClientClick=" return ConfirmMessage(5);" CssClass="results-control col-xs-4"></asp:Button>
                                <asp:Button ID="lnkbtnAll" runat="server" Text="All" OnClick="lnkbtnAll_Click" CssClass="results-control col-xs-4" OnClientClick="return ConfirmMessage(6);"></asp:Button>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-sm-9">
                    <h4>Beacon Detail</h4>
                    <div class="row clearfix relative btnGroup btnGroup3" id="dvRightContent" style="height: 492px;">
                        <div class="col-md-12 clearfix">
                            <div class="tabControls">
                                <ul class="nav nav-tabs">
                                    <li class="active col-xsm-50 nav-tabs-property"><span class="linkDisabledsp">&nbsp;</span><a onclick="SetSelectedTab('propertyTabLink');" data-toggle="tab" href="#propertyTabLink">Property</a></li>
                                    <li class="col-xsm-50 nav-tabs-content active"><span class="linkDisabledsp">&nbsp;</span><a data-toggle="tab" href="#manageBeaconDetailTab" onclick="SetSelectedTab('contentTab')">Beacon Details</a></li>
                                </ul>
                                <div class="tab-content">
                                    <!--Property Tab Starts-->
                                    <div class="tab-pane fade in" id="propertyTabLink">
                                        <div class="tab-container clearfix">
                                            <div class="col-md-12">
                                                <div class="row" id="dvTabLbl">
                                                    <div class="col-md-4 top-margin-one">
                                                        <label></label>
                                                    </div>
                                                </div>
                                                <div class="row" id="dvAllProperties">
                                                    <div class="col-md-4 top-margin-one">
                                                      
                                                    </div>
                                                </div>
                                                <div class="row" id="dvSelectPropertiesLbl">
                                                    <div class="col-md-8 top-margin-one">
                                                        <label for="lblStartScreen_plainTextUrl">Define Excluded/Included Properties</label>
                                                        <asp:ListBox ID="lstProperties" SelectionMode="Multiple" runat="server" CssClass="permissionBox"></asp:ListBox>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <!--Property Tab Ends-->

                                    <!--Manage Content Tab Starts-->
                                    <div class="tab-pane fade in" id="manageBeaconDetailTab">
                                        <div class="tab-container clearfix">
                                            <div class="col-md-12">
                                                <div class="row">
                                                    <div class="col-md-4 col-sm-6 col-xs-8">
                                                        <label for="contentItem">Beacon Name</label>
                                                        <asp:TextBox ID="txtGeofenceName" class="form-control" runat="server" MaxLength="250" />
                                                    </div>

                                                    <div class="col-md-2 active-btn col-xs-4  col-sm-4 label_actv">
                                                        <asp:CheckBox ID="chkActive" Text="Active?" Visible="false" runat="server" />
                                                    </div>

                                                </div>

                                                <div class="row">
                                                    <div class="col-md-4">
                                                        <label for="contentItem">Beacon Description</label>
                                                        <asp:TextBox ID="txtGeofenceDescription" CssClass="form-control" runat="server" MaxLength="1000" />
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-md-4">
                                                        <label for="contentItem">Factory ID</label>
                                                        <asp:TextBox type="text" ID="txtFactory_id" CssClass="form-control" value="xxxx-xxxxx" onblur="if(value=='') value ='xxxx-xxxxx'" onfocus="if(value=='xxxx-xxxxx') value = ''" runat="server" MaxLength="20" />
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-md-4">
                                                        <label for="contentItem">Config ID</label>
                                                        <asp:DropDownList runat="server" ID="ddlConfigID" CssClass="form-control jq-selectbox">
                                                        </asp:DropDownList>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <!--adPression Population Tab Ends-->

                                </div>
                            </div>

                            <div class="col-md-12 btnGroup2">
                                <div class="btn-groupSpecial clearfix">
                                    <asp:Button ID="lnkbtnSave" OnClientClick="return FormValidation();" runat="server" Text="Save" OnClick="lnkbtnSave_Click" CssClass="results-control col-xsm-32"></asp:Button>
                                    <asp:Button ID="lnkbtnCancel" runat="server" OnClientClick="return ConfirmMessage(2);" Text="Cancel" OnClick="lnkbtnCancel_Click" CssClass="results-control col-xsm-32"></asp:Button>
                                    <asp:Button ID="lnkbtnDelete" runat="server" OnClientClick="return ConfirmMessage(3);" Text="Delete" OnClick="lnkbtnDelete_Click" CssClass="results-control col-xsm-32"></asp:Button>

                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <script type="text/javascript">

                    $(document).ready(function () {
                        RegisterDivHeight();
                        DisableAndResetListBox();
                        SetDefaultTab();

                    });
                    //***************************************Start On UpdatePanel Refresh Register Common Functions ********************************************************8

                    var prm = Sys.WebForms.PageRequestManager.getInstance();
                    if (prm != null) {
                        prm.add_endRequest(function (sender, e) {
                            if (sender._postBackSettings.panelsToUpdate != null) {

                                DisableAndResetListBox();
                                RegisterDivHeight();
                                SetDefaultTab()
                            }
                        });
                    }
                    ///Page validations

                    function FormValidation() {

                        if (myTrim(document.getElementById('<%=txtGeofenceName.ClientID%>').value) == '') {
                            document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please enter beacon  name';
                            $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                            document.getElementById('<%=txtGeofenceName.ClientID%>').focus();
                            return false;
                        }
                        if (myTrim(document.getElementById('<%=txtGeofenceDescription.ClientID%>').value) == '') {
                            document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please enter beacon description';
                        $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                        document.getElementById('<%=txtGeofenceDescription.ClientID%>').focus();
                        return false;
                    }

                    if (myTrim(document.getElementById('<%=txtFactory_id.ClientID%>').value) == '' || document.getElementById('<%=txtFactory_id.ClientID%>').value == 'xxxx-xxxxx') {
                            document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please enter factory id';
                        $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                        document.getElementById('<%=txtFactory_id.ClientID%>').focus();
                         return false;
                     }

                     var validation = ConfirmMessage(1);
                     if (validation == false) {
                         return false;
                     }
                     else {
                         return true;
                     }
                 }

                 function DisableAndResetListBox() {
                     if ($("#chkAllProperties").prop('checked')) {
                         $('#dvSelectPropertiesLbl').find('select, button, input:text').prop('disabled', true);
                     }
                     else {
                         $('#dvSelectPropertiesLbl').find('select, button, input:text').prop('disabled', false);
                     }
                 }

                 function RegisterDivHeight() {
                     $("#dvLeftcontentdetail").height($('#dvRightContent').height());
                 }

                 ///Alert Message
                 function ConfirmMessage(flag) {
                     var savemsg = 'Are you sure you want to save this beacon?';
                     var cancelmsg = 'Are you sure to discard current changes?';
                     var deletemsg = 'Are you sure to delete this beacons?';
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
                        } else if (flag == 2) {
                            $('#<%=btnConfirmedSave.ClientID%>').hide();
                            $('#<%=btnConfirmedCancel.ClientID%>').show();
                            $('#<%=btnConfirmedDelete.ClientID%>').hide();
                            $('#<%=btnConfirmedActive.ClientID%>').hide();
                            $('#<%=btnConfirmedInActive.ClientID%>').hide();
                            $('#<%=btnConfirmedAll.ClientID%>').hide();
                            $('#ConfirmBoxMessage').html(cancelmsg);
                        } else if (flag == 3) {
                            $('#<%=btnConfirmedSave.ClientID%>').hide();
                            $('#<%=btnConfirmedCancel.ClientID%>').hide();
                            $('#<%=btnConfirmedDelete.ClientID%>').show();
                            $('#<%=btnConfirmedActive.ClientID%>').hide();
                            $('#<%=btnConfirmedInActive.ClientID%>').hide();
                            $('#<%=btnConfirmedAll.ClientID%>').hide();
                            $('#ConfirmBoxMessage').html(deletemsg);
                        } else if (flag == 4) {
                            $('#<%=btnConfirmedSave.ClientID%>').hide();
                            $('#<%=btnConfirmedCancel.ClientID%>').hide();
                            $('#<%=btnConfirmedDelete.ClientID%>').hide();
                            $('#<%=btnConfirmedActive.ClientID%>').show();
                            $('#<%=btnConfirmedInActive.ClientID%>').hide();
                            $('#<%=btnConfirmedAll.ClientID%>').hide();
                            $('#ConfirmBoxMessage').html(cancelmsg);
                        } else if (flag == 5) {
                            $('#<%=btnConfirmedSave.ClientID%>').hide();
                            $('#<%=btnConfirmedCancel.ClientID%>').hide();
                            $('#<%=btnConfirmedDelete.ClientID%>').hide();
                            $('#<%=btnConfirmedActive.ClientID%>').hide();
                            $('#<%=btnConfirmedInActive.ClientID%>').show();
                            $('#<%=btnConfirmedAll.ClientID%>').hide();
                            $('#ConfirmBoxMessage').html(cancelmsg);
                        } else if (flag == 6) {
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

function isNumber(evt) {
    evt = (evt) ? evt : window.event;
    var charCode = (evt.which) ? evt.which : evt.keyCode;
    //alert (charCode);
    if (charCode > 31 && (charCode < 48 || charCode > 57)) {
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
                                <asp:Button ID="btnConfirmedSave" CssClass="btn btn-danger" runat="server" Text="OK" UseSubmitBehavior="false" data-dismiss="modal" OnClick="lnkbtnSave_Click" Style="display: none;"></asp:Button>
                                <asp:Button ID="btnConfirmedCancel" CssClass="btn btn-danger" runat="server" Text="OK" UseSubmitBehavior="false" data-dismiss="modal" OnClick="lnkbtnCancel_Click" Style="display: none;"></asp:Button>
                                <asp:Button ID="btnConfirmedDelete" CssClass="btn btn-danger" runat="server" Text="OK" UseSubmitBehavior="false" data-dismiss="modal" OnClick="lnkbtnDelete_Click" Style="display: none;"></asp:Button>
                                <asp:Button ID="btnConfirmedActive" CssClass="btn btn-danger" runat="server" Text="OK" UseSubmitBehavior="false" data-dismiss="modal" OnClick="lnkbtnActive_Click" Style="display: none;"></asp:Button>
                                <asp:Button ID="btnConfirmedInActive" CssClass="btn btn-danger" runat="server" Text="OK" UseSubmitBehavior="false" data-dismiss="modal" OnClick="lnkbtnInActive_Click" Style="display: none;"></asp:Button>
                                <asp:Button ID="btnConfirmedAll" CssClass="btn btn-danger" runat="server" Text="OK" UseSubmitBehavior="false" data-dismiss="modal" OnClick="lnkbtnAll_Click" Style="display: none;"></asp:Button>

                                <button type="button" class="btn" id="confirm" data-dismiss="modal">Cancel</button>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- Dialog show event handler -->
                <script type="text/javascript">
                    //Tab routines
                    function SetTabControls() {
                        var readTabValue = $('input:hidden[id*="hdnSelectedTab"]').val();
                        var isTab = $("#<%=hdnButtonPermission.ClientID %>").val();
                        var rowscount = $("#<%=gvBeacons.ClientID %> tr").length;
                        // Code is comment because permission is not implemented, when imlemented we can remove the comment code.
                        switch (readTabValue) {
                            case 'property':
                                $('.nav-tabs li').removeClass('active');
                                $('.nav-tabs li.nav-tabs-property').addClass('active');
                                $('.tab-content .tab-pane').removeClass('active in');
                                $('#propertyTabLink').addClass('active in');
                                break;
                            case 'contentTab':
                                $('.nav-tabs li').removeClass('active');
                                $('.nav-tabs li.nav-tabs-content').addClass('active');
                                $('.tab-content .tab-pane').removeClass('active in');
                                $('#manageBeaconDetailTab').addClass('active in');
                                break;
                        }
                        RegisterleftDivheight();
                    }

                    ///Set Default tab on pageload
                    function SetDefaultTab() {
                        $('.nav-tabs li').removeClass('active');
                        $('.nav-tabs li.nav-tabs-property').addClass('active');
                        $('.tab-content .tab-pane').removeClass('active in');
                        $('#propertyTabLink').addClass('active in');

                    }

                    function SetSelectedTab(selectedTab) {
                        $('input:hidden[id*="hdnSelectedTab"]').val(selectedTab);
                        SetTabControls();
                    }

                    function RegisterleftDivheight() {
                        $("#dvLeftcontentdetail1").height($('#dvRightContent1').height());
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
                </script>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
