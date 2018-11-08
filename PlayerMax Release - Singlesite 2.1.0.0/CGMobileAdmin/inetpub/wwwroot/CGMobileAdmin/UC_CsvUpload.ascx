<%@ Control Language="C#" AutoEventWireup="true" ValidateRequestMode="Disabled" CodeBehind="UC_CsvUpload.ascx.cs"  Inherits="HAMobileWebAdmin.UserControl.UC_CsvUpload" %>
<%@ Register TagPrefix="aspAjax" Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit" %>
<div class="row">
    <div class="col-md-12">
        <div class="distribution">
            <div class="col-md-6">
                <label for="StartScreen_lblImage">
                    CSV File
                                                            <br />
                </label>
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
                    <button type="button" id="btnCsvFileUpload" class="UploadButton" ></button>
                    <div id="UploadedFile">
                    </div>
                </div>
            </div>
            <div class="col-md-6 model2">
                <div class="form-group">
                <label>Valid Records</label>
                <div class="input-group model-file-uploaders model-file-uploaders1">
                    <asp:TextBox ID="txtValidRecords" ReadOnly="true" Text="0" runat="server" class="form-control"></asp:TextBox>
                    <span class="input-group-addon" data-toggle="modal" href="#invalidRecordsModal1"><i class="glyphicon glyphicon-eye-open"></i></span>
                </div>
                    </div>
                <div class="form-group">
                <label>Invalid Records</label>
                <div class="input-group model-file-uploaders model-file-uploaders2">
                    <asp:TextBox ID="txtInvalidRecords" Text="0" ReadOnly="true" runat="server" class="form-control"></asp:TextBox>
                    <span class="input-group-addon" data-toggle="modal" href="#invalidRecordsModal2"><i class="glyphicon glyphicon-eye-open"></i></span>
                </div>
                    </div>
                <div class="form-group">
                <label>Records in List</label>
                <div class="input-group model-file-uploaders model-file-uploaders3">
                    <asp:TextBox ID="txtTotalRecords" Text="0" runat="server" ReadOnly="true" class="form-control"></asp:TextBox>
                    <span class="input-group-addon" data-toggle="modal" href="#invalidRecordsModal3"><i class="glyphicon glyphicon-eye-open"></i></span>
                </div>
                    </div>
            </div>
        </div>



    </div>

</div>
<div class="modal fade" id="invalidRecordsModal1" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="false">
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

<div class="modal fade" id="invalidRecordsModal2" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="false">
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

<div class="modal fade" id="invalidRecordsModal3" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="false">
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


