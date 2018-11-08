<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AwardBuilder.aspx.cs" EnableViewState="true" MasterPageFile="~/Site.Master" Inherits="HAMobileWebAdmin.AwardBuilder" %>

<asp:Content runat="server" ID="Content1" ContentPlaceHolderID="HeadContent">    
</asp:Content>
<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">
    <script src="Scripts/CommonJS/datatables.min.js"></script>

    <div style="text-align: center;">
        <asp:UpdateProgress ID="updateProgress" runat="server" AssociatedUpdatePanelID="updpnlAwardBuilder">
            <ProgressTemplate>
                <div style="position: fixed; text-align: center; height: 100%; width: 100%; top: 0; right: 0; left: 0; z-index: 9999999; background-color: #000000; opacity: 0.7;">
                    <asp:Image ID="imgUpdateProgress" runat="server" ImageUrl="Content/img/loader.gif" AlternateText="Loading ..." ToolTip="Loading ..." Style="padding: 10px; position: fixed; top: 45%; left: 50%;" />
                </div>
            </ProgressTemplate>
        </asp:UpdateProgress>
    </div>

    <asp:UpdatePanel ID="updpnlAwardBuilder" runat="server">
        <ContentTemplate>
            <asp:HiddenField runat="server" ID="hdnButtonPermission" Value="0" />
             <asp:HiddenField runat="server" ID="hdnAwardID" />
            <asp:HiddenField runat="server" ID="hdnSelectedTab" Value="0" />
            <div class="row">
                <div class="col-md-3">
                    <h5>Award Builder</h5>
                    <div class="filterWrapper relative" id="dvLeftcontentdetail">

                        <div class="clearfix">
                            <div class="pull-left">
                                <label>Awards</label>
                            </div>
                            <div class="pull-right">

                                <span class="addBtn">Add
                                    <asp:Button ID="btnAddAward" runat="server" OnClick="btnAddAward_Click" CssClass="btn btn-add pull-right"></asp:Button></span>

                            </div>
                        </div>
                        <div class="input-group clearfix col-sm-12">
                            <asp:TextBox ID="txtAwardSearch" runat="server" CssClass="form-control height26"></asp:TextBox>
                            <span class="input-group-btn">
                                <asp:Button ID="btnAwardFilter" runat="server" class="btn btn-black glyphicons filter btn-icon white input-group-btnbtnmargin" OnClick="btnAwardFilter_Click" />
                                <i></i></button>
                            </span>

                        </div>

                        <div class="new-select">
                            <asp:DropDownList ID="ddlAwardTypeFilter" AutoPostBack="true" runat="server" CssClass="form-control jq-selectbox" Visible="false" OnSelectedIndexChanged="ddlAwardTypeFilter_SelectedIndexChanged">
                            </asp:DropDownList>
                        </div>
                        <div id="divgv">
                            <asp:HiddenField runat="server" ID="hdnGvSelectedIndex" Value="0" />
                            <asp:GridView CssClass="gridview" ID="gvAwardBuilder" runat="server" ShowHeader="False" AutoGenerateColumns="false"
                                DataKeyNames="AwardTypeID,AwardID" AllowPaging="true" PageSize="10"
                                OnPageIndexChanging="gvAwardBuilder_PageIndexChanging">
                                <Columns>

                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <asp:Label ID="lblMessageID" runat="server" Visible="false" Text='<%#Eval("AwardID") %>' />
                                            <asp:LinkButton ID="lnkBtnAwardName" runat="server" CommandArgument='<%#Eval("AwardID") %>' Text='<%#Eval("AwardName") %>' OnCommand="lnkBtnAwardName" />

                                        </ItemTemplate>

                                    </asp:TemplateField>
                                </Columns>
                                <PagerStyle CssClass="gridview-pager"></PagerStyle>
                                <SelectedRowStyle CssClass="gvSelectedRow" />
                            </asp:GridView>
                            <div id="content"></div>

                        </div>
                        <div id="dvLeftContent" class="filterResults relative btnGroup">
                            <div class="btn-groupSpecial">
                                <asp:Button ID="lnkbtnActiveMessage" runat="server" Text="active" CssClass="results-control col-xs-4" OnClick="lnkbtnActiveAwards_Click"></asp:Button>
                                <asp:Button ID="lnkbtnInactiveMessage" runat="server" Text="inactive" CssClass="results-control col-xs-4" OnClick="lnkbtnInactiveAwards_Click"></asp:Button>
                                <asp:Button ID="lnkbtnAllMessage" runat="server" Text="all" CssClass="results-control col-xs-4" OnClick="lnkbtnAllAwards_Click"></asp:Button>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-9">
                    <h5>Award Details</h5>
                    <div class="row clearfix relative btnGroup btnGroup3" id="dvRightContent">
                        <div class="tabControls" style="padding: 0 15px;">
                            <ul class="nav nav-tabs">
                                <li class="col-xsm-50 nav-tabs-property"><span class="linkDisabledsp">&nbsp;</span><a onclick="SetSelectedTab('property');" data-toggle="tab" href="#propertyTab">Property</a></li>
                                <li class="col-xsm-50 nav-tabs-content active"><span class="linkDisabledsp">&nbsp;</span><a data-toggle="tab" href="#manageAwardDetailTab" onclick="SetSelectedTab('contentTab')">Configuration Details</a></li>
                            </ul>
                            <div class="tab-content">
                                <!--Property Tab Starts-->
                                <div class="tab-pane fade in" id="propertyTab">
                                    <div class="tab-container clearfix">
                                        <div class="col-md-12">
                                            <div class="row" id="dvTabLbl">
                                                <div class="col-md-4 top-margin-one">
                                                    <label>Define Assigned Properties</label>
                                                </div>
                                            </div>
                                            <div class="row" id="dvAllProperties">
                                                <div class="col-md-4 top-margin-one">
                                                    <asp:CheckBox ID="chkAllProperties" Text="All Properties" AutoPostBack="true" OnClick="JavaScript:EnableDisableProperties()" OnCheckedChanged="chkAllProperties_AllPropertiesChanged" Visible="True" runat="server" />
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

                                <!-- Award Tab Starts -->
                                <div class="tab-pane active fade in" id="manageAwardDetailTab">
                                    <div class="tab-container  clearfix">
                                        <div class="col-md-4">
                                            <div class="form-group">
                                                <label>Award Name</label>
                                                <asp:TextBox ID="txtAwardName" MaxLength="250" runat="server" CssClass="form-control"></asp:TextBox>
                                                <label>Award Description</label>
                                                <asp:TextBox ID="txtAwardDescription" TextMode="MultiLine" runat="server" CssClass="form-control" MaxLength="1000"></asp:TextBox>
                                                <label>Award Type</label>
                                                <asp:DropDownList ID="ddlAwardType" runat="server" Enabled="False" CssClass="form-control"></asp:DropDownList>
                                                <label>Award Quantity</label>
                                                <asp:TextBox ID="txtAwardQuantity" runat="server" CssClass="form-control numeric" MaxLength="10"></asp:TextBox>
                                                <label>Award Value</label>
                                                <asp:TextBox ID="txtAwardValue" runat="server" CssClass="form-control numeric" MaxLength="10"></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="col-md-8" style="display: none">
                                            <div class="fieldset">

                                                <fieldset class="switchExpirationWrap">
                                                    <legend>
                                                        <asp:CheckBox ID="chkDefineAwardExpiration" runat="server" Text="Define Expiration" />
                                                    </legend>
                                                    <div class="clearfix fieldSwitch" id="dvDefineAwardExpiration">
                                                        <div class="col-sm-5 switchExpiration">

                                                            <asp:RadioButton ID="rdbFixedExpiration" Checked="true" runat="server" Text="Fixed Expiration" GroupName="FixedExp" />
                                                            <asp:RadioButton ID="rdbRollingExpiration" Text="Rolling Expiration" GroupName="FixedExp" runat="server" />


                                                        </div>
                                                        <div class="col-sm-7">
                                                            <div id="fixedExpiration" class="col-xs-9">
                                                                <label for="FixedExpiration">Expiration Date</label>
                                                                <div class="input-group date datePickers" data-date-format="mm-dd-yyyy">
                                                                    <asp:TextBox ID="txtExpirationDate" CssClass="form-control datePickers" runat="server" MaxLength="15"></asp:TextBox>
                                                                    <span class="input-group-addon" id="Span3"><i class="icon-th"></i></span>
                                                                </div>
                                                            </div>


                                                            <div id="exPeriodWrap">
                                                                <label for="exCount">Count</label>
                                                                <asp:TextBox ID="txtFixedExpirationCount" runat="server" CssClass="form-control numeric" MaxLength="10"></asp:TextBox>
                                                                <label>Period</label>
                                                                <asp:DropDownList ID="ddlExpirationPeriod" runat="server" CssClass="form-control">
                                                                    <asp:ListItem Value="D" Selected="True" Text="Days from Date Earned"></asp:ListItem>
                                                                </asp:DropDownList>

                                                            </div>
                                                        </div>
                                                    </div>
                                                </fieldset>


                                            </div>
                                            <%--       <div class="fieldset2">
                                <fieldset>
                                    <legend>
                                        <asp:CheckBox ID="chkDefineBarcode" runat="server" Text="Define Barcode" />
                                    </legend>
                                    <div class="clearfix fieldSwitch">
                                        <div class="col-sm-6">
                                            <asp:CheckBox ID="chkTounamentID" runat="server" Text="Tournament ID" />
                                            <asp:CheckBox ID="chkPromotionEventAward" runat="server" Text="Promotion Event Award" />

                                        </div>
                                        <div class="col-sm-6">
                                            <asp:CheckBox ID="chkPlayerID" runat="server" Text="Player ID" />
                                            <asp:CheckBox ID="chkRedemptionID" runat="server" Text="Redemption ID" />

                                        </div>
                                    </div>
                                </fieldset>
                            </div>--%>
                                        </div>
                                        <%--       <div class="col-md-12">
                            <div class="fieldset">
                                <fieldset>
                                    <legend>
                                        <asp:CheckBox ID="chkDefineVoucherText" runat="server" Text="Define Voucher Text" />
                                    </legend>
                                    <div class="clearfix fieldSwitch">
                                        <label for="disclaimerText">Disclaimer Text</label>
                                        <div class="textarea-wrap">
                                            <asp:TextBox ID="txtDisclaimerText" TextMode="MultiLine" runat="server" CssClass="form-control ruledText" MaxLength="1000"></asp:TextBox>
                                        </div>
                                        <label for="finePrintText">Fine Print</label>
                                        <div class="textarea-wrap">
                                            <asp:TextBox ID="txtFinePrintText" TextMode="MultiLine" runat="server" CssClass="form-control ruledText" MaxLength="1000"></asp:TextBox>
                                        </div>
                                    </div>
                                </fieldset>
                            </div>
                        </div>--%>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-12 btnGroup" style="padding:0;">
                                <div class="btn-groupSpecial clearfix" >
                                    <asp:Button ID="lnkbtnSave" runat="server" Text="Save" OnClick="lnkbtnSave_Click" OnClientClick="return FormValidation()" CssClass="results-control col-xsm-32"></asp:Button>
                                    <asp:Button ID="lnkbtnCancel" runat="server" Text="Cancel" OnClick="lnkbtnCancel_Click" CssClass="results-control col-xsm-32"></asp:Button>
                                    <asp:Button ID="lnkbtnDelete" runat="server" Text="Delete" OnClick="lnkbtnDelete_Click" CssClass="results-control col-xsm-32"></asp:Button>
                                </div>
                            </div>
                        </div>
                        <script type="text/ecmascript">


                            $(document).ready(function () {
                                $("#dvLeftcontentdetail").height($('#dvRightContent').height());
                                setPageSize();
                                isNumber();
                            });
                            ///Page validations
                            function FormValidation() {
                                var activeTab = $('input:hidden[id*="hdnSelectedTab"]').val();
                                if (myTrim($('#<%=hdnSelectedProperties.ClientID%>').val()) == '' &&
                            $('#<%=chkAllProperties.ClientID%>').attr("checked") != "checked") {
                                    document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please Include atleast one Property.';
                                    $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                                    document.getElementById('<%=chkAllProperties.ClientID%>').focus();
                        SetDefaultTab();
                        return false;
                    }

                    if (myTrim(document.getElementById('<%=txtAwardName.ClientID%>').value) == '') {
                                    document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please enter award name';
                        $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                        document.getElementById('<%=txtAwardName.ClientID%>').focus();
                        return false;
                    }
                     <%-- if ($('#<%=chkDefineBarcode.ClientID%>')[0].checked == false) {

                          document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please select define barcode';
                          $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                          document.getElementById('<%=txtFixedExpirationCount.ClientID%>').focus();
                          return false;

                      }--%>
                                if ($('#<%=chkDefineAwardExpiration.ClientID%>')[0].checked == true && $('#<%=rdbRollingExpiration.ClientID%>')[0].checked == true) {
                                    if (document.getElementById('<%=txtFixedExpirationCount.ClientID%>').value == '') {
                            document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please enter count';
                            $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                            document.getElementById('<%=txtFixedExpirationCount.ClientID%>').focus();
                              return false;
                          }
                      }
                      if ($('#<%=chkDefineAwardExpiration.ClientID%>')[0].checked == true && $('#<%=rdbFixedExpiration.ClientID%>')[0].checked == true) {
                                    if (document.getElementById('<%=txtExpirationDate.ClientID%>').value == '') {
                              document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please enter expiration date';
                            $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                            document.getElementById('<%=txtExpirationDate.ClientID%>').focus();
                              return false;
                          }
                      }
                                <%-- if ($('#<%=chkDefineBarcode.ClientID%>')[0].checked == true && ($('#<%=chkTounamentID.ClientID%>')[0].checked == false && $('#<%=chkPlayerID.ClientID%>')[0].checked == false && $('#<%=chkPromotionEventAward.ClientID%>')[0].checked == false && $('#<%=chkRedemptionID.ClientID%>')[0].checked == false)) {

                          document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Select at least one of the barcode';
                          $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                          document.getElementById('<%=chkDefineBarcode.ClientID%>').focus();
                          return false;
                      } --%>                    
                      <%--if ($('#<%=chkDefineVoucherText.ClientID%>')[0].checked == true ) {
                          if (myTrim(document.getElementById('<%=txtDisclaimerText.ClientID%>').value) == '' && myTrim(document.getElementById('<%=txtFinePrintText.ClientID%>').value) == '') {
                              document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please enter  at least one line of disclaimer text or fine print.';
                              $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                              document.getElementById('<%=txtFixedExpirationCount.ClientID%>').focus();
                              return false;
                          }
                      }--%>


                            }
                            function setPageSize() {

                                $('.datePickers').datepicker({
                                    autoclose: true,
                                    todayBtn: true,
                                    todayHighlight: true
                                });

                                //  Time Picker
                                $('.timePickers').timepicker();
                                $("#dvLeftcontentdetail").height($('#dvRightContent').height());

                                if ($('#MainContent_rdbRollingExpiration').is(':checked')) {
                                    $('#fixedExpiration').fadeOut(200);
                                    $('#exPeriodWrap').fadeIn(200);
                                }

                                if ($('#MainContent_rdbFixedExpiration').is(':checked')) {
                                    $('#exPeriodWrap').fadeOut(200);
                                    $('#fixedExpiration').fadeIn(200);
                                }
                                $('#MainContent_rdbRollingExpiration').on('change', function () {
                                    if ($(this).is(':checked')) {
                                        $('#fixedExpiration').fadeOut(200);
                                        $('#exPeriodWrap').fadeIn(200);

                                    }
                                });
                                $('#MainContent_rdbFixedExpiration').on('change', function () {
                                    if ($(this).is(':checked')) {
                                        $('#exPeriodWrap').fadeOut(200);
                                        $('#fixedExpiration').fadeIn(200);
                                    }
                                });




                                var fieldSwitch = $('.fieldset .fieldSwitch');
                                var legendSwitch = $('.fieldset legend input');
                                if (legendSwitch.is(':checked')) {
                                    fieldSwitch.find('input, select, textarea').prop('disabled', false);
                                    fieldSwitch.find('.input-group-addon').parent().removeClass('dis');
                                }
                                else {
                                    fieldSwitch.find('input, select, textarea').prop('disabled', true);
                                    fieldSwitch.find('.input-group-addon').parent().addClass('dis');
                                }
                                legendSwitch.on('click', function () {
                                    if ($(this).is(':checked')) {
                                        $(this).parent().next('.fieldSwitch').find('input, select, textarea').prop('disabled', false);
                                        $(this).parent().next('.fieldSwitch').find('.input-group-addon').parent().removeClass('dis');
                                    }
                                    else {
                                        $(this).parent().next('.fieldSwitch').find('input, select, textarea').prop('disabled', true);
                                        $(this).parent().next('.fieldSwitch').find('.input-group-addon').parent().addClass('dis');
                                    }
                                });


                                //  fieldset define barcode
                                var fieldSwitch2 = $('.fieldset2 .fieldSwitch');
                                var legendSwitch2 = $('.fieldset2 legend input');
                                if (legendSwitch2.is(':checked')) {
                                    fieldSwitch2.find('input, select, textarea').prop('disabled', false);
                                }
                                else {
                                    fieldSwitch2.find('input, select, textarea').prop('disabled', true);
                                }
                                legendSwitch2.on('click', function () {
                                    if ($(this).is(':checked')) {
                                        $(this).parent().next('.fieldSwitch').find('input, select, textarea').prop('disabled', false);
                                    }
                                    else {
                                        $(this).parent().next('.fieldSwitch').find('input, select, textarea').prop('disabled', true);
                                        $(this).parent().next('.fieldSwitch').find('input').prop("checked", false);
                                    }
                                });
                                $('#<%=chkDefineAwardExpiration.ClientID%>').on('change', function () {
                                    if ($('#<%=chkDefineAwardExpiration.ClientID%>')[0].checked == false) {
                                        $('#dvDefineAwardExpiration').find('input, select').prop('disabled', false);
                                        $('#dvDefineAwardExpiration').prop('disabled', false);
                                    }
                                    else {
                                        $('#dvDefineAwardExpiration').find('input, select').prop('disabled', false);
                                        $('#dvDefineAwardExpiration').prop('disabled', false);
                                    }
                                });

                                isNumber();
                            }

                            function isNumber() {
                                $('.numeric').keydown(function (event) {
                                    // Allow special chars + arrows 

                                    if (event.keyCode == 46 || event.keyCode == 8 || event.keyCode == 9
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
                                $(".numeric").bind("paste", function (e) {
                                    return false;
                                });
                                $(".numeric").bind("drop", function (e) {
                                    return false;
                                });
                            }
                            function myTrim(x) {
                                return x.replace(/\s/g, '').replace('-', '');
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
                        <script type="text/javascript">
                            //Tab routines
                            function SetTabControls() {
                                var readTabValue = $('input:hidden[id*="hdnSelectedTab"]').val();
                                var isTab = $("#<%=hdnButtonPermission.ClientID %>").val();
                                var rowscount = $("#<%=gvAwardBuilder.ClientID %> tr").length;
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
                                        $('#manageAwardDetailTab').addClass('active in');
                                        break;
                                }
                                RegisterleftDivheight();
                            }

                            ///Set Default tab on pageload
                            function SetDefaultTab() {
                                $('.nav-tabs li').removeClass('active');
                                $('.nav-tabs li.nav-tabs-property').addClass('active');
                                $('.tab-content .tab-pane').removeClass('active in');
                                $('#propertyTab').addClass('active in');

                            }

                            function SetSelectedTab(selectedTab) {
                                $('input:hidden[id*="hdnSelectedTab"]').val(selectedTab);
                                SetTabControls();
                            }

                            function RegisterleftDivheight() {
                                $("#dvLeftcontentdetail").height($('#dvRightContent').height());
                            }


                        </script>
                        <script type="text/javascript">

                            //  Area list box
                            function RegisterListBox() {
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
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>


