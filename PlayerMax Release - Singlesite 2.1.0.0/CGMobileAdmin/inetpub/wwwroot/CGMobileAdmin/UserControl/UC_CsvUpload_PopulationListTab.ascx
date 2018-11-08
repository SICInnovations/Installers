<%@ Control Language="C#" AutoEventWireup="true" ValidateRequestMode="Disabled" CodeBehind="UC_CsvUpload_PopulationListTab.ascx.cs" Inherits="HAMobileWebAdmin.UC_CsvUpload_PopulationListTab" %>
<div class="clearfix tab-container">
    <div class="col-md-12">
        <div class="fieldset">
            <div class="row">
                <div class="col-md-12">
                    <div>
                        <div class="col-md-6 model2 row">
                            <div>
                                <asp:Label ID="lblValidRecords" runat="server"></asp:Label>
                                <asp:Label ID="lblInValidRecords" runat="server"></asp:Label>
                                <asp:HiddenField runat="server" ID="hdncsvFileImageUrl" />
                                <asp:HiddenField runat="server" ID="hdnTotalRecordIds" />
                                <asp:HiddenField runat="server" ID="hdnValidRecordIds" Value="0" />
                                <asp:HiddenField runat="server" ID="hdnInvalidRecordIds" />
                                <asp:HiddenField runat="server" ID="hdnValidRecordCount" />
                                <asp:HiddenField runat="server" ID="hdnInvalidRecordCount" />
                                <asp:HiddenField runat="server" ID="hdnTotalRecordCount" />
                                <asp:HiddenField runat="server" ID="hdnFileName" />
                                <asp:HiddenField runat="server" ID="PlayerClubNumberBarcodeIDList" />
                                <asp:HiddenField runat="server" ID="hdnID" />
                                 <asp:HiddenField runat="server" ID="hdnBarCodeID" />
                                <label for="lblUploadCSV">Upload CSV </label>
                                <div class="UploadDiv uploadcsv">
                                    <div id="UploadStatus">
                                    </div>
                                    <button type="button" onclick="return false;" id="btnCsvFileUpload" class="UploadCSVButton1"></button>
                                    <div id="UploadedFile">
                                    </div>
                                </div>
                                <div class="progress topMargin">
                                    <div class="progress-bar progress-bar-success" role="progressbar" aria-valuenow="70" aria-valuemin="0" aria-valuemax="100" style="width: 0%" id="dvHostDisplay" runat="server">
                                        <span class="sr-only" id="spHostDatapercentage" runat="server"></span>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-5 populationradio-btn-margin">
                            <div>
                                <asp:RadioButton ID="rbReplace" runat="server" GroupName="check"/>
                                <label for="<%=rbReplace.ClientID %>">Replace Existing CSV</label>
                              <asp:RadioButton  ID="rbUpdate" Checked="true" runat="server" GroupName="check" />
                                <label for="<%=rbUpdate.ClientID %>">Update Existing CSV</label>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <div class="row">
                                <div class="form-group col-md-4">
                                    <label>Valid Records</label>
                                    <div class="input-group model-file-uploaders model-file-uploaders1">
                                        <asp:TextBox ID="txtValidRecords" ReadOnly="true" Text="0" runat="server" class="form-control"></asp:TextBox>
                                        <span class="input-group-addon" data-toggle="modal" href="#validRecordsModal"><i class="glyphicon glyphicon-eye-open"></i></span>
                                    </div>
                                </div>
                                <div class="form-group col-md-4">
                                    <label>Invalid Records</label>
                                    <div class="input-group model-file-uploaders model-file-uploaders2">
                                        <asp:TextBox ID="txtInvalidRecords" Text="0" ReadOnly="true" runat="server" class="form-control"></asp:TextBox>
                                        <span class="input-group-addon" data-toggle="modal" href="#invalidRecordsModal"><i class="glyphicon glyphicon-eye-open"></i></span>
                                    </div>
                                </div>
                                <div class="form-group col-md-4">
                                    <label>Records in List</label>
                                    <div class="input-group model-file-uploaders model-file-uploaders3">
                                        <asp:TextBox ID="txtTotalRecords" Text="0" runat="server" ReadOnly="true" class="form-control"></asp:TextBox>
                                        <span class="input-group-addon" data-toggle="modal" href="#totalRecordsModal1"><i class="glyphicon glyphicon-eye-open"></i></span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-12 clearlist-btn">
                        <div class="btn-groupSpecial clearfix">
                            <asp:Button ID="lnkbtnAll"  OnClick="lnkbtnAll_Click"  runat="server" Text="Clear List" CssClass="results-control col-xs-4"></asp:Button></div>
                    </div>

                    <div class="col-md-12">

                        <div class="row">
                            <div class="valid-players-list topMargin" style="overflow-x: hidden; overflow-y: auto; height: 300px">
                                <asp:GridView CssClass="gridview" ID="GvPlayerList" runat="server" AutoGenerateColumns="false" >
                                    <Columns>
                                        <asp:TemplateField HeaderText="Player ID">
                                            <ItemTemplate>
                                                <asp:Label ID="lblID" runat="server" Visible="True" Text='<%#Eval("PlayerClubNumber") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Barcode ID">
                                            <ItemTemplate>
                                                <asp:Label ID="lblBarcodeID" runat="server" Visible="True" Text='<%#Eval("BarcodeID") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="File Name">
                                            <ItemTemplate>
                                                <asp:Label ID="lblFileName" runat="server" Visible="True" Text='<%#Eval("CSVFileName") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                    <PagerStyle CssClass="gridview-pager"></PagerStyle>
                                    <SelectedRowStyle CssClass="gvSelectedRow" />
                                </asp:GridView>
                                <div id="Div2">
                                </div>
                            </div>
                        </div>
                    </div>
                </div>


            </div>
            <div class="modal fade" id="validRecordsModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="false">
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

            <div class="modal fade" id="invalidRecordsModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="false">
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

            <div class="modal fade" id="totalRecordsModal1" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="false">
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
    </div>
</div>
