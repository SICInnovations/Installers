<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RapidReserveVIPTiers.aspx.cs" MasterPageFile="~/Site.Master" Inherits="HAMobileWebAdmin.RapidReserveVipTiers" %>


<asp:Content runat="server" ID="Content1" ContentPlaceHolderID="HeadContent">
</asp:Content>
<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">
    <div style="text-align: center;">
        <asp:UpdateProgress ID="updateProgress" runat="server" AssociatedUpdatePanelID="updpnlRapidReserveVIPTiers">
            <ProgressTemplate>
                <div style="position: fixed; text-align: center; height: 100%; width: 100%; top: 0; right: 0; left: 0; z-index: 9999999; background-color: #000000; opacity: 0.7;">
                    <asp:Image ID="imgUpdateProgress" runat="server" ImageUrl="Content/img/loader.gif" AlternateText="Loading ..." ToolTip="Loading ..." Style="padding: 10px; position: fixed; top: 45%; left: 50%;" />
                </div>
            </ProgressTemplate>
        </asp:UpdateProgress>
    </div>
    <asp:UpdatePanel ID="updpnlRapidReserveVIPTiers" runat="server">
        <ContentTemplate>
            <asp:HiddenField ID="hdnTierIDs" runat="server" Value="" />
            <div class="row" id="slotInventory">
                <div class="col-md-12">
                    <div class="col-md-8">
                        <h5><b>Define RapidReserve VIP Tiers</b></h5>
                    </div>
                    <div class="col-md-8">
                        <label>RapidReserve VIP Tiers</label>
                    </div>
                    <div class="row">
                        <div class="col-md-8">

                            <asp:ListBox ID="lstbxTiers" SelectionMode="Multiple" runat="server" CssClass="RRvipTierBox"></asp:ListBox>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-8">
                            <div class="col-md-12 icons-control-btn clearfix">
                                <asp:Button ID="btnCancel" runat="server" class="btn btn-icon-cancel pull-right" Text="Cancel" OnClick="btnCancel_Click" />
                                <asp:Button ID="btnSave" runat="server" class="btn btn-icon-save pull-right" Text="Save" OnClick="btnSave_Click" />

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
                function RegisterListBox() {
                    var permissionBox = $('.RRvipTierBox').bootstrapDualListbox({
                        nonselectedlistlabel: 'Exclude',
                        selectedlistlabel: 'VIP Tiers',
                        preserveselectiononmove: 'moved',
                        moveonselect: false,
                        hdnControlId: 'hdnTierIDs'
                        
                    });
                }
            </script>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>


