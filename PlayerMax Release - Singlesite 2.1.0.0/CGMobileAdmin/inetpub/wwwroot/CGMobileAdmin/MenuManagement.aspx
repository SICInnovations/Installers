<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="Site.Master" EnableEventValidation="false" CodeBehind="MenuManagement.aspx.cs" Inherits="HAMobileWebAdmin.MenuManagement" Title="Menu Management" %>

<asp:Content runat="server" ID="Content1" ContentPlaceHolderID="HeadContent">
    <link href="Content/Tree-css/context-menu.css" rel="stylesheet" />
    <link rel="stylesheet" href="Content/css/perfect-scrollbar-0.4.10.min.css" />
    <script src="Content/Tree-js/context-menu.js"></script>
    <script src="Scripts/CommonJS/jquery.mousewheel.js"></script>
    <script src="Scripts/CommonJS/perfect-scrollbar.js"></script>
    <script src="Content/Tree-js/drag-drop-folder-tree.js"></script>
    <title>COG Mobile | Menu Management</title>
    <style>
        .menuIcon {
            width: auto;
            height: auto;
        }
    </style>

</asp:Content>
<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">
    <asp:UpdatePanel ID="updpnlContentDetail" runat="server" UpdateMode="Conditional">
        <ContentTemplate>
            <asp:HiddenField ID="hdn_Flag" runat="server" Value="r" />
            <asp:HiddenField ID="hdn_MenuIds" runat="server" />
            <asp:HiddenField ID="hdn_MenuId" runat="server" Value="0" />
            <asp:HiddenField ID="hdn_SubMenuId" runat="server" Value="0" />
            <asp:HiddenField ID="hdnFlagAddOrUpadate" runat="server" Value="Add" />
            <asp:HiddenField ID="hdnSelectedSubMenu" runat="server" />
            <asp:HiddenField ID="hdnDeletePermission" runat="server" Value="0" />
            <asp:HiddenField ID="hdnNewPermission" runat="server" Value="0" />
            <asp:HiddenField ID="hdnSavePermission" runat="server" Value="0" />
            <asp:HiddenField ID="hdnEditStatus" runat="server" />
            <asp:HiddenField runat="server" ID="hdnFileID" />
            <div class="clearfix" id="slotInventory">
                <div class="col-md-3">
                    <h5>Menu Management</h5>
                    <div class="filterWrapper relative" id="dvLeftcontentdetail1">
                        <div class="row clearfix whiteBg">
                            <div class="col-xs-7">
                                <%--<label>Content Type</label>--%>
                            </div>

                        </div>

                        <div class="selectbox-wrapper clearfix">
                            <asp:DropDownList ID="ddlEnvironment" AutoPostBack="True" runat="server" CssClass="form-control" onchange="SetEnvironment()">
                                <asp:ListItem Value="0">Production</asp:ListItem>
                                <asp:ListItem Value="1">Test</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <div id="divgv" class="side-tree">

                            <ul class="dhtmlgoodies_tree">
                                <li id="node0" nodrag="true" nosiblings="true" nodelete="true" norename="true">
                                    <a href="javascript:void(0);" onclick="getMenu('Root node')">Menu</a>

                                    <ul id="dhtmlgoodies_tree2" class="dhtmlgoodies_tree">
                                        <%
                                            ArrayList arlst = new ArrayList();
                                            ArrayList arlstSub = new ArrayList();
                                            long MenuId = 0;
                                            int index = 0;
                                            int Subindex = 0;
                                            if (dt_Menu != null)
                                            {
                                                for (int i = 0; i <= dt_Menu.Rows.Count - 1; i++)
                                                {
                                                    if (!arlst.Contains(dt_Menu.Rows[i]["MenuID"].ToString()))
                                                    {
                                                        if (dt_Menu.Rows[i]["ParentID"].ToString() == "0")
                                                        {
                                                            arlst.Insert(index, dt_Menu.Rows[i]["MenuID"].ToString());
                                                            index++;
                                                            if (hdnSavePermission.Value == "1")
                                                            {
                                        %>
                                        <li id="node<%=dt_Menu.Rows[i]["MenuID"]%>" nochildren="false" nosiblings="false" nodrag="false" aria-valuemin=""><a style="cursor: pointer; pointer-events: all;" onclick="getMenuId('<%=dt_Menu.Rows[i]["MenuID"]%>','<%=dt_Menu.Rows[i]["MenuName"]%>','<%=dt_Menu.Rows[i]["Active"]%>','<%=dt_Menu.Rows[i]["FileContent"]%>','<%=dt_Menu.Rows[i]["PageID"]%>','<%= dt_Menu.Rows[i]["FileID"] %>','<%= dt_Menu.Rows[i]["IsAuthentication"] %>','<%= dt_Menu.Rows[i]["AndroidPageID"] %>','<%= dt_Menu.Rows[i]["IsTierLimited"] %>','<%= dt_Menu.Rows[i]["LimitedTiers"] %>')" href="javascript:void(0);"><%=dt_Menu.Rows[i]["MenuName"]%></a>

                                            <% 
                                                            }
                                                            else
                                                            { 
                                            %>
                                        <li id="node<%=dt_Menu.Rows[i]["MenuID"]%>" nochildren="true" nosiblings="true" nodrag="true" aria-valuemin=""><a style="cursor: no-drop; pointer-events: none;" onclick="getMenuId('<%=dt_Menu.Rows[i]["MenuID"]%>','<%=dt_Menu.Rows[i]["MenuName"]%>','<%=dt_Menu.Rows[i]["Active"]%>','<%=dt_Menu.Rows[i]["FileContent"]%>','<%=dt_Menu.Rows[i]["PageID"]%>','<%= dt_Menu.Rows[i]["FileID"] %>','<%= dt_Menu.Rows[i]["IsAuthentication"] %>','<%= dt_Menu.Rows[i]["AndroidPageID"] %>','<%= dt_Menu.Rows[i]["IsTierLimited"] %>','<%= dt_Menu.Rows[i]["LimitedTiers"] %>')" href="javascript:void(0);"><%=dt_Menu.Rows[i]["MenuName"]%></a>

                                            <% 
                                                            }
                                                        }
                                                        MenuId = Convert.ToInt64(dt_Menu.Rows[i]["MenuId"]);
                                                        System.Data.DataView dv = new System.Data.DataView(dt_Menu, "ParentID = " + MenuId + "", "MenuSequence", System.Data.DataViewRowState.CurrentRows);
                                                        if (dv.Count > 0)
                                                        {
                                                            if (dv[0]["ParentID"].ToString() != "0")
                                                            { 
                                            %>
                                            <ul>
                                                <%
                                                                for (int x = 0; x <= dv.Count - 1; x++)
                                                                {
                                                                    if (!arlstSub.Contains(dv[x]["MenuID"].ToString()))
                                                                    {
                                                                        if (hdnSavePermission.Value == "1")
                                                                        {
                                                %>

                                                <li id="node<%= dv[x]["MenuID"]%>" nochildren="false" nodrag="false" siblings="false" nodelete="false" norename="false"><a href="javascript:void(0);" style="cursor: pointer; pointer-events: auto;" onclick="getSubMenuId('<%= dv[x]["MenuID"] %>','<%= dv[x]["ParentID"] %>','<%= dv[x]["MenuName"] %>','<%= dv[x]["Active"] %>','<%= dv[x]["FileContent"] %>','<%= dv[x]["PageID"] %>','<%= dv[x]["FileID"] %>','<%=dv[x]["IsAuthentication"] %>','<%=dv[x]["AndroidPageID"] %>','<%= dv[x]["IsTierLimited"] %>','<%= dv[x]["LimitedTiers"] %>')"><%= dv[x]["MenuName"] %></a></li>

                                                <%                         }
                                                                        else
                                                                        {
                                                %>

                                                <li id="node<%=dv[x]["MenuID"]%>" nochildren="true" nosiblings="true" nodrag="true" aria-valuemin=""><a href="javascript:void(0);" style="cursor: no-drop; pointer-events: none;" onclick="getSubMenuId('<%= dv[x]["MenuID"] %>','<%= dv[x]["ParentID"] %>','<%= dv[x]["MenuName"] %>','<%= dv[x]["Active"] %>','<%= dv[x]["FileContent"] %>','<%= dv[x]["PageID"] %>','<%= dv[x]["FileID"] %>','<%=dv[x]["IsAuthentication"] %>','<%=dv[x]["AndroidPageID"] %>','<%= dv[x]["IsTierLimited"] %>','<%= dv[x]["LimitedTiers"] %>')"><%= dv[x]["MenuName"] %></a></li>

                                                <%                            }
                                                                        arlstSub.Insert(Subindex, dv[x]["MenuID"].ToString());
                                                                        Subindex++;
                                                                    }
                                                                }
                                                            }
                                                %>
                                            </ul>
                                            <%
                                                        }
                                            %>

                                            <%}
                                                }
                                            } 
                                            %>
                                    </ul>
                                </li>
                                </li>

                            </ul>

                        </div>
                        <div class=" btnGroup">
                            <div class="btn-groupSpecial">
                                <div style="visibility: hidden;">
                                    <a class="results-control col-xs-4" href="#">active</a>
                                    <a class="results-control col-xs-4" href="#">inactive</a>
                                    <a class="results-control col-xs-4" href="#">all</a>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
                <div class="col-md-9">
                    <h5>Menu Item Detail</h5>
                    <div class="row clearfix relative btnGroup btnGroup3" id="dvRightContent">
                        <div class="row">
                            <div class="col-md-12">
                                <div class="col-md-6">
                                    <label for="menuItemName" id="lblMenuName" runat="server">Menu Item Name</label>
                                    <asp:TextBox ID="txtmenuItemName" TabIndex="1" MaxLength="250" class="form-control" runat="server"></asp:TextBox>

                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="col-md-6">
                                    <label for="mobileAppPage">Android App Page</label>
                                    <asp:DropDownList ID="ddlAndroid" TabIndex="2" runat="server" CssClass="form-control">
                                    </asp:DropDownList>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="col-md-6">
                                    <label for="mobileAppPage">iOS App Page</label>
                                    <asp:DropDownList ID="ddliOS" TabIndex="3" runat="server" CssClass="form-control">
                                    </asp:DropDownList>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="col-md-2">
                                    <label>Menu Icon</label>
                                    <div class="menuIcon">
                                        <asp:Image ID="imgMenuIcon" AlternateText="" alt="icon" runat="server" />
                                        <asp:HiddenField runat="server" ID="hdnMenuImageUrl" />
                                    </div>
                                </div>
                                <div class="col-md-5">
                                    <label>&nbsp;</label>
                                    <asp:CheckBox ID="chkmenuActive" TabIndex="4" Text="Active?" Visible="True" runat="server" Style="width: 300px" />
                                    <asp:CheckBox ID="chkAuthentication" TabIndex="5" Text="Don't Show to Unauthenticated Users?" Visible="True" runat="server" Style="width: 300px" />
                                    <asp:CheckBox ID="chkLimitToTiers" TabIndex="6" Text="Limit to Select Tiers" Visible="True" runat="server" Style="width: 300px" />
                                </div>
                            </div>
                        </div>
                        <div class="row" id="tiercontainer">
                            <div class="col-md-12" style="padding-left: 30px">
                                <label>Limit Menu Item to Selected Tiers</label>
                            </div>
                            <div class="col-md-12">
                                <div class="col-md-3 bootstrap-duallistbox-container ">
                                    <label>Unselected Tiers</label>
                                    <asp:ListBox runat="server" ID="lbTiers" Rows="8" Width="100%" SelectionMode="Multiple" CssClass="form-control"></asp:ListBox>
                                </div>
                                <div class="col-md-1 btn-group buttons buttonControles " style="padding-top: 55px">
                                    <asp:LinkButton runat="server" ID="btnAddTiers" title="Move all" class="btn btn-primary btn btn-default move" type="button"></asp:LinkButton><br />
                                    <br />
                                    <asp:LinkButton runat="server" ID="btnRemoveTiers" class="btn btn-danger btn btn-default remove" type="button"></asp:LinkButton>



                                </div>
                                <div class="col-md-3 bootstrap-duallistbox-container">
                                    <label>Selected Tiers</label>
                                    <asp:ListBox runat="server" ID="lbSelectedTiers" TabIndex="7" Rows="8" Width="100%" SelectionMode="Multiple" CssClass="form-control"></asp:ListBox>
                                </div>
                            </div>
                            <asp:HiddenField ID="hdnTierIDs" runat="server" Value="" />
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="col-md-12">
                                    <label>Menu Icon Selections</label>
                                    <div class="dvmenuIconSelection clearfix menuIconSelection">
                                        <asp:DataList ID="dtlMenuIcons" runat="server" RepeatColumns="5" RepeatLayout="Table" TabIndex="8">
                                            <ItemTemplate>
                                                <br />
                                                <table cellpadding="5px" cellspacing="0" class="dlTable">
                                                    <tr>
                                                        <td>
                                                            <div class="menuIconSelection clearfix">
                                                                <div class="singleIcon">

                                                                    <%#(DataBinder.Eval(Container, "DataItem.FileContent") !=null?"<a href=javascript:void(0);>":"")%>
                                                                    <asp:HiddenField runat="server" ID="hdnFileID" Value='<%#Eval("FileID") %>' />
                                                                    <asp:Image ID="Image1" ImageUrl='<%#(DataBinder.Eval(Container, "DataItem.FileContent") !=null? string.Format("data:image/jpeg;base64,{0}", Convert.ToBase64String((byte[])Eval( ("FileContent") ))):null) %>' alt="icon" runat="server" />

                                                                    <%#(DataBinder.Eval(Container, "DataItem.FileContent") !=null?"</a>":"")%>
                                                                </div>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                </table>
                                                <br />
                                            </ItemTemplate>
                                        </asp:DataList>
                                    </div>
                                </div>
                                <div class="col-md-12">
                                    <div class="col-md-12 icons-control-btn clearfix">
                                        <asp:Button ID="lnkbtnCancel" runat="server" OnClientClick="return ConfirmMessage(2);" Text="Cancel" OnClick="lnkbtnCancel_Click" CssClass="btn btn-icon-cancel pull-right"></asp:Button>
                                        <asp:Button ID="lnkbtnSave" runat="server" Text="Save" OnClick="lnkbtnSave_Click" OnClientClick=" return MenuFormValidation()" CssClass="btn btn-icon-cancel pull-right"></asp:Button>
                                        <asp:Button ID="lnkbtnDelete" runat="server" OnClientClick=" return ConfirmMessage(3);" Text="Delete" OnClick="lnkbtnDelete_Click" CssClass="btn btn-icon-cancel pull-right"></asp:Button>
                                        <asp:Button ID="lnkbtnEdit" runat="server" OnClick="lnkbtnEdit_Click" Text="Edit" CssClass="btn btn-icon-cancel pull-right"></asp:Button>
                                        <asp:Button ID="lnkBtnAdd" runat="server" OnClick="lnkbtnAdd_Click" Text="Add" CssClass="btn btn-icon-cancel pull-right"></asp:Button>
                                        <asp:Button ID="btnResetMenu" runat="server" OnClick="lnkbtnResetMenu_Click" Text="ResetMenu" Style="display: none"></asp:Button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <script type="text/javascript">

                ////*************************************************Start Page load functionality.*********************************
                var ajaxObjects = new Array();

                $(document).ready(function () {

                    RegisterMenuScrollBar();
                    RegisterAddandRemoveImage();
                    RegisterInitializeMenu();
                    RegisterConfirmBox();
                    RegisterTierEvents();
                });

                ////*************************************************End Page load functionality.***********************************
                //***************************************Start On UpdatePanel Refresh Register /Common Functions *******************

                var prm = Sys.WebForms.PageRequestManager.getInstance();
                if (prm != null) {
                    prm.add_endRequest(function (sender, e) {
                        if (sender._postBackSettings.panelsToUpdate != null) {

                            RegisterAddandRemoveImage();
                            RegisterInitializeMenu();
                            RegisterConfirmBox();
                            RegisterMenuScrollBar();
                            RegisterTierEvents();
                        }
                    });
                }
                ///**************************************End On UpdatePanel Refresh Register Common Functions***********************

                function RegisterAddandRemoveImage() {
                    //  Icons
                    $('.singleIcon').on('click', function () {
                        if (document.getElementById('<%=hdnEditStatus.ClientID%>').value == 'Edit') {
                            $('.singleIcon').removeClass('selected');
                            $(this).addClass('selected');
                        }
                        else { return false; }
                    });
                    //  Delete
                    $('.btn-icon-delete').click(function () {
                        $('.singleIcon.selected').remove();
                    });
                    //  SetIcons
                    $('.singleIcon').click(function () {
                        if (document.getElementById('<%=hdnEditStatus.ClientID%>').value == 'Edit') {
                            var selectedIcon = $('.singleIcon.selected img').attr('src');
                            var selectedIconid = $('.singleIcon.selected input').attr('value');
                            document.getElementById('<%=hdnFileID.ClientID%>').value = selectedIconid;
                            $('.menuIcon img').attr({ src: selectedIcon });
                        }
                        else { return false; }
                    });
                }

                //DragandDrop Function
                function SetTree() {

                    $('.preloaderNew').show();
                    var Menu_SumMenuID = treeObj.getNodeOrders()
                    $.ajax({
                        type: "POST",
                        url: "MenuManagement.aspx/SetMenu",
                        data: "{ \"MenuIDSubMenuID\":'" + Menu_SumMenuID + "'}",
                        contentType: "application/json; charset=utf-8",
                        success: function (data) {
                            $('#<%=btnResetMenu.ClientID%>').click();
                            $('.preloaderNew').hide();
                        },
                        error: function (xhr, status, err) {

                            $('.preloaderNew').hide();
                            var err = eval("(" + xhr.responseText + ")");
                            alert(err.Message);
                        }
                    });
                    }
                    function RegisterInitializeMenu() {
                        treeObj = new JSDragDropTree();
                        treeObj.setTreeId('dhtmlgoodies_tree2');
                        treeObj.setMaximumDepth(3);
                        treeObj.setMessageMaximumDepthReached('Maximum depth reached'); // If you want to show a message when maximum depth is reached, i.e. on drop.
                        treeObj.initTree();
                        treeObj.expandAll();
                        treeObj.valueOf();
                    }
                    function CheckPermission(isSave, isDelete, isNew, isEdit) {

                        $("#<%=lnkBtnAdd.ClientID%>").addClass('aspNetDisabled');
                    document.getElementById('<%=lnkBtnAdd.ClientID%>').disabled = true;
                    document.getElementById('<%=lnkbtnSave.ClientID%>').disabled = true;
                    $("#<%=lnkbtnSave.ClientID%>").addClass('aspNetDisabled');
                    document.getElementById('<%=lnkbtnDelete.ClientID%>').disabled = true;
                    $("#<%=lnkbtnDelete.ClientID%>").addClass('aspNetDisabled');
                    $("#<%=lnkbtnEdit.ClientID%>").addClass('aspNetDisabled');
                    document.getElementById('<%=lnkbtnEdit.ClientID%>').disabled = true;

                    if ($('#<%=hdnNewPermission.ClientID%>').val() == '1' && isNew == true) {
                        $("#<%=lnkBtnAdd.ClientID%>").removeClass('aspNetDisabled');
                        document.getElementById('<%=lnkBtnAdd.ClientID%>').disabled = false;
                    }
                    if ($('#<%=hdnSavePermission.ClientID%>').val() == '1' && isSave == true) {
                        document.getElementById('<%=lnkbtnSave.ClientID%>').disabled = false;
                        $("#<%=lnkbtnSave.ClientID%>").removeClass('aspNetDisabled');

                    }
                    if ($('#<%=hdnDeletePermission.ClientID%>').val() == '1' && isDelete == true) {
                        document.getElementById('<%=lnkbtnDelete.ClientID%>').disabled = false;
                        $("#<%=lnkbtnDelete.ClientID%>").removeClass('aspNetDisabled');
                    }
                    if (isEdit == true) {
                        $("#<%=lnkbtnEdit.ClientID%>").removeClass('aspNetDisabled');
                        document.getElementById('<%=lnkbtnEdit.ClientID%>').disabled = false;

                    }


                }
                //Set RootMenu value
                function getMenu(name) {

                    document.getElementById('<%=hdn_MenuId.ClientID%>').value = 0;
                    document.getElementById('<%=hdn_SubMenuId.ClientID%>').value = 0;
                    document.getElementById('<%=txtmenuItemName.ClientID%>').value = '';
                    document.getElementById('<%=lblMenuName.ClientID%>').innerHTML = 'Menu Item Name';
                    document.getElementById('<%=hdn_Flag.ClientID%>').value = 'r';
                    document.getElementById('<%=hdnFlagAddOrUpadate.ClientID%>').value = 'Edit';
                    document.getElementById('<%=hdnSelectedSubMenu.ClientID%>').value = '0';
                    $("#<%= ddliOS.ClientID %>").val('-1');
                    $("#<%= ddlAndroid.ClientID %>").val('-1');
                    document.getElementById('<%=chkmenuActive.ClientID%>').checked = false;
                    document.getElementById('<%=chkAuthentication.ClientID%>').checked = false;
                    document.getElementById('<%=chkLimitToTiers.ClientID%>').checked = false;
                    $("#<%=chkLimitToTiers.ClientID%>").trigger('change');

                    //Read Only
                    document.getElementById('<%=txtmenuItemName.ClientID%>').disabled = true;
                    document.getElementById('<%=ddlEnvironment.ClientID%>').disabled = true;
                    document.getElementById('<%=ddlAndroid.ClientID%>').disabled = true;
                    document.getElementById('<%=ddliOS.ClientID%>').disabled = true;
                    document.getElementById('<%=chkmenuActive.ClientID%>').disabled = true;
                    document.getElementById('<%=chkAuthentication.ClientID%>').disabled = true;
                    document.getElementById('<%=imgMenuIcon.ClientID%>').disabled = true;
                    CheckPermission(false, false, true, false);

                }

                //Set Menu Value
                function getMenuId(id, name, active, FileContent, iOSID, fileID, IsAuthentication, AndroidId, isTierLimited, LimitedTiers) {

                    document.getElementById('<%=lblMenuName.ClientID%>').innerHTML = 'Menu Item Name';
                    document.getElementById('<%=hdn_MenuId.ClientID%>').value = id;
                    document.getElementById('<%=txtmenuItemName.ClientID%>').value = name;
                    document.getElementById('<%=hdn_SubMenuId.ClientID%>').value = id;
                    document.getElementById('<%=hdn_Flag.ClientID%>').value = 'm';
                    document.getElementById('<%=hdnFlagAddOrUpadate.ClientID%>').value = 'Edit';
                    document.getElementById('<%=hdnEditStatus.ClientID%>').value = 'Add';
                    document.getElementById('<%=hdnSelectedSubMenu.ClientID%>').value = '0';
                    document.getElementById('<%=chkmenuActive.ClientID%>').checked = false;
                    document.getElementById('<%=chkAuthentication.ClientID%>').checked = false;
                    if (active == 'True') {
                        document.getElementById('<%=chkmenuActive.ClientID%>').checked = true;
                    }
                    if (IsAuthentication == 'True') {
                        document.getElementById('<%=chkAuthentication.ClientID%>').checked = true;
                    }
                    if (isTierLimited == 'True') {
                        document.getElementById('<%=chkLimitToTiers.ClientID%>').checked = true;
                        $("#<%=chkLimitToTiers.ClientID%>").trigger('change');
                        var tiers = LimitedTiers.split(',');
                        $('#<%=lbSelectedTiers.ClientID%> > option').appendTo('#<%=lbTiers.ClientID%>');
                        $.each(tiers, function (i) {
                            $('#<%=lbTiers.ClientID%> option[value="' + tiers[i] + '"]').appendTo('#<%=lbSelectedTiers.ClientID%>');
                        });
                        $('#<%=lbSelectedTiers.ClientID%> > option:selected').prop('selected', false);
                        $('#<%=hdnTierIDs.ClientID%>').val(LimitedTiers);
                    }
                    else {
                        document.getElementById('<%=chkLimitToTiers.ClientID%>').checked = false;
                        $("#<%=chkLimitToTiers.ClientID%>").trigger('change');
                        $('#<%=lbSelectedTiers.ClientID%> > option').appendTo('#<%=lbTiers.ClientID%>');
                        $('#<%=lbTiers.ClientID%> > option:selected').prop('selected', false);
                        $('#<%=hdnTierIDs.ClientID%>').val('');
                    }

                    document.getElementById('<%=hdnFileID.ClientID%>').value = fileID;
                    document.getElementById('<%=imgMenuIcon.ClientID%>').src = FileContent;
                    document.getElementById('<%=hdnMenuImageUrl.ClientID%>').value = FileContent;
                    $("#<%= ddliOS.ClientID %>").val(iOSID);
                    $("#<%= ddlAndroid.ClientID %>").val(AndroidId);

                    //Read Only
                    document.getElementById('<%=txtmenuItemName.ClientID%>').disabled = true;
                    document.getElementById('<%=ddlEnvironment.ClientID%>').disabled = true;
                    document.getElementById('<%=ddlAndroid.ClientID%>').disabled = true;
                    document.getElementById('<%=ddliOS.ClientID%>').disabled = true;
                    document.getElementById('<%=chkmenuActive.ClientID%>').disabled = true;
                    document.getElementById('<%=chkAuthentication.ClientID%>').disabled = true;
                    document.getElementById('<%=chkLimitToTiers.ClientID%>').disabled = true;
                    document.getElementById('<%=imgMenuIcon.ClientID%>').disabled = true;
                    document.getElementById('<%=lbSelectedTiers.ClientID%>').disabled = true;
                    document.getElementById('<%=lbTiers.ClientID%>').disabled = true;
                    document.getElementById('<%=btnRemoveTiers.ClientID%>').disabled = true;
                    document.getElementById('<%=btnAddTiers.ClientID%>').disabled = true;
                    $("#<%=btnAddTiers.ClientID%>").addClass('aspNetDisabled btn btn-primary');
                    $("#<%=btnRemoveTiers.ClientID%>").addClass('aspNetDisabled btn btn-danger');
                    CheckPermission(false, false, true, true);

                }

                //Set SubMenu value
                function getSubMenuId(mid, smid, name, active, FileContent, iOSID, fileID, IsAuthentication, AndroidId, isTierLimited, LimitedTiers) {
                    document.getElementById('<%=hdnEditStatus.ClientID%>').value = 'Add';
                    document.getElementById('<%=hdnSelectedSubMenu.ClientID%>').value = smid;
                    document.getElementById('<%=lblMenuName.ClientID%>').innerHTML = 'Menu Item Name';
                    document.getElementById('<%=hdn_MenuId.ClientID%>').value = mid;
                    document.getElementById('<%=txtmenuItemName.ClientID%>').value = name;
                    document.getElementById('<%=hdn_SubMenuId.ClientID%>').value = smid;
                    document.getElementById('<%=hdn_Flag.ClientID%>').value = 'sm';
                    document.getElementById('<%=chkmenuActive.ClientID%>').checked = false;
                    document.getElementById('<%=chkAuthentication.ClientID%>').checked = false;
                    if (active == 'True') {
                        document.getElementById('<%=chkmenuActive.ClientID%>').checked = true;
                    }
                    if (IsAuthentication == 'True') {
                        document.getElementById('<%=chkAuthentication.ClientID%>').checked = true;
                    }
                    if (isTierLimited == 'True') {
                        document.getElementById('<%=chkLimitToTiers.ClientID%>').checked = true;
                        $("#<%=chkLimitToTiers.ClientID%>").trigger('change');
                        var tiers = LimitedTiers.split(',');
                        $('#<%=lbSelectedTiers.ClientID%> > option').appendTo('#<%=lbTiers.ClientID%>');
                        $.each(tiers, function (i) {
                            $('#<%=lbTiers.ClientID%> option[value="' + tiers[i] + '"]').appendTo('#<%=lbSelectedTiers.ClientID%>');
                        });
                        $('#<%=lbSelectedTiers.ClientID%> > option:selected').prop('selected', false);
                        $('#<%=hdnTierIDs.ClientID%>').val(LimitedTiers);
                    }
                    else {
                        document.getElementById('<%=chkLimitToTiers.ClientID%>').checked = false;
                        $("#<%=chkLimitToTiers.ClientID%>").trigger('change');
                        $('#<%=lbSelectedTiers.ClientID%> > option').appendTo('#<%=lbTiers.ClientID%>');
                        $('#<%=lbTiers.ClientID%> > option:selected').prop('selected', false);
                        $('#<%=hdnTierIDs.ClientID%>').val('');
                    }
                    document.getElementById('<%=hdnFlagAddOrUpadate.ClientID%>').value = 'Edit';
                    document.getElementById('<%=imgMenuIcon.ClientID%>').src = FileContent;
                    document.getElementById('<%=hdnMenuImageUrl.ClientID%>').value = FileContent;
                    document.getElementById('<%=hdnFileID.ClientID%>').value = fileID;
                    $("#<%= ddliOS.ClientID %>").val(iOSID);
                    $("#<%= ddlAndroid.ClientID %>").val(AndroidId);

                    //Read Only
                    document.getElementById('<%=txtmenuItemName.ClientID%>').disabled = true;
                    document.getElementById('<%=ddlEnvironment.ClientID%>').disabled = true;
                    document.getElementById('<%=ddlAndroid.ClientID%>').disabled = true;
                    document.getElementById('<%=ddliOS.ClientID%>').disabled = true;
                    document.getElementById('<%=chkmenuActive.ClientID%>').disabled = true;
                    document.getElementById('<%=chkAuthentication.ClientID%>').disabled = true;
                    document.getElementById('<%=chkLimitToTiers.ClientID%>').disabled = true;
                    document.getElementById('<%=imgMenuIcon.ClientID%>').disabled = true;
                    document.getElementById('<%=lbSelectedTiers.ClientID%>').disabled = true;
                    document.getElementById('<%=lbTiers.ClientID%>').disabled = true;
                    document.getElementById('<%=btnRemoveTiers.ClientID%>').disabled = true;
                    document.getElementById('<%=btnAddTiers.ClientID%>').disabled = true;
                    $("#<%=btnAddTiers.ClientID%>").addClass('aspNetDisabled btn btn-primary');
                    $("#<%=btnRemoveTiers.ClientID%>").addClass('aspNetDisabled btn btn-danger');
                    CheckPermission(false, false, false, true);

                }
                function RegisterMenuScrollBar() {
                    $("#dhtmlgoodies_tree2").perfectScrollbar({ suppressScrollX: true });
                    $(".dvmenuIconSelection").perfectScrollbar({ suppressScrollX: true });
                }
                ///Form validation
                function MenuFormValidation() {
                    $('#<%=lbSelectedTiers.ClientID%> > option').prop('selected', true);
                    var multipleValues = $('#<%=lbSelectedTiers.ClientID%>').val() || [];
                    $('#<%=hdnTierIDs.ClientID%>').val(multipleValues.join(','));

                    if (document.getElementById('<%=ddlEnvironment.ClientID%>').selectedIndex == -1) {
                        document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please select environmentType';
                        $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                        document.getElementById('<%=ddlEnvironment.ClientID%>').focus();
                        return false;
                    }
                    if (myTrim(document.getElementById('<%=txtmenuItemName.ClientID%>').value) == '') {
                        document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please enter menu item name';
                        $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                        document.getElementById('<%=txtmenuItemName.ClientID%>').focus();
                        return false;
                    }
                    var validation = ConfirmMessage(1);
                    if (validation == false) {
                        return false;
                    }
                    else {
                        return true;
                    }
                }
                ///Confirmation message after delete/save/cancel button onclick
                function ConfirmMessage(flag) {
                    var savemsg = 'Are you sure to save this Menu?';
                    var cancelmsg = 'Are you sure to discard current changes?';
                    var deletemsg = 'Are you sure to delete this ';
                    if (document.getElementById('<%=hdn_Flag.ClientID%>').value == 'sm') {
                        deletemsg = deletemsg + 'SubMenu?'
                    }
                    else {
                        deletemsg = deletemsg + 'Menu?'
                    }
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
            function RegisterConfirmBox() {
                $('#ConfirmBox').on('show.bs.modal', function (e) {

                });
            }
            function myTrim(x) {
                return x.replace(/\s/g, '').replace('-', '');
            }

            function RegisterTierEvents() {
                if ($("#<%=chkLimitToTiers.ClientID%>").prop('checked')) {
                        $('#tiercontainer').show();
                        $('#<%=lbSelectedTiers.ClientID%> > option').appendTo('#<%=lbTiers.ClientID%>');
                        var tiers = $('#<%=hdnTierIDs.ClientID%>').val().split(',');
                        $.each(tiers, function (i) {
                            $('#<%=lbTiers.ClientID%> option[value="' + tiers[i] + '"]').appendTo('#<%=lbSelectedTiers.ClientID%>');
                        });
                        $('#<%=lbSelectedTiers.ClientID%> > option:selected').prop('selected', false);
                    }
                    else
                        $('#tiercontainer').hide();

                    $("#<%=chkLimitToTiers.ClientID%>").change(function () {
                        $('#tiercontainer').toggle(this.checked);
                    });
                    $("#<%=btnAddTiers.ClientID%>").click(function (e) {
                        $('#<%=lbTiers.ClientID%> > option:selected').appendTo('#<%=lbSelectedTiers.ClientID%>');
                        $('#<%=lbSelectedTiers.ClientID%> > option:selected').prop('selected', false);
                        e.preventDefault();
                    });
                    $("#<%=btnRemoveTiers.ClientID%>").click(function (e) {
                        $('#<%=lbSelectedTiers.ClientID%> > option:selected').appendTo('#<%=lbTiers.ClientID%>');
                        $('#<%=lbTiers.ClientID%> > option:selected').prop('selected', false);
                        e.preventDefault();
                    });

                    $(document).click(function () {
                        $("#MainContent_chkmenuActive").closest('span').find('label').removeAttr('style');
                        $("#MainContent_chkAuthentication").closest('span').find('label').removeAttr('style');
                        $("#MainContent_chkLimitToTiers").closest('span').find('label').removeAttr('style');
                    });

                    $('input[type="checkbox"], select').keydown(function (e) {
                        var keyCode = e.keyCode || e.which;
                        if (keyCode == 9) {
                            if ($(this).prop('id') == 'MainContent_ddliOS') {
                                $("#MainContent_chkmenuActive").closest('span').find('label').css('color', '#2f96b4');
                            }
                            else if ($(this).prop('id') == 'MainContent_chkmenuActive') {
                                $("#MainContent_chkmenuActive").closest('span').find('label').removeAttr('style');
                                $("#MainContent_chkAuthentication").closest('span').find('label').css('color', '#2f96b4');
                            }
                            else if ($(this).prop('id') == 'MainContent_chkAuthentication') {
                                $("#MainContent_chkAuthentication").closest('span').find('label').removeAttr('style');
                                $("#MainContent_chkLimitToTiers").closest('span').find('label').css('color', '#2f96b4');
                            }
                            else {
                                $("#MainContent_chkLimitToTiers").closest('span').find('label').removeAttr('style');
                            }
                        }
                    });
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
                            <asp:Button ID="btnConfirmedSave" CssClass="btn btn-danger" runat="server" Text="OK" UseSubmitBehavior="false" data-dismiss="modal" OnClick="lnkbtnSave_Click" Style="display: none;"></asp:Button>
                            <asp:Button ID="btnConfirmedCancel" CssClass="btn btn-danger" runat="server" Text="OK" UseSubmitBehavior="false" data-dismiss="modal" OnClick="lnkbtnCancel_Click" Style="display: none;"></asp:Button>
                            <asp:Button ID="btnConfirmedDelete" CssClass="btn btn-danger" runat="server" Text="OK" UseSubmitBehavior="false" data-dismiss="modal" OnClick="lnkbtnDelete_Click" Style="display: none;"></asp:Button>
                            <button type="button" class="btn" id="confirm" data-dismiss="modal">Cancel</button>
                        </div>
                    </div>
                </div>
            </div>
            <div style="text-align: center;">
                <asp:UpdateProgress ID="updateProgress" runat="server">
                    <ProgressTemplate>
                        <div style="position: fixed; text-align: center; height: 100%; width: 100%; top: 0; right: 0; left: 0; z-index: 9999999; background-color: #000000; opacity: 0.7;">
                            <asp:Image ID="imgUpdateProgress" runat="server" ImageUrl="Content/img/loader.gif" AlternateText="Loading ..." ToolTip="Loading ..." Style="padding: 10px; position: fixed; top: 45%; left: 50%;" />
                        </div>
                    </ProgressTemplate>
                </asp:UpdateProgress>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
