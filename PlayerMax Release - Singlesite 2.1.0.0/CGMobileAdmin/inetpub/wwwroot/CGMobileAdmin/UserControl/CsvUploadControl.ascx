<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="CsvUploadControl.ascx.cs" Inherits="HAMobileWebAdmin.UserControl.CsvUploadControl" %>


<asp:Panel ID="pnlUploadControl" runat="server">
    <div class="row">
        <div class="col-md-12">
            <div class="distribution">
                <div class="col-md-6">
                    <label for="">
                        <%=HeaderMessage %><br />
                    </label>
                    <asp:Label ID="lblValidRecords" runat="server"></asp:Label>
                    <asp:Label ID="lblInValidRecords" runat="server"></asp:Label>
                    <asp:HiddenField runat="server" ID="hdncsvFileImageUrl" />
                    <asp:HiddenField runat="server" ID="hdnTotalRecordIds" />
                    <asp:HiddenField runat="server" ID="hdnValidRecordIds" />
                    <asp:HiddenField runat="server" ID="hdnInvalidRecordIds" />
                    <asp:HiddenField runat="server" ID="hdnValidRecordCount" />
                    <asp:HiddenField runat="server" ID="hdnInvalidRecordCount" />
                    <asp:HiddenField runat="server" ID="hdnTotalRecordCount" />
                    <asp:HiddenField runat="server" ID="hdnFileName" />
                    <asp:HiddenField runat="server" ID="hdnID" />
                    <div class="UploadDiv UploadDiv2 col-md-6">
                        <div id="UploadStatus">
                        </div>
                        <asp:Button ID="btnCsvFileUpload" runat="server" OnClientClick="return false;" CssClass="UploadButton"></asp:Button>
                        <div id="UploadedFile">
                        </div>
                    </div>
                    <div class="progress progress2 topMargin" >
                        <div class=" progress-bar-success"  aria-valuenow="70" aria-valuemin="0" aria-valuemax="100" style="width: 0%" id="dvLocationPopulationDisplay" runat="server">
                            <span  id="spLocationPopuDatapercentage" runat="server"></span>
                        </div>
                    </div>
                    <div class="valid-players-list topMargin" style="overflow-x:hidden;overflow-y:auto; height:300px">
                    <asp:GridView CssClass="gridview" ID="GvA_SEC_Po_PL_PlayerList" runat="server"  AutoGenerateColumns="false" >
                        <Columns>
                            <asp:TemplateField HeaderText="Player ID">
                                <ItemTemplate>
                                   <asp:Label ID="lblID" runat="server" Visible="True" Text='<%#Eval("ID") %>' />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="File Name">
                                <ItemTemplate>
                                   <asp:Label ID="lblFileName" runat="server" Visible="True" Text='<%#Eval("CSVFileName") %>' />
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                         <pagerstyle cssclass="gridview-pager"></pagerstyle>
                                    <SelectedRowStyle CssClass="gvSelectedRow" />
                    </asp:GridView>
                    <div id="Div2">
                    </div>
                </div>
                </div>

                <div class="col-md-6 checkboxval">                  
                        <label>Select Your Update Type</label>
                        <input type="radio" name="updateMethod" id="A_SEC_Po_PL_Replace" runat="server" onchange="GetUpdateReplaceCheckBoxValue()" />
                        <label for="<%=A_SEC_Po_PL_Replace.ClientID %>">Replace Existing CSV</label>
                        <input type="radio" name="updateMethod" id="A_SEC_Po_PL_Update" checked="True" runat="server" onchange="GetUpdateReplaceCheckBoxValue()" />
                        <label for="<%=A_SEC_Po_PL_Update.ClientID %>">Update Existing CSV</label>
                  
                    Valid Records
                <div class="input-group model-file-uploaders model-file-uploaders1">
                    <asp:TextBox ID="txtValidRecords" ReadOnly="true" Text="0" runat="server" class="form-control"></asp:TextBox>
                    <span id="validRecords" class="input-group-addon" data-toggle="modal"><i class="glyphicon glyphicon-eye-open"></i></span>
                </div>
                    Invalid Records
                <div class="input-group model-file-uploaders model-file-uploaders2">
                    <asp:TextBox ID="txtInvalidRecords" Text="0" ReadOnly="true" runat="server" class="form-control"></asp:TextBox>
                    <span id="invalidRecords" class="input-group-addon" data-toggle="modal"><i class="glyphicon glyphicon-eye-open"></i></span>
                </div>
                    Records in List
                <div class="input-group model-file-uploaders model-file-uploaders3">
                    <asp:TextBox ID="txtTotalRecords" Text="0" runat="server" ReadOnly="true" class="form-control"></asp:TextBox>
                    <span id="totalRecords" class="input-group-addon" data-toggle="modal"><i class="glyphicon glyphicon-eye-open"></i></span>
                </div>
                    <input type="button" id="btnClearList" class="results-control col-xs-12 btn btn-reset topMargin" onclick="return ClearUploadedList(this);" value="Clear List" />
                </div>
            </div>
        </div>
    </div>
    <div class="modal fade" id="modalValidRecords" runat="server" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="false">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>
                    <h4 class="modal-title">Valid Records</h4>
                </div>
                <div class="modal-body">
                    <div class="modal-body-inner">
                        <div class="data-table-wrapper" style="overflow-y: auto; overflow-x: hidden; height: 220px;">
                            <table class="table data-table" runat="server" id="tblValidRecords">
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

    <div class="modal fade" id="modalInvalidRecords" runat="server" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="false">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>
                    <h4 class="modal-title">Invalid Records</h4>
                </div>
                <div class="modal-body">
                    <div class="modal-body-inner">
                        <div class="data-table-wrapper" style="overflow-y: auto; overflow-x: hidden; height: 220px;">
                            <table class="table data-table" runat="server" id="tblInvalidRecords">
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

    <div class="modal fade" id="modalAllRecords" runat="server" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="false">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>
                    <h4 class="modal-title">Total Records</h4>
                </div>
                <div class="modal-body">
                    <div class="modal-body-inner">
                        <div class="data-table-wrapper" style="overflow-y: auto; overflow-x: hidden; height: 220px;">
                            <table class="table data-table" runat="server" id="tblTotalRecords">
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
</asp:Panel>
