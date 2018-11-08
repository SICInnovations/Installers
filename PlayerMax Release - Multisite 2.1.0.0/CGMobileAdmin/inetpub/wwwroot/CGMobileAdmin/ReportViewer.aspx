<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ReportViewer.aspx.cs" MasterPageFile="~/Site.Master" Inherits="HAMobileWebAdmin.ReportViewer" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=11.0.0.0, Culture=neutral, PublicKeyToken=89845DCD8080cc91" Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <style>
        .ms-options ul{
            list-style: none;
            padding: 15px;
        }
        .ms-options-wrap > .ms-options > ul input[type='checkbox']{position:static !important;}
    </style>
</asp:Content>
<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">
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
            <div class="row topMargin">
                <div>
                    <div class="col-md-12">
                        <div class="col-md-3">
                             <label for="contentItem">Reports Name</label>
                            <asp:ListBox ID="lstReports" Height="35" runat="server" AutoPostBack="true" OnSelectedIndexChanged="lstReports_SelectedIndexChanged" CssClass="ReportListBox form-control"></asp:ListBox>
                          
                        </div>

                        <div class="col-md-9 ">
                            <div class="col-md-12 ">
                                <div class="row">
                                    <div class="panel-group" id="accordion1">
                                        <div class="panel panel-default" style="overflow:visible;height:230px;">
                                            <div class="panel-heading panel-heading-rpt">
                                                <h4 class="panel-title">
                                                    <a data-toggle="collapse" data-parent="#accordion1" href="#collapseOne2">Parameters
                                                    </a>
                                                </h4>
                                            </div>
                                            <div id="collapseOne2" class="panel-collapse collapse in col-md-12">
                                                <asp:PlaceHolder runat="server" ID="rptPlaceHolder"></asp:PlaceHolder>
                                                <div class="col-sm-2 col-md-offset-9 search_by_btn-margin-right rptviewer-runbtnmargin">
                                                    <asp:Button ID="btnGetReport1" runat="server" OnClientClick="GetMultiSelectedValues();" OnClick="btnGetReport_Click" CssClass="search_by_btn " Text="Run Report" />
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                </div>
                            </div>
                            <div class="row">
                                <div class="col-xs-12 rptviewersetoverflow">
                                   <rsweb:ReportViewer ID="rptViewer"  runat="server" Width="100%" valign="top" Height=""></rsweb:ReportViewer>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
             
        </ContentTemplate>
    </asp:UpdatePanel>
    <asp:HiddenField ID="hdnproperties" runat="server" ClientIDMode="Static" />
    <script type="text/javascript">

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

        function Multiselect()
        {
            $('.dropdownListMultiple').multiselect({
                columns: 1,
                placeholder: 'Select Properties',
                search: true
            });           
        }

        function GetMultiSelectedValues()
        {
            var properties = [];
            $.each($(".dropdownListMultiple option:selected"), function () {
                properties.push($(this).val());
            });
            $("#hdnproperties").val(properties.join(", "));           
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
                            <button type="button" class="btn" id="confirm" data-dismiss="modal">Cancel</button>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Dialog show event handler -->
</asp:Content>
