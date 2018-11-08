<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="Site.Master" CodeBehind="MapManagement.aspx.cs" Inherits="HAMobileWebAdmin.MapManagement" Title="Map Management" ValidateRequest="false" EnableEventValidation="false" %>

<asp:Content runat="server" ID="Content1" ContentPlaceHolderID="HeadContent">
    <link rel="stylesheet" href="Content/css/perfect-scrollbar-0.4.10.min.css" />
    <script src="Scripts/CommonJS/jquery.mousewheel.js"></script>
    <script src="Scripts/CommonJS/perfect-scrollbar.js"></script>
    <title>COG Mobile | Map Management</title>
    <style>
        .bootstrap-duallistbox-container{
            display:none;
        }
         .bootstrap-duallistbox-container:nth-child(1){
            display:block;
        }
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
                <asp:HiddenField runat="server" ID="hdnSelectedTab" Value="0" />
               <asp:HiddenField runat="server" ClientIDMode="Static" ID="hdnSelectedProperties" Value="0" />
            <div class="row" id="slotInventory">
                <div class="col-sm-3">
                    <h5>Map Management</h5>
                    <div class="filterWrapper relative" id="dvLeftcontentdetail">
                        <div class=" clearfix whiteBg">
                            <div class="pull-left">
                                <label>Map</label>
                            </div>
                            <div class="pull-right">
                                <span class="addBtn">Add
                                    <asp:Button ID="lnkbtnAdd" runat="server" OnClientClick="SelectPropTab();" OnClick="lnkbtnAdd_Click" CssClass="btn btn-add pull-right"></asp:Button></span>

                            </div>
                        </div>
                        <div class="input-group clearfix col-sm-12">
                            <asp:TextBox CssClass="form-control height26" ID="txtSearchName" runat="server"></asp:TextBox>
                            <span class="input-group-btn">
                                <asp:Button ID="btnSearch" runat="server" OnClientClick="SelectPropTab();" OnClick="btnSearch_Click" CssClass="btn btn-black glyphicons filter btn-icon white input-group-btnbtnmargin"></asp:Button>
                                <i></i>
                            </span>
                        </div>
                        <div id="divgv">
                            <asp:GridView CssClass="gridview" ID="gvMapDetail" runat="server" ShowHeader="False" AutoGenerateColumns="false" DataKeyNames="FloorMapID" AllowPaging="true" PageSize="12" OnPageIndexChanging="gvMapDetail_PageIndexChanging">
                                <Columns>
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <asp:Label ID="lblID" runat="server" Visible="false" Text='<%#Eval("FloorMapId") %>' />
                                            <asp:LinkButton ID="lnkBtnShowContentDetail" runat="server" OnClientClick="SelectPropTab();" Text='<%#Eval("Name") %>' CommandName="Select" OnClick="lnkBtnShowMapDetail_Click" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                                <PagerStyle CssClass="gridview-pager"></PagerStyle>
                                <SelectedRowStyle CssClass="gvSelectedRow" />
                            </asp:GridView>
                            <div id="content">
                            </div>
                        </div>
                        <div class="filterResults relative btnGroup filterResults3" id="dvLeftContent">
                            <div class="btn-groupSpecial">
                                <asp:Button ID="lnkbtnActive" runat="server" Text="Active" OnClick="lnkbtnActive_Click" OnClientClick="SelectPropTab(); setActive('Active'); return MapValidationAlert(4);" CssClass="results-control col-xs-4 active"></asp:Button>
                                <asp:Button ID="lnkbtnInActive" runat="server" Text="InActive" OnClick="lnkbtnInActive_Click" OnClientClick="SelectPropTab(); setActive('InActive'); return MapValidationAlert(5);" CssClass="results-control col-xs-4"></asp:Button>
                                <asp:Button ID="lnkbtnInAll" runat="server" Text="All" OnClick="lnkbtnAll_Click" CssClass="results-control col-xs-4" OnClientClick="SelectPropTab(); setActive('All'); return MapValidationAlert(6);"></asp:Button>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-sm-9">
                    <h5>Map Detail</h5>
                    <div class="row clearfix relative btnGroup btnGroup3" id="dvRightContent">
                        <div class="col-md-12 clearfix">
                            <div class="tabControls">
                                <ul class="nav nav-tabs">
                                    <li class="col-xsm-25 nav-tabs-property"><span class="linkDisabledsp">&nbsp;</span><a onclick="SetSelectedTab('propertyTabLink');" data-toggle="tab" href="#propertyTabLink">Property</a></li>
                                    <li class="active col-xsm-25 nav-tabs-map"><span class="linkDisabledsp">&nbsp;</span><a data-toggle="tab" href="#mapDetailsTab" onclick="SetSelectedTab('Map');">Map Details</a></li>
                                    <li class="col-xsm-25 nav-tabs-machine"><span class="linkDisabledsp">&nbsp;</span><a data-toggle="tab" id="lnkMachineDetails" href="#machineDetailsTab" onclick="SetSelectedTab('Machine');">Machine details</a></li>
                                    <li class="col-xsm-25 nav-tabs-inventory"><span class="linkDisabledsp">&nbsp;</span><a data-toggle="tab" href="#slotInventoryDataTab" onclick="SetSelectedTab('Inventory');">Slot Inventory Data</a></li>
                                </ul>
                                <div class="tab-content">
                                    <!--Property Tab Starts-->
                                    <div class="tab-pane fade in" id="propertyTabLink">
                                        <div class="tab-container clearfix">
                                             <div class="col-md-12">
                                                <div class="row" id="dvTabLbl">
                                                    <div class="col-md-4 top-margin-one">
                                                        <label>Define Assigned Property</label>
                                                    </div>
                                                </div>
                                                <div class="row" id="dvAllProperties">
                                                    <div class="col-md-4 top-margin-one">
                                                        <asp:CheckBox ID="chkAllProperties" ClientIDMode="Static" Text="All Properties"  AutoPostBack="true" OnCheckedChanged="chkAllProperties_AllPropertiesChanged" Visible="False" runat="server" />
                                                    </div>
                                                </div>
                                                <div class="row" id="dvSelectPropertiesLbl">
                                                    <div class="col-md-8 top-margin-one">
                                                       <%-- <label for="lblStartScreen_plainTextUrl">Define Excluded/Included Property</label>--%>
                                                        <asp:ListBox ID="lstProperties" SelectionMode="Single" runat="server" CssClass="permissionBox"></asp:ListBox>
                                                       
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <!--Property Tab Ends-->

                                    <asp:HiddenField runat="server" ID="imgMapImageUrl" />
                                    <!--Map Details Tab Starts-->
                                    <div class="tab-pane active fade in" id="mapDetailsTab">
                                        <div class="tab-container clearfix">
                                            <div class="col-md-9 clearfix">
                                                <div class="col-md-6">
                                                    <label for="mapText">Map</label>
                                                    <asp:TextBox runat="server" ID="txtMapName" CssClass="form-control" MaxLength="100"></asp:TextBox>
                                                </div>
                                            </div>
                                            <div class="col-md-12 clearfix">
                                                <div class="col-md-12">
                                                    <label for="lblMapImage">
                                                        Upload Map
                                                    </label>
                                                    <div class="UploadDiv col-xs-4">
                                                        <div id="Div36">
                                                        </div>
                                                        <button type="button" id="btnMapUploadImage" onclick="return false;" class="UploadButton">&nbsp;</button>
                                                        <div id="Div37">
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-9 clearfix">
                                                <div class="col-md-6 clearfix">
                                                    <asp:LinkButton ID="btnlnkClear" runat="server" Text="Clear Map" OnClientClick="return ClearMap()" CssClass="results-control col-xs-12 btn btn-reset topMargin"></asp:LinkButton>

                                                    <asp:HiddenField runat="server" ID="hdnImgWidth" />
                                                    <asp:HiddenField runat="server" ID="hdnImgHeight" />
                                                    <asp:HiddenField runat="server" ID="hdnSlotGameDetailID" />
                                                    <asp:HiddenField runat="server" ID="hdnFloorMapID" />
                                                    <asp:HiddenField runat="server" ID="hdnFileID" />
                                                    <asp:HiddenField runat="server" ID="hdnMapStatus" />
                                                    <asp:HiddenField runat="server" ID="hdnMachineDetailStatus" />
                                                    <asp:HiddenField runat="server" ID="hdngvMapIndex" Value="0" />
                                                    <asp:HiddenField runat="server" ID="hdnSelectedButton" Value="Active" />
                                                    <asp:HiddenField runat="server" ID="hdnGvMapSelectedIndex" Value="0" />
                                                    <asp:HiddenField runat="server" ID="hdnGvMachineDetailSelectedIndex" Value="0" />
                                                    <asp:HiddenField runat="server" ID="hdnIsMapUpload" Value="0" />
                                                    <asp:HiddenField runat="server" ID="hdnAssetNumber" Value="0" />
                                                </div>
                                            </div>
                                            <div class="col-md-12 clearfix">
                                                <div class="col-md-12">
                                                    <div class="mapPreview">
                                                        <label>Map Preview</label>
                                                        <div class="map">
                                                            <div class="imgMachineDetailWrap mapdv" id="dvMapImage" runat="server">
                                                                <asp:Image ID="imgMap" runat="server" />

                                                                <asp:HiddenField runat="server" ID="hdnMapImageUrl" />
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                        </div>
                                    </div>
                                    <div class="col-md-12 btnGroup2 btnGroup3">
                                        <div class="btn-groupSpecial clearfix">
                                            <asp:Button ID="lnkBtnSaveMap" runat="server" Text="Save" OnClick="lnkBtnSaveMap_Click" OnClientClick="setControlValue('Save'); return FormMapValidation();" CssClass="results-control col-xsm-32"></asp:Button>
                                            <asp:Button ID="lnkBtnCancelMap" runat="server" OnClientClick=" setControlValue('Cancel'); return MapValidationAlert(2);" Text="Cancel" OnClick="lnkBtnCancelMap_Click" CssClass="results-control col-xsm-32"></asp:Button>
                                            <asp:Button ID="lnkBtnDeleteMap" runat="server" OnClientClick="setControlValue('Delete'); return MapValidationAlert(3);" Text="Delete" OnClick="lnkBtnDeleteMap_Click" CssClass="results-control col-xsm-32"></asp:Button>

                                        </div>
                                    </div>
                                    <!--Map Details Tab Ends-->

                                    <!--Machine DetaMainContent_ddlMapDenominationils Tab Starts-->
                                    <div class="tab-pane fade" id="machineDetailsTab">
                                        <div class="tab-container clearfix">
                                            <div class="col-md-12">
                                                <div class="col-md-5">
                                                    <div class="clearfix whiteBg">
                                                        <div class="pull-left">
                                                            <label>Machine Details</label>
                                                        </div>
                                                        <div class="pull-right">
                                                            <span class="addBtn">Add
                                                        <asp:Button ID="btnAddMachineDetail" runat="server" OnClick="lnkbtnAddMachineDetail_Click" CssClass="btn btn-add pull-right input-group-shedulebtnbtnmargin"></asp:Button></span>

                                                        </div>
                                                    </div>
                                                    <asp:Panel runat="server" DefaultButton="btnSearchDenomination">
                                                    <div class="input-group" >
                                                        
                                                        <asp:TextBox ID="txtSearchDenomination" class="form-control  height26 numericwithdecimal" runat="server" value="Search Denomination" onblur="if(value=='') value = 'Search Denomination'" onkeypress="return EnterEvent(event)" onfocus="if(value=='Search Denomination') value = ''" />
                                                        <span class="input-group-btn" >
                                                            <asp:Button ID="btnSearchDenomination" runat="server" OnClick="btnSearchDenomination_Click" CssClass="btn btn-black glyphicons filter btn-icon white"></asp:Button>
                                                            <i></i>
                                                        </span>
                                                       
                                                    </div></asp:Panel>
                                                    <div class="map-detail-selectbox">
                                                        <asp:DropDownList ID="ddlSearchManufacturer" AutoPostBack="True" runat="server" OnSelectedIndexChanged="ddlSearchManufacturer_SelectedIndexChanged" CssClass="form-control">
                                                        </asp:DropDownList>
                                                        <asp:DropDownList ID="ddlSearchGameType" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlSearchGameType_SelectedIndexChanged" CssClass="form-control no-border-top">
                                                        </asp:DropDownList>
                                                        <%-- <asp:DropDownList ID="ddlMapDenominationS" runat="server" OnSelectedIndexChanged="ddlMapDenominationS_SelectedIndexChanged" AutoPostBack="True" CssClass="form-control no-border-top">
                                                        </asp:DropDownList>--%>
                                                        <asp:DropDownList ID="ddlSearchGameName" AutoPostBack="True" OnSelectedIndexChanged="ddlSearchGameName_SelectedIndexChanged" runat="server" CssClass="form-control no-border-top">
                                                            <asp:ListItem Value="-1">Select by Coordinates</asp:ListItem>
                                                            <asp:ListItem Value="1">Has Coordinates</asp:ListItem>
                                                            <asp:ListItem Value="0">No Coordinates</asp:ListItem>
                                                        </asp:DropDownList>
                                                        <div id="div1" class="scrollbar" style="height: 360px; overflow: auto;">
                                                              <asp:UpdatePanel runat="server" ID="grdUpdatepanel">
                                                                  <ContentTemplate>
                                                                        <asp:GridView CssClass="gridview" ID="gvMachineDetail" runat="server" AutoGenerateColumns="false" DataKeyNames="SlotGameID,AssetNumber"
                                                                AllowSorting="true" OnSorting="gvMachineDetail_Sorting"  CurrentSortField="AssetNumber" CurrentSortDirection="ASC" OnRowCreated="gvMachineDetail_RowCreated">
                                                                <Columns>
                                                                    <asp:TemplateField HeaderText="Asset ID" SortExpression="AssetNumber">

                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblID" runat="server" Visible="false" Text='<%#Eval("SlotGameID") %>' />
                                                                            <asp:LinkButton ID="lnkBtnShowMachineDetail" runat="server" Text='<%#Eval("AssetNumber")%>' CommandName="Select" OnClick="lnkBtnShowMachineDetail_Click" />
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                </Columns>
                                                                <Columns>
                                                                    <asp:TemplateField HeaderText="Game Name" SortExpression="GameName">
                                                                        <ItemTemplate>
                                                                            <asp:LinkButton ID="lnkBtnShowMachineDetail1" runat="server" Text='<%#(Eval("GameName") ) %>' CommandName="Select" OnClick="lnkBtnShowMachineDetail_Click" />
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                </Columns>
                                                                <SelectedRowStyle CssClass="gvSelectedRow" />
                                                            </asp:GridView>
                                                                  </ContentTemplate>
                                                              </asp:UpdatePanel>
                                                            <div id="Div2">
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <asp:UpdatePanel runat="server" >
                                                    <ContentTemplate>
                                                         <div class="col-md-7">
                                                    <div class="col-md-9">
                                                        <asp:HiddenField runat="server" ID="hdnSlotGameID" />
                                                        <label for="manufacturer">Manufacturer</label>
                                                        <asp:DropDownList ID="ddlMapManufacturer" runat="server" CssClass="form-control">
                                                        </asp:DropDownList>
                                                        <label for="MapGameType">Game Type</label>
                                                        <asp:DropDownList ID="ddlMapGameType" runat="server" CssClass="form-control">
                                                        </asp:DropDownList>
                                                        <label for="MapDenomination">Denomination</label>
                                                        <%--  <asp:DropDownList ID="ddlMapDenomination" runat="server" CssClass="form-control">
                                                        </asp:DropDownList>--%>
                                                        <asp:TextBox ID="txtDenomination" class="form-control numericwithdecimal " MaxLength="15" runat="server" />
                                                        <label for="MapGameName">Game Name</label>
                                                        <%--  <asp:DropDownList ID="ddlMapGameName" AutoPostBack="True" runat="server" CssClass="form-control">                                                         
                                                        </asp:DropDownList>--%>
                                                        <asp:TextBox ID="txtMapGameName" class="form-control" runat="server" MaxLength="250" />
                                                    </div>
                                                    <div class="col-md-9">
                                                        <label for="assetId">Asset ID</label>

                                                        <asp:TextBox type="text" ID="txtMapAssetId" class="form-control numeric" runat="server" MaxLength="250" />

                                                        <label>Map Coordinates (X,Y)</label>
                                                        <div class="row">
                                                            <div class="col-md-12 clearfix">
                                                                <label for="mapX" class="pull-left">X</label>
                                                                <asp:TextBox ID="txtMapX" CssClass="form-control pull-right numericwithdecimal" runat="server" Width="90%" MaxLength="18" />
                                                            </div>

                                                        </div>

                                                        <div class="row">
                                                            <div class="col-md-12 clearfix">
                                                                <label for="mapY" class="pull-left">Y</label>
                                                                <asp:TextBox ID="txtMapY" class="form-control pull-right numericwithdecimal" runat="server" Width="90%" MaxLength="18" />
                                                            </div>
                                                            <div class="col-xs-5 col-sm-offset-4">
                                                                <input type="reset" class="btn btn-reset" value="Clear Coordinates" onclick="return ClearCoordinate()" />
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-11 marginTop">
                                                        <div class="col-md-12  btnGroup3">
                                                            <div class="btn-groupSpecial row clearfix">

                                                                <asp:Button ID="lnkbtnSaveMachineDetail" runat="server" Text="Save" OnClick="lnkbtnSaveMachineDetail_Click" OnClientClick="setControlValue('MDSave'); return FormMachineDetailValidation();" CssClass="results-control col-xsm-32"></asp:Button>
                                                                <asp:Button ID="lnkbtnCancelMachineDetail" runat="server" OnClientClick="setControlValue('MDCancel'); return MachineDetailValidationAlert(2);" Text="Cancel" OnClick="lnkbtnCancelMachineDetail_Click" CssClass="results-control col-xsm-32"></asp:Button>
                                                                <asp:Button ID="lnkbtnDeleteMachineDetail" runat="server" OnClientClick="setControlValue('MDDelete'); return MachineDetailValidationAlert(3);" Text="Delete" OnClick="lnkbtnDeleteMachineDetail_Click" CssClass="results-control col-xsm-32"></asp:Button>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                    </ContentTemplate>
                                                </asp:UpdatePanel>
                                                   
                                                <div class="col-md-12 clearfix">
                                                    <div class="mapPreview">
                                                        <label>Map Preview</label>

                                                        <div class="map" id="dvMachineImage" runat="server">

                                                            <div class="imgMachineDetailWrap machinedv ps-active-x ps-active-y">
                                                                <div class="pin" style="display: none" id="dvPin">
                                                                    <span>Coordinate: X= 0 Y= 0</span>
                                                                </div>
                                                                <asp:Image ID="imgMachineDetail" runat="server" />
                                                            </div>
                                                        </div>
                                                    </div>

                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <!--Machine Details Tab Ends-->

                                    <!--Slot Inventory Tab Starts-->
                                    <div class="tab-pane fade" id="slotInventoryDataTab">
                                        <div class="tabbable tabs-left">
                                            <div class="tab-container clearfix">
                                                <div class="col-md-12">
                                                    <div class="fieldset">
                                                        <fieldset>
                                                            <legend>
                                                                <label>Slot Inventory Update Method</label></legend>
                                                            <div class="col-md-5">
                                                                <input type="radio" name="updateMethod" id="updateSync" />
                                                                <label for="updateSync">Sync Service</label>
                                                                <input type="radio" name="updateMethod" id="updateManual" checked="checked" />
                                                                <label for="updateManual">Manual File Upload</label>
                                                            </div>
                                                            <div class="col-md-7">
                                                                <label for="map">Upload Slot Inventory File</label>

                                                                <asp:Image EnableViewState="True" ID="imgSlotInventoryDataImageUrl" runat="server" />
                                                                <asp:HiddenField runat="server" ID="hdnSlotInventoryDataImageUrl" />
                                                                <div class="UploadDiv col-xs-12">
                                                                    <asp:FileUpload runat="server" ID="FUSlotInventoryData" onchange="fileCheck(this);" />

                                                                </div>
                                                                <div class="row clearfix topMargin">
                                                                    <div class="col-xs-6 topMargin">
                                                                        <asp:Button ID="btnUpdateSlotInventoryData" OnClick="btnUpdateSlotInventoryData_Click" OnClientClick="return FormSlotInventoryValidation()" Text="Update with selected file" runat="server" CssClass="btn btn-reset" />
                                                                    </div>
                                                                    <div class="col-xs-6 topMargin">
                                                                        <asp:Button ID="btnReplaceSlotInventoryData" OnClick="btnReplaceSlotInventoryData_Click" OnClientClick="return FormSlotInventoryValidation()" Text="Replace with selected file" runat="server" CssClass="btn btn-reset" />
                                                                    </div>
                                                                </div>
                                                                <div class="progress topMargin">
                                                                    <div class="progress-bar progress-bar-success" role="progressbar" aria-valuenow="70" aria-valuemin="0" aria-valuemax="100" style="width: 0%" id="dvSlotPercentageDisplay" runat="server">
                                                                        <span class="sr-only" id="spSlotInventoryDatapercentage" runat="server"></span>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </fieldset>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <!--Slot Inventory Data Tab Ends-->

                                </div>
                            </div>
                        </div>

                    </div>
                </div>
            </div>
            <asp:HiddenField runat="server" ID="hdnSeletedTab" Value="property" />
            <asp:HiddenField runat="server" ID="hdnActive" Value="Active" />

            <script type="text/javascript">

              
                function EnterEvent(e) {
                    if (e.keyCode == 13)
                    {
                        document.getElementById('<%=btnSearchDenomination.ClientID%>').click();
                    }
                }
                //***************************************Start On UpdatePanel Refresh Register /Common Functions *******************
                var prm = Sys.WebForms.PageRequestManager.getInstance();
                if (prm != null) {
                    prm.add_endRequest(function (sender, e) {
                        if (sender._postBackSettings.panelsToUpdate != null) {

                            RegisterUploadMapControls();
                            $('.imgMachineDetailWrap').perfectScrollbar();
                            RegisterMapShowCoordinateIcon();
                            isNumberWithDecimal();
                            ReigsterLeftDivHeight();
                            GetMapImage();
                        }
                    });
                }

                ///**************************************End On UpdatePanel Refresh Register Common Functions**************************
                ////*************************************************Start Page load functionality.***********************************
                $(document).ready(function () {

                    RegisterUploadMapControls();
                    $('.imgMachineDetailWrap').perfectScrollbar();
                    RegisterMapShowCoordinateIcon();
                    isNumberWithDecimal();
                    ReigsterLeftDivHeight();
                    GetMapImage();

                });
                ////*************************************************End Page load functionality.***********************************

                function ReigsterLeftDivHeight() {
                    $("#dvLeftcontentdetail").height($('#dvRightContent').height());
                }
                function RegisterMapScrollBar() {
                    $('.machinedv').perfectScrollbar({ suppressScrollX: true, suppressScrollY: true });
                    $('.map').perfectScrollbar({ suppressScrollX: true, suppressScrollY: true });

                }
                function RegisterMapShowCoordinateIcon() {

                    $('#<%=imgMachineDetail.ClientID%>').bind('click', function (e) {
                        var img = new Image();
                        img.src = $('#<%=imgMachineDetail.ClientID%>').attr('src');
                            var width = img.width;
                            var height = img.height;
                            var offset = $('#<%=imgMachineDetail.ClientID%>').offset();
                            var relativeX = (e.pageX - offset.left);
                            var relativeY = (e.pageY - offset.top);
                            var oHeight = ((relativeY) / height * 100);
                            var oWidth = ((relativeX) / width * 100);
                            var str = '';
                            str += '<tr><td>Asset ID:</td><td>' + document.getElementById('<%=txtMapAssetId.ClientID%>').value + '</td></tr>';
                            var str = '';
                            str += '<tr><td>Asset ID:</td><td>' + document.getElementById('<%=txtMapAssetId.ClientID%>').value + '</td></tr>';
                            if (document.getElementById('<%=ddlMapManufacturer.ClientID%>').selectedIndex != 0) {

                            str += '<tr><td>Manufacturer:</td><td>' + document.getElementById('<%=ddlMapManufacturer.ClientID%>').options[document.getElementById('<%=ddlMapManufacturer.ClientID%>').selectedIndex].text + '</td></tr>';
                            } else {
                                str += '<tr><td>Manufacturer:</td><td></td></tr>';
                            }
                        if (document.getElementById('<%=ddlMapGameType.ClientID%>').selectedIndex != 0) {

                            str += '<tr><td>Game Type:</td><td>' + document.getElementById('<%=ddlMapGameType.ClientID%>').options[document.getElementById('<%=ddlMapGameType.ClientID%>').selectedIndex].text + '</td></tr>';
                            }
                            else {
                                str += '<tr><td>Game Type:</td><td></td></tr>';
                            }
                        if (document.getElementById('<%=txtDenomination.ClientID%>').value != '') {
                            str += '<tr><td>Denomination:</td><td>' + document.getElementById('<%=txtDenomination.ClientID%>').value + '</td></tr>';
                            }
                            else {
                                str += '<tr><td>Denomination:</td><td></td></tr>';

                            } str += '<tr><td>Game Name:</td><td>' + document.getElementById('<%=txtMapGameName.ClientID%>').value + '</td></tr>';
                        str += '<tr><td>Coordinate:</td><td>X= ' + oWidth + ' <br> Y= ' + oHeight + '</td></tr>';
                        $('.pin').css({ top: relativeY - 24, left: relativeX - 12 });
                        $('.pin span').html('<table>' + str + '</table>');

                        document.getElementById("MainContent_txtMapX").value = oWidth;
                        document.getElementById("MainContent_txtMapY").value = oHeight;
                        $('#dvPin').show();
                        if (relativeY < 150) {
                            $('.pin span').css({ 'bottom': '-128px' });
                        }
                        else {
                            $('.pin span').css({ 'bottom': '28px' });
                        }

                    });
                }
                function setControlValue(val) {
                    document.getElementById('<%=hdnSelectedButton.ClientID%>').value = val;
                    }
                    function setActive(val) {
                        document.getElementById('<%=hdnActive.ClientID%>').value = val;                        
                    }

                    ///Check file format
                    function fileCheck(obj) {

                        document.getElementById('<%=spSlotInventoryDatapercentage.ClientID%>').innerHTML = '';
                    document.getElementById('<%=dvSlotPercentageDisplay.ClientID%>').style.width = '0%';
                    var fileExtension = ['csv', 'txt'];
                    if ($.inArray($(obj).val().split('.').pop().toLowerCase(), fileExtension) == -1) {
                        alert("Only 'csv','txt' formats are allowed.");
                        obj.value = '';
                    }
                }
                function ClearCoordinate() {

                    document.getElementById('<%=txtMapX.ClientID%>').value = '';
                    document.getElementById('<%=txtMapY.ClientID%>').value = '';
                    $('#dvPin').hide();
                    return false;
                }
                function ClearMap() {
                    document.getElementById('<%=hdnMapImageUrl.ClientID%>').value = '';
                    document.getElementById('<%=imgMapImageUrl.ClientID%>').value = '';
                    $('#<%=imgMap.ClientID%>').attr('src', '');
                    $('#<%=imgMachineDetail.ClientID%>').attr('src', '');
                    $('#dvPin').hide();
                    return false;
                }
                function RegisterUploadMapControls() {
                    new AjaxUpload('#btnMapUploadImage', {
                        action: 'MapUpload.ashx',
                        onComplete: function (file, response) {
                            var res = response.split("-");
                            $('#<%=imgMap.ClientID%>').attr('src', '');
                            $('#<%=imgMap.ClientID%>').attr('src', res[2]);
                            $('#<%=imgMachineDetail.ClientID%>').attr('src', '');
                            $('#<%=imgMachineDetail.ClientID%>').attr('src', res[2]);
                            var img = new Image();
                            img.src = $('#<%=imgMap.ClientID%>').attr('src');

                            document.getElementById('<%=hdnImgWidth.ClientID%>').value = img.width;
                            document.getElementById('<%=hdnImgHeight.ClientID%>').value = img.height;
                            document.getElementById('<%=imgMapImageUrl.ClientID%>').value = res[2];
                            document.getElementById("<%=hdnIsMapUpload.ClientID%>").value = '1';
                            document.getElementById('<%=txtMapX.ClientID%>').value = '';
                            document.getElementById('<%=txtMapY.ClientID%>').value = '';
                            document.getElementById('<%=hdnMapImageUrl.ClientID%>').value = response;
                            $('#dvPin').hide();

                        },
                        onSubmit: function (file, ext) {

                            if (!(ext && /^(jpg|png|jpeg|gif)$/.test(ext))) {
                                alert('Invalid File Format.');

                                return false;
                            }

                        },
                        error: function (xhr, desc, err) {
                            var errormsg = xhr + "," + desc + "," + err;
                            alert(errormsg);

                        }
                    });
                }

                ///Confirmation message after delete/save/cancel button onclick
                function MapValidationAlert(flag) {
                    var savemsg = 'Are you sure to save this Map?';
                    var cancelmsg = 'Are you sure to discard current changes?';
                    var deletemsg = 'Are you sure to delete this Map ';
                    var isChange = FormChanges('from1');
                    if (isChange != "") {
                        var message = '';
                        if (flag == 1) {
                            $('#<%=btnConfirmedSaveMachineDetail.ClientID%>').hide();
                            $('#<%=btnConfirmedCancelMachineDetail.ClientID%>').hide();
                            $('#<%=btnConfirmedDeleteMachineDetail.ClientID%>').hide();
                            $('#<%=btnConfirmedSave.ClientID%>').show();
                            $('#<%=btnConfirmedCancel.ClientID%>').hide();
                            $('#<%=btnConfirmedDelete.ClientID%>').hide();
                            $('#<%=btnConfirmedActive.ClientID%>').hide();
                            $('#<%=btnConfirmedInActive.ClientID%>').hide();
                            $('#<%=btnConfirmedAll.ClientID%>').hide();
                            $('#ConfirmBoxMessage').html(savemsg);
                        }
                        else if (flag == 2) {
                            $('#<%=btnConfirmedSaveMachineDetail.ClientID%>').hide();
                                $('#<%=btnConfirmedCancelMachineDetail.ClientID%>').hide();
                                $('#<%=btnConfirmedDeleteMachineDetail.ClientID%>').hide();
                                $('#<%=btnConfirmedSave.ClientID%>').hide();
                                $('#<%=btnConfirmedCancel.ClientID%>').show();
                                $('#<%=btnConfirmedDelete.ClientID%>').hide();
                                $('#<%=btnConfirmedActive.ClientID%>').hide();
                                $('#<%=btnConfirmedInActive.ClientID%>').hide();
                                $('#<%=btnConfirmedAll.ClientID%>').hide();
                                $('#ConfirmBoxMessage').html(cancelmsg);
                            }
                            else if (flag == 3) {
                                $('#<%=btnConfirmedSaveMachineDetail.ClientID%>').hide();
                                $('#<%=btnConfirmedCancelMachineDetail.ClientID%>').hide();
                                $('#<%=btnConfirmedDeleteMachineDetail.ClientID%>').hide();
                                $('#<%=btnConfirmedSave.ClientID%>').hide();
                                $('#<%=btnConfirmedCancel.ClientID%>').hide();
                                $('#<%=btnConfirmedDelete.ClientID%>').show();
                                $('#<%=btnConfirmedActive.ClientID%>').hide();
                                $('#<%=btnConfirmedInActive.ClientID%>').hide();
                                $('#<%=btnConfirmedAll.ClientID%>').hide();
                                $('#ConfirmBoxMessage').html(deletemsg);
                            }
                            else if (flag == 4) {

                                $('#<%=btnConfirmedSaveMachineDetail.ClientID%>').hide();
                                $('#<%=btnConfirmedCancelMachineDetail.ClientID%>').hide();
                                $('#<%=btnConfirmedDeleteMachineDetail.ClientID%>').hide();
                                $('#<%=btnConfirmedSave.ClientID%>').hide();
                                $('#<%=btnConfirmedCancel.ClientID%>').hide();
                                $('#<%=btnConfirmedDelete.ClientID%>').hide();
                                $('#<%=btnConfirmedActive.ClientID%>').show();
                                $('#<%=btnConfirmedInActive.ClientID%>').hide();
                                $('#<%=btnConfirmedAll.ClientID%>').hide();
                                $('#ConfirmBoxMessage').html(cancelmsg);
                                $('#ConfirmBox').modal({ backdrop: 'static', keyboard: false });
                                return false;
                            }
                            else if (flag == 5) {

                                $('#<%=btnConfirmedSaveMachineDetail.ClientID%>').hide();
                                $('#<%=btnConfirmedCancelMachineDetail.ClientID%>').hide();
                                $('#<%=btnConfirmedDeleteMachineDetail.ClientID%>').hide();
                                $('#<%=btnConfirmedSave.ClientID%>').hide();
                                $('#<%=btnConfirmedCancel.ClientID%>').hide();
                                $('#<%=btnConfirmedDelete.ClientID%>').hide();
                                $('#<%=btnConfirmedActive.ClientID%>').hide();
                                $('#<%=btnConfirmedInActive.ClientID%>').show();
                                $('#<%=btnConfirmedAll.ClientID%>').hide();
                                $('#ConfirmBoxMessage').html(cancelmsg);
                                $('#ConfirmBox').modal({ backdrop: 'static', keyboard: false });
                                return false;
                            }
                            else if (flag == 6) {

                                $('#<%=btnConfirmedSaveMachineDetail.ClientID%>').hide();
                                $('#<%=btnConfirmedCancelMachineDetail.ClientID%>').hide();
                                $('#<%=btnConfirmedDeleteMachineDetail.ClientID%>').hide();
                                $('#<%=btnConfirmedSave.ClientID%>').hide();
                                $('#<%=btnConfirmedCancel.ClientID%>').hide();
                                $('#<%=btnConfirmedDelete.ClientID%>').hide();
                                $('#<%=btnConfirmedActive.ClientID%>').hide();
                                $('#<%=btnConfirmedInActive.ClientID%>').hide();
                                $('#<%=btnConfirmedAll.ClientID%>').show();
                                $('#ConfirmBoxMessage').html(cancelmsg);
                                $('#ConfirmBox').modal({ backdrop: 'static', keyboard: false });
                                return false;
                            }
        $('#ConfirmBox').modal({ backdrop: 'static', keyboard: false });
        return false;
    }
    else if (flag == 3) {
        $('#<%=btnConfirmedSaveMachineDetail.ClientID%>').hide();
        $('#<%=btnConfirmedCancelMachineDetail.ClientID%>').hide();
        $('#<%=btnConfirmedDeleteMachineDetail.ClientID%>').hide();
        $('#<%=btnConfirmedSave.ClientID%>').hide();
        $('#<%=btnConfirmedCancel.ClientID%>').hide();
        $('#<%=btnConfirmedDelete.ClientID%>').show();
        $('#ConfirmBoxMessage').html(deletemsg);
        $('#ConfirmBox').modal({ backdrop: 'static', keyboard: false });
        return false;
    }
    return true;

}
$('#ConfirmBox').on('show.bs.modal', function (e) {

});

