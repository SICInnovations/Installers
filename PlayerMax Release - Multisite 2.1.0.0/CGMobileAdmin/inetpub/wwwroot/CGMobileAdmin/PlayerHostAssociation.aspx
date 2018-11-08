<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="Site.Master" CodeBehind="PlayerHostAssociation.aspx.cs" Inherits="HAMobileWebAdmin.PlayerHostAssociation" %>


<asp:Content runat="server" ID="Content1" ContentPlaceHolderID="HeadContent">
    <title>COG Mobile | Player Host Association</title>
</asp:Content>

<asp:Content runat="server" ID="Content3" ContentPlaceHolderID="MainContent">

    <div style="text-align: center;">
        <asp:UpdateProgress ID="updateProgress1" runat="server" AssociatedUpdatePanelID="updpnlBatchMessage">
            <ProgressTemplate>
                <div style="position: fixed; text-align: center; height: 100%; width: 100%; top: 0; right: 0; left: 0; z-index: 9999999; background-color: #000000; opacity: 0.7;">
                    <asp:Image ID="imgUpdateProgress" runat="server" ImageUrl="Content/img/loader.gif" AlternateText="Loading ..." ToolTip="Loading ..." Style="padding: 10px; position: fixed; top: 45%; left: 50%;" />
                </div>
            </ProgressTemplate>
        </asp:UpdateProgress>
    </div>

    <asp:UpdatePanel ID="updpnlBatchMessage" runat="server">
        <ContentTemplate>


            <div id="slotInventory" class="row">
                <div class="col-md-3">
                    <h5>Player Host Association</h5>
                    <div class="filterWrapper relative" id="dvLeftcontentdetail">

                        <div class="input-group">
                            <h3>Hosted Player List</h3>
                            <asp:TextBox CssClass="form-control" ID="txtSearchPlayer" runat="server"></asp:TextBox>
                            <span class="input-group-btn">
                                <asp:Button ID="btnSearch" runat="server" class="btn btn-black glyphicons filter btn-icon white" OnClick="btnSearch_Click" />
                                <i></i>
                            </span>
                        </div>
                        <div class="selectbox-wrapper clearfix">
                            <asp:DropDownList runat="server" ID="ddlPlayer" AutoPostBack="True" onchange="ContentDeatilChange()" CssClass="form-control" OnSelectedIndexChanged="ddlPlayer_SelectedIndexChanged"></asp:DropDownList>
                        </div>
                        <div id="divgv">

                            <asp:GridView CssClass="gridview" ID="gvPlayerHostAssociation" runat="server" ShowHeader="False" AutoGenerateColumns="false"
                                DataKeyNames="HostID" AllowPaging="true" PageSize="10"
                                OnPageIndexChanging="gvPlayerHostAssociation_PageIndexChanging">
                                <Columns>

                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <asp:Label ID="lblHostID" runat="server" Visible="false" Text='<%#Eval("HostID") %>' />
                                            <asp:LinkButton ID="lnkBtnPlayerHostAssociation" runat="server" Text='<%#Eval("MessageFrom") %>' OnClick="lnkBtnPlayerHostAssociation_Click" />

                                        </ItemTemplate>

                                    </asp:TemplateField>
                                </Columns>
                                <SelectedRowStyle CssClass="gvSelectedRow" />



                            </asp:GridView>
                            <div id="content"></div>

                        </div>

                        <div id="dvLeftContent" class="filterResults relative btnGroup">
                            <div class="btn-groupSpecial">
                                <asp:LinkButton ID="lnkbtnActive" runat="server" Text="active" CssClass="results-control col-xs-4" OnClick="lnkbtnActive_Click"></asp:LinkButton>
                                <asp:LinkButton ID="lnkbtnInactive" runat="server" Text="inactive" CssClass="results-control col-xs-4" OnClick="lnkbtnInactive_Click"></asp:LinkButton>
                                <asp:LinkButton ID="lnkbtnAll" runat="server" Text="all" CssClass="results-control col-xs-4" OnClick="lnkbtnAll_Click"></asp:LinkButton>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-9">
                    <h5>Player Host Association </h5>
                    <div class="row clearfix relative btnGroup btnGroup3" id="dvRightContent">



                        <div class="col-md-12 clearfix">

                            <div class="row">
                                <div class="col-md-12">
                                    <div class="distribution">
                                        <div class="col-md-6">

                                            <asp:Label ID="lblValidRecords" runat="server"></asp:Label>
                                            <asp:Label ID="lblInValidRecords" runat="server"></asp:Label>
                                            <asp:HiddenField runat="server" ID="hdncsvFileImageUrl" />
                                            <asp:HiddenField runat="server" ID="hdnTotalRecordIds" />
                                            <asp:HiddenField runat="server" ID="hdnValidRecordIds" Value="0" />
                                            <asp:HiddenField runat="server" ID="hdnInvalidRecordIds" />
                                            <asp:HiddenField runat="server" ID="hdnValidRecordCount" />
                                            <asp:HiddenField runat="server" ID="hdnInvalidRecordCount" />
                                            <asp:HiddenField runat="server" ID="hdnTotalRecordCount" />
                                            <div class="UploadDiv col-md-6">
                                                <div id="UploadStatus">
                                                </div>
                                                <%--<button type="button" id="btnCsvFileUpload" class="UploadButton" />--%>
                                                <asp:Button ID="btnCsvFileUpload" runat="server" OnClientClick="return false;" CssClass="UploadButton"></asp:Button>
                                                <div id="UploadedFile">
                                                </div>
                                            </div>
                                        </div>

                                        <div class="col-md-5">
                                            <label>Select Your Update Type</label>
                                            <input type="radio" name="updateMethod" id="updateSync" />
                                            <label for="updateSync">Replace All Current Host Association</label>
                                            <input type="radio" name="updateMethod" id="updateManual" checked="checked" />
                                            <label for="updateManual">Update Current Host Association</label>
                                        </div>
                                        <div class="progress topMargin">
                                            <div class="progress-bar progress-bar-success" role="progressbar" aria-valuenow="70" aria-valuemin="0" aria-valuemax="100" style="width: 0%" id="dvSlotPercentageDisplay" runat="server">
                                                <span class="sr-only" id="spSlotInventoryDatapercentage" runat="server"></span>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            Valid Player Host Association
                <div class="input-group model-file-uploaders model-file-uploaders1">
                    <asp:TextBox ID="txtValidRecords" ReadOnly="true" Text="0" runat="server" class="form-control"></asp:TextBox>
                    <span class="input-group-addon" data-toggle="modal" href="#invalidRecordsModal1"><i class="glyphicon glyphicon-eye-open"></i></span>
                </div>
                                            Invalid Player Host Association
                <div class="input-group model-file-uploaders model-file-uploaders2">
                    <asp:TextBox ID="txtInvalidRecords" Text="0" ReadOnly="true" runat="server" class="form-control"></asp:TextBox>
                    <span class="input-group-addon" data-toggle="modal" href="#invalidRecordsModal2"><i class="glyphicon glyphicon-eye-open"></i></span>
                </div>
                                            <%-- Records in List
                <div class="input-group model-file-uploaders model-file-uploaders3">
                    <asp:TextBox ID="txtTotalRecords" Text="0" runat="server" ReadOnly="true" class="form-control"></asp:TextBox>
                    <span class="input-group-addon" data-toggle="modal" href="#invalidRecordsModal3"><i class="glyphicon glyphicon-eye-open"></i></span>
                </div>--%>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="modal fade" id="modalValidRecords" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="false">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>
                                            <h4 class="modal-title">Valid Records</h4>
                                        </div>
                                        <div class="modal-body">
                                            <div class="modal-body-inner">
                                                <div class="data-table-wrapper">
                                                    <table class="table data-table" id="data-table1">
                                                        <thead>
                                                            <tr>
                                                                <td>&nbsp;</td>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                        </tbody>
                                                    </table>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-default left cancelBtn" data-dismiss="modal">Close</button>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="modal fade" id="modalInvalidRecords" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="false">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>
                                            <h4 class="modal-title">Invalid Records</h4>
                                        </div>
                                        <div class="modal-body">
                                            <div class="modal-body-inner">
                                                <div class="data-table-wrapper">
                                                    <table class="table data-table" id="data-table2">
                                                        <thead>
                                                            <tr>
                                                                <td>&nbsp;</td>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                        </tbody>
                                                    </table>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-default left cancelBtn" data-dismiss="modal">Close</button>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="modal fade" id="modalAllRecords" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="false">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>
                                            <h4 class="modal-title">Total Records</h4>
                                        </div>
                                        <div class="modal-body">
                                            <div class="modal-body-inner">
                                                <div class="data-table-wrapper">
                                                    <table class="table data-table" id="data-table3">
                                                        <thead>
                                                            <tr>
                                                                <td>&nbsp;</td>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                        </tbody>
                                                    </table>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-default left cancelBtn" data-dismiss="modal">Close</button>
                                        </div>
                                    </div>
                                </div>
                            </div>

                        </div>
                        <div class="col-md-12">
                            <div class="btn-groupSpecial clearfix">
                                <asp:LinkButton ID="lnkbtnSave" runat="server" Text="Save" OnClick="lnkbtnSave_Click" CssClass="results-control col-xsm-32"></asp:LinkButton>
                                <asp:LinkButton ID="lnkbtnCancel" runat="server" Text="Cancel" OnClick="lnkbtnCancel_Click" CssClass="results-control col-xsm-32"></asp:LinkButton>
                                <asp:LinkButton ID="lnkbtnDelete" runat="server" Text="Delete" OnClick="lnkbtnDelete_Click" CssClass="results-control col-xsm-32"></asp:LinkButton>

                            </div>
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


            <script type="text/javascript">

                $(document).ready(function () {

                    //  Inactive Fieldset
                    var fieldSwitch = $('.fieldSwitch');
                    var legendSwitch = $('.fieldset legend input');
                    fieldSwitch.find('input, select').prop('disabled', true);
                    $('.fieldset .input-group-addon').parent().addClass('dis');
                    //$('.input-group-addon').parent().removeClass('dis');
                    legendSwitch.on('click', function () {
                        if ($(this).is(':checked')) {
                            $(this).parent().next('.fieldSwitch').find('input, select').prop('disabled', true);
                            $('.fieldset  .input-group-addon').parent().addClass('dis');
                        }
                        else {
                            $(this).parent().next('.fieldSwitch').find('input, select').prop('disabled', false).prop("selected", false);
                            $('.fieldset  .input-group-addon').parent().removeClass('dis');
                        }
                    });


                });
            </script>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>


