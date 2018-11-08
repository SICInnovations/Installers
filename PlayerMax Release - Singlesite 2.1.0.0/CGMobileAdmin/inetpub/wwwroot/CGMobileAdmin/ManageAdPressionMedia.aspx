<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ManageAdPressionMedia.aspx.cs" MasterPageFile="~/Site.Master" Inherits="HAMobileWebAdmin.ManageAdPressionMedia" %>

<asp:Content runat="server" ID="Content1" ContentPlaceHolderID="HeadContent">
    <script src="Scripts/JWPlayer/jwplayer.js"></script>
</asp:Content>
<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">

    <div style="text-align: center;">
        <asp:UpdateProgress ID="updateProgress" runat="server" AssociatedUpdatePanelID="updpnlBatchMessage">
            <ProgressTemplate>
                <div style="position: fixed; text-align: center; height: 100%; width: 100%; top: 0; right: 0; left: 0; z-index: 9999999; background-color: #000000; opacity: 0.7;">
                    <asp:Image ID="imgUpdateProgress" runat="server" ImageUrl="Content/img/loader.gif" AlternateText="Loading ..." ToolTip="Loading ..." Style="padding: 10px; position: fixed; top: 45%; left: 50%;" />
                </div>
            </ProgressTemplate>
        </asp:UpdateProgress>
    </div>
    <asp:UpdatePanel ID="updpnlBatchMessage" runat="server">
        <ContentTemplate>
            <asp:HiddenField runat="server" ID="hdnVideoUrl" />
            <asp:HiddenField runat="server" ID="hdnVideoFile" />
            <asp:HiddenField runat="server" ID="hdnFileID" />
                <asp:HiddenField runat="server" ID="hdnBtnPermission" />
             <asp:HiddenField runat="server" ID="hdngvAdPressionMediaSelectedIndex" Value="0" />
            <div class="row" id="slotInventory">
                <div class="col-sm-3">
                    <h5>Manage adPression Media</h5>
                    <div class="filterWrapper relative" id="dvLeftcontentdetail">
                        <div class="clearfix">
                            <div class="pull-left">
                                <label>Content Type</label>
                            </div>
                            <div class="pull-right"><span class="addBtn">Add
                                <asp:Button ID="btnAddVideo" runat="server" OnClick="btnAddVideo_Click" CssClass="btn btn-add pull-right" /></span>
                            </div>
                        </div>
                        <div class="input-group clearfix col-sm-12">
                            <asp:TextBox ID="txtFileSearch" runat="server" CssClass="form-control height26"></asp:TextBox>
                            <span class="input-group-btn">
                                <asp:Button ID="btnVideoFilter" runat="server" class="btn btn-black glyphicons filter btn-icon white  input-group-btnbtnmargin" OnClick="btnVideoFilter_Click" />
                                <i></i></button>
                            </span>
                        </div>
                        <div id="divgv">

                            <asp:GridView CssClass="gridview" ID="gvVideos" runat="server" ShowHeader="False" AutoGenerateColumns="false"
                                DataKeyNames="FileID" AllowPaging="true" PageSize="10" OnPageIndexChanging="gvVideos_PageIndexChanging">
                                <Columns>

                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <asp:Label ID="lblVideoFileID" runat="server" Visible="false" Text='<%#Eval("FileID") %>' />
                                            <asp:LinkButton ID="lnkFileName" runat="server" Text='<%#Eval("DisplayName") %>' OnClick="lnkFileName_Click" />

                                        </ItemTemplate>

                                    </asp:TemplateField>
                                </Columns>
                                <SelectedRowStyle CssClass="gvSelectedRow" />
                                <PagerStyle CssClass="gridview-pager"></PagerStyle>


                            </asp:GridView>
                            <div id="content"></div>

                        </div>
                        <div id="dvLeftContent" class="filterResults relative btnGroup">
                            <div class="btn-groupSpecial">
                                <asp:Button ID="lnkbtnActiveMessage" runat="server" Text="active" CssClass="results-control col-xs-4 active"  OnClientClick="return ConfirmMessage(2); " OnClick="lnkbtnActiveAwards_Click"></asp:Button>
                                <asp:Button ID="lnkbtnInactiveMessage" runat="server" Text="inactive" CssClass="results-control col-xs-4" OnClientClick="return ConfirmMessage(2);" OnClick="lnkbtnInactiveAwards_Click"></asp:Button>
                                <asp:Button ID="lnkbtnAllMessage" runat="server" Text="all" CssClass="results-control col-xs-4" OnClientClick="return ConfirmMessage(2);" OnClick="lnkbtnAllAwards_Click"></asp:Button>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-sm-9">
                    <h5>adPression Media Detail</h5>
                    <div class="row clearfix relative btnGroup btnGroup3" id="dvRightContent">
                        <div class="col-md-12">
                            <div class="row">
                                <div class="col-md-6 clearfix">
                                    <label for="<%= txtMediaName.ClientID %>">Media Asset Name</label>
                                    <asp:TextBox ID="txtMediaName" runat="server" class="form-control" MaxLength="250"></asp:TextBox>
                                </div>

                            </div>
                        </div>
                        <div class="col-md-12">


                            <!--adPression Event Tab Starts-->



                            <div class="UploadDiv col-md-6 clearfix">
                                <label>Media File</label>
                                <%-- <button type="button" id="btnVideoFileUpload" class="UploadButton"></button>--%>
                                <asp:FileUpload ID="FileUploadControl" runat="server" CssClass="form-group btn btn-default "  />
                                <asp:Button runat="server" ID="btnUploadVideoFile" Text="Upload" OnClick="btnUploadVideoFile_Click"  CssClass="form-group  uploadbtn" />
                                <br />
                                <br />
                                <asp:Label ID="lblErrorMsg" runat="server" Visible="false" ForeColor="Red"></asp:Label>
                            </div>




                            <!--adPression Event Tab Ends-->

                        </div>
                        <div class="col-md-12">
                            <div class="row">
                                <div class="col-md-8">
                                    <label>Media Preview</label>

                                    <%-- <video id="videoPlayer" width="500px" height="400px" controls>
                                        <source src="<%=hdnVideoUrl.Value %>" type="video/mp4">
                                        Your browser does not support the video tag.
                                    </video>--%>
                                    <%--<video  height="270" id="videoPlayer"   runat="server"                                  width="480">
                                                </video>--%>
                                    <div id="videoPlayer" style="height: 270px; width: 480px;">Loading the player ...</div>
                                </div>
                            </div>

                        </div>

                        <div class="col-md-12">
                            <div class="btn-groupSpecial clearfix">
                                <asp:Button ID="lnkbtnSave" runat="server" Text="Save" CssClass="results-control col-xsm-32" OnClientClick="return ConfirmMessage(1);" OnClick="lnkbtnSave_Click"></asp:Button>
                                <asp:Button ID="lnkbtnCancel" runat="server" Text="Cancel" CssClass="results-control col-xsm-32" OnClientClick="return ConfirmMessage(2);" OnClick="lnkbtnCancel_Click"></asp:Button>
                                <asp:Button ID="lnkbtnDelete" runat="server" Text="Delete" CssClass="results-control col-xsm-32" OnClientClick="return ConfirmMessage(3);" OnClick="lnkbtnDelete_Click"></asp:Button>

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
        
            <script type='text/javascript'>
                function RegisterJavaScript() {   
                    $("#dvLeftcontentdetail").height($('#dvRightContent').height());
                    jwplayer("videoPlayer").setup({
                        flashplayer: "Scripts/JWPlayer/player.swf",
                        file: '<%=hdnVideoUrl.Value %>',
                        image: 'Scripts/JWPlayer/preview.jpg',
                        autostart: true,
                        height: 270,
                        width: 480,
                        plugins: {
                            sharing: { link: false }
                        }
                    });
                }
                ///Confirmation message after delete/save/cancel button onclick
                function ConfirmMessage(flag) {
                    var savemsg = 'Are you sure to save this Icon?';
                    var cancelmsg = 'Are you sure to discard current changes?';
                    var deletemsg = 'Are you sure to delete this media asset?';
                 
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
            </script>
          


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
        </ContentTemplate>
        <Triggers>
            <asp:PostBackTrigger ControlID="gvVideos" />
            <asp:PostBackTrigger ControlID="btnUploadVideoFile" />
            <asp:PostBackTrigger ControlID="btnAddVideo" />
            <asp:PostBackTrigger ControlID="btnVideoFilter" />
            <asp:PostBackTrigger ControlID="lnkbtnCancel" />
            <asp:PostBackTrigger ControlID="lnkbtnDelete" />
            <asp:PostBackTrigger ControlID="lnkbtnActiveMessage" />
            <asp:PostBackTrigger ControlID="lnkbtnInactiveMessage" />
            <asp:PostBackTrigger ControlID="lnkbtnAllMessage" />
        </Triggers>
    </asp:UpdatePanel>
</asp:Content>



