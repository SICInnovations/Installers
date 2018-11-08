<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="AvTConfiguration.aspx.cs" Inherits="HAMobileWebAdmin.AvTConfiguration" %>

<asp:Content runat="server" ID="Content1" ContentPlaceHolderID="HeadContent">
    <title>COG Mobile | AvT Configuration</title>
    <link rel="stylesheet" href="Content/css/bootstrap-multiselect.css" type="text/css" />
    <script type="text/javascript" src="Scripts/CommonJS/bootstrap-multiselect.js"></script>
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
        </Triggers> 
    <ContentTemplate>
        <asp:HiddenField runat="server" ID="hdnConfigId" Value="0" />
        <asp:HiddenField runat="server" ID="hdnButtonPermission" Value="0" />
        <asp:HiddenField runat="server" ID="hdnConfigSelectedIndex" Value="0" />
        <asp:HiddenField runat="server" ID="hdnButtonStatus" Value="Active" />
        <asp:HiddenField runat="server" ID="hdnSelectedTab" Value="0" />
        <div class="row" id="slotInventory">
            <div class="col-sm-3">
                    <h5>AvT Global Configuration</h5>
                    <div class="filterWrapper relative" id="dvLeftcontentdetail1">
                        <div class="clearfix">
                            <div class="pull-left">
                                <label>AvT Configuration</label>
                            </div>
                            <div class="pull-right">
                                <span>
                                    <asp:Button ID="btnAdd" runat="server" CssClass="btn btn-add pull-right" OnClick="btnAdd_OnClick"></asp:Button>
                                </span>
                            </div>
                        </div>
                        <div class="input-group clearfix col-sm-12">
                            <asp:TextBox runat="server" ID="txtSearchText" CssClass="form-control height26" />
                            <span class="input-group-btn">
                                <asp:Button runat="server" ID="btnSearch" CssClass="btn btn-black glyphicons filter btn-icon white input-group-btnbtnmargin" OnClick="btnSearch_OnClick" ClientIDMode="Inherit" /><i></i>
                            </span>
                        </div>
                        <div id="divgv">
                            <asp:GridView runat="server" CssClass="gridview" ID="grdConfiguration" ShowHeader="False" AutoGenerateColumns="False" DataKeyNames="ConfigID" AllowPaging="true" PageSize="15" OnPageIndexChanging="grdConfiguration_PageIndexChanging">
                                <Columns>
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <asp:Label ID="lblID" runat="server" Visible="false" Text='<%#Eval("ConfigID") %>' />
                                            <asp:LinkButton runat="server" ID="lnkBtnRRComfiguration" CommandName="Select" OnClick="lnkBtnRRConfiguration_Click" Text='<%#Eval("ConfigName") %>'></asp:LinkButton>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                                <PagerStyle CssClass="gridview-pager"></PagerStyle>
                                <SelectedRowStyle CssClass="gvSelectedRow" />
                            </asp:GridView>
                            <div id="content">
                            </div>
                        </div>
                        <div class="filterResults relative btnGroup" id="dvLeftContent">
                            <div class="btn-groupSpecial" >                            
                                <asp:Button Text="Active" ID="lnkBtnActiveConfiguration" CssClass="results-control col-xs-4" OnClick="lnkbtnActiveConfiguration_Click" runat="server" Enabled="True" />
                                <asp:Button Text="InActive" ID="lnkBtnInactiveConfiguration" CssClass="results-control col-xs-4" OnClick="lnkbtnInactiveConfiguration_Click" runat="server" Enabled="True" />
                                <asp:Button Text="All" ID="lnkBtnAllConfiguration" CssClass="results-control col-xs-4" OnClick="lnkbtnAllConfiguration_Click" runat="server" Enabled="True" />
                            </div>
                        </div>
                    </div>
                </div>

        
            <div class="col-sm-9">  
                <h5>AvT Configuration</h5>
                <div class="row clearfix relative btnGroup btnGroup3" id="dvRightContent1">
                    <div class="col-md-12 clearfix">
                        <div class="tabControls">
                            <ul class="nav nav-tabs">
                                <li class="acive col-xsm-50 nav-tabs-property"><span class="linkDisabledsp">&nbsp;</span><a onclick="SetSelectedTab('property');" data-toggle="tab" href="#propertyTab">Property</a></li>
                                <li class="col-xsm-50 nav-tabs-content"><span class="linkDisabledsp">&nbsp;</span><a data-toggle="tab" href="#manageConfigurationDetailTab" onclick="SetSelectedTab('contentTab')">Configuration Details</a></li>
                            </ul>
                            <div class="tab-content">
                                <!--Property Tab Starts-->
                                <div class="tab-pane active fade in" id="propertyTab">
                                    <div class="tab-container clearfix">
                                         <div class="col-md-12">
                                            <div class="row" id="dvTabLbl">
                                                <div class="col-md-4 top-margin-one">
                                                    <label>Define Assigned Properties</label>
                                                </div>
                                            </div>
                                            <div class="row" id="dvAllProperties">
                                                <div class="col-md-4 top-margin-one">
                                                    <asp:CheckBox ID="chkAllProperties" Text="All Properties" OnClick="JavaScript:EnableDisableProperties()" OnCheckedChanged="chkAllProperties_AllPropertiesChanged" AutoPostBack="true" Visible="True" runat="server" />
                                                </div>
                                           </div>
                                           <div class="row" id="dvSelectPropertiesLbl">
                                               <div class="col-md-8 top-margin-one">
                                                    <label for="lblStartScreen_plainTextUrl">Define Excluded/Included Properties</label>
                                                    <asp:ListBox ID="lstProperties" SelectionMode="Multiple" runat="server" CssClass="propertiesBox"></asp:ListBox>
                                                   <asp:HiddenField runat="server" ID="hdnSelectedProperties" Value="0" />
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <!--Property Tab Ends-->
                                
                                <!-- Configuration Details Tab Starts -->
                                <div class="tab-pane active fade in" id="manageConfigurationDetailTab">
                                    <div class="tab-container  clearfix">
                                            <div class="col-md-12">
                                                <label>Configuration Name</label>
                                            </div>
                                            <div class="col-md-8">
                                                <asp:TextBox ID="txtPropertyName" class="form-control" runat="server" Width="50%"/>
                                            </div>
                                            <div class="col-md-12" style="margin-top: 20px">
                                                <label>AvT Batch Evaluation Process</label>
                                            </div>
                                            <div class="col-md-12" style="margin-top: 20px">
                                                    <div class="col-md-10 no-padding">
                                                        <div class="bootstrap-timepicker input-group">
                                                            <asp:Label runat="server" style="padding-right:10px">Daily at</asp:Label>
                                                            <asp:TextBox ID="txtDailyat" class="form-control timePickers" runat="server" Width="100px" Text="" />
                                                            <i class="icon-time"></i>
                                                            <asp:label runat="server" style="padding-right:10px; padding-left:10px">Based on Play During the Previous Period From</asp:label>
                                                            <asp:TextBox ID="txtFrom" class="form-control timePickers" runat="server" Width="100px" Text="" />
                                                            <i class="icon-time"></i>
                                                            <asp:label runat="server" style="padding-right:10px; padding-left:10px">To</asp:label>
                                                            <asp:TextBox ID="txtTo" class="form-control timePickers" runat="server" Width="100px" Text="" />
                                                            <i class="icon-time"></i>
                                                        </div>
                                                    </div>
                                            </div>
                                            <div class="col-md-12" style="margin-top: 100px">
                                                <div>
                                                    <label for="contentItem">AvT Notification Schedule</label>
                                                </div>
                                                <div class="bootstrap-timepicker" style="margin-top: 20px">
                                                    <asp:label runat="server" >Daily At</asp:label>
                                                    <asp:TextBox ID="txtDailyatTime" class="form-control timePickers" runat="server" Width="200px" Text="" />
                                                    <i class="icon-time"></i>
                                                </div>                                                
                                            </div>
                                      
                                        </div>
                                    </div>
                                 </div>
                            </div>
                        </div>
                    </div>
                  <div class="col-md-12 btnGroup">
                       <div class="btn-groupSpecial clearfix" style="bottom: 1px;">                           
                       <asp:Button Text="Save" runat="server" ID="btnSave" OnClientClick="return Validate();" OnClick="btnSave_Click" CssClass="results-control col-xsm-32" />
                       <asp:Button Text="Cancel" runat="server" ID="lnkBtnCancel" OnClick="lnkBtnCancel_OnClick" CssClass="results-control col-xsm-32" />
                       <asp:Button Text="Delete" runat="server" ID="lnkBtnDelete" OnClick="lnkBtnDelete_OnClick" CssClass="results-control col-xsm-32" />

                        </div>
                  </div>    
                </div>                         
                                
                                     <div id="ConfirmBox" class="modal fade" role="dialog" aria-labelledby="confirmDeleteLabel" aria-hidden="true">
                                         <div class="modal-dialog">
                                             <div class="modal-content">
                                                 <div class="modal-header">
                                                     <button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>
                                                     <h4 class="modal-title">Success?</h4>
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


        var prm = Sys.WebForms.PageRequestManager.getInstance();
        if (prm != null) {
            prm.add_endRequest(function (sender, e) {
                if (sender._postBackSettings.panelsToUpdate != null) {
                    RegisterDatePickersAndTimers();
                }
            });
        }
        function RaiseSuccessMessage() {
            $('#ConfirmBox').modal({ backdrop: 'static', keyboard: false });
        }

        function Validate() {
            if (document.getElementById('<%=txtPropertyName.ClientID%>').value == '') {

                document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please enter Configuration name';
                $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                document.getElementById('<%=txtPropertyName.ClientID%>').focus();
                return false;
             }

            if (document.getElementById('<%=txtDailyat.ClientID%>').value == '') {

                document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please enter the Schedule time!';
                $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                document.getElementById('<%=txtDailyat.ClientID%>').focus();
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
            if (document.getElementById('<%=txtDailyatTime.ClientID%>').value == '') {
                document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please enter the Daily execution time!';
                $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                document.getElementById('<%=txtDailyatTime.ClientID%>').focus();
                return false;
            }

        }
    </script>
    <script type="text/javascript">
        //Tab routines
        function SetTabControls() {
            var readTabValue = $('input:hidden[id*="hdnSelectedTab"]').val();
            var isTab = $("#<%=hdnButtonPermission.ClientID %>").val();
            var rowscount = $("#<%=grdConfiguration.ClientID %> tr").length;
            // Code is comment because permission is not implemented, when imlemented we can remove the comment code.
            switch (readTabValue) {
                case 'property':
                    $('.nav-tabs li').removeClass('active');
                    $('.nav-tabs li.nav-tabs-property').addClass('active');
                    $('.tab-content .tab-pane').removeClass('active in');
                    $('#propertyTab').addClass('active in');
                    break;
                case 'contentTab':
                    $('.nav-tabs li').removeClass('active');
                    $('.nav-tabs li.nav-tabs-content').addClass('active');
                    $('.tab-content .tab-pane').removeClass('active in');
                    $('#manageConfigurationDetailTab').addClass('active in');
                    break;
            }
            RegisterleftDivheight();
        }

        ///Set Default tab on pageload
        function SetDefaultTab() {
            $('.nav-tabs li').removeClass('active');
            $('.nav-tabs li.nav-tabs-content').addClass('active');
            $('.tab-content .tab-pane').removeClass('active in');
            $('#manageConfigurationDetailTab').addClass('active in');

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
            var propertiesBox = $('.propertiesBox').bootstrapDualListbox({
                nonselectedlistlabel: 'Exclude',
                selectedlistlabel: 'Include',
                preserveselectiononmove: 'moved',
                moveonselect: false,
                hdnControlId: 'hdnSelectedProperties'
            });
        }

        function EnableDisableProperties() {
            if (document.getElementById("<%=chkAllProperties.ClientID%>").checked) {
                $('#dvSelectPropertiesLbl').find('select, button, input:text').prop('disabled', true);
            } else {
                $('#dvSelectPropertiesLbl').find('select, button, input:text').prop('disabled', false);
            }
        }        
        </script>
       </ContentTemplate></asp:UpdatePanel>
</asp:Content>
