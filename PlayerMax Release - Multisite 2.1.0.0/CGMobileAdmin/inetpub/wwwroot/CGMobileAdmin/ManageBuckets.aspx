<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ManageBuckets.aspx.cs" Inherits="HAMobileWebAdmin.ManageBuckets" %>

<%@ Register Src="~/UserControl/ImageUploadControl.ascx" TagPrefix="img" TagName="UploadImage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <link href="Content/css/select2.css" rel="stylesheet" />
    <script src="Scripts/CommonJS/datatables.min.js"></script>
    <link rel="stylesheet" href="Content/css/bootstrap-multiselect.css" type="text/css" />
    <script type="text/javascript" src="Scripts/CommonJS/bootstrap-multiselect.js"></script>
    <style type="text/css">
        .margin-left-20 {
            margin-left: 20px;
        }

        .margin-left-60 {
            margin-left: 10%;
        }

        .margin-top-40 {
            margin-top: 40px;
        }

        .margin-top-50 {
            margin-top: 6%;
        }

        .margin-top-120 {
            margin-top: 10%;
        }

        .grid-table {
            position: relative;
            z-index: 99;
        }
       
        img#MainContent_UploadBucketImage_imgImageUrl {
            display: block;
            max-width: 100%;
            height: auto;
        }

        .UploadDiv.UploadDiv2.col-md-12 {
            float: left;
            width: 100% !important;
        }
        body .imageMainPreview{
            width:100% !important;
        }

    </style>
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
            <asp:HiddenField runat="server" ID="hdnBucketID" />
            <asp:HiddenField runat="server" ID="hdnGvBucketSelectedIndex" Value="0" />
            <asp:HiddenField runat="server" ID="hdnButtonPermission" Value="0" />
            <asp:HiddenField runat="server" ID="hdnSelectedTab" Value="0" />
            <asp:HiddenField runat="server" ID="hdnButtonStatus" Value="Active" />
            <asp:HiddenField runat="server" ID="hdnIsImageUpdated" Value="0" />
            <asp:HiddenField runat="server" ID="hdnImageFileId1" />
            <asp:HiddenField runat="server" ID="hdnShow" />
            <div class="row">
                <div class="col-md-3">
                    <h5>Manage Buckets</h5>
                    <div class="filterWrapper relative" id="dvLeftcontentdetail">
                        <div class="clearfix">
                            <div class="pull-left">
                                <label>Bucket Type</label>
                            </div>
                            <div class="pull-right">
                                <span class="addBtn">Add
                                    <asp:Button ID="lnkbtnAdd" runat="server" OnClick="lnkbtnAdd_Click" CssClass="btn btn-add pull-right"></asp:Button>
                                </span>

                            </div>
                        </div>
                        <div class="input-group clearfix col-sm-12">
                            <asp:TextBox CssClass="form-control height26" ID="txtSearchName" runat="server"></asp:TextBox>
                            <span class="input-group-btn">
                                <asp:Button ID="btnSearch" runat="server" OnClick="btnSearch_Click" CssClass="btn btn-black glyphicons filter btn-icon white input-group-btnbtnmargin"></asp:Button>
                                <i></i>
                            </span>
                        </div>
                        <div id="divgv">
                            <asp:GridView CssClass="gridview" ID="gvBucket" runat="server" DataKeyNames="BucketID" PageSize="13" OnPageIndexChanging="gvBucket_PageIndexChanging" ShowHeader="False"
                                AutoGenerateColumns="false" AllowPaging="true">
                                <Columns>
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <asp:Label ID="lblID" runat="server" Visible="false" Text='<%#Eval("BucketID") %>' />
                                            <asp:LinkButton ID="lnkBtnShowContentDetail" runat="server" Text='<%#Eval("BucketDisplayName") %>' CommandName="Select" OnClick="lnkBtnBucketName_Click" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                                <PagerStyle CssClass="gridview-pager"></PagerStyle>
                                <SelectedRowStyle CssClass="gvSelectedRow" />
                            </asp:GridView>
                            <div id="content"></div>
                        </div>
                        <div class="filterResults relative btnGroup">
                            <div class="btn-groupSpecial">
                                <asp:Button ID="lnkbtnActive" runat="server" OnClientClick="return ConfirmMessage(4);" Text="Active" OnClick="lnkbtnActive_Click" CssClass="results-control col-xs-4 active"></asp:Button>
                                <asp:Button ID="lnkbtnInActive" runat="server" Text="InActive" OnClientClick="return ConfirmMessage(5);" OnClick="lnkbtnInActive_Click" CssClass="results-control col-xs-4"></asp:Button>
                                <asp:Button ID="lnkbtnAll" runat="server" Text="All" OnClientClick="return ConfirmMessage(6);" OnClick="lnkbtnAll_Click" CssClass="results-control col-xs-4"></asp:Button>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-sm-9">
                    <h5>Bucket Detail</h5>
                    <div id="dvRightContent" class="row clearfix relative btnGroup btnGroup3">
                        <div class="col-md-12 clearfix">
                            <div class="tabControls">
                                <ul class="nav nav-tabs">
                                    <li class="col-xsm-100 nav-tabs-content active"><span class="linkDisabledsp">&nbsp;</span><a data-toggle="tab" href="#manageBucketDetailTab" onclick="SetSelectedTab('contentTab')">Bucket Details</a></li>
                                </ul>
                                <div class="tab-pane active fade in" id="manageBucketTab">
                                    <div class="tab-container clearfix">
                                        <%--<div class="row">--%>
                                        <div class="col-md-12 marginTop">
                                            <div class="col-md-3 paddingNone">
                                                <label for="iconName">Bucket Display Name</label>
                                                <asp:TextBox ID="txtBucketDisplayName" runat="server" CssClass="form-control"></asp:TextBox>
                                            </div>
                                        </div>
                                        <%-- </div>--%>

                                        <div class="col-md-12 topMargin">
                                            <div class="col-md-3 margin-top-40 paddingNone">
                                                <label for="lblImage">
                                                    Upload Bucket Image (140x140 Pixels)
                                                </label>
                                                <img:UploadImage runat="server" ID="UploadBucketImage" CssClass="img-responsive" />
                                            </div>
                                            <div class="col-md-6 margin-top-120 margin-left-60">
                                                <div class="col-md-12">
                                                    <asp:RadioButton ID="rdIsPromo" onchange="ShowddlAwardType('hide');" AutoPostBack="false" GroupName="AwardType" runat="server" Text="Is Promo?" />

                                                </div>
                                                <div>
                                                    <asp:HiddenField ID="HdnPromoId" runat="server" />
                                                </div>
                                                <div class="col-md-12">
                                                    <asp:RadioButton ID="rdIsUniverse" onchange="ShowddlAwardType('show');" AutoPostBack="false" GroupName="AwardType" runat="server" Text="Universal Bucket?" />
                                                </div>

                                                <div class="col-md-12">
                                                    <asp:DropDownList ID="ddlAwardType" CssClass="form-control" runat="server" Width="150px">
                                                    </asp:DropDownList>
                                                </div>
                                                <div class="col-md-6">
                                                    <asp:CheckBox ID="chkShowInApp" Text="Show In App" runat="server" />

                                                </div>

                                            </div>
                                        </div>

                                    </div>
                                </div>
                            </div>
                            <div class="col-md-12 btnGroup paddingNone">
                                <div class="btn-groupSpecial clearfix">
                                    <asp:Button ID="lnkbtnSave" OnClientClick="return FormValidation();" runat="server" Text="Save" OnClick="lnkbtnSave_Click" CssClass="results-control col-xsm-32"></asp:Button>
                                    <asp:Button ID="lnkbtnCancel" runat="server" OnClientClick=" return ConfirmMessage(2);" Text="Cancel" OnClick="lnkbtnCancel_Click" CssClass="results-control col-xsm-32"></asp:Button>
                                    <asp:Button ID="lnkbtnDelete" runat="server" OnClientClick="return ConfirmMessage(3);" Text="Delete" OnClick="lnkbtnDelete_Click" Enabled="false" CssClass="results-control col-xsm-32"></asp:Button>

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
                                <button type="button" class="btn" id="btnOK" onclick="__doPostBack();" data-dismiss="modal">OK</button>
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
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
    <script type="text/javascript">

        //***************************************Start On UpdatePanel Refresh Register ImageUpload/Common Functions ************************************
        var prm = Sys.WebForms.PageRequestManager.getInstance();
        if (prm != null) {
            prm.add_endRequest(function (sender, e) {
                if (sender._postBackSettings.panelsToUpdate != null) {                    
                    RegisterUploadControls();
                    // hdnShow.Value
                    
                    if (document.getElementById('<%=hdnShow.ClientID%>').value != "") {
                        ShowddlAwardType(document.getElementById('<%=hdnShow.ClientID%>').value);
                    }

                }
            });
        };


        function RegisterUploadControls() {
            $('.UploadButton1').each(function () {
                var mainDiv = $(this).parent().parent();
                var hdnImageUrl = $(mainDiv).find('input:hidden[id*="hdnImageUrl"]');
                var hdnSetImageUrl = $(mainDiv).find('input:hidden[id*="hdnSetDefaultImageUrl"]');
                var imgImageUrl = $(this).parent().parent().find('img[id*="imgImageUrl"]');
                UploadControlHandler($(this), $(hdnImageUrl).prop('id'), $(imgImageUrl).prop('id'), $(hdnSetImageUrl).prop('id'));
            });
        }

        function UploadControlHandler(control, ImageUrlHf, ImageUrlImg, ImageSetUrlImg) {

            new AjaxUpload('#' + $(control).prop('id') + '', {
                action: 'FileUpload.ashx',
                onComplete: function (file, response) {
                    var height = 0;
                    var width = 0;
                    var res = response.split('-');
                    var img = new Image();
                    img.src = res[2];

                    height = 140;
                    width = 140;

                    setTimeout(function () {
                        if (img.width != width) {
                            document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'File width should be ' + width + '.';
                            $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                        }
                        else if (img.height != height) {
                            document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'File height should be ' + height + '.';
                            $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                        }

                        else {
                            $('#' + ImageUrlHf).val(response);
                            $('#' + ImageUrlImg).attr('src', res[2]);
                            $('#' + ImageSetUrlImg).val(res[2]);
                            $('#<%=hdnIsImageUpdated.ClientID%>').val('1');
                        }

                    }, 100);

                },
                onSubmit: function (file, ext) {

                    if (!(ext && /^(jpg|png|jpeg|gif)$/.test(ext))) {
                        document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Invalid File Format.';
                        $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                        return false;
                    }

                }
            });
        }





        function SetEnvironment() {
            document.getElementById("MainContent_hdnEnvironmentType").value = document.getElementById('MainContent_ddlEnvironment').options[document.getElementById('MainContent_ddlEnvironment').selectedIndex].text;
        }
        function RegisterDetectedFormChanges() {
            $.each($("input:text"), function (index, element) {
                element.defaultValue = $(element).val();
            });
        }

        function FormValidation() {
            var activeTab = $('input:hidden[id*="hdnSelectedTab"]').val();

            // Start EventDetails Validation        
            if (myTrim(document.getElementById('<%=txtBucketDisplayName.ClientID%>').value) == '') {

                document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please enter bucket name.';
                $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                document.getElementById('<%=txtBucketDisplayName.ClientID%>').focus();
                return false;
            }

            if (document.getElementById('<%=hdnIsImageUpdated.ClientID%>').value == '0') {
                document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please upload a bucket image.';
                $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                return false;
            }
            if (document.getElementById('<%=rdIsUniverse.ClientID%>').checked == true) {
                if (document.getElementById('<%=ddlAwardType.ClientID%>').selectedIndex == 0) {
                    document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please select a universal bucket.';
                    $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                    document.getElementById('<%=ddlAwardType.ClientID%>').focus();
                    return false;
                }
            }
            var validation = ConfirmMessage(1);
            if (validation == false) {
                return false;
            }
            else {
                return true;
            }
        }

        function myTrim(x) {
            return x.replace(/\s/g, '').replace('-', '');
        }

        ///Confirmation message after delete/save/cancel button onclick
        function ConfirmMessage(flag) {
            var savemsg = 'Are you sure to save this Bucket?';
            var cancelmsg = 'Are you sure to discard current changes?';
            var deletemsg = 'Are you sure to delete this Bucket?';

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
                }
                else if (flag == 2) {
                    $('#<%=btnConfirmedSave.ClientID%>').hide();
                    $('#<%=btnConfirmedCancel.ClientID%>').show();
                    $('#<%=btnConfirmedDelete.ClientID%>').hide();
                    $('#<%=btnConfirmedActive.ClientID%>').hide();
                    $('#<%=btnConfirmedInActive.ClientID%>').hide();
                    $('#<%=btnConfirmedAll.ClientID%>').hide();
                    $('#ConfirmBoxMessage').html(cancelmsg);
                }
                else if (flag == 3) {
                    $('#<%=btnConfirmedSave.ClientID%>').hide();
                    $('#<%=btnConfirmedCancel.ClientID%>').hide();
                    $('#<%=btnConfirmedDelete.ClientID%>').show();
                    $('#<%=btnConfirmedActive.ClientID%>').hide();
                    $('#<%=btnConfirmedInActive.ClientID%>').hide();
                    $('#<%=btnConfirmedAll.ClientID%>').hide();
                    $('#ConfirmBoxMessage').html(deletemsg);
                }
                else if (flag == 4) {
                    $('#<%=btnConfirmedSave.ClientID%>').hide();
                    $('#<%=btnConfirmedCancel.ClientID%>').hide();
                    $('#<%=btnConfirmedDelete.ClientID%>').hide();
                    $('#<%=btnConfirmedActive.ClientID%>').show();
                    $('#<%=btnConfirmedInActive.ClientID%>').hide();
                    $('#<%=btnConfirmedAll.ClientID%>').hide();
                    $('#ConfirmBoxMessage').html(cancelmsg);
                }
                else if (flag == 5) {
                    $('#<%=btnConfirmedSave.ClientID%>').hide();
                    $('#<%=btnConfirmedCancel.ClientID%>').hide();
                    $('#<%=btnConfirmedDelete.ClientID%>').hide();
                    $('#<%=btnConfirmedActive.ClientID%>').hide();
                    $('#<%=btnConfirmedInActive.ClientID%>').show();
                    $('#<%=btnConfirmedAll.ClientID%>').hide();
                    $('#ConfirmBoxMessage').html(cancelmsg);
                }
                else if (flag == 6) {
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
else if (flag == 2) {
    return true;
}
}


    </script>
    <script type="text/javascript">
        //Tab routines
        function SetTabControls() {
            var readTabValue = $('input:hidden[id*="hdnSelectedTab"]').val();
            var isTab = $("#<%=hdnButtonPermission.ClientID %>").val();
            var rowscount = $("#<%=gvBucket.ClientID %> tr").length;
            // Code is comment because permission is not implemented, when imlemented we can remove the comment code.
            switch (readTabValue) {
                case 'contentTab':
                    $('.nav-tabs li').removeClass('active');
                    $('.nav-tabs li.nav-tabs-content').addClass('active');
                    $('.tab-content .tab-pane').removeClass('active in');
                    $('#manageBucketDetailTab').addClass('active in');
                    break;
            }
            RegisterleftDivheight();
        }

        ///Set Default tab on pageload
        function SetDefaultTab() {
            $('.nav-tabs li').removeClass('active');
            $('.nav-tabs li.nav-tabs-content').addClass('active');
            $('.tab-content .tab-pane').removeClass('active in');
            $('#manageBucketDetailTab').addClass('active in');
            RegisterleftDivheight();
        }

        function SetSelectedTab(selectedTab) {
            $('input:hidden[id*="hdnSelectedTab"]').val(selectedTab);
            SetTabControls();
        }

        function RegisterleftDivheight() {
            $("#dvLeftcontentdetail").height($('#dvRightContent').height());
        }

        //Upload Image

        $(document).ready(function () {

            //ShowddlAwardType(null);
            $('input[type="radio"]').click(function () {

                var inputValue = $(this).attr("value");

                if (inputValue == 'rdIsPromo') {
                    $("#<%=ddlAwardType.ClientID %>").hide();
                }
                else if (inputValue == 'rdIsUniverse') {

                    $("#<%=ddlAwardType.ClientID %>").show();
                }
            });
        });


        function ShowddlAwardType(e) {           
        if (e == "show") {
            $("#<%=ddlAwardType.ClientID %>").show();
        }
        else {
            $("#<%=ddlAwardType.ClientID %>").hide();
        }
    }

    </script>

</asp:Content>

