<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ManageIcon.aspx.cs" Inherits="HAMobileWebAdmin.ManageIcon" %>

<%@ Register Src="~/UserControl/ImageUploadControl.ascx" TagPrefix="img" TagName="ImageUploadControl" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <link href="Content/css/scroll.css" rel="stylesheet" />
    <link href="Content/css/select2.css" rel="stylesheet" />
    <script src="Scripts/CommonJS/datatables.min.js"></script>
    <script src="Scripts/CommonJS/scroll.js"></script>
    <script src="Scripts/select2.js"></script>
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
            <asp:HiddenField runat="server" ID="hdnEnvironmentType" />
            <asp:HiddenField runat="server" ID="hdnIconId" />
            <asp:HiddenField runat="server" ID="hdnIconFileId" />
            <asp:HiddenField runat="server" ID="hdnImageFileId1" />
            <asp:HiddenField runat="server" ID="hdnGvSelectedIndex" Value="0" />
             

            <asp:HiddenField runat="server" ID="hdnButtonSatus" Value="Active" />
            <asp:HiddenField runat="server" ID="hdnIsPermissionDelete" Value="1" />
            <asp:HiddenField runat="server" ID="hdnSelectedTab" Value="contentTab" />
            <asp:HiddenField runat="server" ID="hdnStatus" />

            <div class="row" style="margin-top: 20px; margin-bottom: 10px;">
                <div class="col-md-3">
                    <h5>Icon Management</h5>
                    <div class="filterWrapper relative" id="dvLeftcontentdetail">

                        <div class="clearfix">
                            <div class="pull-left">
                                <label>Icon</label>
                            </div>
                            <div class="pull-right">

                                <span class="addBtn">Add
                                    <asp:Button ID="lnkbtnAdd" runat="server" CssClass="btn btn-add pull-right" OnClick="lnkbtnAdd_Click"></asp:Button></span>
                            </div>
                        </div>



                        <div class="input-group clearfix col-sm-12">
                            <asp:TextBox ID="txtIconSearch" runat="server" CssClass="form-control height26"></asp:TextBox>
                            <span class="input-group-btn">
                                <asp:Button ID="btnIconFilter" runat="server" class="btn btn-black glyphicons filter btn-icon white input-group-btnbtnmargin"  OnClick="btnIconFilter_Click" /><%--OnClick="btnAwardFilter_Click"--%>
                                <i></i></button>
                            </span>

                        </div>

                        <div>
                            <div id="" class="gridview2 relative" style="height: 395px;">
                                <asp:GridView CssClass="gridview" ID="gvIcon" runat="server" ShowHeader="False" AutoGenerateColumns="false" DataKeyNames="ID" AllowPaging="true" PageSize="12" OnPageIndexChanging="gvIcon_PageIndexChanging">
                                    <Columns>
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <asp:Label ID="lblID" runat="server" Visible="false" Text='<%#Eval("ID") %>' />
                                                <asp:LinkButton ID="lnkBtnShowIconDetail" runat="server" Text='<%#Eval("IconName") %>' CommandName="Select" OnClick="lnkBtnShowIconDetail_Click" />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                    <PagerStyle CssClass="gridview-pager"></PagerStyle>
                                    <SelectedRowStyle CssClass="gvSelectedRow" />
                                </asp:GridView>
                              
                            </div>
                        </div>

                        <div id="dvLeftContent" class="filterResults relative btnGroup" style="top: auto; height: 22px !important;">
                            <div class="btn-groupSpecial">
                                <asp:Button ID="lnkbtnActive" runat="server" Text="active" CssClass="results-control col-xs-4" OnClick="lnkbtnActive_Click"></asp:Button>
                                <asp:Button ID="lnkbtnInactive" runat="server" Text="inactive" CssClass="results-control col-xs-4" OnClick="lnkbtnInactive_Click"></asp:Button>
                                <asp:Button ID="lnkbtnAll" runat="server" Text="all" CssClass="results-control col-xs-4" OnClick="lnkbtnAll_Click"></asp:Button>
                            </div>
                        </div>

                    </div>

                </div>
                <div class="col-md-9">
                    <h5>Icon Management Details</h5>

                    <div class="row clearfix relative btnGroup btnGroup3" id="dvRightContent">
                        <div class="col-md-12 clearfix">
                            <div class="tabControls">
                                <div class="tab-pane">
                                    <ul class="nav nav-tabs">                                       
                                        <li class="col-xsm-100 nav-tabs-content active"><span class="linkDisabledsp">&nbsp;</span><a data-toggle="tab" href="#contentTab" id="manageContentTabLink" onclick="SetSelectedTab('contentTab')">Icon Content</a></li>
                                    </ul>

                                    <div class="tab-content">                                        

                                        <!--Icon  content Tab Starts-->
                                        <div class="tab-pane fade in" id="contentTab">
                                            <div class="tab-container clearfix">
                                                <div class="col-md-12">
                                                    <div  class="row clearfix relative btnGroup btnGroup3">
                                                        <div class="row">
                                                            <div class="col-md-12">
                                                                <div class="col-md-4">
                                                                    <label for="iconName">Icon Name</label>
                                                                    <asp:TextBox CssClass="form-control" ID="txtIconName" MaxLength="250" runat="server"></asp:TextBox>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="row">
                                                            <div class="col-md-12">
                                                                <div class="col-md-4">
                                                                    <label for="iconContentType">Content Type</label>
                                                                    <asp:DropDownList ID="ddlEnvironment"  runat="server" CssClass="form-control" onchange="SetEnvironment()">
                                                                        <asp:ListItem Value="0">Production</asp:ListItem>
                                                                        <asp:ListItem Value="1">Test</asp:ListItem>
                                                                    </asp:DropDownList>
                                                                </div>

                                                            </div>
                                                        </div>
                                                        <div class="row">
                                                            <div class="col-md-12">
                                                                <div class="col-md-5 three-column imgpreview131">
                                                                    <label>Icon Image
                                                                        <br>
                                                                        (Upload Image 64x64 Pixels)</label>
                                                                    <asp:Image EnableViewState="True" CssClass="imageMainPreview" ID="imgIconImageUrl" Style="width: 50px; height: 50px;" runat="server" />
                                                                    <asp:HiddenField runat="server" ID="hdnIconImageUrl" />
                                                                    <div class="UploadDiv mt20 col-xs-12 relative">
                                                                        <span class="linkDisabledsp">&nbsp;</span>
                                                                        <div id="UploadStatus">
                                                                        </div>
                                                                        <button type="button" id="btnIconUploadImage" class="UploadButton1"></button>
                                                                        <div id="UploadedFile">
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="row">
                                                            <div class="col-md-12">
                                                                <div class="col-md-3">
                                                                    <asp:CheckBox ID="menuActive" Text="Active?" Visible="True" runat="server" />
                                                                </div>
                                                            </div>
                                                        </div>
                                                      

                                                    </div>


                                                </div>
                                            </div>
                                        </div>
                                        <!--Icon  content Tab End -->

                                    </div>
                                </div>
                            </div>
                            <div class="col-md-12 btnGroup2">
                                <div class="btn-groupSpecial clearfix">
                                    <asp:Button ID="lnkbtnSave" runat="server" Text="Save"  CssClass="results-control col-xsm-32" OnClick="lnkbtnSave_Click"></asp:Button>
                                    <asp:Button ID="lnkbtnCancel" runat="server" OnClientClick=" return ConfirmMessage(2);" Text="Cancel" CssClass="results-control col-xsm-32" OnClick="lnkbtnCancel_Click"></asp:Button>
                                    <asp:Button ID="lnkbtnDelete" runat="server" OnClientClick=" return ConfirmMessage(3);" Text="Delete" CssClass="results-control col-xsm-32" OnClick="lnkbtnDelete_Click"></asp:Button>
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
                            <asp:Button ID="btnConfirmedCancel" CssClass="btn btn-danger" runat="server" Text="OK" UseSubmitBehavior="false" data-dismiss="modal"  OnClick="lnkbtnCancel_Click" Style="display: none;"></asp:Button>
                            <asp:Button ID="btnConfirmedDelete" CssClass="btn btn-danger" runat="server" Text="OK" UseSubmitBehavior="false" data-dismiss="modal"  OnClick="lnkbtnDelete_Click" Style="display: none;"></asp:Button>
                            <button type="button" class="btn" id="confirm" data-dismiss="modal">Cancel</button>
                        </div>
                    </div>
                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
    <script type="text/javascript">

        //On UpdatePanel Refresh
        var prm = Sys.WebForms.PageRequestManager.getInstance();
        if (prm != null) {
            prm.add_endRequest(function (sender, e) {
                if (sender._postBackSettings.panelsToUpdate != null) {
                    RegisterUploadControls();
                    RegisterDetectedFormChanges();
                }
            });
        }
        $(document).ready(function () {
            RegisterUploadControls();
            RegisterDetectedFormChanges();
            SetDefaultTab();
        });

        function SetEnvironment() {
            document.getElementById("MainContent_hdnEnvironmentType").value = document.getElementById('MainContent_ddlEnvironment').options[document.getElementById('MainContent_ddlEnvironment').selectedIndex].text;
        }
        function RegisterDetectedFormChanges() {
            $.each($("input:text"), function (index, element) {
                element.defaultValue = $(element).val();
            });
        }
        //Upload Image
        function RegisterUploadControls() {
            ///upload GamesBingo
            new AjaxUpload('#btnIconUploadImage', {
                action: 'FileUpload.ashx',
                onComplete: function (file, response) {
                    var res = response.split("-");
                    var img = new Image();
                    img.src = res[2];
                    setTimeout(function () {
                        document.getElementById("MainContent_imgIconImageUrl").src = res[2];
                        document.getElementById("MainContent_hdnIconImageUrl").value = response;

                        if (img.height > 64) {
                            document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'File height should not exceed 64.';
                            $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                            document.getElementById("MainContent_imgIconImageUrl").src = "";
                        }
                        else if (img.width > 64) {                           
                            document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'File width should not exceed 64.';
                            $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                            document.getElementById("MainContent_imgIconImageUrl").src="";
                        }
                        else {
                            document.getElementById("MainContent_imgIconImageUrl").src = res[2];
                            document.getElementById("MainContent_hdnIconImageUrl").value = response;
                        }

                    }, 100);


                },
                onSubmit: function (file, ext) {

                    if (!(ext && /^(ico|icon|jpg|png|jpeg|gif)$/.test(ext))) {
                        alert('Invalid File Format.');
                        return false;
                    }

                }
            });
        }
        ///Confirmation message after delete/save/cancel button onclick
        function ConfirmMessage(flag) {
            var savemsg = 'Are you sure to save this Icon?';
            var cancelmsg = 'Are you sure to discard current changes?';
            var deletemsg = 'Are you sure to delete this Icon?';

            var isChange = FormChanges('from1');

            if (isChange != "") {
                var message = '';
                if (flag == 1) {
                    $('#<%=btnConfirmedSave.ClientID%>').show();
                    $('#<%=btnConfirmedCancel.ClientID%>').hide();
                    $('#<%=btnConfirmedDelete.ClientID%>').hide();
                    $('#ConfirmBoxMessage').html(savemsg);
                }
                else if (flag == 2) {
                    $('#<%=btnConfirmedSave.ClientID%>').hide();
                    $('#<%=btnConfirmedCancel.ClientID%>').show();
                    $('#<%=btnConfirmedDelete.ClientID%>').hide();
                    $('#ConfirmBoxMessage').html(cancelmsg);
                }
                else if (flag == 3) {
                    $('#<%=btnConfirmedSave.ClientID%>').hide();
                    $('#<%=btnConfirmedCancel.ClientID%>').hide();
                    $('#<%=btnConfirmedDelete.ClientID%>').show();
                    $('#ConfirmBoxMessage').html(deletemsg);
                }
        $('#ConfirmBox').modal({ backdrop: 'static', keyboard: false });
        return false;
    }
    else if (flag == 3) {
        $('#<%=btnConfirmedSave.ClientID%>').hide();
                $('#<%=btnConfirmedCancel.ClientID%>').hide();
                $('#<%=btnConfirmedDelete.ClientID%>').show();
                $('#ConfirmBoxMessage').html(deletemsg);
                $('#ConfirmBox').modal({ backdrop: 'static', keyboard: false });
                return false;
            }
            else if (flag == 2) {
                return true;
            }
    }
    $('#ConfirmBox').on('show.bs.modal', function (e) {

    });

    function ToggleImageAttachControl(flag) {
        if (flag === 'true') {
            $('.UploadDiv').removeClass('dsb'); //enable
        }
        else {
            $('.UploadDiv').addClass('dsb');
        }
    }

        //---------------------------------------------------------------------------------

      function SetSelectedTab(selectedTab) {
        var selected = selectedTab;
        $('#<%=hdnSelectedTab.ClientID%>').val(selectedTab);
                SetActiveTab();
            }


            function SetActiveTab() {
                var rowscount = $("#<%=gvIcon.ClientID %> tr").length;
                var activeTab = $('input:hidden[id*="hdnSelectedTab"]').val();
                var isTab = $("#<%=hdnButtonSatus.ClientID %>").val();
             var isPermissionDelete = $("#<%=hdnIsPermissionDelete.ClientID %>").val();
                switch (activeTab) {                    
                    case 'contentTab':
                        $('.nav-tabs li').removeClass('active');
                        $('.nav-tabs li.nav-tabs-content').addClass('active');
                        $('.tab-content .tab-pane').removeClass('active in');
                        $('#contentTab').addClass('active in');
                }
                RegisterLeftDivheight();
            }

        //Set Left content height.
        function RegisterLeftDivheight() {
            $("#dvLeftcontentdetail").height($('#dvRightContent').height());
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

        function SetDefaultTab() {
            $('.nav-tabs li').removeClass('active');
            $('.nav-tabs li.nav-tabs-content').addClass('active');
            $('.tab-content .tab-pane').removeClass('active in');
            $('#contentTab').addClass('active in');

        }

     
        //function DisableContent() {
        //    if ($("#chkAllProperties").prop('checked')) {
        //        $('#dvSelectPropertiesLbl').find('select, button, input:text').prop('disabled', true);
        //    }
        //    else {
        //        $('#dvSelectPropertiesLbl').find('select, button, input:text').prop('disabled', false);
        //    }
        //}

    </script>
</asp:Content>