function MachineDetailValidationAlert(flag) {
    var savemsg = 'Are you sure to save this Machine detail?';
    var cancelmsg = 'Are you sure to discard current changes?';
    var deletemsg = 'Are you sure to delete this Machine detail ';
    var isChange = FormChanges('from1');
    if (isChange != "") {
        var message = '';
        if (flag == 1) {
            $('#<%=btnConfirmedSaveMachineDetail.ClientID%>').show();
                            $('#<%=btnConfirmedCancelMachineDetail.ClientID%>').hide();
                            $('#<%=btnConfirmedDeleteMachineDetail.ClientID%>').hide();
                            $('#<%=btnConfirmedSave.ClientID%>').hide();
                            $('#<%=btnConfirmedCancel.ClientID%>').hide();
                            $('#<%=btnConfirmedDelete.ClientID%>').hide();
                            $('#ConfirmBoxMessage').html(savemsg);
                        }
                        else if (flag == 2) {
                            $('#<%=btnConfirmedSaveMachineDetail.ClientID%>').hide();
                                $('#<%=btnConfirmedCancelMachineDetail.ClientID%>').show();
                                $('#<%=btnConfirmedDeleteMachineDetail.ClientID%>').hide();
                                $('#<%=btnConfirmedSave.ClientID%>').hide();
                                $('#<%=btnConfirmedCancel.ClientID%>').hide();
                                $('#<%=btnConfirmedDelete.ClientID%>').hide();
                                $('#ConfirmBoxMessage').html(cancelmsg);
                            }
                            else if (flag == 3) {
                                $('#<%=btnConfirmedSaveMachineDetail.ClientID%>').hide();
                                $('#<%=btnConfirmedCancelMachineDetail.ClientID%>').hide();
                                $('#<%=btnConfirmedDeleteMachineDetail.ClientID%>').show();
                                $('#<%=btnConfirmedSave.ClientID%>').hide();
                                $('#<%=btnConfirmedCancel.ClientID%>').hide();
                                $('#<%=btnConfirmedDelete.ClientID%>').hide();
                                $('#ConfirmBoxMessage').html(deletemsg);
                            }
                    $('#ConfirmBox').modal({ backdrop: 'static', keyboard: false });
                    return false;
                }
                else if (flag == 3) {

                    $('#<%=btnConfirmedSaveMachineDetail.ClientID%>').hide();
                    $('#<%=btnConfirmedCancelMachineDetail.ClientID%>').hide();
                    $('#<%=btnConfirmedDeleteMachineDetail.ClientID%>').show();
                    $('#<%=btnConfirmedSave.ClientID%>').hide();
                    $('#<%=btnConfirmedCancel.ClientID%>').hide();
                    $('#<%=btnConfirmedDelete.ClientID%>').hide();
                    $('#ConfirmBoxMessage').html(deletemsg);
                    $('#ConfirmBox').modal({ backdrop: 'static', keyboard: false });
                    return false;
                }
            return true;

        }
        function GetMapImage() {

            if (document.getElementById('<%=hdnFileID.ClientID%>').value != "") {
                        var fileId = document.getElementById('<%=hdnFileID.ClientID%>').value;
                        $('#<%=updateProgress.ClientID%>').show();
                        $('.preloaderNew').show();
                        $.ajax({
                            type: "POST",
                            url: "MapManagement.aspx/GetMapImage",
                            data: "{ \"fileID\":'" + fileId + "'}",
                            contentType: "application/json; charset=utf-8",
                            success: function (data) {

                                $('#<%=imgMap.ClientID%>').attr('src', data.d.ImgUrl);
                                $('#<%=imgMachineDetail.ClientID%>').attr('src', '');
                                $('#<%=imgMachineDetail.ClientID%>').attr('src', data.d.ImgUrl);
                                document.getElementById('<%=hdnMapImageUrl.ClientID%>').value = data.d.hdnUrl;
                                document.getElementById('<%=imgMapImageUrl.ClientID%>').value = data.d.ImgUrl;

                                var img = new Image();
                                img.src = $('#<%=imgMap.ClientID%>').attr('src');
                                document.getElementById('<%=hdnImgWidth.ClientID%>').value = img.width;
                                document.getElementById('<%=hdnImgHeight.ClientID%>').value = img.height;
                                if (document.getElementById('<%=txtMapX.ClientID%>').value != "") {
                                    var mapy = document.getElementById('<%=txtMapY.ClientID%>').value == "" ? 0 : document.getElementById('<%=txtMapY.ClientID%>').value;
                                    var mapx = document.getElementById('<%=txtMapX.ClientID%>').value == "" ? 0 : document.getElementById('<%=txtMapX.ClientID%>').value;

                                    if (document.getElementById('<%=txtMapY.ClientID%>').value == "Infinity") {
                                        document.getElementById('<%=txtMapY.ClientID%>').value = "";
                                        mapy = "0";
                                    }
                                    if (document.getElementById('<%=txtMapX.ClientID%>').value == "Infinity") {
                                        document.getElementById('<%=txtMapX.ClientID%>').value = "";
                                        mapx = "0";
                                    }
                                    var oHeight = (mapy * img.height / 100);
                                    var oWidth = (mapx * img.width / 100);

                                    var str = '';
                                    str += '<tr><td>Asset ID:</td><td>' + document.getElementById('<%=txtMapAssetId.ClientID%>').value + '</td></tr>';
                                    var str = '';
                                    str += '<tr><td>Asset ID:</td><td>' + document.getElementById('<%=txtMapAssetId.ClientID%>').value + '</td></tr>';
                                    if (document.getElementById('<%=ddlMapManufacturer.ClientID%>').selectedIndex != 0) {

                                        str += '<tr><td>Manufacturer:</td><td>' + document.getElementById('<%=ddlMapManufacturer.ClientID%>').options[document.getElementById('<%=ddlMapManufacturer.ClientID%>').selectedIndex].text + '</td></tr>';
                                    }
                                    else {
                                        str += '<tr><td>Manufacturer:</td><td></td></tr>';
                                    }
                                    if (document.getElementById('<%=ddlMapGameType.ClientID%>').selectedIndex != 0) {
                                        str += '<tr><td>Game Type:</td><td>' + document.getElementById('<%=ddlMapGameType.ClientID%>').options[document.getElementById('<%=ddlMapGameType.ClientID%>').selectedIndex].text + '</td></tr>';
                                    }
                                    else {
                                        str += '<tr><td>Game Type:</td><td></td></tr>';

                                    }
                                    if (document.getElementById('<%=txtDenomination.ClientID%>').value != '') {
                                        str += '<tr><td>Denomination:</td><td>' + document.getElementById('<%=txtDenomination.ClientID%>').value + '</td></tr>';
                                    }
                                    else {
                                        str += '<tr><td>Denomination:</td><td></td></tr>';

                                    } str += '<tr><td>Game Name:</td><td>' + document.getElementById('<%=txtMapGameName.ClientID%>').value + '</td></tr>';
                                    str += '<tr><td>Coordinate:</td><td>X= ' + mapx + ' <br> Y= ' + mapy + '</td></tr>';
                                    $('.pin').css({ top: oHeight - 24, left: oWidth - 12 });
                                    $('.pin span').html('<table>' + str + '</table>');
                                    $('#dvPin').show();
                                    if (mapy < 150) {
                                        $('.pin span').css({ 'bottom': '-128px' });
                                    }
                                    else {
                                        $('.pin span').css({ 'bottom': '28px' });
                                    }
                                }
                                else {

                                    $('#dvPin').hide();
                                }
                                $('.preloaderNew').hide();
                                $('#<%=updateProgress.ClientID%>').hide();
                            },
                            error: function (xhr, status, err) {
                                $('#<%=updateProgress.ClientID%>').hide();
                                $('.preloaderNew').hide();
                                var err = eval("(" + xhr.responseText + ")");
                                alert(err.Message);

                            }
                        });
                        }
                        else {
                            $('#<%=imgMap.ClientID%>').attr('src', '');
                        $('#<%=imgMachineDetail.ClientID%>').attr('src', '');
                        $('#<%=imgMachineDetail.ClientID%>').attr('src', document.getElementById('<%=imgMapImageUrl.ClientID%>').value);
                        $('#<%=imgMap.ClientID%>').attr('src', document.getElementById('<%=imgMapImageUrl.ClientID%>').value);

                    }

                }

                function FormSlotInventoryValidation() {
                    if (document.getElementById('<%=hdnFloorMapID.ClientID%>').value == '') {
                        document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please first save map detail';
                        $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                        return false;
                    }
                    if (document.getElementById('<%=FUSlotInventoryData.ClientID%>').value == '') {

                        document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please select file';
                            $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                            document.getElementById('<%=txtMapName.ClientID%>').focus();
                            return false;
                        }
                    }
                    function FormMapValidation() {
                        if (myTrim(document.getElementById('<%=txtMapName.ClientID%>').value) == '') {
                            document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please enter map name';
                            $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                            SetSelectedTab('Map');
                            document.getElementById('<%=txtMapName.ClientID%>').focus();
                            return false;
                        }
                        if (document.getElementById('<%=hdnMapImageUrl.ClientID%>').value == '') {
                            document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please upload map image';
                            $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                            return false;
                        }
                        var status = MapValidationAlert(1);
                        if (status == false) {
                            return false;
                        }
                    }
                     function FormMachineDetailValidation() {
                        if (document.getElementById('<%=hdnFloorMapID.ClientID%>').value == '') {
                            document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please first save map detail';
                            $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                            return false;
                        }
                        if (document.getElementById('<%=hdnMapImageUrl.ClientID%>').value == '') {
                            document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please upload map image';
                            $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                            return false;
                        }
                        if (document.getElementById('<%=hdnFloorMapID.ClientID%>').value == '') {

                            document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please first create map detail';
                            $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                            return false;
                        }
                        if (myTrim(document.getElementById('<%=txtMapName.ClientID%>').value) == '') {

                            document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please enter map name';
                            $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                            document.getElementById('<%=txtMapName.ClientID%>').focus();
                            return false;
                        }
                        if ($('#<%=ddlMapManufacturer.ClientID%> option:selected').val() == "-1") {
                            document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please select  manufacturer';
                            $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                            document.getElementById('<%=ddlMapManufacturer.ClientID%>').focus();
                            return false;
                        }
                        if ($('#<%=ddlMapGameType.ClientID%> option:selected').val() == "-1") {
                            document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please select game type';
                            $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                            document.getElementById('<%=ddlMapGameType.ClientID%>').focus();
                            return false;
                        }
                        if (document.getElementById('<%=txtDenomination.ClientID%>').value == '') {
                            document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please enter denomination';
                            $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                            document.getElementById('<%=txtDenomination.ClientID%>').focus();
                            return false;
                        }
                        if (myTrim(document.getElementById('<%=txtMapGameName.ClientID%>').value) == '') {
                            document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please enter game name';
                            $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                            document.getElementById('<%=txtMapGameName.ClientID%>').focus();
                            return false;
                        }
                        if (myTrim(document.getElementById('<%=txtMapAssetId.ClientID%>').value) == '') {
                            document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please enter asset id';
                            $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                            document.getElementById('<%=txtMapAssetId.ClientID%>').focus();
                            return false;
                        }
                        var status = MachineDetailValidationAlert(1);
                        if (status == false) {
                            return false;
                        }
                    }
                    function SetTabControls() {
                        var readTabValue = $('#<%=hdnSeletedTab.ClientID%>').val();
                        switch (readTabValue) {
                            case 'propertyTabLink':
                                $('.nav-tabs li').removeClass('active');
                                $('.nav-tabs li.nav-tabs-property').addClass('active');
                                $('.tab-content .tab-pane').removeClass('active in');
                                $('#propertyTabLink').addClass('active in');
                                break;
                            case 'Map':

                                $('.nav-tabs li').removeClass('active');
                                $('.nav-tabs li.nav-tabs-map').addClass('active');
                                $('.tab-content .tab-pane').removeClass('active in');
                                $('#mapDetailsTab').addClass('active in');
                                break;
                            case 'Machine':
                                $('.nav-tabs li').removeClass('active');
                                $('.nav-tabs li.nav-tabs-machine').addClass('active');
                                $('.tab-content .tab-pane').removeClass('active in');
                                $('#machineDetailsTab').addClass('active in');
                                break;
                            case 'Inventory':
                                $('.nav-tabs li').removeClass('active');
                                $('.nav-tabs li.nav-tabs-inventory').addClass('active');
                                $('.tab-content .tab-pane').removeClass('active in');
                                $('#slotInventoryDataTab').addClass('active in');

                                break;
                        }
                        ReigsterLeftDivHeight();
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
                    function SetDefaultTab() {
                        $('.nav-tabs li').removeClass('active');
                        $('.nav-tabs li.nav-tabs-content').addClass('active');
                        $('.tab-content .tab-pane').removeClass('active in');
                        $('#propertyTabLink').addClass('active in');
                    }

                    function SetSelectedTab(selectedTab) {
                        var selected = selectedTab;
                        $('#<%=hdnSeletedTab.ClientID%>').val(selectedTab);
                    SetTabControls();
                }


                function myTrim(x) {
                    return x.replace(/\s/g, '').replace('-', '');
                }

                function DisableAndResetListBox() {
                    if ($("#chkAllProperties").prop('checked')) {
                        $('#dvSelectPropertiesLbl').find('select, button, input:text').prop('disabled', true);
                    }
                    else {
                        $('#dvSelectPropertiesLbl').find('select, button, input:text').prop('disabled', false);
                    }
                }

                //  Area list box
                function RegisterListBox() {
                    //$("#dvLeftcontentdetail").height($('#dvRightContent').height());
                    var permissionBox = $('.permissionBox').bootstrapDualListbox({
                        nonselectedlistlabel: 'Exclude',
                        selectedlistlabel: 'Include',
                        preserveselectiononmove: 'moved',
                        moveonselect: false,
                        hdnControlId: 'hdnSelectedProperties',
                        
                    });
                }

                function SelectPropTab()
                {                    
                    $('#<%=hdnSeletedTab.ClientID%>').val('propertyTabLink');
                }

                function DisableMachineDetailsTab()
                {
                    $('#lnkMachineDetails').attr('disabled','disabled');
                    $('#lnkMachineDetails').css({"pointer-events": "none", "cursor": "default"})
                }

                function DisableMachineDetailTabDelete()
                {
                    $('#<%=lnkbtnDeleteMachineDetail.ClientID%>').attr('disabled', 'disabled');
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
                            <asp:Button ID="btnConfirmedSave" CssClass="btn btn-danger" runat="server" Text="OK" UseSubmitBehavior="false" data-dismiss="modal" OnClick="lnkBtnSaveMap_Click" Style="display: none;"></asp:Button>
                            <asp:Button ID="btnConfirmedCancel" CssClass="btn btn-danger" runat="server" Text="OK" UseSubmitBehavior="false" data-dismiss="modal" OnClick="lnkBtnCancelMap_Click" Style="display: none;"></asp:Button>
                            <asp:Button ID="btnConfirmedDelete" CssClass="btn btn-danger" runat="server" Text="OK" UseSubmitBehavior="false" data-dismiss="modal" OnClick="lnkBtnDeleteMap_Click" Style="display: none;"></asp:Button>
                            <asp:Button ID="btnConfirmedSaveMachineDetail" CssClass="btn btn-danger" runat="server" Text="OK" UseSubmitBehavior="false" data-dismiss="modal" OnClick="lnkbtnSaveMachineDetail_Click" Style="display: none;"></asp:Button>
                            <asp:Button ID="btnConfirmedCancelMachineDetail" CssClass="btn btn-danger" runat="server" Text="OK" UseSubmitBehavior="false" data-dismiss="modal" OnClick="lnkbtnCancelMachineDetail_Click" Style="display: none;"></asp:Button>
                            <asp:Button ID="btnConfirmedDeleteMachineDetail" CssClass="btn btn-danger" runat="server" Text="OK" UseSubmitBehavior="false" data-dismiss="modal" OnClick="lnkbtnDeleteMachineDetail_Click" Style="display: none;"></asp:Button>
                            <asp:Button ID="btnConfirmedActive" CssClass="btn btn-danger" runat="server" Text="OK" UseSubmitBehavior="false" data-dismiss="modal" OnClick="lnkbtnActive_Click" Style="display: none;"></asp:Button>
                            <asp:Button ID="btnConfirmedInActive" CssClass="btn btn-danger" runat="server" Text="OK" UseSubmitBehavior="false" data-dismiss="modal" OnClick="lnkbtnInActive_Click" Style="display: none;"></asp:Button>
                            <asp:Button ID="btnConfirmedAll" CssClass="btn btn-danger" runat="server" Text="OK" UseSubmitBehavior="false" data-dismiss="modal" OnClick="lnkbtnAll_Click" Style="display: none;"></asp:Button>
                            <button type="button" class="btn" id="confirm" data-dismiss="modal">Cancel</button>
                        </div>
                    </div>
                </div>
            </div>
        </ContentTemplate>
        <Triggers>
            <asp:PostBackTrigger ControlID="btnReplaceSlotInventoryData" />
            <asp:PostBackTrigger ControlID="btnUpdateSlotInventoryData" />
        </Triggers>
    </asp:UpdatePanel>
</asp:Content>


