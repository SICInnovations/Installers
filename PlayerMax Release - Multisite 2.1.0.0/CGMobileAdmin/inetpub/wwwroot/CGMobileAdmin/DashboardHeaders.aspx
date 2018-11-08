<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="Site.Master" CodeBehind="DashboardHeaders.aspx.cs" Inherits="HAMobileWebAdmin.DashboardHeaders" %>

<asp:Content runat="server" ID="Content1" ContentPlaceHolderID="HeadContent">
    <title>COG Mobile | Dashboard Header Details</title>
    <style>
        #dvLeftcontentdetail .btn-groupSpecial{
            width:100%;
            min-height:22px;
        }
       
    </style>
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
                <div class="col-sm-3">
                    <h5>Dashboard Headers</h5>
                    <div class="filterWrapper relative" id="dvLeftcontentdetail">
                        <div class=" clearfix whiteBg">
                            <div class="pull-left">
                            </div>
                            <div class="pull-right">

                            </div>
                        </div>
                        <div class="input-group clearfix col-sm-12" style="display:none">
                        </div>

                        <div id="divgv">
                              <asp:GridView CssClass="gridview" ID="gvDashboardHeaders" runat="server" ShowHeader="False" AutoGenerateColumns="false" DataKeyNames="PropertyID" AllowPaging="true" PageSize="12" OnPageIndexChanging="gvDashboardHeaders_PageIndexChanging">
                                <Columns>
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <asp:LinkButton ID="lnkBtnShowDashboardHeaders" runat="server" CommandArgument='<%#Eval("ID") %>' Text='<%#Eval("PropertyName") %>' OnCommand="lnkBtnShowDashboardHeaders" />
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
                                </div>
                        </div>
                    </div>
                </div>
                <div class="col-sm-9">
                    <h4 style="margin-bottom:5px; margin-left:15px;">Dashboard Header Detail</h4>
                    <div class="row clearfix relative btnGroup btnGroup3" id="dvRightContent" style="height: 500px;">
                        <div class="col-md-12 clearfix">
                               <div class="tab-container clearfix" style="min-height:500px;">
                                            <div class="col-md-10">
                                                  <div class="row">
                                                    <div class="col-md-6">
                                                        <label for="contentItem">Select Property</label>
                                                        <asp:DropDownList runat="server" ID="ddlProperty" CssClass="form-control jq-selectbox">
                                                        </asp:DropDownList>
                                                    </div>
                                                      <div class="col-md-6 top-margin-one pull-right">
                                                        <asp:CheckBox ID="chkAllProperties" Text="All Properties" OnCheckedChanged="chkAllProperties_CheckedChanged" ClientIDMode="Static" AutoPostBack="true" Visible="True" runat="server" />
                                                     </div>
                                                </div>
                                                 <div class="row">
                                                    <div class="col-md-6 col-sm-6 col-xs-8">
                                                        <label for="contentItem">Personal Dashboard Button Label</label>
                                                        <asp:TextBox ID="txtPersonalButton" class="form-control" runat="server" MaxLength="100" />
                                                    </div>
                                                      <div class="col-md-6 col-xs-8 pull-right">
                                                        <label for="contentItem">Casino Dashboard Button Label</label>
                                                        <asp:TextBox ID="txtCasinoButton" class="form-control " runat="server" MaxLength="100" />
                                                    </div>
                                                     </div>
                                                  <div class="row">
                                                    <div class="col-md-6 col-sm-6 col-xs-8">
                                                        <label for="contentItem">Balance Header Label</label>
                                                         <asp:TextBox ID="txtBalanceHeader" class="form-control" runat="server" MaxLength="100" />
                                                    </div>
                                                    <div class="col-md-6 col-xs-8 pull-right">
                                                        <label for="contentItem">Favourite Slot Picks Header Label</label>
                                                         <asp:TextBox ID="txtFavouriteSlotPicks" class="form-control" runat="server" MaxLength="100" />
                                                    </div>

                                                      </div>
                                                <div class="row">
                                                    <div class="col-md-6">
                                                        <label for="contentItem">App Points Header Label</label>
                                                        <asp:TextBox ID="txtAppPointHeader" CssClass="form-control" runat="server" MaxLength="100" />
                                                    </div>
                                                    <div class="col-md-6 col-xs-8 pull-right">
                                                        <label for="contentItem">Achievements Header Label</label>
                                                         <asp:TextBox ID="txtAchievementsHeader" class="form-control" runat="server" MaxLength="100" />
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-md-6">
                                                        <label for="contentItem">Message Header Label</label>
                                                       <asp:TextBox ID="txtMessageHeader" CssClass="form-control" runat="server" MaxLength="100" />
                                                    </div>
                                                </div>
                                             
                                            </div>
                                        </div>
                            <div class="col-md-12 btnGroup2">
                                <div class="btn-groupSpecial clearfix">
                                    <asp:Button ID="lnkbtnAdd" Text="Add" OnClick="lnkbtnAdd_Click" runat="server" CssClass="results-control col-xsm-25"></asp:Button>
                                    <asp:Button ID="lnkbtnEdit" runat="server" Text="Edit" OnClick="lnkbtnEdit_Click" CssClass="results-control col-xsm-25"></asp:Button>
                                    <asp:Button ID="lnkbtnSave" runat="server" Text="Save" CssClass="results-control col-xsm-25" OnClick="lnkbtnSave_Click"></asp:Button>
                                    <asp:Button ID="lnkbtnCancel" runat="server" Text="Cancel" OnClick="lnkbtnCancel_Click" CssClass="results-control col-xsm-25"></asp:Button>
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
                                <asp:Button ID="btnConfirmedSave" CssClass="btn btn-danger" runat="server" Text="OK" UseSubmitBehavior="false" data-dismiss="modal"  Style="display: none;"></asp:Button>
                                <asp:Button ID="btnConfirmedCancel" CssClass="btn btn-danger" runat="server" Text="OK" UseSubmitBehavior="false" data-dismiss="modal" Style="display: none;"></asp:Button>
                                <asp:Button ID="btnConfirmedDelete" CssClass="btn btn-danger" runat="server" Text="OK" UseSubmitBehavior="false" data-dismiss="modal" Style="display: none;"></asp:Button>
                                <asp:Button ID="btnConfirmedActive" CssClass="btn btn-danger" runat="server" Text="OK" UseSubmitBehavior="false" data-dismiss="modal"  Style="display: none;"></asp:Button>
                                <asp:Button ID="btnConfirmedInActive" CssClass="btn btn-danger" runat="server" Text="OK" UseSubmitBehavior="false" data-dismiss="modal"  Style="display: none;"></asp:Button>
                                <asp:Button ID="btnConfirmedAll" CssClass="btn btn-danger" runat="server" Text="OK" UseSubmitBehavior="false" data-dismiss="modal" Style="display: none;"></asp:Button>

                                <button type="button" class="btn" id="confirm" data-dismiss="modal">Cancel</button>
                            </div>
                        </div>
                    </div>
                </div>


                <script type="text/javascript">

                    //***************************************Start On UpdatePanel Refresh Register Common Functions ********************************************************8

                    var prm = Sys.WebForms.PageRequestManager.getInstance();
                    if (prm != null) {
                        prm.add_endRequest(function (sender, e) {
                            if (sender._postBackSettings.panelsToUpdate != null) {

                                RegisterDivHeight();
                                RegisterModel();
                            }
                        });
                    }
                    ///Page validations
                    function RegisterModel() {
                        $('#ConfirmBox').on('show.bs.modal', function (e) {
                        });
                    }

                    function RegisterDivHeight() {
                        $("#dvLeftcontentdetail").height($('#dvRightContent').height());
                    }

                    function DisableDashboardHeaderControls()
                    {
                        $('#dvRightContent').find('select, input:text, input:checkbox').prop('disabled', true);
                    }
                    function EnableDashboardHeaderControls()
                    {
                        $('#dvRightContent').find('select, input:text, input:checkbox').prop('disabled', false);
                    }
                    function DisableSaveCancelButton()
                    {
                        $("#<%=lnkbtnSave.ClientID %>").attr("disabled", true);
                        $("#<%=lnkbtnCancel.ClientID %>").attr("disabled", true);
                    }
                    function EnableSaveCancelButton() {
                        $("#<%=lnkbtnSave.ClientID %>").attr("disabled", false);
                        $("#<%=lnkbtnCancel.ClientID %>").attr("disabled", false);
                    }
                    function DisablePropertyDropdown() {
                        $("#<%=ddlProperty.ClientID %>").prop('disabled', true);
                    }
                    function DisableAddButton()
                    {
                        $("#<%=lnkbtnAdd.ClientID %>").attr("disabled", true);
                    }
                    function DisableEditButton() {
                        $("#<%=lnkbtnEdit.ClientID %>").attr("disabled", true);
                    }
                </script>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
