<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="PDFUploadControl.ascx.cs" Inherits="HAMobileWebAdmin.UserControl.PDFUploadControl" %>
<div>
<%--<asp:Image  ID="imgImageUrl" Style="width: 100px; height: 100px;" runat="server" />--%>
<asp:HiddenField runat="server" ID="hdnImageUrl" />
<asp:HiddenField runat="server" ID="hdnSetDefaultImageUrl" />
<div class="UploadDiv UploadDiv2 col-md-12 fullwidthlabel">
    <div id="UploadStatus">
    </div>
    <asp:Button ID="btnUploadPDFButton" runat="server" OnClientClick="return false;" CssClass="UploadPDFButton1"></asp:Button>
    <asp:Label id="lblPdfName" runat="server"></asp:Label>
    <div id="UploadedFile">
    </div>
</div>
</div>