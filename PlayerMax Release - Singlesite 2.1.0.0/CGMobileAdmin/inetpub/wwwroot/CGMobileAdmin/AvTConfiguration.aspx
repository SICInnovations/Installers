<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="AvTConfiguration.aspx.cs" Inherits="HAMobileWebAdmin.AvTConfiguration" %>

<asp:Content runat="server" ID="Content1" ContentPlaceHolderID="HeadContent">
    <title>COG Mobile | AvT Configuration</title>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
      <asp:UpdateProgress ID="updateProgress" runat="server">
            <ProgressTemplate>
                <div style="position: fixed; text-align: center; height: 100%; width: 100%; top: 0; right: 0; left: 0; z-index: 9999999; background-color: #000000; opacity: 0.7;">
                    <asp:Image ID="imgUpdateProgress" runat="server" ImageUrl="Content/img/loader.gif" AlternateText="Loading ..." ToolTip="Loading ..." Style="padding: 10px; position: fixed; top: 45%; left: 50%;" />
                </div>
            </ProgressTemplate>
        </asp:UpdateProgress>
   <asp:UpdatePanel ID="updPnlRREvent" runat="server" UpdateMode="Conditional">
               
                     <Triggers>
            <asp:PostBackTrigger ControlID="btnConfirmedSave" runat="server" />
        </Triggers> <ContentTemplate>
    <h4>AvT Global Configuration</h4>

    <table style="margin-left: 10px;">
        <tr>
            <td colspan="6">
                <label for="contentItem">AvT Batch Evaluation Process</label>
            </td>
        </tr>
        <tr>
            <td style="padding-right:10px">Daily at</td>
            <td style="width: 120px; align-content: center">
                <div class="bootstrap-timepicker input-group">
                    <asp:TextBox ID="txtDallyat" class="form-control timePickers" runat="server" Width="90px" Text="" />
                    <i class="icon-time"></i>
                </div>
            </td>
            <td style="padding-right:10px">Based on Play During the Previous Period From</td>
            <td style="width: 120px;">
                <div class="bootstrap-timepicker input-group">
                    <asp:TextBox ID="txtFrom" class="form-control timePickers" runat="server" Width="90px" Text="" />
                    <i class="icon-time"></i>
                </div>
            </td>
            <td style="padding-right:10px">To</td>
            <td style="width: 120px">
                <div class="bootstrap-timepicker input-group">
                    <asp:TextBox ID="txtTo" class="form-control timePickers" runat="server" Width="90px" Text="" />
                    <i class="icon-time"></i>
                </div>
            </td>
        </tr>
        <tr>
            <td colspan="6">
                <label for="contentItem">AvT Notification Schedule</label>
            </td>
        </tr>
        <tr>
            <td style="padding-right:10px">Daily At</td>
            <td colspan="5">
                <div class="bootstrap-timepicker input-group">
                    <asp:TextBox ID="txtDallyatTime" class="form-control timePickers" runat="server" Width="200px" Text="" />
                    <i class="icon-time"></i>
                </div>
            </td>
        </tr>
        <tr>
            <td></td>
            <td colspan="5"></td>
        </tr>
    </table>
    <div class="clearfix" style="margin-top: 50px">
        <div class="col-sm-1 text-center">
            <div class="filterResults btnGroup" >
                <div class="btn-groupSpecial">
                    <asp:Button ID="btnSave" runat="server" Text="Update" OnClientClick="return Validate()" CssClass="results-control" style="border-right:none" OnClick="btnSave_Click"></asp:Button>
                </div>
            </div>
        </div>
    </div>
   
    <div id="ConfirmBox" class="modal fade" role="dialog" aria-labelledby="confirmDeleteLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>
                    <h4 class="modal-title">Success</h4>
                </div>
                <div class="modal-body">
                    <p id="ConfirmBoxMessage">Updated successfully!</p>
                </div>
                <div class="modal-footer">                  
                    <asp:Button ID="btnConfirmedSave" CssClass="btn btn-danger" runat="server" Text="OK" data-dismiss="modal" Style="display: none;"></asp:Button>           
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
            RegisterDatePickersAndTimers();

        });
        function RegisterDatePickersAndTimers() {
            $('.timePickers').timepicker(
                      {
                          template: false,
                          showInputs: false,
                          minuteStep: 5,
                          defaultTime: false
                      });
        }


        //var prm = Sys.WebForms.PageRequestManager.getInstance();
        //if (prm != null) {
        //    prm.add_endRequest(function (sender, e) {
        //        if (sender._postBackSettings.panelsToUpdate != null) {
        //            alert('dsafdsf');
        //        }
        //    });
        //}
        function RaiseSuccessMessage() {
            $('#ConfirmBox').modal({ backdrop: 'static', keyboard: false });
        }

        function Validate() {
            if (document.getElementById('<%=txtDallyat.ClientID%>').value == '') {

                document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please enter the Schedule time!';
                $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                document.getElementById('<%=txtDallyat.ClientID%>').focus();
                return false;
            }
            if (document.getElementById('<%=txtFrom.ClientID%>').value == '') {

                document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please enter the From time!';
                $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                document.getElementById('<%=txtFrom.ClientID%>').focus();
                return false;
            }
            if (document.getElementById('<%=txtTo.ClientID%>').value == '') {

                document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please enter the To time!';
                $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                document.getElementById('<%=txtTo.ClientID%>').focus();
                return false;
            }
            if (document.getElementById('<%=txtDallyatTime.ClientID%>').value == '') {
                document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please enter the Daily execution time!';
                $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                document.getElementById('<%=txtDallyatTime.ClientID%>').focus();
                return false;
            }
                     
        }
    </script>
       </ContentTemplate></asp:UpdatePanel>
</asp:Content>
