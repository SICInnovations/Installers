<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PermissionManagement.aspx.cs" MasterPageFile="~/Site.Master" Inherits="HAMobileWebAdmin.PermissionManagement" %>

<asp:Content runat="server" ID="Content1" ContentPlaceHolderID="HeadContent">
</asp:Content>
<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">
    <style type="text/css">
        .ms-options ul {
            list-style: none;
            padding: 15px;
        }

        .ms-options-wrap > .ms-options > ul input[type='checkbox'] {
            position: static !important;
        }

        .ms-options {
            display: block !important;
            min-height: 368px !important;
            max-height: 368px !important;
        }

        .ms-options-wrap button {
            display: none;
        }

        .ms-options-wrap .ms-options {
            margin-top: -42px;
            min-height: 367px;
            max-height: 367px;
        }

        .PropertySearchdv .ms-search input {
            background: url(../../Content/img/search-icon.jpg) no-repeat right top;
            height: 27px;
        }

            .PropertySearchdv .ms-search input:hover {
                background: url(../../Content/img/activeFilter.png) no-repeat right top;
            }

        .PropertySearchdv .ms-options ul {
            padding: 0;
        }

        .PropertySearchdv .ms-search {
            height: 27px;
        }

        .PropertySearchdv .ms-options li label {
            padding: 5px;
            padding-left: 30px !important;
            font-weight: 400;
            color: #333;
        }

            .PropertySearchdv .ms-options li label:hover {
                background: #D9534F !important;
            }

        .PropertySearchdv .inputcheckBox {
        }

        .PropertySearchdv .ms-options li label input[type="checkbox"] {
            opacity: 0;
            z-index: 100;
            position: absolute !important;
            height: 20px;
            width: 20px;
        }

        .PropertySearchdv .ms-options li label.inputcheckBox {
            position: absolute;
            left: 5px;
            height: 20px;
            top: 6px;
            z-index: 99;
            width: 20px;
        }


        .PropertySearchdv .ms-options li input[type="checkbox"]:checked + label {
            background-position: 0 -26px;
        }

        .PropertySearchdv .ms-options li input[type="checkbox"] + label {
            background-position: 0 0px;
            padding-left: 0 !important;
        }

            .PropertySearchdv .ms-options li input[type="checkbox"] + label.inputcheckBox:hover, .PropertySearchdv .ms-options li input[type="checkbox"]:checked + label.inputcheckBox:hover {
                background-image: url(../../Content/img/checkbox.png) !important;
                background-color: none !important;
                background-repeat: no-repeat !important;
            }

        .PropertySearchdv .ms-options ul {
            overflow: auto !important;
            min-height: 330px !important;
            max-height: 330px !important;
        }

        .PropertySearchdv .ms-options {
            overflow: visible !important;
              z-index: 100!important;
        }
          
    </style>

    <script type="text/javascript">
        function CheckSelectedProperties() {

            var data = $("#hdnSelectedPropertyList").val();

            var dataarray = data.split(",");
            $(".dropdownListMultiple").val(dataarray);
            $('.dropdownListMultiple').multiselect('refresh');
        }


        var prm = Sys.WebForms.PageRequestManager.getInstance();
        if (prm != null) {
            prm.add_endRequest(function (sender, e) {
                if (sender._postBackSettings.panelsToUpdate != null) {

                    $("#dvLeftcontentdetail").height($('#dvRightContent').height());
                    Multiselect();
                    $('.PropertySearchdv input').attr('placeholder', '  ');
                    $(".ms-options li label").append("<label class='inputcheckBox'> </label>")

                    Multiselect();
                    GetMultiSelectedValues();
                    setPageSize();
                    $('.dropdownListMultiple').multiselect('refresh');
                    CheckSelectedProperties();

                }
            });
        };

        $(document).ready(function () {
            $("#dvLeftcontentdetail").height($('#dvRightContent').height());
            Multiselect();
            $('.PropertySearchdv input').attr('placeholder', '  ');
            $(".ms-options li label").append("<label class='inputcheckBox'> </label>")
            $('.dropdownListMultiple').multiselect('refresh');
            CheckSelectedProperties();
        });
        function Multiselect() {
            $('.dropdownListMultiple').multiselect({
                columns: 1,
                placeholder: 'Select Properties',
                search: true,
            });
        }
        function setPageSize() {
            $("#dvLeftcontentdetail").height($('#dvRightContent').height());
        }

        function GetMultiSelectedValues() {
            var properties = [];
            $.each($(".dropdownListMultiple option:selected"), function () {
                properties.push($(this).val());
            });
            $("#hdnPropertyIds").val(properties.join(", "));
        }


    </script>
    <div style="text-align: center;">
        <asp:UpdateProgress ID="updateProgress" runat="server" AssociatedUpdatePanelID="updpnlPermissionManagement">
            <ProgressTemplate>
                <div style="position: fixed; text-align: center; height: 100%; width: 100%; top: 0; right: 0; left: 0; z-index: 9999999; background-color: #000000; opacity: 0.7;">
                    <asp:Image ID="imgUpdateProgress" runat="server" ImageUrl="Content/img/loader.gif" AlternateText="Loading ..." ToolTip="Loading ..." Style="padding: 10px; position: fixed; top: 45%; left: 50%;" />
                </div>
            </ProgressTemplate>
        </asp:UpdateProgress>
    </div>

    <asp:UpdatePanel ID="updpnlPermissionManagement" runat="server">
        <ContentTemplate>
            <asp:HiddenField ID="hdnFunctionIDs" runat="server" Value="" />
            <asp:HiddenField ID="hdnPropertyIds" runat="server" ClientIDMode="Static" />
            <asp:HiddenField ID="hdnSelectedPropertyList" Value="" runat="server" ClientIDMode="Static" />
          
             <div class="row" id="slotInventory">
                <div class="col-md-3">
                    <h5>Permission Management</h5>
                    <div class="filterWrapper relative" id="dvLeftcontentdetail">
                        <div class="row">
                            <div class="col-xs-6">
                                <label>User Groups</label>
                            </div>
                            <div class="col-xs-6">
                                <!--<button class="btn btn-add pull-right">Add</button>-->
                            </div>
                        </div>
                        <div class="input-group">
                            <asp:TextBox CssClass="form-control height26" ID="txtSearchAdGroup" runat="server"></asp:TextBox>
                            <span class="input-group-btn">
                                <asp:Button ID="btnSearch" runat="server" class="btn btn-black glyphicons filter btn-icon white" OnClick="btnSearch_Click" />
                                <i></i></button>
                            </span>
                        </div>
                        <div id="divgv">

                            <asp:GridView CssClass="gridview" ID="gvADGroups" runat="server" ShowHeader="False" AutoGenerateColumns="false"
                                DataKeyNames="ADGroupID" AllowPaging="true" PageSize="10"
                                OnPageIndexChanging="gvADGroups_PageIndexChanging">
                                <Columns>

                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <asp:Label ID="lblMessageID" runat="server" Visible="false" Text='<%#Eval("ADGroupID") %>' />
                                            <asp:LinkButton ID="lnkBtnADGroupName" runat="server" Text='<%#Eval("ADGroupName") %>' OnClick="lnkBtnADGroupName_Click" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                                <SelectedRowStyle CssClass="gvSelectedRow" />
                                <PagerStyle CssClass="gridview-pager"></PagerStyle>


                            </asp:GridView>


                            <div id="content"></div>

                        </div>
                        <div class="filterResults relative btnGroup">
                            <div class="btn-groupSpecial">
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-2">
                    <h5>&nbsp;</h5>
                    <div class="row clearfix relative">

                        <div class="col-md-12">
                            <label>Property</label>
                        </div>
                    </div>
                    <div class="filterWrapper relative form-group">
                        <div class="input-group">
                            <asp:TextBox ID="txtPropertySearch" runat="server" ReadOnly="false" CssClass="form-control height26"></asp:TextBox>
                            <span class="input-group-btn">
                                <asp:Button ID="btnPropertySearch" runat="server" class="btn btn-black glyphicons filter btn-icon white"/>
                                <i></i></button>
                            </span>
                        </div>
                        <div class="row">
                          
                        </div>
                        <div class="filterResults relative btnGroup">
                            <div class="btn-groupSpecial">
                            </div>
                        </div>
                    </div>
                    <div class="clearfix PropertySearchdv">
                        <asp:ListBox ID="lstProperty" runat="server" CssClass="dropdownListMultiple" SelectionMode="Multiple"></asp:ListBox><div>
                        </div>
                    </div>
                </div>
                <div class="col-md-7">
                    <h5>&nbsp;</h5>
                    <div class="row clearfix relative btnGroup btnGroup3" id="dvRightContent">
                        <div class="row">
                            <div class="col-md-12">
                                <div class="col-md-12">
                                    <label>User Group</label>
                                    <asp:TextBox ID="txtUserGroupName" runat="server" ReadOnly="true" CssClass="form-control height26"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="col-md-12">
                                    <label>Functions</label>
                                    <asp:ListBox ID="lstbxFunctions" SelectionMode="Multiple" runat="server" CssClass="permissionBox"></asp:ListBox>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-8">
                                <div class="col-md-8 icons-control-btn clearfix">
                                    <asp:Button ID="btnCancel" runat="server" class="btn btn-icon-cancel pull-right" Text="Cancel" OnClick="btnCancel_Click" />
                                    <asp:Button ID="btnSave" runat="server" class="btn btn-icon-save pull-right" Text="Save" OnClientClick="GetMultiSelectedValues();" OnClick="btnSave_Click" />

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
                //  Area list box
                function RegisterListBox() {
                    //$("#dvLeftcontentdetail").height($('#dvRightContent').height());
                    var permissionBox = $('.permissionBox').bootstrapDualListbox({
                        nonselectedlistlabel: 'Exclude',
                        selectedlistlabel: 'Include',
                        preserveselectiononmove: 'moved',
                        moveonselect: false,
                        hdnControlId: 'hdnFunctionIDs'
                    });
                }

            </script>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>


