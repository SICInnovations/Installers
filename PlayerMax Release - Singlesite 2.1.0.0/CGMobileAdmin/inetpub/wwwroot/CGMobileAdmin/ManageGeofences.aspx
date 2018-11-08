<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="Site.Master" CodeBehind="ManageGeofences.aspx.cs" Inherits="HAMobileWebAdmin.ManageGeofences" %>

<asp:Content runat="server" ID="Content1" ContentPlaceHolderID="HeadContent">
    <title>COG Mobile | Manage Geofence Detail</title>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <link rel="stylesheet" href="Content/css/perfect-scrollbar-0.4.10.min.css" />
    <script src="Scripts/CommonJS/jquery.mousewheel.js"></script>
    <script src="Scripts/CommonJS/perfect-scrollbar.js"></script>

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
            <div class="row">
                <div class="col-sm-3">
                    <h5>Geofences</h5>
                    <div class="filterWrapper relative" id="dvLeftcontentdetail">
                        <div class="clearfix whiteBg">
                            <div class="pull-left">
                            </div>
                            <div class="pull-right">
                                <span class="addBtn">Add
                                    <asp:Button ID="lnkbtnAdd" runat="server" OnClick="lnkbtnAdd_Click" CssClass="btn btn-add pull-right" OnClientClick="SetZeroIsRadiusAndPolygon()"></asp:Button></span>
                            </div>
                        </div>
                        <div class="input-group clearfix col-sm-12">
                            <asp:TextBox CssClass="form-control height26" ID="txtSearch" runat="server"></asp:TextBox>
                            <span class="input-group-btn">
                                <asp:Button ID="btnSearch" runat="server" CssClass="btn btn-black glyphicons filter btn-icon white input-group-btnbtnmargin" OnClick="btnSearch_Click"></asp:Button>
                                <i></i>
                            </span>
                        </div>
                        <div id="divgv">
                            <asp:GridView CssClass="gridview" ID="gvGeofences" runat="server" ShowHeader="False" AutoGenerateColumns="false" DataKeyNames="GeofenceID" AllowPaging="true" PageSize="20" OnPageIndexChanging="gvGeofences_PageIndexChanging">
                                <Columns>
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <asp:Label ID="lblID" runat="server" Visible="false" Text='<%#Eval("GeofenceID") %>' />
                                            <asp:LinkButton ID="lnkBtnShowGeofences" runat="server" Text='<%#Eval("GeofenceName") %>' CommandName="Select" OnClick="lnkBtnShowGeofences_Click" />

                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                                <PagerStyle CssClass="gridview-pager"></PagerStyle>
                                <SelectedRowStyle CssClass="gvSelectedRow" />
                            </asp:GridView>
                            <div id="content">
                            </div>
                        </div>
                        <div class="filterResults relative btnGroup">
                            <div class="btn-groupSpecial">
                                <asp:Button ID="lnkbtnActive" runat="server" Text="Active" OnClick="lnkbtnActive_Click" OnClientClick="return ConfirmMessage(4);" CssClass="results-control col-xs-4 active"></asp:Button>
                                <asp:Button ID="lnkbtnInActive" runat="server" Text="InActive" OnClick="lnkbtnInActive_Click" OnClientClick=" return ConfirmMessage(5);" CssClass="results-control col-xs-4"></asp:Button>
                                <asp:Button ID="lnkbtnAll" runat="server" Text="All" OnClick="lnkbtnAll_Click" CssClass="results-control col-xs-4" OnClientClick="return ConfirmMessage(6);"></asp:Button>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-sm-9">
                    <h4>Geofence Detail</h4>
                    <div class="row clearfix relative btnGroup btnGroup3" id="dvRightContent">
                        <div class="col-md-12 clearfix">
                            <div class="tabControls">
                                <div>
                                    <asp:HiddenField runat="server" ID="hdnGeofencefocusLatLong" Value="" />
                                    <asp:HiddenField runat="server" ID="hdnRadiusLatLong" Value="" />
                                    <asp:HiddenField runat="server" ID="hdnRadius" Value="" />
                                    <asp:HiddenField runat="server" ID="hdnIsRadious" Value="true" />
                                    <asp:HiddenField runat="server" ID="hdnGeofenceID" Value="" />
                                    <asp:HiddenField runat="server" ID="hdnGimbleID" Value="" />
                                    <asp:HiddenField runat="server" ID="hdnButtonSatus" Value="Active" />
                                    <asp:HiddenField runat="server" ID="hdnCoordinates" Value="" />
                                    <asp:HiddenField runat="server" ID="hdnGvGeofenceSelectedIndex" Value="0" />
                                    <asp:HiddenField runat="server" ID="hdnPolygonLatLong" Value="" />
                                    <asp:HiddenField runat="server" ID="hdnDefaultMapLatLong" Value="" />
                                    <!--Manage Content Tab Starts-->
                                    <div class="tab-pane active fade in" id="manageContentTab">
                                        <div class=" clearfix">
                                            <div class="">
                                                <div class="row">
                                                    <div class="col-md-12 col-sm-6 col-xs-8">
                                                        <label for="contentItem">Geofence Name</label>
                                                        <asp:TextBox ID="txtGeofenceName" class="form-control" runat="server" MaxLength="250" />
                                                    </div>

                                                    <div class="col-md-12 active-btn col-xs-4  col-sm-4 label_actv">
                                                        <asp:CheckBox ID="chkActive" Checked="true" Text="Active?" Visible="false" runat="server" />
                                                    </div>

                                                </div>

                                                <div class="row">
                                                    <div class="col-md-12">
                                                        <label for="contentItem">Geofence Description</label>
                                                        <asp:TextBox ID="txtGeofenceDescription" CssClass="form-control" runat="server" MaxLength="350" />
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-md-12 clearfix">
                                                        <div class="geofencePreview">
                                                            <h3>Create Geofence</h3>

                                                            <div class="map" id="dvMachineImage" runat="server">
                                                                <div class="controle-search-map-geo">
                                                                   
                                                                    <div class="pull-left col-md-9 col-sm-8 col-xs-7  pd0">
                                                                     <asp:TextBox ID="txtSearchLatLongMap" CssClass="form-control mxwidth" placeholder="Search by latitude,longitude or by place"  runat="server" class="col-md-5 col-lg-6 col-xs-12 text_sec numericwithdecimal" />
                                                                    </div>
                                                                    
                                                                    <div class="col-md-3 col-sm-4 col-xs-5 pd0">
                                                                        <div class="ctrl_btns wd100">
                                                                            <div class="col-md-2 col-sm-2 col-xs-2 pd0 searchbtn">
                                                                                <button id="btnSerachMapLatLong" type="button" class="btn  search-btn search-latlong" onclick=" return SearchLatAndLong();"  title="Search By lat and long"></button>
                                                                            </div>
                                                                            <div class="col-md-10 col-sm-10 col-xs-10 pd0">
                                                                                <button type="button" class="btn clear" onclick="DeleteField()" title="Clear map lat and long">Clear Geofence</button>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <div class="imgMachineDetailWrap">
                                                                    <div id="map-canvas"></div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <!--  radial secrtion starts here -->
                                                <div class="radial-sec clearfix col-md-8">

                                                    <div class="radius-sec col-md-6">                                                    
                                                        <asp:RadioButton ID="rbRadius" type="radio" GroupName="rb" runat="server" Text="Radius" onclick="ReigsterPolygonAndRadious()" />
                                                        Click and drag to create a radius geofence.
                                                    </div>

                                                    <div class="poligon-sec col-md-6">
                                                        <asp:RadioButton ID="rbPolygon" type="radio" GroupName="rb" runat="server" Text="Polygon" onclick=" ReigsterPolygonAndRadious()" />
                                                        Click the map to define your polygon; close the polygon to complete.
                                                    </div>
                                                </div>
                                            </div>
                                            <!-- create geofence section end here-->

                                        </div>
                                    </div>
                                </div>

                                <!--adPression Population Tab Ends-->

                            </div>
                        </div>

                        <div class="col-md-12 btnGroup2">
                            <div class="btn-groupSpecial clearfix">                              
                                <asp:Button ID="lnkbtnSave" runat="server" OnClientClick="return FormValidation();" Text="Save" OnClick="lnkbtnSave_Click" CssClass="results-control col-xsm-32"></asp:Button>
                                <asp:Button ID="lnkbtnCancel" runat="server" OnClientClick="return ConfirmMessage(2);" Text="Cancel" OnClick="lnkbtnCancel_Click" CssClass="results-control col-xsm-32"></asp:Button>
                                <asp:Button ID="lnkbtnDelete" runat="server" OnClientClick="return ConfirmMessage(3);" Text="Delete" OnClick="lnkbtnDelete_Click" CssClass="results-control col-xsm-32"></asp:Button>

                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <script type="text/javascript">

                $(document).ready(function () {
                    isMarker = 0;
                    RegisterDivHeight();
                    SetMapDrawingType();
                    isNumberWithDecimal();
                    RegisterDetectedFormChanges();
                });
                //***************************************Start On UpdatePanel Refresh Register Common Functions ********************************************************8

                var prm = Sys.WebForms.PageRequestManager.getInstance();
                if (prm != null) {
                    prm.add_endRequest(function (sender, e) {
                        if (sender._postBackSettings.panelsToUpdate != null) {

                            isMarker = 0;
                            RegisterDivHeight();
                            var centerpointlatlong = document.getElementById('MainContent_hdnGeofencefocusLatLong').value;

                            if (centerpointlatlong != '') {
                                var xy = centerpointlatlong.split(",");
                                SetCenterPoint(xy[0], xy[1]);
                            }
                            else {
                                SetCenterPoint('', '');
                            }
                            SetMapDrawingType();
                            isNumberWithDecimal();
                            RegisterDetectedFormChanges();

                        }
                    });
                }

                function SetMapDrawingType() {
                    var type;
                    var radius = document.getElementById('MainContent_hdnRadius').value;
                    var isRadius = $('#<%=rbRadius.ClientID%>')[0].checked;
                    var isPolygon = $('#<%=rbPolygon.ClientID%>')[0].checked;
                    var isRadiusExistInDb = $('#<%=hdnIsRadious.ClientID%>').val();
                    isMarker = 0;
                    if (isRadius) {
                        var radiusLatLong = document.getElementById('MainContent_hdnRadiusLatLong').value;
                        type = 1;
                        IsRadius(type);
                        if (isRadiusExistInDb == 'true' && radiusLatLong != '') {
                            SetMapCenterPoint();
                            DrawRadius(radiusLatLong, radius);
                            document.getElementById('MainContent_hdnPolygonLatLong').value = '';
                        }
                        else
                            centerpoint = '';
                    }
                    else if (isPolygon) {
                        var polygonLatLong = document.getElementById('MainContent_hdnPolygonLatLong').value;
                        type = 0;
                        IsRadius(type);
                        if (isRadiusExistInDb != 'true' && polygonLatLong != '') {
                            SetMapCenterPoint();
                            DrawPolygon(polygonLatLong);
                            document.getElementById('MainContent_hdnRadiusLatLong').value = '';

                        }
                        else
                            centerpoint = '';
                    }
                   
                    initialize();
                   
                }
                ///Set Center Point for Map
                function SetMapCenterPoint() {

                    var centerpointlatlong = document.getElementById('MainContent_hdnGeofencefocusLatLong').value;
                    if (centerpointlatlong != '') {
                        var xy = centerpointlatlong.split(",");
                        SetCenterPoint(xy[0], xy[1]);
                    }
                    else {
                        SetCenterPoint('', '');
                    }
                }

                ///Set Center Point for Map
                function SearchLatAndLong() {

                    var isRadius = $('#<%=rbRadius.ClientID%>')[0].checked;
                    var isPolygon = $('#<%=rbPolygon.ClientID%>')[0].checked;
                    var centerpointlatlong = $('#<%=txtSearchLatLongMap.ClientID%>').val();
                    var latlong = centerpointlatlong.indexOf(',');
                    var spCoords = centerpointlatlong.split(',');

                    if ($('#<%=txtSearchLatLongMap.ClientID%>').val() == '' || centerpointlatlong == 'Search by latitude,longitude or by place') {
                        $('#ConfirmBoxMessage').html('Please enter latitude and longitude');
                        $('#ConfirmBox').modal({ backdrop: 'static', keyboard: false });
                        return false;
                    }
                    else if (latlong == -1) {
                        $('#ConfirmBoxMessage').html('Please enter valid latitude and longitude with comma(,) seprate');
                        $('#ConfirmBox').modal({ backdrop: 'static', keyboard: false });
                        return false;
                    }
                    else if (spCoords[0].length <= 0) {
                        $('#ConfirmBoxMessage').html('Please enter latitude');
                        $('#ConfirmBox').modal({ backdrop: 'static', keyboard: false });
                        return false;
                    }
                    else if (spCoords[1].length <= 0) {
                        $('#ConfirmBoxMessage').html('Please enter longitude');
                        $('#ConfirmBox').modal({ backdrop: 'static', keyboard: false });
                        return false;
                    }
                    else if (IsNumeric($('#<%=txtSearchLatLongMap.ClientID%>')) == false) {
                        $('#ConfirmBoxMessage').html('Latitude and Longitude are not correctly typed');
                        $('#ConfirmBox').modal({ backdrop: 'static', keyboard: false });
                        return false;
                    }
                    $('#<%=hdnGeofencefocusLatLong.ClientID%>').val(centerpointlatlong);
                    if (isRadius) {
                        IsRadius(1);
                        isMarker = 1;
                        $('#<%=hdnRadiusLatLong.ClientID%>').val(centerpointlatlong);
                        DrawRadius(centerpointlatlong, '');
                    }
                    if (isPolygon) {
                        IsRadius(0);
                        isMarker = 1;
                        //centerpointlatlong = centerpointlatlong + ' ' + centerpointlatlong ;
                        $('#<%=hdnPolygonLatLong.ClientID%>').val(centerpointlatlong);
                        DrawPolygon(centerpointlatlong);
                    }
                    if (centerpointlatlong != '' && latlong > 0 && centerpointlatlong != 'Search by latitude,longitude or by place') {
                        var xy = centerpointlatlong.split(",");
                        SetCenterPoint(xy[0], xy[1]);
                        initialize();
                    }



                }
                function FormValidation() {

                    if (myTrim(document.getElementById('<%=txtGeofenceName.ClientID%>').value) == '') {
                        document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please enter geofence name';
                        $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                        document.getElementById('<%=txtGeofenceName.ClientID%>').focus();
                        return false;
                    }
                    if ($('#<%=hdnCoordinates.ClientID%>').val() == '') {
                        if ($('#<%=rbRadius.ClientID%>')[0].checked == true) {
                            document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please draw radius';
                            $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                            return false;
                        }
                        if ($('#<%=rbPolygon.ClientID%>')[0].checked == true) {
                            document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please draw polygon';
                            $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                            return false;
                        }
                    }

                    if ($('#<%=rbRadius.ClientID%>')[0].checked == true)
                        GetRadiusCoordinates(myField);
                    else
                        GetPolygonCoordinates(myField);

                    PolygonEditable(false);

                    var validation = ConfirmMessage(1);
                    if (validation == false) {
                        return false;
                    }
                    else {
                        return true;
                    }
                }
                function SetZeroIsRadiusAndPolygon() {
                    isChangeRadiusAndPolygon = 0;
                }
                function RegisterDivHeight() {
                    $("#dvLeftcontentdetail").height($('#dvRightContent').height());
                }

                function IsNumeric(fieldName) {

                    var latlngVal = /^[0-9@!#\$\^%&*()+=\-\[\]\\\';,\.\/\{\}\|\":<>\? ]+$/;;
                    var latlng = fieldName.val();
                    var invalid_latlng = 'Latitude and Longitude are not correctly typed';

                    // Validate Latitude and Longitude
                    if (!latlngVal.test(latlng)) {
                        return false;
                    };
                }

                ///Alert Message

                function ConfirmMessage(flag) {
                    var savemsg = 'Are you sure to save this geofence?';
                    var cancelmsg = 'Are you sure to discard current changes?';
                    var deletemsg = 'Are you sure to delete this geofence?';
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
                return true;
            }
            function isNumberWithDecimal() {

                $('.numericwithdecimal').keydown(function (event) {
                    // Allow special chars + arrows 
                    //alert(event.keyCode);
                    if (event.keyCode == 46 || event.keyCode == 109 || event.keyCode == 110 || event.keyCode == 8 || event.keyCode == 9
                        || event.keyCode == 27 || event.keyCode == 32 || event.keyCode == 13 || event.keyCode == 17 || event.keyCode == 86 || event.keyCode == 107 || event.keyCode == 188 || event.keyCode == 190
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
                // $(".numericwithdecimal").bind("paste", function (e) {
                //  return false;
                //});
                //$(".numericwithdecimal").bind("drop", function (e) {
                //    return false;
                //});
            }

            function myTrim(x) {
                return x.replace(/\s/g, '').replace('-', '');
            }
            function RegisterDetectedFormChanges() {
                $.each($("input:text"), function (index, element) {
                    element.defaultValue = $(element).val();
                });
                $.each($("input:radio"), function (index, element) {
                    element.defaultChecked = element.checked;
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
                            <asp:Button ID="btnConfirmedSave" runat="server" CssClass="btn btn-danger" Text="OK" UseSubmitBehavior="false" data-dismiss="modal" OnClick="lnkbtnSave_Click" Style="display: none;"></asp:Button>
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
            <!-- Dialog show event handler -->
            <script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?v=3.exp&sensor=false&libraries=drawing,geometry,places&key=AIzaSyCNruKOqfCFAD4Gnj02JuPnh7WOxkFGXz8"></script>
            <asp:PlaceHolder runat="server" ID="PlaceholderGeofenceScript1"></asp:PlaceHolder>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
