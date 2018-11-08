<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ImageUploadControl.ascx.cs" Inherits="HAMobileWebAdmin.UserControl.ImageUploadControl" %>
<div>
<asp:Image CssClass="imageMainPreview" ID="imgImageUrl" Style="width: 100px; " runat="server" />
<asp:HiddenField runat="server" ID="hdnImageUrl" />
<asp:HiddenField runat="server" ID="hdnSetDefaultImageUrl" />
<div class="UploadDiv UploadDiv2 col-md-12">
    <div id="UploadStatus">
    </div>
    <asp:Button ID="btnCsvFileUpload" runat="server" OnClientClick="return false;" CssClass="UploadButton1"></asp:Button>
    <div id="UploadedFile">
    </div>
</div>
</div>