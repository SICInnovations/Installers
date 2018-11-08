<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PermissionManagement.aspx.cs" MasterPageFile="~/Site.Master" Inherits="HAMobileWebAdmin.PermissionManagement" %>


<asp:Content runat="server" ID="Content1" ContentPlaceHolderID="HeadContent">
</asp:Content>
<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">
    
      <script type="text/ecmascript">
          $(document).ready(function () {
              $("#dvLeftcontentdetail").height($('#dvRightContent').height());
          });

          function setPageSize() {
              $("#dvLeftcontentdetail").height($('#dvRightContent').height());
          }

    </script>
      <div style="text-align: center;" >
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
                                <asp:Button ID="btnSearch" runat="server"  class="btn btn-black glyphicons filter btn-icon white" OnClick="btnSearch_Click"/>
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
                                            <asp:LinkButton ID="lnkBtnADGroupName" runat="server" Text='<%#Eval("ADGroupName") %>'  OnClick="lnkBtnADGroupName_Click" />
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
                <div class="col-md-9">
                    <h5>&nbsp;</h5>
                    <div class="row clearfix relative btnGroup btnGroup3" id="dvRightContent">
                        <div class="row">
                            <div class="col-md-12">
                                <div class="col-md-12">
                                    <label>User Group</label>
                                    <asp:TextBox ID="txtUserGroupName" runat="server" ReadOnly="true" CssClass="form-control"></asp:TextBox>                                   
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
                            <div class="col-md-12">
                                <div class="col-md-12 icons-control-btn clearfix">
                                    <asp:Button ID="btnCancel" runat="server" class="btn btn-icon-cancel pull-right"  Text="Cancel" OnClick="btnCancel_Click"/>
                                    <asp:Button ID="btnSave" runat="server" class="btn btn-icon-save pull-right"  Text="Save" OnClick="btnSave_Click"/>
                                  
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


