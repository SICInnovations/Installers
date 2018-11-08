<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ManageContent.aspx.cs" MasterPageFile="~/Site.Master" Inherits="HA.WebApp.ManageContent" ValidateRequest="false" Title="ManageContent Detail" EnableEventValidation="false" %>

<%@ Register Src="~/UserControl/WebHtmlEditor.ascx" TagPrefix="ighedit" TagName="WebHtmlEditor" %>
<%@ Register Src="~/UserControl/ImageUploadControl.ascx" TagPrefix="img" TagName="UploadImage" %>
<%@ Register Src="~/UserControl/PDFUploadControl.ascx" TagPrefix="pdf" TagName="UploadPDF" %>
<%@ Register Src="~/UserControl/UC_CsvUpload_PopulationListTab.ascx" TagPrefix="csv" TagName="UC_CsvUpload_PopulationListTab" %>
<%@ Register Src="~/UserControl/UC_PopulationTypeTab.ascx" TagPrefix="listbox" TagName="UC_PopulationTypeTab" %>
<%@ Register Src="~/UserControl/UC_CsvUpload_PopulationListTab_WithOutBarCodeID.ascx" TagPrefix="csv" TagName="UC_CsvUpload_PopulationListTab_WithOutBarCodeID" %>


<asp:Content runat="server" ID="Content1" ContentPlaceHolderID="HeadContent">
    <title>COG Mobile | Manage Content Detail</title>
</asp:Content>
<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">
    <script src="Scripts/CommonJS/jquery.simple-color.js"></script>
    <script src="Scripts/CommonJS/datatables.min.js"></script>
    <asp:UpdatePanel ID="updpnlContentDetail" runat="server" UpdateMode="Conditional">
        <ContentTemplate>
            <div class="row" id="slotInventory">
                <div class="col-sm-3">
                    <h5>Manage Content</h5>
                    <div class="filterWrapper relative" id="dvLeftcontentdetail">
                        <div class="clearfix whiteBg">
                            <div class="pull-left">
                                <label>Content Type</label>
                            </div>
                            <div class="pull-right">
                                <span class="addBtn">Add
                                    <asp:Button ID="lnkbtnAdd" runat="server" OnClick="lnkbtnAdd_Click" CssClass="btn btn-add pull-right"></asp:Button></span>

                            </div>
                        </div>
                        <div class="input-group clearfix col-sm-12">
                            <asp:TextBox CssClass="form-control height26" ID="txtSearchName" runat="server"></asp:TextBox>
                            <span class="input-group-btn">
                                <asp:Button ID="btnSearch" runat="server" OnClick="btnSearch_Click" CssClass="btn btn-black glyphicons filter btn-icon white input-group-btnbtnmargin"></asp:Button>
                                <i></i>
                            </span>
                        </div>
                        <div class="new-select">
                            <asp:DropDownList runat="server" ID="ddlContentType" AutoPostBack="True" CssClass="form-control jq-selectbox" OnSelectedIndexChanged="ddlContentType_SelectedIndexChanged"></asp:DropDownList>
                        </div>
                        <div id="divgv">
                            <asp:GridView CssClass="gridview" ID="gvContentDetail" runat="server" ShowHeader="False" AutoGenerateColumns="false" DataKeyNames="ContentDetailID" AllowPaging="true" PageSize="15" OnPageIndexChanging="gvContentDetail_PageIndexChanging">
                                <Columns>
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <label for="lblID" runat="server" visible="false" text='<%#Eval("ContentDetailID") %>' />
                                            <asp:LinkButton ID="lnkBtnShowContentDetail" runat="server" Text='<%#Eval("Name") %>' CommandName="Select" OnClick="lnkBtnShowContentDetail_Click" />

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
                                <asp:Button ID="lnkbtnActive" runat="server" Text="Active" OnClick="lnkbtnActive_Click" OnClientClick="return ConfirmMessage(4); " CssClass="results-control col-xs-4 active"></asp:Button>
                                <asp:Button ID="lnkbtnInActive" runat="server" Text="InActive" OnClick="lnkbtnInActive_Click" OnClientClick="return ConfirmMessage(5);" CssClass="results-control col-xs-4"></asp:Button>
                                <asp:Button ID="lnkbtnAll" runat="server" Text="All" OnClick="lnkbtnAll_Click" CssClass="results-control col-xs-4" OnClientClick="return ConfirmMessage(6);"></asp:Button>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-sm-9">
                    <asp:HiddenField runat="server" ID="hdnIsShedule" Value="False" />
                    <asp:HiddenField runat="server" ID="hdnGvContentDetailSelectedIndex" Value="0" />
                    <asp:HiddenField runat="server" ID="hdnGvScheduleSelectedIndex" Value="0" />
                    <asp:HiddenField runat="server" ID="hdnIsPopulation" Value="False" />
                    <asp:HiddenField runat="server" ID="hdnEnvironmentType" />
                    <asp:HiddenField runat="server" ID="hdnContentDetailId" />
                    <asp:HiddenField runat="server" ID="hdnContentTypeId" />
                    <asp:HiddenField runat="server" ID="hdnImageFileId1" />
                    <asp:HiddenField runat="server" ID="hdnImageFileId2" />
                    <asp:HiddenField runat="server" ID="hdnImageFileId3" />
                    <asp:HiddenField runat="server" ID="hdnImageFileId4" />
                    <asp:HiddenField runat="server" ID="hdnSeletedTab" Value="content" />
                    <asp:HiddenField runat="server" ID="hdnActive" Value="Active" />
                    <asp:HiddenField runat="server" ID="hdnIsActive" Value="true" />
                    <asp:HiddenField runat="server" ID="hdnIsImageUpdated" Value="0" />
                    <asp:HiddenField runat="server" ID="hdnIsOneToMany" Value="False" />
                    <asp:HiddenField runat="server" ID="hdnUploadSquence" Value="" />
                    <asp:HiddenField runat="server" ID="hdnAwardID1" />
                    <asp:HiddenField runat="server" ID="hdnAwardID2" />
                    <asp:HiddenField runat="server" ID="hdnAwardID3" />
                    <asp:HiddenField runat="server" ID="hdnAwardID4" />
                    <asp:HiddenField runat="server" ID="hdnIsPermissionDelete" Value="1" />
                    <asp:HiddenField runat="server" ID="hdnIsPermissionSave" Value="1" />
                    <h5>Content Detail</h5>
                    <div class="row clearfix relative btnGroup btnGroup3 manage-content-right" id="dvRightContent">
                        <div class="col-md-12 clearfix">
                            <div class="tabControls">
                                <ul class="nav nav-tabs">
                                    <li class="active col-xsm-32 nav-tabs-content"><span class="linkDisabledsp">&nbsp;</span><a onclick="SetSelectedTab('content');" data-toggle="tab" href="#manageContentTab">Content</a></li>
                                    <li class="col-xsm-32 linkDisabled nav-tabs-schedule"><span class="linkDisabledsp">&nbsp;</span><a data-toggle="tab" onclick="SetSelectedTab('schedule');" href="#manageScheduleTab" id="manageScheduleTabLink">Schedule</a></li>
                                    <li class="col-xsm-32 linkDisabled nav-tabs-population"><span class="linkDisabledsp">&nbsp;</span><a data-toggle="tab" onclick="SetSelectedTab('populationTab');" href="#managePopulationTab" id="managePopulationTabLink">Population</a></li>
                                </ul>
                                <div class="tab-content">

                                    <!--Manage Content Tab Starts-->
                                    <div class="tab-pane active fade in" id="manageContentTab">
                                        <div class="tab-container clearfix">
                                            <div class="col-md-12">

                                                <div class="row" id="dvEnvironment">
                                                    <div class="col-md-12">
                                                        <label for="contentType">Environment</label>
                                                        <asp:DropDownList ID="ddlEnvironment" runat="server" CssClass="form-control jq-selectbox" onchange="RegisterSetEnvironmentTextOnLabelControl()">
                                                            <asp:ListItem Value="0">Production</asp:ListItem>
                                                            <asp:ListItem Value="1">Test</asp:ListItem>
                                                        </asp:DropDownList>

                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-md-12">
                                                        <asp:Label CssClass="label" ID="lblAssetName" runat="server" Text=""></asp:Label>
                                                        <asp:TextBox ID="txtAssetName" class="form-control" runat="server" MaxLength="250" />
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div id="dvStartupScreen" class="hello">
                                            <div class="tab-container clearfix">
                                                <div class="col-md-12">

                                                    <div class="row">
                                                        <div class="col-md-12">
                                                            <label for="lblStartScreen_plainTextUrl">Start Text</label>
                                                            <asp:TextBox ID="txtStartScreenTxtplainTextUrl" class="form-control" runat="server" MaxLength="500" />
                                                        </div>
                                                    </div>

                                                    <div class="row">
                                                        <div class="col-md-6 imageview">
                                                            <label for="lblImage">
                                                                Image Thumbnail (Upload Image 640X1008 Pixels)
                                                            <img:UploadImage runat="server" ID="UploadStartScreenImage" />
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                        </div>

                                        <div id="dvSignUp" class="hello" style="display: none;">
                                            <div class="tab-container clearfix">
                                                <div class="col-md-12">


                                                    <div class="row">
                                                        <div class="col-md-4">
                                                            <label for="lblSignUpText">Sign Up Text</label>
                                                            <asp:TextBox ID="txtSignUpText" runat="server" CssClass="form-control" MaxLength="250"></asp:TextBox>
                                                        </div>
                                                    </div>

                                                    <div class="row">
                                                        <div class="col-md-4">
                                                            <label for="lblSignInValue" runat="server">Sign In Value</label>
                                                            <asp:TextBox ID="txtSignInValue" runat="server" CssClass="form-control" MaxLength="15"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col-md-4">
                                                            <label for="lblSignUpPIN" runat="server">PIN</label>
                                                            <asp:TextBox ID="txtSignUpPIN" runat="server" CssClass="form-control" MaxLength="50"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col-md-6 imageview">
                                                            <label for="lblImage">
                                                                Image Thumbnail (Upload Image 640X1008 Pixels)</label>
                                                            <img:UploadImage runat="server" ID="UploadSignUpImage" />
                                                        </div>

                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <div id="dvPromotionAssets" class="hello" style="display: none;">
                                            <div class="tab-container clearfix">
                                                <div class="col-md-12">
                                                    <div class="row">
                                                        <div class="col-md-4">
                                                            <label for="lblPromotionAssetTitle">Promotions Title</label>
                                                            <asp:TextBox ID="txtPromotionAssetsTitle" runat="server" CssClass="form-control" MaxLength="250"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col-md-6 imageview">
                                                            <label for="lblImage">
                                                                Image Thumbnail (Upload Image 640X1008 Pixels)
                                                            <img:UploadImage runat="server" ID="UploadPromotionAssetsImage" />
                                                        </div>

                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <div id="dvPropertyAssets" class="hello" style="display: none;">
                                            <div class="tab-container clearfix">
                                                <div class="col-md-12">
                                                    <div class="row">
                                                        <div class="col-md-4">
                                                            <label for="lblPropertyCasinoName">Casino Name</label>
                                                            <asp:TextBox ID="txtPropertyCasinoName" runat="server" CssClass="form-control" MaxLength="250"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <div id="dvAboutUs" class="hello" style="display: none;">
                                            <div class="tab-container clearfix">
                                                <div class="col-md-12">

                                                    <div class="row">
                                                        <div class="col-md-12">
                                                            <label for="lblAboutUsTitle">About Us Title</label>
                                                            <asp:TextBox ID="txtAboutUsTitle" runat="server" CssClass="form-control" MaxLength="250"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                    </div>
                                                    <div class="row ">
                                                        <div class="col-md-12">
                                                            <ighedit:WebHtmlEditor runat="server" ID="txtAboutUsHtml" />
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col-md-4">
                                                            <label for="lblImage">
                                                                Image Thumbnail<br />
                                                                (Upload Image 636x396 Pixels)</label>
                                                            <img:UploadImage runat="server" ID="UploadAboutUsImage" />
                                                        </div>

                                                    </div>

                                                </div>
                                            </div>
                                        </div>

                                        <div id="dvDrivingDirections" class="hello" style="display: none;">
                                            <div class="tab-container clearfix">
                                                <div class="col-md-12">

                                                    <div class="row">
                                                        <div class="col-md-4">
                                                            <label for="lblDrivingDirectionLatitude">Latitude</label>
                                                            <asp:TextBox ID="txtDrivingDirectionsLatitude" runat="server" CssClass="form-control numericwithdecimal" MaxLength="15"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col-md-4">
                                                            <label for="lblDrivingDirectionLongitude">Longitude</label>
                                                            <asp:TextBox ID="txtDrivingDirectionsLongitude" runat="server" CssClass="form-control numericwithdecimal" MaxLength="15"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col-md-4">
                                                            <label for="lblDrivingDirectionsPinText">Driving Directions PinText</label>
                                                            <asp:TextBox ID="txtDrivingDirectionsPinText" runat="server" CssClass="form-control" MaxLength="250"></asp:TextBox>
                                                        </div>
                                                    </div>


                                                    <div class="row">
                                                        <div class="col-md-4">
                                                            <label>Driving Directions Text</label>
                                                        </div>


                                                    </div>
                                                    <div class="row">
                                                        <div class="col-md-12">
                                                            <ighedit:WebHtmlEditor runat="server" ID="txtDrivingDirectionsHeaderHtml" />
                                                        </div>
                                                    </div>
                                                    <br />

                                                    <div class="row">
                                                        <div class="col-md-4">
                                                            <label for="DrivingDirections_lblImage">
                                                                Image Thumbnail<br />
                                                                (Upload Image 636x396 Pixels)</label>
                                                            <img:UploadImage runat="server" ID="UploadDrivingDirectionsImage" />
                                                        </div>

                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <div id="dvClubInfo" class="hello" style="display: none;">
                                            <div class="tab-container clearfix">
                                                <div class="col-md-12">

                                                    <div class="row">
                                                        <div class="col-md-4">
                                                            <label for="lblClubInfoTitle">Club Information Title</label>
                                                            <asp:TextBox ID="txtClubInfoTitle" runat="server" CssClass="form-control" MaxLength="250"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col-md-4">
                                                            <label>HTML Text</label>
                                                        </div>

                                                    </div>
                                                    <div class="row">
                                                        <div class="col-md-12">
                                                            <ighedit:WebHtmlEditor runat="server" ID="txtClubInfoHtml" />
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col-md-4">
                                                            <label for="lblImage">
                                                                Image Thumbnail<br />
                                                                (Upload Image 636x396 Pixels)</label>
                                                            <img:UploadImage runat="server" ID="UploadClubInfoImage" />
                                                        </div>

                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <div id="dvWebAppBranding" class="hello" style="display: none;">
                                            <div class="tab-container clearfix">
                                                <div class="col-md-12">


                                                    <div class="row">
                                                        <div class="col-md-5 three-column">
                                                            <label for="WebAppBranding_lblImage1">
                                                                Upper Left Image
                                                                <br />
                                                                (Upload Image 636x396 Pixels)</label>
                                                            <img:UploadImage runat="server" ID="UploadWebAppBrandingImage1" />
                                                        </div>
                                                        <div class="col-md-5 three-column">
                                                            <label for="WebAppBranding_lblImage2">
                                                                Top/Right Image
                                                                <br />
                                                                (Upload Image 636x396 Pixels)</label>
                                                            <img:UploadImage runat="server" ID="UploadWebAppBrandingImage2" />
                                                        </div>

                                                    </div>
                                                    <div class="row">
                                                        <div class="col-md-5 three-column">
                                                            <label for="WebAppBranding_lblImage3">
                                                                Bottom Left Image
                                                                <br />
                                                                (Upload Image 636x396 Pixels)</label>
                                                            <img:UploadImage runat="server" ID="UploadWebAppBrandingImage3" />
                                                        </div>
                                                        <div class="col-md-7">
                                                            <div class="row">
                                                                <div class="col-md-6">
                                                                    <label for="lblWebAppBrandMenuAccentColor">Menu Accent Color</label>
                                                                    <asp:TextBox ID="txtWebAppBrandMenuAccentColor" onchange="isValidColor(this)" runat="server" CssClass="form-control simple_color_color_code" MaxLength="15"></asp:TextBox>
                                                                </div>

                                                                <div class="col-md-6">
                                                                    <label for="lblWebAppBrandTournamentCalendarAccent">Tournament Calendar Accent </label>
                                                                    <asp:TextBox ID="txtWebAppBrandTournamentCalendarAccent" onchange="isValidColor(this)" runat="server" CssClass="form-control simple_color_color_code" MaxLength="15"></asp:TextBox>
                                                                </div>
                                                            </div>
                                                            <div class="row">
                                                                <div class="col-md-6">
                                                                    <label for="lblWebAppBrandReferaFriendCalendarAccent">Refer a Friend Calendar Accent</label>
                                                                    <asp:TextBox ID="txtWebAppBrandReferaFriendCalendarAccent" onchange="isValidColor(this)" runat="server" CssClass="form-control simple_color_color_code" MaxLength="15"></asp:TextBox>
                                                                </div>

                                                                <div class="col-md-6">
                                                                    <label for="lblWebBrandadPressionCalendarAccent">adPression Calendar Accent</label>
                                                                    <asp:TextBox ID="txtWebAppBrandadPressionCalendarAccent" onchange="isValidColor(this)" runat="server" CssClass="form-control simple_color_color_code" MaxLength="15"></asp:TextBox>
                                                                </div>
                                                            </div>
                                                            <div class="row">
                                                                <div class="col-md-6">
                                                                    <label for="lblWebAppBrandMyOffersCalendarAccent">My Offers Calendar Accent</label>
                                                                    <asp:TextBox ID="txtWebAppBrandMyOffersCalendarAccent" onchange="isValidColor(this)" runat="server" CssClass="form-control simple_color_color_code" MaxLength="15"></asp:TextBox>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>

                                                </div>
                                            </div>
                                        </div>

                                        <div id="dvWebAppLoginScreenBranding" class="hello" style="display: none;">
                                            <div class="tab-container clearfix">
                                                <div class="col-md-12">
                                                    <div class="row">
                                                        <div class="col-md-5 three-column">
                                                            <label for="lblWebAppLoginScreenBrandingmage1">
                                                                Upper Left Image
                                                                <br />
                                                                (Upload Image 636x396 Pixels)</label>
                                                            <img:UploadImage runat="server" ID="UploadWebAppLoginScreenBrandingImage1" />
                                                        </div>
                                                        <div class="col-md-5 three-column">
                                                            <label for="lblWebAppLoginScreenBrandingImage2">
                                                                Left Image
                                                                <br />
                                                                (Upload Image 636x396 Pixels)</label>
                                                            <img:UploadImage runat="server" ID="UploadWebAppLoginScreenBrandingImage2" />
                                                        </div>

                                                    </div>

                                                </div>
                                                <div class="col-md-12">
                                                    <div class="row">

                                                        <div class="col-md-5 three-column">
                                                            <label for="lblWebAppBrandingImage3">
                                                                Right Image
                                                                <br />
                                                                (Upload Image 636x396 Pixels)</label>
                                                            <img:UploadImage runat="server" ID="UploadWebAppLoginScreenBrandingImage3" />
                                                        </div>
                                                    </div>

                                                </div>
                                                <div>
                                                </div>
                                            </div>
                                        </div>

                                        <div id="dvMyRewardImage" class="hello" style="display: none;">
                                            <div class="tab-container clearfix">
                                                <div class="col-md-12">
                                                    <div class="row">
                                                        <div class="col-md-5 three-column">
                                                            <label for="lblMyRewardImage1">
                                                                 POINT Image
                                                                <br />
                                                                (Upload Image 140x140 Pixels)</label>
                                                            <img:UploadImage runat="server" ID="UploadMyRewardImagePOINTImage" />
                                                        </div>
                                                        <div class="col-md-5 three-column">
                                                            <label for="UploadMyRewardImageImage2">
                                                                PROMO Image
                                                                 <br />
                                                                (Upload Image 140x140 Pixels)</label>
                                                            <img:UploadImage runat="server" ID="UploadMyRewardImagePROMOImage" />
                                                        </div>


                                                    </div>

                                                    <div>
                                                        <div class="row">
                                                            <div class="col-md-5 three-column">                                                                
                                                                <label for="UploadMyRewardImageImage3">
                                                                    CASH Image
                                                                    <br />
                                                                    (Upload Image 140x140 Pixels)</label>
                                                                <img:UploadImage runat="server" ID="UploadMyRewardImageCASHImage" />
                                                            </div>
                                                            <div class="col-md-5 three-column">
                                                                <label for="UploadMyRewardImageImage3">
                                                                    COMP Image
                                                                    <br />
                                                                    (Upload Image 140x140 Pixels)</label>
                                                                <img:UploadImage runat="server" ID="UploadMyRewardImageCOMPImage" />
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <div id="dvLinkReferralCode" class="hello" style="display: none;">
                                            <div class="tab-container clearfix">
                                                <div class="col-md-12">


                                                    <div class="row">
                                                        <div class="col-md-8">
                                                            <label for="lblLinkReferralCodeTitle">Greeting</label>
                                                            <asp:TextBox ID="txtLinkReferralCodeTitle" runat="server" CssClass="form-control" MaxLength="250"></asp:TextBox>
                                                        </div>
                                                    </div>

                                                    <div class="row">
                                                        <div class="col-md-8">
                                                            <label for="lblLinkReferralCodeBody">Tagged Link Referral Message</label>
                                                            <asp:TextBox ID="txtLinkReferralCodeBody" runat="server" CssClass="form-control" MaxLength="250"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col-md-8">
                                                            <br />
                                                            <strong>Tag refrence:-</strong>
                                                            <br />
                                                            <ol>
                                                                <li>@ReferrerFirstName = To show first name of Referrer in referral message</li>
                                                                <li>@ReferrerPoint = To show points of Referrer in referral message</li>
                                                                <li>@ReferreePoint = To show points of Referree for referal in referral message</li>
                                                            </ol>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <div id="dvReferAFriend" class="hello" style="display: none;">
                                            <div class="tab-container clearfix">
                                                <div class="col-md-12">


                                                    <div class="row">
                                                        <div class="col-md-4">
                                                            <label for="lblRefAFriendGreeting">Greeting</label>
                                                            <asp:TextBox ID="txtRefAFreindGreeting" runat="server" CssClass="form-control" MaxLength="250"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col-md-4">
                                                            <label for="lblRefAFriendBody">Tagged Download Application Message</label>
                                                            <asp:TextBox ID="txtRefAFriendBody" runat="server" CssClass="form-control" MaxLength="250"></asp:TextBox>
                                                        </div>
                                                    </div>

                                                </div>
                                            </div>
                                        </div>

                                        <div id="dvMyOffers" class="hello" style="display: none;">
                                            <div class="tab-container clearfix">
                                                <div class="col-md-12">


                                                    <div class="row">
                                                        <div class="col-md-4">
                                                            <label for="lblOfferTitle">Offer Title</label>
                                                            <asp:TextBox ID="txtOfferTitle" runat="server" CssClass="form-control" MaxLength="250"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col-md-4">
                                                            <label>Offer Detail</label>
                                                        </div>

                                                    </div>
                                                    <div class="row">
                                                        <div class="col-md-12">
                                                            <ighedit:WebHtmlEditor runat="server" ID="txtOfferDetailHtml" />
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col-md-4">
                                                            <label for="MyOffers_lblImage">
                                                                Image Thumbnail<br />
                                                                (Upload Image 636x396 Pixels)</label>
                                                            <img:UploadImage runat="server" ID="UploadMyOffersImage" />
                                                        </div>

                                                    </div>

                                                </div>
                                            </div>
                                        </div>

                                        <div id="dvPromotions" class="hello " style="display: none;">
                                            <div class="tab-container clearfix">
                                                <div class="col-md-12">
                                                    <div class="row">
                                                        <div class="col-md-6" style="display: none">
                                                            <label for="lblPromotionShareURL">Promotion Share URL</label>
                                                            <asp:TextBox ID="txtPromotionShareURL" runat="server" CssClass="form-control" MaxLength="500"></asp:TextBox>

                                                        </div>
                                                        <div class="col-md-6">
                                                            <label for="lblPromotionShareText">Promotion Share Text & URL</label>
                                                            <asp:TextBox ID="txtPromotionShareText" runat="server" CssClass="form-control" MaxLength="250"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col-md-5 three-column dvpromtion">
                                                            <label for="lblPromotionsImage">
                                                                Promotion Large Image<br />
                                                                (Upload Image 636x740 Pixels)</label>
                                                            <img:UploadImage runat="server" ID="UploadPromotionsImage" />

                                                        </div>
                                                        <div class="col-md-5 three-column ">
                                                            <label for="lblPromotionsDetailImage">
                                                                Promotion Detail Image<br />
                                                                (Upload Image 636x396 Pixels)</label>
                                                            <img:UploadImage runat="server" ID="UploadPromotionsDetailImage" />
                                                        </div>

                                                    </div>

                                                    <div class="row">
                                                        <div class="col-md-4">
                                                            <label>Promotion Detail HTML</label>
                                                        </div>

                                                    </div>
                                                    <div class="row ">
                                                        <div class="col-md-12">
                                                            <ighedit:WebHtmlEditor runat="server" ID="txtPromotionDetailHtml" />
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <div id="dvGamesPoker" class="hello" style="display: none;">
                                            <div class="tab-container clearfix">
                                                <div class="col-md-12">


                                                    <div class="row">
                                                        <div class="col-md-4">
                                                            <label for="lblPokerHeader">Poker Header</label>
                                                            <asp:TextBox ID="txtGamesPokerHeader" runat="server" CssClass="form-control" MaxLength="250"></asp:TextBox>
                                                        </div>
                                                    </div>

                                                    <div class="row">
                                                        <div class="col-md-4">
                                                            <label for="lblGamePokerWinning">Poker SubHeader</label>
                                                            <asp:TextBox ID="txtGamePokerWinning" runat="server" CssClass="form-control" MaxLength="250"></asp:TextBox>
                                                        </div>
                                                    </div>

                                                    <div class="row">
                                                        <div class="col-md-4">
                                                            <label for="GamesPoker_lblImage">
                                                                Image Thumbnail<br />
                                                                (Upload Image 636x396 Pixels)</label>
                                                            <img:UploadImage runat="server" ID="UploadGamePokerImage" />
                                                        </div>

                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <div id="dvPokerGamesDetail" class="hello" style="display: none;">
                                            <div class="tab-container clearfix">
                                                <div class="col-md-12">
                                                    <div class="row">
                                                        <div class="col-md-4">
                                                            <label for="lblPokerGameDetailName">Poker Game Name</label>
                                                            <asp:TextBox ID="txtPokerGameDetailName" runat="server" CssClass="form-control" MaxLength="250"></asp:TextBox>
                                                        </div>
                                                        <div class="col-md-4">
                                                            <label for="lblPokerGameDetailFilter">Filter</label>
                                                            <asp:DropDownList runat="server" ID="ddlPokerGameDetailFilter" CssClass="form-control" />
                                                        </div>
                                                    </div>

                                                    <div class="row">
                                                        <div class="col-md-4">
                                                            <label>Poker Game Description HTML</label>
                                                        </div>

                                                    </div>
                                                    <div class="row ">
                                                        <div class="col-md-12">
                                                            <ighedit:WebHtmlEditor runat="server" ID="txtPokerGamesDetailHtml" />
                                                        </div>
                                                    </div>

                                                    <div class="row">
                                                        <div class="col-md-4">
                                                            <label for="GamesPokerDetail_lblImage">
                                                                Image Thumbnail<br />
                                                                (Upload Image 636x396 Pixels)</label>
                                                            <img:UploadImage runat="server" ID="UploadPokerGamesDetailImage" />
                                                        </div>

                                                    </div>

                                                </div>
                                            </div>
                                        </div>

                                        <div id="dvBingo" class="hello" style="display: none;">
                                            <div class="tab-container clearfix">
                                                <div class="col-md-12">


                                                    <div class="row">
                                                        <div class="col-md-4">
                                                            <label for="lblBingoHeader">Bingo Header</label>
                                                            <asp:TextBox ID="txtBingoHeader" runat="server" CssClass="form-control" MaxLength="250"></asp:TextBox>
                                                        </div>
                                                    </div>

                                                    <div class="row">
                                                        <div class="col-md-4">
                                                            <label for="lblSubheader">Bingo Jackpot Header</label>
                                                            <asp:TextBox ID="txtBingoSubheader" runat="server" CssClass="form-control" MaxLength="250"></asp:TextBox>
                                                        </div>
                                                    </div>

                                                    <div class="row">
                                                        <div class="col-md-4">
                                                            <label for="GamesBingo_lblImage">
                                                                Image Thumbnail<br />
                                                                (Upload Image 636x396 Pixels)</label>
                                                            <img:UploadImage runat="server" ID="UploadGamesBingoImage" />
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>


                                        <div id="dvBingoGamesDetail" class="hello" style="display: none;">
                                            <div class="tab-container clearfix">
                                                <div class="col-md-12">

                                                    <div class="row">
                                                        <div class="col-md-4">
                                                            <label for="lblBingoDetailGameName">Bingo Game Name</label>
                                                            <asp:TextBox ID="txtBingoDetailGameName" runat="server" CssClass="form-control" MaxLength="250"></asp:TextBox>
                                                        </div>
                                                        <div class="col-md-4">
                                                            <label for="lblBingoDetailGameNameFilter">Filter</label>
                                                            <asp:DropDownList runat="server" ID="ddlBingoDetailGameNameFilter" CssClass="form-control" />
                                                        </div>
                                                    </div>

                                                    <div class="row">
                                                        <div class="col-md-4">
                                                            <label>Bingo Game Description HTML</label>
                                                        </div>
                                                    </div>
                                                    <div class="row ">
                                                        <div class="col-md-12">
                                                            <ighedit:WebHtmlEditor runat="server" ID="txtBingoGamesDetailHtml" />
                                                        </div>
                                                    </div>

                                                    <div class="row">
                                                        <div class="col-md-4">
                                                            <label class="label">
                                                                Image Thumbnail<br />
                                                                (Upload Image 636x396 Pixels)</label>
                                                            <img:UploadImage runat="server" ID="UploadBingoGamesDetailImage" />
                                                        </div>

                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <div id="dvGamesBingoJackpot" class="hello" style="display: none;">
                                            <div class="tab-container clearfix">
                                                <div class="col-md-12">
                                                    <div class="row">
                                                        <div class="col-md-4">
                                                            <label for="lblBingoJackpotHeader">Bingo Jackpot Header</label>
                                                            <asp:TextBox ID="txtBingoJackpotHeader" runat="server" CssClass="form-control"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col-md-4">
                                                            <label for="lblBingoJackPotSubHeader">Bingo Jackpot Subheader</label>
                                                            <asp:TextBox ID="txtGamesBingoJackpotSubheader" runat="server" CssClass="form-control"></asp:TextBox>
                                                        </div>
                                                    </div>

                                                </div>
                                            </div>
                                        </div>

                                        <div id="dvGamesTables" class="hello" style="display: none;">
                                            <div class="tab-container clearfix">
                                                <div class="col-md-12">

                                                    <div class="row">
                                                        <div class="col-md-4">
                                                            <label for="lblTableGameHeader1">Table Header</label>
                                                            <asp:TextBox ID="txtTableGameHeader1" runat="server" CssClass="form-control" MaxLength="250"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col-md-4">
                                                            <label for="lblTableGameHeader2">Table Header 2</label>
                                                            <asp:TextBox ID="txtTableGameHeader2" runat="server" CssClass="form-control" MaxLength="250"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col-md-4">
                                                            <label for="lblTableGameHeader3">Table Header 3</label>
                                                            <asp:TextBox ID="txtTableGameHeader3" runat="server" CssClass="form-control" MaxLength="250"></asp:TextBox>
                                                        </div>
                                                    </div>

                                                    <div class="row">
                                                        <div class="col-md-4">
                                                            <label class="label">
                                                                Image Thumbnail<br />
                                                                (Upload Image 636x396 Pixels)</label>
                                                            <img:UploadImage runat="server" ID="UploadTableGameImage" />
                                                        </div>

                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <div id="dvGlobalAsset" class="hello" style="display: none;">
                                            <div class="tab-container clearfix">
                                                <div class="col-md-12">

                                                    <div class="row">
                                                        <div class="col-md-6 imageview">
                                                            <label class="label"></label>
                                                            Image Thumbnail (Upload Image 640X1008 Pixels)
                                                            <img:UploadImage runat="server" ID="UploadGlobalAssetImage" />
                                                        </div>

                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <div id="dvTableGamesDetail" class="hello" style="display: none;">
                                            <div class="tab-container clearfix">
                                                <div class="col-md-12">


                                                    <div class="row">
                                                        <div class="col-md-4">
                                                            <label for="lblTableGamesDetailName">Table Game Name</label>
                                                            <asp:TextBox ID="txtTableGamesDetailName" runat="server" CssClass="form-control" MaxLength="250"></asp:TextBox>
                                                        </div>
                                                        <div class="col-md-4">
                                                            <label for="lblTableGamesDetailNameFilter">Filter</label>
                                                            <asp:DropDownList runat="server" ID="ddlTableGamesDetailNameFilter" CssClass="form-control" />
                                                        </div>
                                                    </div>

                                                    <div class="row">
                                                        <div class="col-md-4">
                                                            <label>Table Games HTML</label>
                                                        </div>
                                                    </div>
                                                    <div class="row ">
                                                        <div class="col-md-12">
                                                            <ighedit:WebHtmlEditor runat="server" ID="txtTableGamesDetailHtml" />
                                                        </div>
                                                    </div>
                                                    <div class="row">

                                                        <div class="col-md-4">
                                                            <label for="mapX">X-Pos</label>
                                                            <asp:TextBox ID="txtTableGamesDetailXpos" class="form-control numericwithdecimal" runat="server" MaxLength="15" />
                                                        </div>

                                                        <div class="col-md-4">
                                                            <label for="mapY">Y-Pos</label>
                                                            <asp:TextBox ID="txtTableGamesDetailYpos" class="form-control numericwithdecimal" runat="server" MaxLength="15" />
                                                        </div>


                                                    </div>
                                                    <div class="row">
                                                        <div class="col-md-4">
                                                            <label for="lblTableGamesDetailImage">
                                                                Image Thumbnail<br />
                                                                (Upload Image 636x396 Pixels)</label>
                                                            <img:UploadImage runat="server" ID="UploadTableGamesDetailImage" />
                                                        </div>

                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <div id="dvSlots" class="hello" style="display: none;">
                                            <div class="tab-container clearfix">
                                                <div class="col-md-12">

                                                    <div class="row">
                                                        <div class="col-md-4">
                                                            <label for="lblSlotHeader">Slot Header</label>
                                                            <asp:TextBox ID="txtSlotHeader" runat="server" CssClass="form-control" MaxLength="250"></asp:TextBox>
                                                        </div>
                                                    </div>


                                                    <div class="row">
                                                        <div class="col-md-4">
                                                            <label for="lblSlotsImage">
                                                                Image Thumbnail<br />
                                                                (Upload Image 636x396 Pixels)</label>
                                                            <img:UploadImage runat="server" ID="UploadSlotImage" />
                                                        </div>
                                                    </div>

                                                </div>
                                            </div>
                                        </div>

                                        <div id="dvSlotGameDetail" class="hello" style="display: none;">
                                            <div class="tab-container clearfix">
                                                <div class="col-md-12">


                                                    <div class="row">
                                                        <div class="col-md-4">
                                                            <label for="Label1">Slot Name</label>
                                                            <asp:TextBox ID="txtSlotGameDetailName" runat="server" CssClass="form-control"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col-md-4">
                                                            <label for="Label2">Denomination</label>
                                                            <asp:TextBox ID="txtSlotGameDetailDenomination" runat="server" CssClass="form-control"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                    <div class="row">

                                                        <div class="col-xs-6">
                                                            <label for="mapX">X-Pos</label>
                                                            <asp:TextBox type="text" ID="txtSlotGameDetailXpos" class="form-control" runat="server" />
                                                        </div>
                                                    </div>
                                                    <div class="row">

                                                        <div class="col-xs-6">
                                                            <label for="mapY">Y-Pos</label>
                                                            <asp:TextBox type="text" ID="txtSlotGameDetailYpos" class="form-control" runat="server" />
                                                        </div>


                                                    </div>
                                                    <div class="row">
                                                        <div class="col-md-4">
                                                            <label for="lblSlotGameDetailImage">
                                                                Image Thumbnail<br />
                                                                (Upload Image 636x396 Pixels)</label>
                                                            <img:UploadImage runat="server" ID="UploadSlotGameDetailImage" />
                                                        </div>

                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <div id="dvEvents" class="hello" style="display: none;">
                                            <div class="tab-container clearfix">
                                                <div class="col-md-12">
                                                    <div class="row">
                                                        <div class="col-md-4">
                                                            <label>Event Header</label>
                                                            <asp:TextBox ID="txtEventsHeader" runat="server" CssClass="form-control" MaxLength="250"></asp:TextBox>
                                                        </div>
                                                        <div class="col-md-4">
                                                            <label>Event Header Line 2</label>
                                                            <asp:TextBox ID="txtEventDescription" runat="server" CssClass="form-control" MaxLength="250"></asp:TextBox>
                                                        </div>

                                                    </div>
                                                    <div class="row">
                                                        <div class="col-md-4" style="display: none;">
                                                            <label>Event Share URL</label>
                                                            <asp:TextBox ID="txtEventShareURL" runat="server" CssClass="form-control" MaxLength="500"></asp:TextBox>
                                                        </div>
                                                        <div class="col-md-4">
                                                            <label>Event Share Text</label>
                                                            <asp:TextBox ID="txtEventShareText" runat="server" CssClass="form-control" MaxLength="250"></asp:TextBox>
                                                        </div>


                                                    </div>
                                                    <%-- Modified 9/13/16, Nacupido COG-16, hide event ticket label and url fields %>
<%--                                                <div class="row">
                                                        <div class="col-md-4">
                                                            <label>Event Ticket Label</label>
                                                            <asp:TextBox ID="txtEventTicketText" runat="server" CssClass="form-control" MaxLength="250"></asp:TextBox>
                                                        </div>
                                                        <div class="col-md-4">
                                                            <label>Event Ticket URL</label>
                                                            <asp:TextBox ID="txtEventTicketURL" runat="server" CssClass="form-control" MaxLength="500"></asp:TextBox>

                                                        </div>
                                                    </div>--%>
                                                    <div class="row">
                                                        <div class="col-md-4">
                                                            <label>HTML Text</label>
                                                        </div>
                                                    </div>
                                                    <div class="row ">
                                                        <div class="col-md-12">
                                                            <ighedit:WebHtmlEditor runat="server" ID="txtEventsHtml" />
                                                        </div>
                                                    </div>

                                                    <div class="row">
                                                        <div class="col-md-4">
                                                            <label for="lblEvent_lblImage">
                                                                Image Thumbnail<br />
                                                                (Upload Image 636x396 Pixels)</label>
                                                            <img:UploadImage runat="server" ID="UploadEventImage" />
                                                        </div>
                                                    </div>

                                                </div>
                                            </div>
                                        </div>

                                        <div id="dvDining" class="hello" style="display: none;">
                                            <div class="tab-container clearfix">
                                                <div class="col-md-12">


                                                    <div class="row">
                                                        <div class="col-md-4">
                                                            <label for="lblDiningEventHeader">Dining Header</label>
                                                            <asp:TextBox ID="txtDiningEventHeader" runat="server" CssClass="form-control" MaxLength="250"></asp:TextBox>
                                                        </div>
                                                        <div class="col-md-4">
                                                            <label for="lblDiningCallButtonLabel">Call Button Label</label>
                                                            <asp:TextBox ID="txtDiningCallButtonLabel" runat="server" CssClass="form-control" MaxLength="250"></asp:TextBox>

                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col-md-4">
                                                            <label for="lblDiningSortOrder">Sort Order</label>
                                                            <asp:TextBox ID="txtDiningSortOrder" MaxLength="2" runat="server" CssClass="form-control numeric"></asp:TextBox>

                                                        </div>
                                                        <div class="col-md-4">
                                                            <label for="lblDiningPhoneNumber">Phone Number</label>
                                                            <asp:TextBox ID="txtDiningPhoneNumber" runat="server" CssClass="form-control numericMobile" MaxLength="15"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col-md-4">
                                                            <label>HTML Text</label>
                                                        </div>

                                                    </div>
                                                    <div class="row webhtmleditior-bottom-space">
                                                        <div class="col-md-12">
                                                            <ighedit:WebHtmlEditor runat="server" ID="txtDiningHtml" />
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col-md-5 three-column">
                                                            <label for="lblDining_lblImage">
                                                                Image
                                                                <br />
                                                                (Upload Image 636x396 Pixels)</label>
                                                            <img:UploadImage runat="server" ID="UploadDiningImage" />
                                                        </div>
                                                        <div class="col-md-7 row">
                                                            <div class="col-md-12">
                                                                <label for="lblDining_lblImage">Menu Button Label</label>
                                                                <asp:TextBox ID="txtDiningMenuButtonLabel" runat="server" CssClass="form-control" MaxLength="250"></asp:TextBox>
                                                            </div>
                                                            <div class=" col-md-12 ">
                                                                <label for="lblDining_lblImage">Menu File Name</label>
                                                                <pdf:UploadPDF runat="server" ID="UploadDiningPDF" cssClass="fullwidthlabel" />
                                                                <%-- Modified 9-13-16 Nacupido COG-13 PDF Menu delete function --%>                                   
                                                                <asp:Button ID="btnClearMenuFileName" runat="server" OnClick="btnClearMenuFileName_Click"  Text="Clear Menu" />
                                                            </div>
                                                        </div>
                                                        <%--<div class="col-md-5 three-column">
                                                            <label for="lblDining_lblImage">Menu Thumbnail <br />
                                                                (Upload Image 636x396 Pixels)</label>
                                                            <img:UploadImage runat="server" ID="UploadDiningMenuThumbnailImage" />
                                                        </div>--%>
                                                    </div>


                                                </div>
                                            </div>
                                        </div>


                                        <%--HS-1 Lodging Support, NAcupido, 2/28/2017 ////////////////////////////////////////////////////////////////////////////////////////--%>
                                        <div id="dvLodging" class="hello" style="display: none;">
                                            <div class="tab-container clearfix">
                                                <div class="col-md-12">


                                                    <div class="row">
                                                        <div class="col-md-4">
                                                            <label for="lblLodgingHeader">Section Header</label>
                                                            <asp:TextBox ID="txtLodgingHeader" runat="server" CssClass="form-control" MaxLength="250"></asp:TextBox>
                                                        </div>
                                                        <div class="col-md-4">
                                                            <label for="lblLodgingCallButtonLabel">Call Button Label</label>
                                                            <asp:TextBox ID="txtLodgingCallButtonLabel" runat="server" CssClass="form-control" MaxLength="250"></asp:TextBox>
                                                        </div>
                                                        <div class="col-md-4">
                                                            <label for="lblLodgingVenueURLLabel">Venue URL Label</label>
                                                            <asp:TextBox ID="txtLodgingVenueURLLabel" runat="server" CssClass="form-control" MaxLength="250"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col-md-4">
                                                            <label for="lblLodgingSortOrder">Sort Order</label>
                                                            <asp:TextBox ID="txtLodgingSortOrder" MaxLength="2" runat="server" CssClass="form-control numeric"></asp:TextBox>
                                                        </div>
                                                        <div class="col-md-4">
                                                            <label for="lblLodgingPhoneNumber">Phone Number</label>
                                                            <asp:TextBox ID="txtLodgingPhoneNumber" runat="server" CssClass="form-control numericMobile" MaxLength="15"></asp:TextBox>
                                                        </div>
                                                        <div class="col-md-4">
                                                            <label for="lblLodgingVenueURL">Venue URL</label>
                                                            <asp:TextBox ID="txtLodgingVenueURL" runat="server" CssClass="form-control" MaxLength="250"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col-md-4">
                                                            <label for="lblLodgingCheckOffers">Check for Offers button</label>
                                                            <asp:TextBox ID="txtLodgingCheckOffers" runat="server" Enabled="false" CssClass="form-control" MaxLength="250"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col-md-4">
                                                            <label>HTML Text</label>
                                                        </div>
                                                    </div>
                                                    <div class="row webhtmleditior-bottom-space">
                                                        <div class="col-md-12">
                                                            <ighedit:WebHtmlEditor runat="server" ID="txtLodgingHtml" />
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col-md-5 three-column">
                                                            <label for="lblDining_lblImage">
                                                                Image
                                                                <br />
                                                                (Upload Image 636x396 Pixels)</label>
                                                            <img:UploadImage runat="server" ID="UploadLodgingImage" />
                                                        </div>
                                                        <div class="col-md-7 row">
<%--                                                            <div class="col-md-12">
                                                                <label for="lblDining_lblImage">Menu Button Label</label>
                                                                <asp:TextBox ID="TextBox5" runat="server" CssClass="form-control" MaxLength="250"></asp:TextBox>
                                                            </div>
                                                            <div class=" col-md-12 ">
                                                                <label for="lblDining_lblImage">Menu File Name</label>
                                                                <pdf:UploadPDF runat="server" ID="UploadPDF1" cssClass="fullwidthlabel" />
                                                                <asp:Button ID="Button1" runat="server" OnClick="btnClearMenuFileName_Click"  Text="Clear Menu" />
                                                            </div>--%>
                                                        </div>
                                                        <%--<div class="col-md-5 three-column">
                                                            <label for="lblDining_lblImage">Menu Thumbnail <br />
                                                                (Upload Image 636x396 Pixels)</label>
                                                            <img:UploadImage runat="server" ID="UploadDiningMenuThumbnailImage" />
                                                        </div>--%>
                                                    </div>


                                                </div>
                                            </div>
                                        </div>

                                        <div id="dvCustomStack1" class="hello" style="display: none;">
                                            <div class="tab-container clearfix">
                                                <div class="col-md-12">


                                                    <div class="row">
                                                        <div class="col-md-4">
                                                            <label for="lblCustomStack1Header">Section Header</label>
                                                            <asp:TextBox ID="txtCustomStack1Header" runat="server" CssClass="form-control" MaxLength="250"></asp:TextBox>
                                                        </div>
                                                        <div class="col-md-4">
                                                            <label for="lblCustomStack1CallButtonLabel">Call Button Label</label>
                                                            <asp:TextBox ID="txtCustomStack1CallButtonLabel" runat="server" CssClass="form-control" MaxLength="250"></asp:TextBox>
                                                        </div>
                                                        <div class="col-md-4">
                                                            <label for="lblCustomStack1VenueURLLabel">Venue URL Label</label>
                                                            <asp:TextBox ID="txtCustomStack1VenueURLLabel" runat="server" CssClass="form-control" MaxLength="250"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col-md-4">
                                                            <label for="lblCustomStack1SortOrder">Sort Order</label>
                                                            <asp:TextBox ID="txtCustomStack1SortOrder" MaxLength="2" runat="server" CssClass="form-control numeric"></asp:TextBox>
                                                        </div>
                                                        <div class="col-md-4">
                                                            <label for="lblCustomStack1PhoneNumber">Phone Number</label>
                                                            <asp:TextBox ID="txtCustomStack1PhoneNumber" runat="server" CssClass="form-control numericMobile" MaxLength="15"></asp:TextBox>
                                                        </div>
                                                        <div class="col-md-4">
                                                            <label for="lblCustomStack1VenueURL">Venue URL</label>
                                                            <asp:TextBox ID="txtCustomStack1VenueURL" runat="server" CssClass="form-control" MaxLength="250"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col-md-4">
                                                            <label for="lblCustomStack1CheckOffers">Check for Offers button</label>
                                                            <asp:TextBox ID="txtCustomStack1CheckOffers" runat="server" Enabled="false" CssClass="form-control" MaxLength="250"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col-md-4">
                                                            <label>HTML Text</label>
                                                        </div>
                                                    </div>
                                                    <div class="row webhtmleditior-bottom-space">
                                                        <div class="col-md-12">
                                                            <ighedit:WebHtmlEditor runat="server" ID="txtCustomStack1Html" />
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col-md-5 three-column">
                                                            <label for="lblDining_lblImage">
                                                                Image
                                                                <br />
                                                                (Upload Image 636x396 Pixels)</label>
                                                            <img:UploadImage runat="server" ID="UploadCustomStack1Image" />
                                                        </div>
                                                        <div class="col-md-7 row">
<%--                                                            <div class="col-md-12">
                                                                <label for="lblDining_lblImage">Menu Button Label</label>
                                                                <asp:TextBox ID="TextBox5" runat="server" CssClass="form-control" MaxLength="250"></asp:TextBox>
                                                            </div>
                                                            <div class=" col-md-12 ">
                                                                <label for="lblDining_lblImage">Menu File Name</label>
                                                                <pdf:UploadPDF runat="server" ID="UploadPDF1" cssClass="fullwidthlabel" />
                                                                <asp:Button ID="Button1" runat="server" OnClick="btnClearMenuFileName_Click"  Text="Clear Menu" />
                                                            </div>--%>
                                                        </div>
                                                        <%--<div class="col-md-5 three-column">
                                                            <label for="lblDining_lblImage">Menu Thumbnail <br />
                                                                (Upload Image 636x396 Pixels)</label>
                                                            <img:UploadImage runat="server" ID="UploadDiningMenuThumbnailImage" />
                                                        </div>--%>
                                                    </div>


                                                </div>
                                            </div>
                                        </div>

                                        <div id="dvCustomStack2" class="hello" style="display: none;">
                                            <div class="tab-container clearfix">
                                                <div class="col-md-12">


                                                    <div class="row">
                                                        <div class="col-md-4">
                                                            <label for="lblCustomStack2Header">Section Header</label>
                                                            <asp:TextBox ID="txtCustomStack2Header" runat="server" CssClass="form-control" MaxLength="250"></asp:TextBox>
                                                        </div>
                                                        <div class="col-md-4">
                                                            <label for="lblCustomStack2CallButtonLabel">Call Button Label</label>
                                                            <asp:TextBox ID="txtCustomStack2CallButtonLabel" runat="server" CssClass="form-control" MaxLength="250"></asp:TextBox>
                                                        </div>
                                                        <div class="col-md-4">
                                                            <label for="lblCustomStack2VenueURLLabel">Venue URL Label</label>
                                                            <asp:TextBox ID="txtCustomStack2VenueURLLabel" runat="server" CssClass="form-control" MaxLength="250"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col-md-4">
                                                            <label for="lblCustomStack2SortOrder">Sort Order</label>
                                                            <asp:TextBox ID="txtCustomStack2SortOrder" MaxLength="2" runat="server" CssClass="form-control numeric"></asp:TextBox>
                                                        </div>
                                                        <div class="col-md-4">
                                                            <label for="lblCustomStack2PhoneNumber">Phone Number</label>
                                                            <asp:TextBox ID="txtCustomStack2PhoneNumber" runat="server" CssClass="form-control numericMobile" MaxLength="15"></asp:TextBox>
                                                        </div>
                                                        <div class="col-md-4">
                                                            <label for="lblCustomStack2VenueURL">Venue URL</label>
                                                            <asp:TextBox ID="txtCustomStack2VenueURL" runat="server" CssClass="form-control" MaxLength="250"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col-md-4">
                                                            <label for="lblCustomStack2CheckOffers">Check for Offers button</label>
                                                            <asp:TextBox ID="txtCustomStack2CheckOffers" runat="server" Enabled="false" CssClass="form-control" MaxLength="250"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col-md-4">
                                                            <label>HTML Text</label>
                                                        </div>
                                                    </div>
                                                    <div class="row webhtmleditior-bottom-space">
                                                        <div class="col-md-12">
                                                            <ighedit:WebHtmlEditor runat="server" ID="txtCustomStack2Html" />
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col-md-5 three-column">
                                                            <label for="lblDining_lblImage">
                                                                Image
                                                                <br />
                                                                (Upload Image 636x396 Pixels)</label>
                                                            <img:UploadImage runat="server" ID="UploadCustomStack2Image" />
                                                        </div>
                                                        <div class="col-md-7 row">
<%--                                                            <div class="col-md-12">
                                                                <label for="lblDining_lblImage">Menu Button Label</label>
                                                                <asp:TextBox ID="TextBox5" runat="server" CssClass="form-control" MaxLength="250"></asp:TextBox>
                                                            </div>
                                                            <div class=" col-md-12 ">
                                                                <label for="lblDining_lblImage">Menu File Name</label>
                                                                <pdf:UploadPDF runat="server" ID="UploadPDF1" cssClass="fullwidthlabel" />
                                                                <asp:Button ID="Button1" runat="server" OnClick="btnClearMenuFileName_Click"  Text="Clear Menu" />
                                                            </div>--%>
                                                        </div>
                                                        <%--<div class="col-md-5 three-column">
                                                            <label for="lblDining_lblImage">Menu Thumbnail <br />
                                                                (Upload Image 636x396 Pixels)</label>
                                                            <img:UploadImage runat="server" ID="UploadDiningMenuThumbnailImage" />
                                                        </div>--%>
                                                    </div>


                                                </div>
                                            </div>
                                        </div>
                                        
                                        <div id="dvCustom1" class="hello" style="display: none;">
                                            <div class="tab-container clearfix">
                                                <div class="col-md-12">

                                                    <div class="row">
                                                        <div class="col-md-4">
                                                            <label for="lblCustom1Title">Custom 1 Title</label>
                                                            <asp:TextBox ID="txtCustom1Title" runat="server" CssClass="form-control" MaxLength="250"></asp:TextBox>
                                                        </div>
                                                        <div class="col-md-4">
                                                            <label for="lblCustom1CallButton" style="visibility:hidden">Call Button Label</label>
                                                            <asp:TextBox ID="txtCustom1CallButton" runat="server" CssClass="form-control" MaxLength="250" style="visibility:hidden"></asp:TextBox>
                                                        </div>
                                                        <div class="col-md-4">
                                                            <label for="lblCustom1VenueURLLabel" style="visibility:hidden">Venue URL Label</label>
                                                            <asp:TextBox ID="txtCustom1VenueURLLabel" runat="server" CssClass="form-control" MaxLength="250" style="visibility:hidden"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col-md-4">
                                                            <label style="visibility:hidden" for="lblCustom1SortOrder">Sort Order</label>
                                                            <asp:TextBox Visible="false" ID="txtCustom1SortOrder" MaxLength="2" runat="server" CssClass="form-control numeric"></asp:TextBox>
                                                        </div>
                                                        <div class="col-md-4">
                                                            <label for="lblCustom1PhoneNumber" style="visibility:hidden">Phone Number</label>
                                                            <asp:TextBox ID="txtCustom1PhoneNumber" runat="server" CssClass="form-control numericMobile" style="visibility:hidden" MaxLength="15"></asp:TextBox>
                                                        </div>
                                                        <div class="col-md-4">
                                                            <label for="lblCustom1VenueURL" style="visibility:hidden">Venue URL</label>
                                                            <asp:TextBox ID="txtCustom1VenueURL" runat="server" CssClass="form-control" style="visibility:hidden" MaxLength="250"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col-md-4">
                                                            <label>HTML Text</label>
                                                        </div>

                                                    </div>
                                                    <div class="row">
                                                        <div class="col-md-12">
                                                            <ighedit:WebHtmlEditor runat="server" ID="txtCustom1Html" />
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col-md-4">
                                                            <label for="lblImage">
                                                                Image Thumbnail<br />
                                                                (Upload Image 636x396 Pixels)</label>
                                                            <img:UploadImage runat="server" ID="UploadCustom1Image" />
                                                        </div>

                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <div id="dvCustom2" class="hello" style="display: none;">
                                            <div class="tab-container clearfix">
                                                <div class="col-md-12">

                                                    <div class="row">
                                                        <div class="col-md-4">
                                                            <label for="lblCustom2Title">Custom 2 Title</label>
                                                            <asp:TextBox ID="txtCustom2Title" runat="server" CssClass="form-control" MaxLength="250"></asp:TextBox>
                                                        </div>
                                                        <div class="col-md-4">
                                                            <label for="lblCustom2CallButton" style="visibility:hidden">Call Button Label</label>
                                                            <asp:TextBox ID="txtCustom2CallButton" runat="server" CssClass="form-control" style="visibility:hidden" MaxLength="250"></asp:TextBox>
                                                        </div>
                                                        <div class="col-md-4">
                                                            <label for="lblCustom2VenueURLLabel" style="visibility:hidden">Venue URL Label</label>
                                                            <asp:TextBox ID="txtCustom2VenueURLLabel" runat="server" CssClass="form-control" style="visibility:hidden" MaxLength="250"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col-md-4">
                                                            <label style="visibility:hidden" for="lblCustom2SortOrder">Sort Order</label>
                                                            <asp:TextBox Visible="false" ID="txtCustom2SortOrder" MaxLength="2" runat="server" CssClass="form-control numeric"></asp:TextBox>
                                                        </div>
                                                        <div class="col-md-4">
                                                            <label for="lblCustom2PhoneNumber" style="visibility:hidden">Phone Number</label>
                                                            <asp:TextBox ID="txtCustom2PhoneNumber" runat="server" CssClass="form-control numericMobile" style="visibility:hidden" MaxLength="15"></asp:TextBox>
                                                        </div>
                                                        <div class="col-md-4">
                                                            <label for="lblCustom2VenueURL" style="visibility:hidden">Venue URL</label>
                                                            <asp:TextBox ID="txtCustom2VenueURL" runat="server" CssClass="form-control" style="visibility:hidden" MaxLength="250"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col-md-4">
                                                            <label>HTML Text</label>
                                                        </div>

                                                    </div>
                                                    <div class="row">
                                                        <div class="col-md-12">
                                                            <ighedit:WebHtmlEditor runat="server" ID="txtCustom2Html" />
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col-md-4">
                                                            <label for="lblImage">
                                                                Image Thumbnail<br />
                                                                (Upload Image 636x396 Pixels)</label>
                                                            <img:UploadImage runat="server" ID="UploadCustom2Image" />
                                                        </div>

                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <%-- //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// --%>

                                        <div id="dvDiningSpecial" class="hello" style="display: none;">
                                            <div class="tab-container clearfix">
                                                <div class="col-md-12">


                                                    <div class="row">
                                                        <div class="col-md-4">
                                                            <label for="lblDiningSpecialEventHeader">DiningSpecial Header</label>
                                                            <asp:TextBox ID="txtDiningSpecialEventHeader" runat="server" CssClass="form-control" MaxLength="250"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col-md-4">
                                                            <label for="lblDiningSpecialShareURL">Share URL</label>
                                                            <asp:TextBox ID="txtDiningSpecialShareURL" runat="server" CssClass="form-control" MaxLength="500"></asp:TextBox>
                                                        </div>
                                                    </div>

                                                    <div class="row">
                                                        <div class="col-md-4">
                                                            <label>HTML Text</label>
                                                        </div>

                                                    </div>
                                                    <div class="row ">
                                                        <div class="col-md-12">
                                                            <ighedit:WebHtmlEditor runat="server" ID="txtDiningSpecialHtml" />

                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col-md-4">
                                                            <label for="lblDiningSpecialImage">
                                                                Image Thumbnail<br />
                                                                (Upload Image 636x396 Pixels)</label>
                                                            <img:UploadImage runat="server" ID="UploadDiningSpecialImage" />

                                                        </div>
                                                    </div>


                                                </div>
                                            </div>
                                        </div>

                                        <div id="dvHosts" class="hello" style="display: none;">
                                            <div class="tab-container clearfix">
                                                <div class="col-md-12">


                                                    <div class="row">
                                                        <div class="col-md-4">
                                                            <label for="lblHostName">Host Name</label>
                                                            <asp:TextBox ID="txtHostName" runat="server" CssClass="form-control" MaxLength="250"></asp:TextBox>

                                                        </div>
                                                        <div class="col-md-4">
                                                            <label for="Label3">Sort Order</label>
                                                            <asp:TextBox ID="txtHostSortOrder" runat="server" MaxLength="2" CssClass="form-control numeric"></asp:TextBox>
                                                        </div>

                                                    </div>
                                                    <div class="row">
                                                        <div class="col-md-4">
                                                            <label for="lblHostCall">Call</label>
                                                            <asp:TextBox ID="txtHostCall" runat="server" CssClass="form-control" MaxLength="20"></asp:TextBox>
                                                        </div>
                                                        <div class="col-md-4">
                                                            <label for="lblHostEmail">Email</label>
                                                            <asp:TextBox ID="txtHostEmail" runat="server" CssClass="form-control" MaxLength="50"></asp:TextBox>
                                                        </div>
                                                    </div>

                                                    <div class="row">
                                                        <div class="col-md-4">
                                                            <label for="lblsms">SMS</label>
                                                            <asp:TextBox ID="txtHostSMS" runat="server" CssClass="form-control" MaxLength="150"></asp:TextBox>
                                                        </div>

                                                    </div>
                                                    <div class="row">
                                                        <div class="col-md-4">
                                                            <label>Host Description</label>
                                                        </div>

                                                    </div>
                                                    <div class="row ">
                                                        <div class="col-md-12">
                                                            <ighedit:WebHtmlEditor runat="server" ID="txtHostDescriptionHtml" />

                                                        </div>
                                                    </div>

                                                    <div class="row">
                                                        <div class="col-md-4">
                                                            <label for="lblDining_lblImage">
                                                                Image Thumbnail<br />
                                                                (Upload Image 636x396 Pixels)</label>
                                                            <img:UploadImage runat="server" ID="UploadHostImage" />
                                                        </div>
                                                    </div>
                                                    <br />
                                                    <br />


                                                </div>
                                            </div>
                                        </div>

                                        <div id="dvFreePlayOffers" class="hello" style="display: none;">
                                            <div class="tab-container clearfix">
                                                <div class="col-md-12">


                                                    <div class="row">
                                                        <div class="col-md-4">
                                                            <label for="lblFreePlayOfferTitle">Offer Title</label>
                                                            <asp:TextBox ID="txtFreePlayOfferTitle" runat="server" CssClass="form-control" MaxLength="250"></asp:TextBox>
                                                        </div>

                                                    </div>
                                                    <div class="row">
                                                        <div class="col-md-4">
                                                            <label for="lblFreePlayOfferDetail">Offer Detail</label>
                                                            <asp:TextBox ID="txtFreePlayOfferDetail" runat="server" CssClass="form-control" MaxLength="250"></asp:TextBox>
                                                        </div>

                                                    </div>
                                                    <div class="row">
                                                        <div class="col-md-4">
                                                            <label for="lblFreePlayOfferRule">Offer Rule</label>
                                                            <asp:TextBox ID="txtFreePlayOfferRule" runat="server" CssClass="form-control" MaxLength="250"></asp:TextBox>
                                                        </div>

                                                    </div>
                                                    <div class="row">
                                                        <div class="col-md-4">
                                                            <label for="lblDining_lblImage">
                                                                Image Thumbnail<br />
                                                                (Upload Image 636x396 Pixels)</label>
                                                            <img:UploadImage runat="server" ID="UploadFreePlayofferImage" />
                                                        </div>
                                                    </div>
                                                    <br />
                                                    <br />


                                                </div>
                                            </div>
                                        </div>

                                        <div id="dvDashboardMostPopularProgressivesAsset" class="hello" style="display: none;">
                                            <div class="tab-container clearfix">
                                                <div class="col-md-12">

                                                    <div class="row">
                                                        <div class="col-md-4">
                                                            <label for="lblDashboardMostPopularProgressiveSlotName">Slot Name</label>
                                                            <asp:TextBox ID="txtDashboardMostPopularProgressiveSlotName" runat="server" CssClass="form-control" MaxLength="250"></asp:TextBox>
                                                        </div>
                                                    </div>

                                                    <div class="row">
                                                        <div class="col-md-4">
                                                            <label for="lblDashboardMostPopularProgressiveValue">Progressive Value</label>
                                                            <asp:TextBox ID="txtDashboardMostPopularProgressiveValue" runat="server" CssClass="form-control numericwithdecimal" MaxLength="15"></asp:TextBox>
                                                        </div>
                                                    </div>

                                                    <div class="row">
                                                        <div class="col-md-4">
                                                            <label id="lblDashboardMostPopularProgressivesortOrder">Sort Order</label>
                                                            <asp:TextBox ID="txtDashboardMostPopularProgressiveSortOrder" MaxLength="2" runat="server" CssClass="form-control numeric"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <div id="dvDashboardMostPopularSlotType" class="hello" style="display: none;">
                                            <div class="tab-container clearfix">
                                                <div class="col-md-12">

                                                    <div class="row">
                                                        <div class="col-md-8">
                                                            <label for="lblDashboardMostPopularSlotType">Slot Type</label>
                                                            <asp:TextBox ID="txtDashboardMostPopularSlotType" runat="server" CssClass="form-control" MaxLength="250"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <div id="dvDashboardMostPopularSlotDetailAsset" class="hello" style="display: none;">
                                            <div class="tab-container clearfix">
                                                <div class="col-md-12">

                                                    <div class="row">
                                                        <div class="col-md-4">
                                                            <label for="contentType">Slot Type</label>
                                                            <asp:DropDownList ID="ddlDashboardMostPopularSlotDetailType" runat="server" CssClass="form-control">
                                                            </asp:DropDownList>
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col-md-4">
                                                            <label for="lblDashboardMostPopularSlotDetailName">Slot Name</label>
                                                            <asp:TextBox ID="txtDashboardMostPopularSlotDetailName" runat="server" CssClass="form-control" MaxLength="250"></asp:TextBox>
                                                        </div>
                                                    </div>

                                                    <div class="row">
                                                        <div class="col-md-4">
                                                            <label for="lblDashboardMostPopularSlotDetailDenomination">Slot Denomination</label>
                                                            <asp:TextBox ID="txtDashboardMostPopularSlotDetailDenomination" runat="server" CssClass="form-control numericwithdecimal" MaxLength="15"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <!--Phase -II Start-->
                                        <div id="dvAchievementBadges" class="hello badgeimgplaceholder" style="display: none;">
                                            <div class="tab-container clearfix">
                                                <div class="col-md-12">
                                                    <div class="row">
                                                        <div class="col-md-4">
                                                            <label for="lblAchievementBadgeImage">
                                                                Image Thumbnail<br />
                                                                (Upload Image 160x160 Pixels)</label>
                                                            <img:UploadImage runat="server" ID="UploadAchievementBadgeImage" />
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <div id="dvWinLossTermsandConditions" class="hello" style="display: none;">
                                            <div class="tab-container clearfix">
                                                <div class="col-md-12">
                                                    <div class="row">
                                                        <div class="col-md-4">
                                                            <label for="lblWinLossTermsandConditionsTitle">Title</label>
                                                            <asp:TextBox ID="txtWinLossTermsandConditionsTitle" runat="server" CssClass="form-control" MaxLength="250"></asp:TextBox>
                                                        </div>
                                                        <div class="col-md-4 top-margin-one">
                                                            <asp:CheckBox ID="chkWinLossTermsandConditionsActive" Text="Active?" Visible="True" runat="server" />
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col-md-4">
                                                            <label>Terms and Conditions (HTML)</label>
                                                        </div>

                                                    </div>
                                                    <div class="row ">
                                                        <div class="col-md-12">
                                                            <ighedit:WebHtmlEditor runat="server" ID="txtWinLossTermsandConditionsHtml" />

                                                        </div>
                                                    </div>

                                                </div>
                                            </div>
                                        </div>
                                        <div id="dvDashBoadHeaders" class="hello" style="display: none;">
                                            <div class="tab-container clearfix">
                                                <div class="col-md-12">
                                                    <div class="row">
                                                        <div class="col-md-8 top-margin-one">
                                                            <asp:CheckBox ID="chkActiveDashBoardHeader" Text="Active?" Visible="True" runat="server" Enabled="true" />
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div id="dvCommunityFavoriteSlots" class="hello badgeimgplaceholder" style="display: none;">
                                            <div class="tab-container clearfix">
                                                <div class="col-md-12">
                                                    <div class="row">
                                                        <div class="col-md-4">
                                                            <label>Sort Order</label>
                                                            <asp:TextBox ID="txtCommunityFavoriteSlotsSortOrder" MaxLength="2" runat="server" CssClass="form-control numeric"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col-md-4">
                                                            <label for="lblAchievementBadgeImage">
                                                                Image Thumbnail<br />
                                                                (Upload Image 160x160 Pixels)</label>
                                                            <img:UploadImage runat="server" ID="UploadCommunityFavoriteSlotsImage" />
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div id="dvMyFavoriteSlots" class="hello" style="display: none;">
                                            <div class="tab-container clearfix">
                                                <div class="col-md-12">
                                                    <div class="row">
                                                        <div class="col-md-4">
                                                            <label>Order   </label>
                                                            <asp:TextBox ID="txtOrder" MaxLength="2" runat="server" CssClass="form-control numeric"></asp:TextBox>
                                                        </div>
                                                        <div class="col-md-8">
                                                            <div class="row">
                                                                <div class="col-md-4">
                                                                    <div class="col-md-4"></div>
                                                                    <div class="col-md-4">
                                                                        <asp:CheckBox ID="chkAwardCreatingSlotFev" Text="Award?" Visible="True" runat="server" Enabled="true" />
                                                                    </div>
                                                                </div>
                                                                <div class="col-md-8" id="dvAwardCreatingSlotFev">
                                                                    <label>Optional Award for Creating Slot Favorites   </label>
                                                                    <asp:DropDownList ID="drpDrpCreatingSlotFev" runat="server" CssClass="form-control"></asp:DropDownList>
                                                                    <label>Maximum Number of Awards   </label>
                                                                    <asp:TextBox ID="txtMaxNumAwardCreatingSlotFev" MaxLength="15" runat="server" CssClass="form-control numeric"></asp:TextBox>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col-md-4 badgeimgplaceholder">
                                                            <label>
                                                                Image Thumbnail<br />
                                                                (Upload Image 160x160 Pixels)</label>
                                                            <img:UploadImage runat="server" ID="UploadMyFavoriteSlotsImage" />
                                                        </div>
                                                        <div class="col-md-8">
                                                            <div class="row">
                                                                <div class="col-md-4">
                                                                    <div class="col-md-4"></div>
                                                                    <div class="col-md-4">
                                                                        <asp:CheckBox ID="chkmyFavNotifyOutOfApp" Text="Notify?" Visible="True" runat="server" Enabled="true" />
                                                                    </div>
                                                                </div>
                                                                <div class="col-md-8" id="dvmyFavNotifyOutOfApp">
                                                                    <label>Award Notification </label>
                                                                    <asp:TextBox ID="txtmyFavNotifyInApp" runat="server" CssClass="form-control" MaxLength="250"></asp:TextBox>
                                                                </div>
                                                            </div>

                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div id="dvMyFavoriteSlotsUpdateAward" class="hello" style="display: none;">
                                            <div class="tab-container clearfix">
                                                <div class="col-md-12">
                                                    <div>
                                                        <div class="col-md-4 form-group">
                                                            <asp:CheckBox ID="chkFavUpdateSlotFavActive" Text="Active?" Visible="True" runat="server" Enabled="true" />
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-md-12">
                                                    <div>
                                                        <div class="col-md-2">
                                                            <asp:CheckBox ID="chkmyFavUpdateSlotFav" Text="Award?" Visible="True" runat="server" Enabled="true" />
                                                        </div>
                                                        <div id="dvmyFavUpdateSlotFav">
                                                            <div class="col-md-10 inputpaddingrgt">
                                                                <label>Optional Award for Updating Slot Favorites  </label>
                                                                <asp:DropDownList ID="drpmyFavAwardUpdateSlotFav" runat="server" CssClass="form-control"></asp:DropDownList>
                                                            </div>
                                                            <div class="col-md-2">
                                                            </div>
                                                            <div class="col-md-5">
                                                                <label>Maximum Number of Awards  </label>
                                                                <asp:TextBox ID="txtmyFavUpdateSlotFavMaxAward" MaxLength="15" runat="server" CssClass="form-control numeric"></asp:TextBox>
                                                            </div>
                                                            <div class="col-md-5">
                                                                <label class="row">
                                                                    Award Issued after N Slot Favorite Updates</label>
                                                                <div class="row">

                                                                    <asp:TextBox ID="txtMyFavoriteSlotsUpdateAwardUpdated" MaxLength="15" runat="server" CssClass="form-control numeric "></asp:TextBox>
                                                                </div>
                                                            </div>
                                                            <div class="col-md-12">
                                                                <div class="row">
                                                                    <div class="col-md-2">
                                                                    </div>
                                                                    <div class="col-md-4">
                                                                        <label>Maximum Frequency of Awards  </label>
                                                                        <asp:TextBox ID="txtmyFavFrequencyOfAward" MaxLength="15" runat="server" CssClass="form-control numeric"></asp:TextBox>
                                                                    </div>
                                                                    <div class="col-md-3">
                                                                        <label>time every  </label>
                                                                        <asp:TextBox ID="txtmyFavFrequencyOfAwardEvery" MaxLength="15" runat="server" CssClass="form-control numeric"></asp:TextBox>

                                                                    </div>

                                                                    <div class="col-md-3 row pull-right">
                                                                        <label style="visibility: hidden;">time every  </label>
                                                                        <asp:DropDownList ID="drpmyFavFrequencyOfAward" runat="server" CssClass="form-control"></asp:DropDownList>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div>
                                                        <div class="col-md-2">
                                                            <asp:CheckBox ID="chkmyFavAwardNotification" Text="Notify?" Visible="True" runat="server" Enabled="true" />
                                                        </div>
                                                        <div class="col-md-10 inputpaddingrgt" id="dvmyFavAwardNotification">
                                                            <label>Award Notification  </label>
                                                            <asp:TextBox ID="txtmyFavAwardNotification" runat="server" CssClass="form-control" MaxLength="250"></asp:TextBox>
                                                        </div>
                                                    </div>


                                                </div>
                                            </div>
                                        </div>

                                        <div id="dvMyFavoriteSlotContent" class="hello" style="display: none;">
                                            <div class="tab-container clearfix">
                                                <div class="col-md-12">
                                                    <%-- <div class="row">
                                                        <div class="col-md-4">
                                                            <label>My Favorite Slot Title</label>
                                                            <asp:TextBox ID="TxtMyFavoriteSlotContentTitle" runat="server" CssClass="form-control"  MaxLength="250"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col-md-4">
                                                            <label>My Favorite Slot Sub Title</label>
                                                            <asp:TextBox ID="TxtMyFavoriteSlotContentsubTitle" runat="server" CssClass="form-control"  MaxLength="250"></asp:TextBox>
                                                        </div>
                                                    </div>--%>
                                                    <div class="row">
                                                        <div class="col-md-4">
                                                            <label>My Favorite Title</label>
                                                            <asp:TextBox ID="TxtMyFavoriteContentTitle" runat="server" CssClass="form-control" MaxLength="250"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col-md-4">
                                                            <label>Community Favorites Title</label>
                                                            <asp:TextBox ID="TxtMyFavoriteContentcCmmunityFavoritesTitle" runat="server" CssClass="form-control" MaxLength="250"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col-md-4">
                                                            <label>
                                                                Image Thumbnail<br />
                                                                (Upload Image 636x396 Pixels)</label>
                                                            <img:UploadImage runat="server" ID="UploadMyFavoriteContentImage" />
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <div id="dvClientBranding" class="hello" style="display: none;">
                                            <div class="tab-container clearfix">
                                                <div class="col-md-4">
                                                    <label for="NavigationBarTintColor">Navigation Bar Tint Color</label>
                                                    <asp:TextBox ID="txtNavigationBarTintColor" runat="server" CssClass="simple_color_color_code form-control" MaxLength="10"></asp:TextBox>
                                                    <label for="lblNavigationBarTitleTextColor">Navigation Bar Title Text Color</label>
                                                    <asp:TextBox ID="txtNavigationBarTitleTextColor" runat="server" CssClass=" simple_color_color_code form-control" MaxLength="10"></asp:TextBox>
                                                    <label for="lblMenuBackgroundColor">Menu Background Color</label>
                                                    <asp:TextBox ID="txtMenuBackgroundColor" runat="server" CssClass="simple_color_color_code form-control" MaxLength="10"></asp:TextBox>
                                                    <label for="lblSecondarySubmenuBackgroundColor">Secondary Submenu Background Color</label>
                                                    <asp:TextBox ID="txtSecondarySubmenuBackgroundColor" runat="server" CssClass="simple_color_color_code form-control" MaxLength="10"></asp:TextBox>
                                                    <label for="lblMenuRowTextColor">Menu Row Text Color</label>
                                                    <asp:TextBox ID="txtMenuRowTextColor" runat="server" CssClass="simple_color_color_code  form-control" MaxLength="10"></asp:TextBox>
                                                    <label for="lblMenuRowTitleColor">Menu Row Title Color</label>
                                                    <asp:TextBox ID="txtMenuRowTitleColor" runat="server" CssClass="simple_color_color_code form-control" MaxLength="10"></asp:TextBox>
                                                </div>
                                                <div class="col-md-4">
                                                    <label for="lblBackgroundNavigationBar">Background Navigation Bar
                                                        <br>
                                                        (Upload Image 640x128 Pixels)</label><img:UploadImage runat="server" ImageControlHeight="60" ID="UploadImgBackgroundNavigationBar" />
                                                    <label for="lblBackgroundNavigationBarRatina">Background Navigation Bar - Ratina
                                                        <br>
                                                        (Upload Image 640x128 Pixels)</label><img:UploadImage runat="server" ImageControlHeight="60" ID="UploadImgBackgroundNavigationBarRatina" />
                                                </div>
                                            </div>

                                        </div>
                                        <div id="dvAchievementColorCode" class="hello" style="display: none;">
                                            <div class="tab-container clearfix">
                                                <div class="col-md-12">
                                                    <div class="col-md-4">
                                                        <label>Background Color</label>
                                                        <asp:TextBox ID="txtAhievementBackgroundColor" onchange="isValidColor(this)" CssClass="simple_color_color_code  form-control" runat="server" MaxLength="15"></asp:TextBox>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <label>InProgress Color</label>
                                                        <asp:TextBox ID="txtAhievementInProgressColor" onchange="isValidColor(this)" CssClass="simple_color_color_code  form-control" runat="server" MaxLength="15"></asp:TextBox>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <label>Complete Color</label>
                                                        <asp:TextBox ID="txtAhievementCompleteColor" onchange="isValidColor(this)" CssClass="simple_color_color_code  form-control" runat="server" MaxLength="15"></asp:TextBox>
                                                    </div>
                                                </div>

                                            </div>
                                        </div>

                                        <div id="dvTierProgress" class="hello" style="display: none;">
                                            <div class="tab-container clearfix">
                                                <div class="col-md-12">

                                                    <div class="row">
                                                        <div class="col-md-1">
                                                            <label>Active</label>
                                                        </div>
                                                        <div class="col-md-2">
                                                            <label>Tier ID</label>

                                                        </div>
                                                        <div class="col-md-3">
                                                            <label>Tier Name</label>

                                                        </div>
                                                        <div class="col-md-3">
                                                            <label>Threshold</label>
                                                        </div>

                                                        <div class="col-md-2">
                                                            <label>Max Degree(%)</label>

                                                        </div>

                                                    </div>
                                                    <div class="row">
                                                        <div class="col-md-1">
                                                            <asp:HiddenField ID="hdnTierID1" runat="server"></asp:HiddenField>
                                                            <asp:CheckBox runat="server" ID="chkTierProgressActive1" Checked="true" />
                                                            <label for="<%=chkTierProgressActive1.ClientID %>" class="label-grapics"></label>
                                                        </div>
                                                        <div id="dvTier1">
                                                            <div class="col-md-2">
                                                                <asp:TextBox ID="txtTierID1" runat="server" CssClass="form-control numeric" MaxLength="15"></asp:TextBox>
                                                            </div>
                                                            <div class="col-md-3">
                                                                <asp:TextBox ID="txtTierProgressTierName1" runat="server" CssClass="form-control" MaxLength="50"></asp:TextBox>
                                                            </div>
                                                            <div class="col-md-3">
                                                                <asp:TextBox ID="txtTierProgressThreshold1" runat="server" CssClass="form-control numeric" MaxLength="8"></asp:TextBox>
                                                            </div>

                                                            <div class="col-md-2">
                                                                <asp:TextBox ID="txtTierProgressMaxDegree1" runat="server" CssClass="form-control numericwithdecimal" MaxLength="4"></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col-md-1">
                                                            <asp:HiddenField runat="server" ID="hdnTierID2" Value="" />
                                                            <asp:CheckBox runat="server" ID="chkTierProgressActive2" Checked="true" />
                                                            <label for="<%=chkTierProgressActive2.ClientID %>" class="label-grapics"></label>
                                                        </div>
                                                        <div id="dvTier2">
                                                            <div class="col-md-2">
                                                                <asp:TextBox ID="txtTierID2" runat="server" CssClass="form-control numeric" MaxLength="15"></asp:TextBox>
                                                            </div>
                                                            <div class="col-md-3">
                                                                <asp:TextBox ID="txtTierProgressTierName2" runat="server" CssClass="form-control" MaxLength="50"></asp:TextBox>
                                                            </div>
                                                            <div class="col-md-3">
                                                                <asp:TextBox ID="txtTierProgressThreshold2" runat="server" CssClass="form-control numeric" MaxLength="8"></asp:TextBox>
                                                            </div>
                                                            <div class="col-md-2">
                                                                <asp:TextBox ID="txtTierProgressMaxDegree2" runat="server" CssClass="form-control numericwithdecimal" MaxLength="4"></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col-md-1">
                                                            <asp:HiddenField ID="hdnTierID3" runat="server"></asp:HiddenField>
                                                            <asp:CheckBox runat="server" ID="chkTierProgressActive3" Checked="true" />
                                                            <label for="<%=chkTierProgressActive3.ClientID %>" class="label-grapics"></label>
                                                        </div>
                                                        <div id="dvTier3">
                                                            <div class="col-md-2">
                                                                <asp:TextBox ID="txtTierID3" runat="server" CssClass="form-control numeric" MaxLength="8"></asp:TextBox>
                                                            </div>
                                                            <div class="col-md-3">
                                                                <asp:TextBox ID="txtTierProgressTierName3" runat="server" CssClass="form-control" MaxLength="50"></asp:TextBox>
                                                            </div>
                                                            <div class="col-md-3">
                                                                <asp:TextBox ID="txtTierProgressThreshold3" runat="server" CssClass="form-control numeric" MaxLength="8"></asp:TextBox>
                                                            </div>
                                                            <div class="col-md-2">
                                                                <asp:TextBox ID="txtTierProgressMaxDegree3" runat="server" CssClass="form-control numericwithdecimal" MaxLength="4"></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col-md-1">
                                                            <asp:HiddenField ID="hdnTierID4" runat="server"></asp:HiddenField>
                                                            <asp:CheckBox runat="server" ID="chkTierProgressActive4" Checked="true" />
                                                            <label for="<%=chkTierProgressActive4.ClientID %>" class="label-grapics"></label>
                                                        </div>
                                                        <div id="dvTier4">
                                                            <div class="col-md-2">
                                                                <asp:TextBox ID="txtTierID4" runat="server" CssClass="form-control numeric" MaxLength="8"></asp:TextBox>
                                                            </div>
                                                            <div class="col-md-3">
                                                                <asp:TextBox ID="txtTierProgressTierName4" runat="server" CssClass="form-control" MaxLength="50"></asp:TextBox>
                                                            </div>
                                                            <div class="col-md-3">
                                                                <asp:TextBox ID="txtTierProgressThreshold4" runat="server" CssClass="form-control numeric" MaxLength="8"></asp:TextBox>
                                                            </div>

                                                            <div class="col-md-2">
                                                                <asp:TextBox ID="txtTierProgressMaxDegree4" runat="server" CssClass="form-control numericwithdecimal" MaxLength="4"></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col-md-1">
                                                            <asp:HiddenField ID="hdnTierID5" runat="server"></asp:HiddenField>
                                                            <asp:CheckBox runat="server" ID="chkTierProgressActive5" Checked="true" />
                                                            <label for="<%=chkTierProgressActive5.ClientID %>" class="label-grapics"></label>
                                                        </div>
                                                        <div id="dvTier5">
                                                            <div class="col-md-2">
                                                                <asp:TextBox ID="txtTierID5" runat="server" CssClass="form-control numeric" MaxLength="8"></asp:TextBox>
                                                            </div>
                                                            <div class="col-md-3">
                                                                <asp:TextBox ID="txtTierProgressTierName5" runat="server" CssClass="form-control" MaxLength="50"></asp:TextBox>
                                                            </div>
                                                            <div class="col-md-3">
                                                                <asp:TextBox ID="txtTierProgressThreshold5" runat="server" CssClass="form-control numeric" MaxLength="8"></asp:TextBox>
                                                            </div>

                                                            <div class="col-md-2">
                                                                <asp:TextBox ID="txtTierProgressMaxDegree5" runat="server" CssClass="form-control numericwithdecimal" MaxLength="4"></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col-md-1">
                                                            <asp:HiddenField ID="hdnTierID6" runat="server"></asp:HiddenField>
                                                            <asp:CheckBox runat="server" ID="chkTierProgressActive6" />
                                                            <label for="<%=chkTierProgressActive6.ClientID %>" class="label-grapics"></label>
                                                        </div>
                                                        <div id="dvTier6">
                                                            <div class="col-md-2">
                                                                <asp:TextBox ID="txtTierID6" runat="server" CssClass="form-control numeric" MaxLength="8"></asp:TextBox>
                                                            </div>
                                                            <div class="col-md-3">
                                                                <asp:TextBox ID="txtTierProgressTierName6" runat="server" CssClass="form-control" MaxLength="50"></asp:TextBox>
                                                            </div>
                                                            <div class="col-md-3">
                                                                <asp:TextBox ID="txtTierProgressThreshold6" runat="server" CssClass="form-control numeric" MaxLength="8"></asp:TextBox>
                                                            </div>
                                                            <div class="col-md-2">
                                                                <asp:TextBox ID="txtTierProgressMaxDegree6" runat="server" CssClass="form-control numericwithdecimal" MaxLength="4"></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col-md-1">
                                                            <asp:HiddenField ID="hdnTierID7" runat="server"></asp:HiddenField>
                                                            <asp:CheckBox runat="server" ID="chkTierProgressActive7" />
                                                            <label for="<%=chkTierProgressActive7.ClientID %>" class="label-grapics"></label>
                                                        </div>
                                                        <div id="dvTier7">
                                                            <div class="col-md-2">
                                                                <asp:TextBox ID="txtTierID7" runat="server" CssClass="form-control numeric" MaxLength="8"></asp:TextBox>
                                                            </div>
                                                            <div class="col-md-3">
                                                                <asp:TextBox ID="txtTierProgressTierName7" runat="server" CssClass="form-control" MaxLength="50"></asp:TextBox>
                                                            </div>
                                                            <div class="col-md-3">
                                                                <asp:TextBox ID="txtTierProgressThreshold7" runat="server" CssClass="form-control numeric" MaxLength="8"></asp:TextBox>
                                                            </div>

                                                            <div class="col-md-2">
                                                                <asp:TextBox ID="txtTierProgressMaxDegree7" runat="server" CssClass="form-control numericwithdecimal" MaxLength="4"></asp:TextBox>
                                                            </div>

                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col-md-1">
                                                            <asp:HiddenField ID="hdnTierID8" runat="server"></asp:HiddenField>
                                                            <asp:CheckBox runat="server" ID="chkTierProgressActive8" />
                                                            <label for="<%=chkTierProgressActive8.ClientID %>" class="label-grapics"></label>
                                                        </div>
                                                        <div id="dvTier8">
                                                            <div class="col-md-2">
                                                                <asp:TextBox ID="txtTierID8" runat="server" CssClass="form-control numeric" MaxLength="8"></asp:TextBox>
                                                            </div>
                                                            <div class="col-md-3">
                                                                <asp:TextBox ID="txtTierProgressTierName8" runat="server" CssClass="form-control" MaxLength="50"></asp:TextBox>
                                                            </div>
                                                            <div class="col-md-3">
                                                                <asp:TextBox ID="txtTierProgressThreshold8" runat="server" CssClass="form-control numeric" MaxLength="8"></asp:TextBox>
                                                            </div>
                                                            <div class="col-md-2">
                                                                <asp:TextBox ID="txtTierProgressMaxDegree8" runat="server" CssClass="form-control numericwithdecimal" MaxLength="4"></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col-md-1">
                                                            <asp:HiddenField ID="hdnTierID9" runat="server"></asp:HiddenField>
                                                            <asp:CheckBox runat="server" ID="chkTierProgressActive9" />
                                                            <label for="<%=chkTierProgressActive9.ClientID %>" class="label-grapics"></label>
                                                        </div>
                                                        <div id="dvTier9">
                                                            <div class="col-md-2">
                                                                <asp:TextBox ID="txtTierID9" runat="server" CssClass="form-control numeric" MaxLength="8"></asp:TextBox>
                                                            </div>
                                                            <div class="col-md-3">
                                                                <asp:TextBox ID="txtTierProgressTierName9" runat="server" CssClass="form-control" MaxLength="50"></asp:TextBox>
                                                            </div>
                                                            <div class="col-md-3">
                                                                <asp:TextBox ID="txtTierProgressThreshold9" runat="server" CssClass="form-control numeric" MaxLength="8"></asp:TextBox>
                                                            </div>

                                                            <div class="col-md-2">
                                                                <asp:TextBox ID="txtTierProgressMaxDegree9" runat="server" CssClass="form-control numericwithdecimal" MaxLength="4"></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col-md-1">
                                                            <asp:HiddenField ID="hdnTierID10" runat="server"></asp:HiddenField>
                                                            <asp:CheckBox runat="server" ID="chkTierProgressActive10" />
                                                            <label for="<%=chkTierProgressActive10.ClientID %>" class="label-grapics"></label>
                                                        </div>
                                                        <div id="dvTier10">
                                                            <div class="col-md-2">
                                                                <asp:TextBox ID="txtTierID10" runat="server" CssClass="form-control numeric" MaxLength="8"></asp:TextBox>
                                                            </div>
                                                            <div class="col-md-3">
                                                                <asp:TextBox ID="txtTierProgressTierName10" runat="server" CssClass="form-control" MaxLength="50"></asp:TextBox>
                                                            </div>
                                                            <div class="col-md-3">
                                                                <asp:TextBox ID="txtTierProgressThreshold10" runat="server" CssClass="form-control numeric" MaxLength="8"></asp:TextBox>
                                                            </div>

                                                            <div class="col-md-2">
                                                                <asp:TextBox ID="txtTierProgressMaxDegree10" runat="server" CssClass="form-control numericwithdecimal" MaxLength="4"></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col-md-1">
                                                            <asp:HiddenField ID="hdnTierID11" runat="server"></asp:HiddenField>
                                                            <asp:CheckBox runat="server" ID="chkTierProgressActive11" />
                                                            <label for="<%=chkTierProgressActive11.ClientID %>" class="label-grapics"></label>
                                                        </div>
                                                        <div id="dvTier11">
                                                            <div class="col-md-2">
                                                                <asp:TextBox ID="txtTierID11" runat="server" CssClass="form-control numeric" MaxLength="8"></asp:TextBox>
                                                            </div>
                                                            <div class="col-md-3">
                                                                <asp:TextBox ID="txtTierProgressTierName11" runat="server" CssClass="form-control" MaxLength="50"></asp:TextBox>
                                                            </div>
                                                            <div class="col-md-3">
                                                                <asp:TextBox ID="txtTierProgressThreshold11" runat="server" CssClass="form-control numeric" MaxLength="8"></asp:TextBox>
                                                            </div>

                                                            <div class="col-md-2">
                                                                <asp:TextBox ID="txtTierProgressMaxDegree11" runat="server" CssClass="form-control numericwithdecimal" MaxLength="4"></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col-md-1">
                                                            <asp:HiddenField ID="hdnTierID12" runat="server"></asp:HiddenField>
                                                            <asp:CheckBox runat="server" ID="chkTierProgressActive12" />
                                                            <label for="<%=chkTierProgressActive12.ClientID %>" class="label-grapics"></label>
                                                        </div>
                                                        <div id="dvTier12">
                                                            <div class="col-md-2">
                                                                <asp:TextBox ID="txtTierID12" runat="server" CssClass="form-control numeric" MaxLength="8"></asp:TextBox>
                                                            </div>
                                                            <div class="col-md-3">
                                                                <asp:TextBox ID="txtTierProgressTierName12" runat="server" CssClass="form-control" MaxLength="50"></asp:TextBox>
                                                            </div>
                                                            <div class="col-md-3">
                                                                <asp:TextBox ID="txtTierProgressThreshold12" runat="server" CssClass="form-control numeric" MaxLength="8"></asp:TextBox>
                                                            </div>

                                                            <div class="col-md-2">
                                                                <asp:TextBox ID="txtTierProgressMaxDegree12" runat="server" CssClass="form-control numericwithdecimal" MaxLength="4"></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="row">

                                                        <div class="col-md-5 ">
                                                            <label>
                                                                Image Thumbnail<br />
                                                                (Upload Image 640X670 Pixels)</label>
                                                            <img:UploadImage runat="server" ID="UploadTierChartImageUrlImage" />

                                                        </div>

                                                        <div class="col-md-5 txtMarginTop">
                                                            <label>Max Tier Chart Degree</label>
                                                            <asp:TextBox runat="server" ID="txtMaxTierChartDegree" CssClass="form-control numericwithdecimal" MaxLength="6"></asp:TextBox>

                                                        </div>

                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <!-- Phase -II Ends-->
                                        <!-- Content Tab Ends-->

                                    </div>

                                    <div class="tab-pane fade" id="manageScheduleTab">

                                        <div class="tab-container clearfix">
                                            <div class="col-md-4">
                                                <div class="filterWrapper filterWrapper2 relative">
                                                    <div class="row clearfix whiteBg">
                                                        <div class="col-xs-7">
                                                            <label>Schedule</label>
                                                        </div>
                                                        <div class="col-xs-5">
                                                            <span class="addBtn">Add
                                                            <asp:Button ID="lnkbtnAddSchedule" runat="server" OnClick="btnAddSchedule_Click" CssClass="btn btn-add pull-right"></asp:Button>
                                                            </span>
                                                        </div>
                                                    </div>
                                                    <div class="input-group">
                                                        <asp:TextBox runat="server" ID="txtScheduleSearch" CssClass="form-control height26" />
                                                        <span class="input-group-btn">
                                                            <asp:Button ID="btnContentScheduleSearch" OnClick="btnContentScheduleSearch_OnClick" CssClass="btn btn-black glyphicons filter btn-icon white refershedulebtn" runat="server" /><i></i>
                                                        </span>
                                                    </div>
                                                    <div class="filterWrapper filterWrapper2 relative schedulegridheight ">
                                                        <div class="filterResults0">
                                                            <div id="div62">
                                                                <asp:GridView CssClass="gridview" ID="gvSchedules" DataKeyNames="ContentScheduleID" runat="server" ShowHeader="False" AutoGenerateColumns="false"
                                                                    AllowPaging="true" PageSize="12" OnPageIndexChanging="gvSchedule_PageIndexChanging">
                                                                    <Columns>
                                                                        <asp:TemplateField>
                                                                            <ItemTemplate>
                                                                                <asp:LinkButton ID="lnkBtnScheduleName" runat="server" Text='<%#Eval("ScheduleName") %>' OnClick="lnkBtnScheduleName_Click" />
                                                                            </ItemTemplate>
                                                                        </asp:TemplateField>
                                                                    </Columns>
                                                                    <SelectedRowStyle CssClass="gvSelectedRow" />
                                                                    <PagerStyle CssClass="gridview-pager"></PagerStyle>
                                                                </asp:GridView>
                                                                <div id="Div63"></div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <asp:Panel ID="pnlSchedule" runat="server">
                                                <div class="col-md-8">
                                                    <div class="row">
                                                        <div class="col-md-12">
                                                            <label for="adscheduleName">Schedule Name</label>
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col-md-8">
                                                            <asp:TextBox ID="txtScheduleName" runat="server" CssClass="form-control" MaxLength="250"></asp:TextBox>
                                                        </div>
                                                        <div class="col-md-4">
                                                            <% if (ddlContentType.SelectedItem != null)
                                                               {
                                                                   if (ddlContentType.SelectedItem.Value == "15")
                                                                   { %>
                                                            <asp:CheckBox ID="ChkShowinAppNow" Text="Show in App Now?" Visible="True" runat="server" />
                                                            <%   }
                                                               }%>
                                                        </div>
                                                    </div>

                                                    <div class="fieldset">
                                                        <fieldset>
                                                            <legend>
                                                                <label>Schedule</label></legend>
                                                            <div class="col-xs-6">
                                                                <div class="clearfix calTime">
                                                                    <div class="col-xs-3">
                                                                        <label for="adscheduleFrom">From</label>
                                                                    </div>
                                                                    <div class="col-xs-9">
                                                                        <div class="input-group date datePickers" data-date-format="mm/dd/yyyy">
                                                                            <asp:TextBox ID="txtScheduleFrom" runat="server" class="form-control datePickers"></asp:TextBox>
                                                                            <span class="input-group-addon" id="adscheduleFrom"><i class="icon-th"></i></span>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <div class="clearfix calTime">
                                                                    <div class="col-xs-3">
                                                                        <label for="adscheduleTo">To</label>
                                                                    </div>
                                                                    <div class="col-xs-9">
                                                                        <div class="input-group date datePickers" data-date-format="mm/dd/yyyy">
                                                                            <asp:TextBox ID="txtScheduleTo" runat="server" class="form-control datePickers"></asp:TextBox>
                                                                            <span class="input-group-addon" id="adscheduleTo"><i class="icon-th"></i></span>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="col-xs-6">
                                                                <div class="clearfix calTime">
                                                                    <div class="col-xs-3">
                                                                        <label for="adscheduleFromAt">At</label>
                                                                    </div>
                                                                    <div class="col-xs-9">
                                                                        <%--<div class="bootstrap-timepicker input-group">
                                                                            <asp:TextBox ID="txtScheduleFromAt" runat="server" class="form-control timePickers"></asp:TextBox>
                                                                            <i class="icon-time"></i>
                                                                        </div>--%>
                                                                        <div class="input-group bootstrap-timepicker">
                                                                            <asp:TextBox ID="txtScheduleFromAt" runat="server" class="form-control timePickers"></asp:TextBox>
                                                                            <span class="add-on"><i class="icon-time"></i></span>
                                                                        </div>


                                                                    </div>
                                                                </div>
                                                                <div class="clearfix calTime">
                                                                    <div class="col-xs-3">
                                                                        <label for="adscheduleToAt">At</label>
                                                                    </div>
                                                                    <div class="col-xs-9">
                                                                        <div class="bootstrap-timepicker input-group">
                                                                            <asp:TextBox ID="txtscheduleToAt" runat="server" class="form-control timePickers"></asp:TextBox>
                                                                            <i class="icon-time"></i>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <%--   <div class="col-xs-12 clearfix">
                                                                <div class="col-xs-12">
                                                                    <asp:RadioButton runat="server" Text="Active Across Event Window" ID="rdbAccessAcrossEventWindow" Checked="True" GroupName="adactiveWindow" />
                                                                </div>
                                                            </div>
                                                            <div class="col-xs-12 clearfix">
                                                                <div class="col-xs-12">
                                                                    <asp:RadioButton runat="server" Text="Active Within Event Window" ID="rdbAccessWithinEventWindow" GroupName="adactiveWindow" />
                                                                </div>
                                                            </div>--%>
                                                        </fieldset>
                                                    </div>
                                                    <div class="fieldset nomargin">
                                                        <fieldset>
                                                            <legend>
                                                                <asp:CheckBox Text="Schedule by Day of Week" ID="chkScheduleByDayOfWeek" runat="server" />
                                                                <%--<input type="checkbox" class="control" id="adscheduleByDay"><label class="controlLabel" for="adscheduleByDay">Schedule by Day of Week</label>--%>
                                                            </legend>
                                                            <table class="table scheduleTable fieldSwitch">
                                                                <tbody>
                                                                    <tr class="trmonday">
                                                                        <td>
                                                                            <asp:CheckBox Text="Monday" runat="server" ID="chkMonday" />
                                                                            <%--<input type="checkbox" id="adscheduleMonday"><label for="adscheduleMonday">Monday</label>--%>
                                                                        </td>
                                                                        <td>
                                                                            <label for="adscheduleMondayFrom" class="pull-left">From</label>
                                                                            <div class="pull-right">
                                                                                <div class="bootstrap-timepicker input-group">
                                                                                    <asp:TextBox ID="txtScheduleMondayFrom" runat="server" class="form-control timePickers"></asp:TextBox>
                                                                                    <i class="icon-time"></i>
                                                                                </div>
                                                                            </div>
                                                                        </td>
                                                                        <td>
                                                                            <label for="adscheduleMondayTo" class="pull-left">To</label>
                                                                            <div class="pull-right">
                                                                                <div class="bootstrap-timepicker input-group">
                                                                                    <asp:TextBox ID="txtScheduleMondayTo" runat="server" class="form-control timePickers"></asp:TextBox>
                                                                                    <i class="icon-time"></i>
                                                                                </div>
                                                                            </div>
                                                                        </td>
                                                                    </tr>
                                                                    <tr class="trtuesday">
                                                                        <td>
                                                                            <asp:CheckBox Text="Tuesday" runat="server" ID="chkTuesday" />
                                                                            <%--<input type="checkbox" id="adscheduleTues"><label for="adscheduleTues">Tuesday</label>--%>
                                                                        </td>
                                                                        <td>
                                                                            <label for="adscheduleTuesFrom" class="pull-left">From</label>
                                                                            <div class="pull-right">
                                                                                <div class="bootstrap-timepicker input-group">
                                                                                    <asp:TextBox ID="txtScheduleTueFrom" runat="server" class="form-control timePickers"></asp:TextBox>
                                                                                    <i class="icon-time"></i>
                                                                                </div>
                                                                            </div>
                                                                        </td>
                                                                        <td>
                                                                            <label for="adscheduleTuesTo" class="pull-left">To</label>
                                                                            <div class="pull-right">
                                                                                <div class="bootstrap-timepicker input-group">
                                                                                    <asp:TextBox ID="txtScheduleTueTo" runat="server" class="form-control timePickers"></asp:TextBox>
                                                                                    <i class="icon-time"></i>
                                                                                </div>
                                                                            </div>
                                                                        </td>
                                                                    </tr>
                                                                    <tr class="trwednesday">
                                                                        <td>
                                                                            <asp:CheckBox Text="Wednesday" runat="server" ID="chkWednesday" />
                                                                            <%--<input type="checkbox" id="adscheduleWed"><label for="adscheduleWed">Wednesday</label>--%>
                                                                        </td>
                                                                        <td>
                                                                            <label for="adscheduleWedFrom" class="pull-left">From</label>
                                                                            <div class="pull-right">
                                                                                <div class="bootstrap-timepicker input-group">
                                                                                    <asp:TextBox ID="txtScheduleWedFrom" runat="server" class="form-control timePickers"></asp:TextBox>
                                                                                    <i class="icon-time"></i>
                                                                                </div>
                                                                            </div>
                                                                        </td>
                                                                        <td>
                                                                            <label for="adscheduleWedTo" class="pull-left">To</label>
                                                                            <div class="pull-right">
                                                                                <div class="bootstrap-timepicker input-group">
                                                                                    <asp:TextBox ID="txtScheduleWedTo" runat="server" class="form-control timePickers"></asp:TextBox>
                                                                                    <i class="icon-time"></i>
                                                                                </div>
                                                                            </div>
                                                                        </td>
                                                                    </tr>
                                                                    <tr class="trthursday">
                                                                        <td>
                                                                            <asp:CheckBox Text="Thursday" ID="chkThursday" runat="server" />
                                                                            <%--<input type="checkbox" id="adscheduleThus"><label for="adscheduleThus">Thursday</label>--%>
                                                                        </td>
                                                                        <td>
                                                                            <label for="adscheduleThusFrom" class="pull-left">From</label>
                                                                            <div class="pull-right">
                                                                                <div class="bootstrap-timepicker input-group">
                                                                                    <asp:TextBox ID="txtScheduleThuFrom" runat="server" class="form-control timePickers"></asp:TextBox>
                                                                                    <i class="icon-time"></i>
                                                                                </div>
                                                                            </div>
                                                                        </td>
                                                                        <td>
                                                                            <label for="adscheduleThusTo" class="pull-left">To</label>
                                                                            <div class="pull-right">
                                                                                <div class="bootstrap-timepicker input-group">
                                                                                    <asp:TextBox ID="txtScheduleThuTo" runat="server" class="form-control timePickers"></asp:TextBox>
                                                                                    <i class="icon-time"></i>
                                                                                </div>
                                                                            </div>
                                                                        </td>
                                                                    </tr>
                                                                    <tr class="trfriday">
                                                                        <td>
                                                                            <asp:CheckBox Text="Friday" ID="chkFriday" runat="server" />
                                                                            <%--<input type="checkbox" id="adscheduleFri"><label for="adscheduleFri">Friday</label>--%>
                                                                        </td>
                                                                        <td>
                                                                            <label for="adschelblWebAppLoginScreenBrandingmage1duleFriFrom" class="pull-left">From</label>
                                                                            <div class="pull-right">
                                                                                <div class="bootstrap-timepicker input-group">
                                                                                    <asp:TextBox ID="txtScheduleFriFrom" runat="server" class="form-control timePickers"></asp:TextBox>
                                                                                    <i class="icon-time"></i>
                                                                                </div>
                                                                            </div>
                                                                        </td>
                                                                        <td>
                                                                            <label for="adscheduleFriTo" class="pull-left">To</label>
                                                                            <div class="pull-right">
                                                                                <div class="bootstrap-timepicker input-group">
                                                                                    <asp:TextBox ID="txtScheduleFriTo" runat="server" class="form-control timePickers"></asp:TextBox>
                                                                                    <i class="icon-time"></i>
                                                                                </div>
                                                                            </div>
                                                                        </td>
                                                                    </tr>
                                                                    <tr class="trsaturday">
                                                                        <td>
                                                                            <asp:CheckBox Text="Saturday" ID="chkSaturday" runat="server" />
                                                                            <%--<input type="checkbox" id="adscheduleSat"><label for="adscheduleSat">Saturday</label>--%>
                                                                        </td>
                                                                        <td>
                                                                            <label for="adscheduleSatFrom" class="pull-left">From</label>
                                                                            <div class="pull-right">
                                                                                <div class="bootstrap-timepicker input-group">
                                                                                    <asp:TextBox ID="txtScheduleSatFrom" runat="server" class="form-control timePickers"></asp:TextBox>
                                                                                    <i class="icon-time"></i>
                                                                                </div>
                                                                            </div>
                                                                        </td>
                                                                        <td>
                                                                            <label for="adscheduleSatTo" class="pull-left">To</label>
                                                                            <div class="pull-right">
                                                                                <div class="bootstrap-timepicker input-group">
                                                                                    <asp:TextBox ID="txtScheduleSatTo" runat="server" class="form-control timePickers"></asp:TextBox>
                                                                                    <i class="icon-time"></i>
                                                                                </div>
                                                                            </div>
                                                                        </td>
                                                                    </tr>
                                                                    <tr class="trsunday">
                                                                        <td>
                                                                            <asp:CheckBox Text="Sunday" ID="chkSunday" runat="server" />
                                                                            <%--<input type="checkbox" id="adscheduleSun"><label for="adscheduleSun">Sunday</label>--%>
                                                                        </td>
                                                                        <td>
                                                                            <label for="adscheduleSunFrom" class="pull-left">From</label>
                                                                            <div class="pull-right">
                                                                                <div class="bootstrap-timepicker input-group">
                                                                                    <asp:TextBox ID="txtScheduleSunFrom" runat="server" class="form-control timePickers"></asp:TextBox>
                                                                                    <i class="icon-time"></i>
                                                                                </div>
                                                                            </div>
                                                                        </td>
                                                                        <td>
                                                                            <label for="adscheduleSunTo" class="pull-left">To</label>
                                                                            <div class="pull-right">
                                                                                <div class="bootstrap-timepicker input-group">
                                                                                    <asp:TextBox ID="txtScheduleSunTo" runat="server" class="form-control timePickers"></asp:TextBox>
                                                                                    <i class="icon-time"></i>
                                                                                </div>
                                                                            </div>
                                                                        </td>
                                                                    </tr>
                                                                </tbody>
                                                            </table>
                                                        </fieldset>
                                                    </div>
                                                </div>
                                            </asp:Panel>
                                        </div>
                                        <asp:HiddenField runat="server" ID="hdnScheduleId" Value="0" />

                                    </div>

                                    <!-- Schedule Tab Ends-->

                                    <!--Population Tab Starts-->
                                    <div class="tab-pane fade" id="managePopulationTab">
                                        <div class="">
                                            <div class="tabbable tabs-left">
                                                <ul class="nav nav-tabs">
                                                    <li id="liTiers" class="active col-xsm-2"><a data-toggle="tab" href="#populationTiersTab" onclick="SetSelectedTab('populationTiersTab')">Tiers</a></li>
                                                    <li id="liList" class="col-xsm-2"><a data-toggle="tab" href="#populationListTab" onclick="SetSelectedTab('populationListTab')">List</a></li>
                                                </ul>
                                                <div class="tab-content">
                                                    <div id="populationTiersTab" class="tab-pane fade in active">
                                                        <listbox:UC_PopulationTypeTab runat="server" ID="UC_PopulationTypeTab" />
                                                    </div>
                                                    <div id="populationListTab" class="tab-pane fade">
                                                        <div id="PopulationListMyOffer" style="display: none">
                                                            <csv:UC_CsvUpload_PopulationListTab runat="server" ID="UC_CsvUpload_PopulationListTab" />
                                                        </div>
                                                        <div id="PopulationListOtherContentType" style="display: none">
                                                            <csv:UC_CsvUpload_PopulationListTab_WithOutBarCodeID runat="server" ID="UC_CsvUpload_PopulationListTab_WithOutBarCodeID" />
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <!--Population Tab Ends-->
                                </div>
                            </div>
                            <div class="col-md-12 btnGroup2">
                                <div class="btn-groupSpecial clearfix">
                                    <asp:Button ID="lnkbtnSave" OnClientClick="return FormValidation();" runat="server" Text="Save" OnClick="lnkbtnSave_Click" CssClass="results-control col-xsm-32"></asp:Button>
                                    <asp:Button ID="lnkbtnCancel" runat="server" OnClientClick=" return ConfirmMessage(2);" Text="Cancel" OnClick="lnkbtnCancel_Click" CssClass="results-control col-xsm-32"></asp:Button>
                                    <asp:Button ID="lnkbtnDelete" runat="server" OnClientClick="return ConfirmMessage(3);" Text="Delete" OnClick="lnkbtnDelete_Click" CssClass="results-control col-xsm-32"></asp:Button>

                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <script type="text/javascript">

                //***************************************Start On UpdatePanel Refresh Register ImageUpload/Common Functions ************************************
                var prm = Sys.WebForms.PageRequestManager.getInstance();
                if (prm != null) {
                    prm.add_endRequest(function (sender, e) {
                        if (sender._postBackSettings.panelsToUpdate != null) {
                            RegisterHideEnvironmentDropdown();
                            RegisterDateAndTimePickers();
                            RegisterColorPicker();
                            RegisterContentTypeTab();
                            RegisterSetEnvironmentTextOnLabelControl();
                            SetSelectedContentTypeText();
                            RegisterUploadControls();
                            RegisterUploadPDFControls();
                            DisabledEnabledCheckbox();
                            RegisterCheckboxClick();
                            RegisterDisabledTypeListBox();
                            RegisterFieldSets();
                            isNumberWithDecimal();
                            isNumber();
                            MobileNoValidation();
                            RegisterMyFevouriteSlotCheckbox();
                            RegisterDetectedFormChanges();
                            MonitorIframe();

                        }
                    });
                };

                ///**************************************End On UpdatePanel Refresh Register ImageUpload/Common Functions***************************************
                ////*************************************************Start Page load functionality.*************************************************************
                $(document).ready(function () {
                    RegisterHideEnvironmentDropdown();
                    RegisterDateAndTimePickers();
                    RegisterColorPicker();
                    RegisterContentTypeDropDownZeroIndex();
                    RegisterContentTypeTab();
                    SetSelectedContentTypeText();
                    RegisterSetEnvironmentTextOnLabelControl();
                    RegisterUploadControls();
                    RegisterUploadPDFControls();
                    DisabledEnabledCheckbox();
                    RegisterCheckboxClick();
                    RegisterDisabledTypeListBox();
                    RegisterFieldSets();
                    isNumberWithDecimal();
                    isNumber();
                    MobileNoValidation();
                    RegisterModel();
                    RegisterMyFevouriteSlotCheckbox();
                    RegisterDetectedFormChanges();

                });

                ////*************************************************End Page load functionality.***************************************************************
                //////****************************Start Common Function Part ***********************************************************************************


                function RegisterHideEnvironmentDropdown() {
                    var contentTypeId = $('#<%=ddlContentType.ClientID%> option:selected').val();
                    if (contentTypeId == 42)
                        $('#dvEnvironment').hide();
                    else
                        $('#dvEnvironment').show();

                }
                function RegisterColorPicker() {
                    $('.simple_color_color_code').simpleColor({ displayColorCode: true });
                    $('.simpleColorDisplay').on('click', function () {
                        $('.simpleColorDisplay').parent().removeClass('current');
                        $(this).parent().addClass('current');
                        $('.simpleColorDisplay').parent().find('.simpleColorChooser').hide();
                        $(this).parent().find('.simpleColorChooser').show();

                    });
                }

                //Page refresh set contentType index.
                function RegisterContentTypeDropDownZeroIndex() {
                    if (document.getElementById('<%=ddlContentType.ClientID%>') != null) {
                            //document.getElementById('<%=ddlContentType.ClientID%>').selectedIndex = 0;
                        }
                    }
                function RegisterModel() {
                    $('#ConfirmBox').on('show.bs.modal', function (e) {
                    });
                }
                ///Set common label text
                function RegisterSetEnvironmentTextOnLabelControl() {
                    document.getElementById('<%=hdnEnvironmentType.ClientID%>').value = document.getElementById('<%=ddlEnvironment.ClientID%>').options[document.getElementById('<%=ddlEnvironment.ClientID%>').selectedIndex].text;
                    }

                    function RegisterDateAndTimePickers() {
                        //  Date Picker
                        $('.datePickers').datepicker({
                            autoclose: true,
                            todayBtn: true,
                            todayHighlight: true
                        });

                        $('.timePickers').timepicker(
                        {
                            template: false,
                            showInputs: false,
                            minuteStep: 5,
                            defaultTime: false
                        });
                    }


                    //Upload Image
                    function RegisterUploadControls() {
                        $('.UploadButton1').each(function () {
                            var mainDiv = $(this).parent().parent();
                            var hdnImageUrl = $(mainDiv).find('input:hidden[id*="hdnImageUrl"]');
                            var hdnSetImageUrl = $(mainDiv).find('input:hidden[id*="hdnSetDefaultImageUrl"]');
                            var imgImageUrl = $(this).parent().parent().find('img[id*="imgImageUrl"]');
                            UploadControlHandler($(this), $(hdnImageUrl).prop('id'), $(imgImageUrl).prop('id'), $(hdnSetImageUrl).prop('id'));
                        });
                    }
                    function UploadControlHandler(control, ImageUrlHf, ImageUrlImg, ImageSetUrlImg) {

                        new AjaxUpload('#' + $(control).prop('id') + '', {
                            action: 'FileUpload.ashx',
                            onComplete: function (file, response) {
                                var height = 0;
                                var width = 0;
                                var contentTypeId = $('#<%=ddlContentType.ClientID%> option:selected').val();
                                var res = response.split('-');
                                var img = new Image();
                                img.src = res[2];
                                //For Start Screen Assets/Signup Assets/Promotion Assets/Global Assets
                                if (contentTypeId == 1 || contentTypeId == 2 || contentTypeId == 3 || contentTypeId == 22) {
                                    height = 1008;
                                    width = 640;
                                }
                                    //For Pramotions
                                else if (contentTypeId == 18 && ImageUrlHf.indexOf('MainContent_UploadPromotionsDetailImage_hdnImageUrl') == -1) {
                                    height = 740;
                                    width = 636;
                                }
                                    //For Client Branding
                                else if (contentTypeId == 41) {
                                    height = 128;
                                    width = 640;
                                }
                                    //For Tier Progress
                                else if (contentTypeId == 42) {
                                    height = 670;
                                    width = 640;
                                }
                                    //Achievement Badges/My Favoriate slot
                                else if (contentTypeId == 35 || contentTypeId == 40 || contentTypeId == 39 || contentTypeId == 23) {
                                    height = 160;
                                    width = 160;
                                }
                                    //For Others
                                else {
                                    height = 396;
                                    width = 636;
                                }

                                setTimeout(function () {

                                    if (contentTypeId == 44 || contentTypeId == 23) {
                                        $('#' + ImageUrlHf).val(response);
                                        $('#' + ImageUrlImg).attr('src', res[2]);
                                        $('#' + ImageSetUrlImg).val(res[2]);
                                    }
                                    else {
                                        if (img.height > height) {
                                            document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'File height should not exceed ' + height + '.';
                                            $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                                        }
                                        else if (img.width > width) {
                                            document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'File width should not exceed ' + width + '.';
                                            $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                                        }
                                        else {
                                            $('#' + ImageUrlHf).val(response);
                                            $('#' + ImageUrlImg).attr('src', res[2]);
                                            $('#' + ImageSetUrlImg).val(res[2]);
                                        }
                                    }
                                    $('#<%=hdnIsImageUpdated.ClientID%>').val('1');

                                }, 100);

                            },
                            onSubmit: function (file, ext) {

                                if (!(ext && /^(jpg|png|jpeg|gif)$/.test(ext))) {
                                    document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Invalid File Format.';
                                    $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                                    return false;
                                }

                            }
                        });
                    }

                    //Upload PDF                
                    function RegisterUploadPDFControls() {
                        $('.UploadPDFButton1').each(function () {
                            var mainDiv = $(this).parent().parent();
                            var hdnImageUrl = $(mainDiv).find('input:hidden[id*="hdnImageUrl"]');
                            var hdnSetImageUrl = $(mainDiv).find('input:hidden[id*="hdnSetDefaultImageUrl"]');
                            var pdfName = $(this).parent().parent().find('span[id*="lblPdfName"]');

                            UploadPDFControlHandler($(this), $(hdnImageUrl).prop('id'), $(pdfName).prop('id'), $(hdnSetImageUrl).prop('id'));
                        });
                    }

                    function UploadPDFControlHandler(control, ImageUrlHf, pdfName, ImageSetUrlImg) {

                        new AjaxUpload('#' + $(control).prop('id') + '', {
                            action: 'Handlers/PDFUpload.ashx',
                            onComplete: function (file, response) {
                                var res = response.split('-');
                                var img = new Image();
                                img.src = res[2];

                                setTimeout(function () {
                                    if (img.height > 745) {
                                        document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'File height should not exceed 745.';
                                        $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                                    }
                                    else if (img.width > 640) {
                                        document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'File width should not exceed 640.';
                                            $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                                        }
                                        else {
                                            $('#' + ImageUrlHf).val(response);
                                            $('#' + pdfName).text(res[1]);
                                            $('#' + ImageSetUrlImg).val(res[2]);

                                        }
                                    $('#<%=hdnIsImageUpdated.ClientID%>').val('1');

                                }, 100);

                            },
                            onSubmit: function (file, ext) {
                                if (!(ext && /^(pdf)$/.test(ext))) {
                                    document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Invalid File Format.';
                                    $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                                    return false;
                                }
                            }
                        });
                    }

                    //Tab/ContentType Onchange Function 
                    function RegisterContentTypeTab() {
                        var originallblAssetNameText = document.getElementById('<%=lblAssetName.ClientID%>').innerHTML;
                        document.getElementById('<%=lblAssetName.ClientID%>').innerHTML = document.getElementById('<%=ddlContentType.ClientID%>').options[document.getElementById('<%=ddlContentType.ClientID%>').selectedIndex].text + ' Name';
                        var contentTypeId = $('#<%=ddlContentType.ClientID%>').val();
                        SetTabControls();
                        switch (contentTypeId) {

                            case ContentTypeConstants.AboutUs:
                                $('.hello').hide();
                                $('#dvAboutUs').fadeIn(1000, function () {
                                    $('#manageScheduleTabLink, #managePopulationTabLink').parent().removeClass('linkDisabled');
                                    if (document.getElementById('<%=hdnIsPopulation.ClientID%>').value == 'False')
                                        $('#managePopulationTabLink').parent().addClass('linkDisabled');
                                    if (document.getElementById('<%=hdnIsShedule.ClientID%>').value == 'False')
                                        $('#manageScheduleTabLink').parent().addClass('linkDisabled');
                                });
                                break;
                            case ContentTypeConstants.StartScreenAssets:
                                $('.hello').hide();
                                $('#dvStartupScreen').fadeIn(1000, function () {
                                    $('#manageScheduleTabLink, #managePopulationTabLink').parent().removeClass('linkDisabled');
                                    if (document.getElementById('<%=hdnIsPopulation.ClientID%>').value == 'False')
                                        $('#managePopulationTabLink').parent().addClass('linkDisabled');
                                    if (document.getElementById('<%=hdnIsShedule.ClientID%>').value == 'False')
                                        $('#manageScheduleTabLink').parent().addClass('linkDisabled');
                                });
                                break;
                            case ContentTypeConstants.SignupAssets:
                                $('.hello').hide();
                                $('#dvSignUp').fadeIn(1000, function () {
                                    $('#manageScheduleTabLink, #managePopulationTabLink').parent().removeClass('linkDisabled');
                                    if (document.getElementById('<%=hdnIsPopulation.ClientID%>').value == 'False')
                                        $('#managePopulationTabLink').parent().addClass('linkDisabled');
                                    if (document.getElementById('<%=hdnIsShedule.ClientID%>').value == 'False')
                                        $('#manageScheduleTabLink').parent().addClass('linkDisabled');

                                });
                                break;
                            case ContentTypeConstants.PromotionAssets:
                                $('.hello').hide();
                                $('#dvPromotionAssets').fadeIn(1000, function () {
                                    $('#manageScheduleTabLink, #managePopulationTabLink').parent().removeClass('linkDisabled');
                                    if (document.getElementById('<%=hdnIsPopulation.ClientID%>').value == 'False')
                                        $('#managePopulationTabLink').parent().addClass('linkDisabled');
                                    if (document.getElementById('<%=hdnIsShedule.ClientID%>').value == 'False')
                                        $('#manageScheduleTabLink').parent().addClass('linkDisabled');
                                });
                                break;
                            case ContentTypeConstants.PropertyAssets:
                                $('.hello').hide();
                                $('#dvPropertyAssets').fadeIn(1000, function () {
                                    $('#manageScheduleTabLink, #managePopulationTabLink').parent().removeClass('linkDisabled');
                                    if (document.getElementById('<%=hdnIsPopulation.ClientID%>').value == 'False')
                                        $('#managePopulationTabLink').parent().addClass('linkDisabled');
                                    if (document.getElementById('<%=hdnIsShedule.ClientID%>').value == 'False')
                                        $('#manageScheduleTabLink').parent().addClass('linkDisabled');
                                });
                                break;

                            case ContentTypeConstants.DrivingDirections:
                                $('.hello').hide();
                                $('#dvDrivingDirections').fadeIn(1000, function () {
                                    $('#manageScheduleTabLink, #managePopulationTabLink').parent().removeClass('linkDisabled');
                                    if (document.getElementById('<%=hdnIsPopulation.ClientID%>').value == 'False')
                                        $('#managePopulationTabLink').parent().addClass('linkDisabled');
                                    if (document.getElementById('<%=hdnIsShedule.ClientID%>').value == 'False')
                                        $('#manageScheduleTabLink').parent().addClass('linkDisabled');
                                });
                                break;
                            case ContentTypeConstants.ClubInformation:
                                $('.hello').hide();
                                $('#dvClubInfo').fadeIn(1000, function () {
                                    $('#manageScheduleTabLink, #managePopulationTabLink').parent().removeClass('linkDisabled');
                                    if (document.getElementById('<%=hdnIsPopulation.ClientID%>').value == 'False')
                                        $('#managePopulationTabLink').parent().addClass('linkDisabled');
                                    if (document.getElementById('<%=hdnIsShedule.ClientID%>').value == 'False')
                                        $('#manageScheduleTabLink').parent().addClass('linkDisabled');
                                });
                                break;
                            case ContentTypeConstants.LinkReferralCode:
                                $('.hello').hide();
                                $('#dvLinkReferralCode').fadeIn(1000, function () {
                                    $('#manageScheduleTabLink, #managePopulationTabLink').parent().removeClass('linkDisabled');
                                    if (document.getElementById('<%=hdnIsPopulation.ClientID%>').value == 'False')
                                        $('#managePopulationTabLink').parent().addClass('linkDisabled');
                                    if (document.getElementById('<%=hdnIsShedule.ClientID%>').value == 'False')
                                        $('#manageScheduleTabLink').parent().addClass('linkDisabled');
                                });
                                break;
                            case ContentTypeConstants.ReferaFriend:
                                $('.hello').hide();
                                $('#dvReferAFriend').fadeIn(1000, function () {
                                    $('#manageScheduleTabLink, #managePopulationTabLink').parent().removeClass('linkDisabled');
                                    if (document.getElementById('<%=hdnIsPopulation.ClientID%>').value == 'False')
                                        $('#managePopulationTabLink').parent().addClass('linkDisabled');
                                    if (document.getElementById('<%=hdnIsShedule.ClientID%>').value == 'False')
                                        $('#manageScheduleTabLink').parent().addClass('linkDisabled');
                                });
                                break;
                            case ContentTypeConstants.MyOffers:
                                $('.hello').hide();
                                $('#dvMyOffers').fadeIn(1000, function () {
                                    $('#manageScheduleTabLink, #managePopulationTabLink').parent().removeClass('linkDisabled');
                                    if (document.getElementById('<%=hdnIsPopulation.ClientID%>').value == 'False')
                                        $('#managePopulationTabLink').parent().addClass('linkDisabled');
                                    if (document.getElementById('<%=hdnIsShedule.ClientID%>').value == 'False')
                                        $('#manageScheduleTabLink').parent().addClass('linkDisabled');

                                });
                                break;
                            case ContentTypeConstants.ShareTournament:
                                $('.hello').hide();
                                $('#dvShareTournament').fadeIn(1000, function () {
                                    $('#manageScheduleTabLink, #managePopulationTabLink').parent().removeClass('linkDisabled');
                                    if (document.getElementById('<%=hdnIsPopulation.ClientID%>').value == 'False')
                                        $('#managePopulationTabLink').parent().addClass('linkDisabled');
                                    if (document.getElementById('<%=hdnIsShedule.ClientID%>').value == 'False')
                                        $('#manageScheduleTabLink').parent().addClass('linkDisabled');

                                });
                                break;
                            case ContentTypeConstants.Promotions:
                                $('.hello').hide();
                                $('#dvPromotions').fadeIn(1000, function () {
                                    $('#manageScheduleTabLink, #managePopulationTabLink').parent().removeClass('linkDisabled');
                                    if (document.getElementById('<%=hdnIsPopulation.ClientID%>').value == 'False')
                                        $('#managePopulationTabLink').parent().addClass('linkDisabled');
                                    if (document.getElementById('<%=hdnIsShedule.ClientID%>').value == 'False')
                                        $('#manageScheduleTabLink').parent().addClass('linkDisabled');
                                });
                                break;
                            case ContentTypeConstants.GamesPoker:
                                $('.hello').hide();
                                $('#dvGamesPoker').fadeIn(1000, function () {
                                    $('#manageScheduleTabLink, #managePopulationTabLink').parent().removeClass('linkDisabled');
                                    if (document.getElementById('<%=hdnIsPopulation.ClientID%>').value == 'False')
                                        $('#managePopulationTabLink').parent().addClass('linkDisabled');
                                    if (document.getElementById('<%=hdnIsShedule.ClientID%>').value == 'False')
                                        $('#manageScheduleTabLink').parent().addClass('linkDisabled');

                                });
                                break;
                            case ContentTypeConstants.GamesBingo:
                                $('.hello').hide();
                                $('#dvBingo').fadeIn(1000, function () {
                                    $('#manageScheduleTabLink, #managePopulationTabLink').parent().removeClass('linkDisabled');
                                    if (document.getElementById('<%=hdnIsPopulation.ClientID%>').value == 'False')
                                        $('#managePopulationTabLink').parent().addClass('linkDisabled');
                                    if (document.getElementById('<%=hdnIsShedule.ClientID%>').value == 'False')
                                        $('#manageScheduleTabLink').parent().addClass('linkDisabled');

                                });
                                break;
                            case ContentTypeConstants.Events:
                                $('.hello').hide();
                                $('#dvEvents').fadeIn(1000, function () {
                                    $('#manageScheduleTabLink, #managePopulationTabLink').parent().removeClass('linkDisabled');
                                    if (document.getElementById('<%=hdnIsPopulation.ClientID%>').value == 'False')
                                        $('#managePopulationTabLink').parent().addClass('linkDisabled');
                                    if (document.getElementById('<%=hdnIsShedule.ClientID%>').value == 'False')
                                        $('#manageScheduleTabLink').parent().addClass('linkDisabled');
                                });
                                break;
                            case ContentTypeConstants.Dining:
                                $('.hello').hide();
                                $('#dvDining').fadeIn(1000, function () {
                                    $('#manageScheduleTabLink, #managePopulationTabLink').parent().removeClass('linkDisabled');
                                    if (document.getElementById('<%=hdnIsPopulation.ClientID%>').value == 'False')
                                        $('#managePopulationTabLink').parent().addClass('linkDisabled');
                                    if (document.getElementById('<%=hdnIsShedule.ClientID%>').value == 'False')
                                        $('#manageScheduleTabLink').parent().addClass('linkDisabled');
                                });
                                break;

                            <%--  HS-1 Lodging Support, NAcupido 2/28/2017 /////////////////////////////////////////////////////////////////////////////////////// --%>
                                case ContentTypeConstants.Lodging:
                                $('.hello').hide();
                                $('#dvLodging').fadeIn(1000, function () {
                                    $('#manageScheduleTabLink, #managePopulationTabLink').parent().removeClass('linkDisabled');
                                    if (document.getElementById('<%=hdnIsPopulation.ClientID%>').value == 'False')
                                        $('#managePopulationTabLink').parent().addClass('linkDisabled');
                                    if (document.getElementById('<%=hdnIsShedule.ClientID%>').value == 'False')
                                        $('#manageScheduleTabLink').parent().addClass('linkDisabled');
                                });
                                    break;
                                case ContentTypeConstants.CustomStack1:
                                $('.hello').hide();
                                $('#dvCustomStack1').fadeIn(1000, function () {
                                    $('#manageScheduleTabLink, #managePopulationTabLink').parent().removeClass('linkDisabled');
                                    if (document.getElementById('<%=hdnIsPopulation.ClientID%>').value == 'False')
                                        $('#managePopulationTabLink').parent().addClass('linkDisabled');
                                    if (document.getElementById('<%=hdnIsShedule.ClientID%>').value == 'False')
                                        $('#manageScheduleTabLink').parent().addClass('linkDisabled');
                                });
                                    break;
                                case ContentTypeConstants.CustomStack2:
                                $('.hello').hide();
                                $('#dvCustomStack2').fadeIn(1000, function () {
                                    $('#manageScheduleTabLink, #managePopulationTabLink').parent().removeClass('linkDisabled');
                                    if (document.getElementById('<%=hdnIsPopulation.ClientID%>').value == 'False')
                                        $('#managePopulationTabLink').parent().addClass('linkDisabled');
                                    if (document.getElementById('<%=hdnIsShedule.ClientID%>').value == 'False')
                                        $('#manageScheduleTabLink').parent().addClass('linkDisabled');
                                });
                                break;
                                case ContentTypeConstants.Custom1:
                                $('.hello').hide();
                                $('#dvCustom1').fadeIn(1000, function () {
                                    $('#manageScheduleTabLink, #managePopulationTabLink').parent().removeClass('linkDisabled');
                                    if (document.getElementById('<%=hdnIsPopulation.ClientID%>').value == 'False')
                                        $('#managePopulationTabLink').parent().addClass('linkDisabled');
                                    if (document.getElementById('<%=hdnIsShedule.ClientID%>').value == 'False')
                                        $('#manageScheduleTabLink').parent().addClass('linkDisabled');
                                });
                                break;
                                case ContentTypeConstants.Custom2:
                                $('.hello').hide();
                                $('#dvCustom2').fadeIn(1000, function () {
                                    $('#manageScheduleTabLink, #managePopulationTabLink').parent().removeClass('linkDisabled');
                                    if (document.getElementById('<%=hdnIsPopulation.ClientID%>').value == 'False')
                                        $('#managePopulationTabLink').parent().addClass('linkDisabled');
                                    if (document.getElementById('<%=hdnIsShedule.ClientID%>').value == 'False')
                                        $('#manageScheduleTabLink').parent().addClass('linkDisabled');
                                });
                                break;
                            <%-- ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// --%> 

                            case ContentTypeConstants.WinLoss:
                                $('.hello').hide();
                                $('#dvWinLoss').fadeIn(1000, function () {
                                    $('#manageScheduleTabLink, #managePopulationTabLink').parent().removeClass('linkDisabled');
                                    if (document.getElementById('<%=hdnIsPopulation.ClientID%>').value == 'False')
                                        $('#managePopulationTabLink').parent().addClass('linkDisabled');
                                    if (document.getElementById('<%=hdnIsShedule.ClientID%>').value == 'False')
                                        $('#manageScheduleTabLink').parent().addClass('linkDisabled');
                                });
                                break;
                            case ContentTypeConstants.GamesSlots:
                                $('.hello').hide();
                                $('#dvSlots').fadeIn(1000, function () {
                                    $('#manageScheduleTabLink, #managePopulationTabLink').parent().removeClass('linkDisabled');
                                    if (document.getElementById('<%=hdnIsPopulation.ClientID%>').value == 'False')
                                        $('#managePopulationTabLink').parent().addClass('linkDisabled');
                                    if (document.getElementById('<%=hdnIsShedule.ClientID%>').value == 'False')
                                        $('#manageScheduleTabLink').parent().addClass('linkDisabled');
                                });
                                break;
                            case ContentTypeConstants.GamesTables:
                                $('.hello').hide();
                                $('#dvGamesTables').fadeIn(1000, function () {
                                    $('#manageScheduleTabLink, #managePopulationTabLink').parent().removeClass('linkDisabled');
                                    if (document.getElementById('<%=hdnIsPopulation.ClientID%>').value == 'False')
                                        $('#managePopulationTabLink').parent().addClass('linkDisabled');
                                    if (document.getElementById('<%=hdnIsShedule.ClientID%>').value == 'False')
                                        $('#manageScheduleTabLink').parent().addClass('linkDisabled');
                                });
                                break;
                            case ContentTypeConstants.Host:
                                $('.hello').hide();
                                $('#dvHosts').fadeIn(1000, function () {

                                    $('#manageScheduleTabLink, #managePopulationTabLink').parent().removeClass('linkDisabled');
                                    if (document.getElementById('<%=hdnIsPopulation.ClientID%>').value == 'False')
                                        $('#managePopulationTabLink').parent().addClass('linkDisabled');
                                    if (document.getElementById('<%=hdnIsShedule.ClientID%>').value == 'False')
                                        $('#manageScheduleTabLink').parent().addClass('linkDisabled');
                                });
                                break;
                            case ContentTypeConstants.WebAppLoginScreenBranding:
                                $('.hello').hide();
                                $('#dvWebAppLoginScreenBranding').fadeIn(1000, function () {
                                    $('#manageScheduleTabLink, #managePopulationTabLink').parent().removeClass('linkDisabled');
                                    if (document.getElementById('<%=hdnIsPopulation.ClientID%>').value == 'False')
                                        $('#managePopulationTabLink').parent().addClass('linkDisabled');
                                    if (document.getElementById('<%=hdnIsShedule.ClientID%>').value == 'False')
                                        $('#manageScheduleTabLink').parent().addClass('linkDisabled');
                                });
                                break;
                            case ContentTypeConstants.WebAppBranding:
                                $('.hello').hide();
                                $('#dvWebAppBranding').fadeIn(1000, function () {
                                    $('#manageScheduleTabLink, #managePopulationTabLink').parent().removeClass('linkDisabled');
                                    if (document.getElementById('<%=hdnIsPopulation.ClientID%>').value == 'False')
                                        $('#managePopulationTabLink').parent().addClass('linkDisabled');
                                    if (document.getElementById('<%=hdnIsShedule.ClientID%>').value == 'False')
                                        $('#manageScheduleTabLink').parent().addClass('linkDisabled');
                                });
                                break;
                            case ContentTypeConstants.TableGamesDetail:
                                $('.hello').hide();
                                $('#dvTableGamesDetail').fadeIn(1000, function () {
                                    $('#manageScheduleTabLink, #managePopulationTabLink').parent().removeClass('linkDisabled');
                                    if (document.getElementById('<%=hdnIsPopulation.ClientID%>').value == 'False')
                                        $('#managePopulationTabLink').parent().addClass('linkDisabled');
                                    if (document.getElementById('<%=hdnIsShedule.ClientID%>').value == 'False')
                                        $('#manageScheduleTabLink').parent().addClass('linkDisabled');
                                });
                                break;
                            case ContentTypeConstants.PokerGamesDetail:
                                $('.hello').hide();
                                $('#dvPokerGamesDetail').fadeIn(1000, function () {
                                    $('#manageScheduleTabLink, #managePopulationTabLink').parent().removeClass('linkDisabled');
                                    if (document.getElementById('<%=hdnIsPopulation.ClientID%>').value == 'False')
                                        $('#managePopulationTabLink').parent().addClass('linkDisabled');
                                    if (document.getElementById('<%=hdnIsShedule.ClientID%>').value == 'False')
                                        $('#manageScheduleTabLink').parent().addClass('linkDisabled');
                                });
                                break;
                            case ContentTypeConstants.BingoGamesDetail:
                                $('.hello').hide();
                                $('#dvBingoGamesDetail').fadeIn(1000, function () {
                                    $('#manageScheduleTabLink, #managePopulationTabLink').parent().removeClass('linkDisabled');
                                    if (document.getElementById('<%=hdnIsPopulation.ClientID%>').value == 'False')
                                        $('#managePopulationTabLink').parent().addClass('linkDisabled');
                                    if (document.getElementById('<%=hdnIsShedule.ClientID%>').value == 'False')
                                        $('#manageScheduleTabLink').parent().addClass('linkDisabled');
                                });
                                break;
                            case ContentTypeConstants.DashboardMostPopularProgressives:
                                $('.hello').hide();
                                $('#dvDashboardMostPopularProgressivesAsset').fadeIn(1000, function () {
                                    $('#manageScheduleTabLink, #managePopulationTabLink').parent().removeClass('linkDisabled');
                                    if (document.getElementById('<%=hdnIsPopulation.ClientID%>').value == 'False')
                                        $('#managePopulationTabLink').parent().addClass('linkDisabled');
                                    if (document.getElementById('<%=hdnIsShedule.ClientID%>').value == 'False')
                                        $('#manageScheduleTabLink').parent().addClass('linkDisabled');
                                });
                                break;
                            case ContentTypeConstants.DashboardMostPopularSlotType:
                                $('.hello').hide();
                                $('#dvDashboardMostPopularSlotType').fadeIn(1000, function () {
                                    $('#manageScheduleTabLink, #managePopulationTabLink').parent().removeClass('linkDisabled');
                                    if (document.getElementById('<%=hdnIsPopulation.ClientID%>').value == 'False')
                                        $('#managePopulationTabLink').parent().addClass('linkDisabled');
                                    if (document.getElementById('<%=hdnIsShedule.ClientID%>').value == 'False')
                                        $('#manageScheduleTabLink').parent().addClass('linkDisabled');
                                });
                                break;
                            case ContentTypeConstants.DashboardMostPopularSlotDetail:
                                $('.hello').hide();
                                $('#dvDashboardMostPopularSlotDetailAsset').fadeIn(1000, function () {
                                    $('#manageScheduleTabLink, #managePopulationTabLink').parent().removeClass('linkDisabled');
                                    if (document.getElementById('<%=hdnIsPopulation.ClientID%>').value == 'False')
                                        $('#managePopulationTabLink').parent().addClass('linkDisabled');
                                    if (document.getElementById('<%=hdnIsShedule.ClientID%>').value == 'False')
                                        $('#manageScheduleTabLink').parent().addClass('linkDisabled');
                                });
                                break;

                            case ContentTypeConstants.SlotGameDetail:
                                $('.hello').hide();
                                $('#dvSlotGameDetail').fadeIn(1000, function () {
                                    $('#manageScheduleTabLink, #managePopulationTabLink').parent().removeClass('linkDisabled');
                                    if (document.getElementById('<%=hdnIsPopulation.ClientID%>').value == 'False')
                                        $('#managePopulationTabLink').parent().addClass('linkDisabled');
                                    if (document.getElementById('<%=hdnIsShedule.ClientID%>').value == 'False')
                                        $('#manageScheduleTabLink').parent().addClass('linkDisabled');
                                });
                                break;
                            case ContentTypeConstants.DiningSpecials:
                                $('.hello').hide();
                                $('#dvDiningSpecial').fadeIn(1000, function () {
                                    $('#manageScheduleTabLink, #managePopulationTabLink').parent().removeClass('linkDisabled');
                                    if (document.getElementById('<%=hdnIsPopulation.ClientID%>').value == 'False')
                                        $('#managePopulationTabLink').parent().addClass('linkDisabled');
                                    if (document.getElementById('<%=hdnIsShedule.ClientID%>').value == 'False')
                                        $('#manageScheduleTabLink').parent().addClass('linkDisabled');
                                });
                                break;
                            case ContentTypeConstants.GlobalAsset:
                                $('.hello').hide();
                                $('#dvGlobalAsset').fadeIn(1000, function () {
                                    $('#manageScheduleTabLink, #managePopulationTabLink').parent().removeClass('linkDisabled');
                                    if (document.getElementById('<%=hdnIsPopulation.ClientID%>').value == 'False')
                                        $('#managePopulationTabLink').parent().addClass('linkDisabled');
                                    if (document.getElementById('<%=hdnIsShedule.ClientID%>').value == 'False')
                                        $('#manageScheduleTabLink').parent().addClass('linkDisabled');
                                });
                                break;

                            case ContentTypeConstants.FreePlayOffers:
                                $('.hello').hide();
                                $('#dvFreePlayOffers').fadeIn(1000, function () {
                                    $('#manageScheduleTabLink, #managePopulationTabLink').parent().removeClass('linkDisabled');
                                    if (document.getElementById('<%=hdnIsPopulation.ClientID%>').value == 'False')
                                        $('#managePopulationTabLink').parent().addClass('linkDisabled');
                                    if (document.getElementById('<%=hdnIsShedule.ClientID%>').value == 'False')
                                        $('#manageScheduleTabLink').parent().addClass('linkDisabled');
                                });
                                break;
                            case ContentTypeConstants.AchievementBadges:
                                $('.hello').hide();
                                $('#dvAchievementBadges').fadeIn(1000, function () {
                                    $('#manageScheduleTabLink, #managePopulationTabLink').parent().removeClass('linkDisabled');
                                    if (document.getElementById('<%=hdnIsPopulation.ClientID%>').value == 'False')
                                        $('#managePopulationTabLink').parent().addClass('linkDisabled');
                                    if (document.getElementById('<%=hdnIsShedule.ClientID%>').value == 'False')
                                        $('#manageScheduleTabLink').parent().addClass('linkDisabled');
                                });
                                break;

                            case ContentTypeConstants.WINLOSSTERMSANDCONDITIONS:
                                $('.hello').hide();
                                $('#dvWinLossTermsandConditions').fadeIn(1000, function () {
                                    $('#manageScheduleTabLink, #managePopulationTabLink').parent().removeClass('linkDisabled');
                                    if (document.getElementById('<%=hdnIsPopulation.ClientID%>').value == 'False')
                                        $('#managePopulationTabLink').parent().addClass('linkDisabled');
                                    if (document.getElementById('<%=hdnIsShedule.ClientID%>').value == 'False')
                                        $('#manageScheduleTabLink').parent().addClass('linkDisabled');
                                });
                                break;

                            case ContentTypeConstants.GamesBingoJackpot:
                                $('.hello').hide();
                                $('#dvGamesBingoJackpot').fadeIn(1000, function () {
                                    $('#manageScheduleTabLink, #managePopulationTabLink').parent().removeClass('linkDisabled');
                                    if (document.getElementById('<%=hdnIsPopulation.ClientID%>').value == 'False')
                                        $('#managePopulationTabLink').parent().addClass('linkDisabled');
                                    if (document.getElementById('<%=hdnIsShedule.ClientID%>').value == 'False')
                                        $('#manageScheduleTabLink').parent().addClass('linkDisabled');

                                });
                                break;

                            case ContentTypeConstants.DashboardHeaders:
                                document.getElementById('<%=lblAssetName.ClientID%>').innerHTML = originallblAssetNameText;
                                $('.hello').hide();
                                $('#dvDashBoadHeaders').fadeIn(1000, function () {
                                    $('#manageScheduleTabLink, #managePopulationTabLink').parent().removeClass('linkDisabled');
                                    if (document.getElementById('<%=hdnIsPopulation.ClientID%>').value == 'False')
                                        $('#managePopulationTabLink').parent().addClass('linkDisabled');
                                    if (document.getElementById('<%=hdnIsShedule.ClientID%>').value == 'False')
                                        $('#manageScheduleTabLink').parent().addClass('linkDisabled');
                                });
                                break;

                            case ContentTypeConstants.CommunityFavoriteSlots:
                                $('.hello').hide();
                                $('#dvCommunityFavoriteSlots').fadeIn(1000, function () {
                                    $('#manageScheduleTabLink, #managePopulationTabLink').parent().removeClass('linkDisabled');
                                    if (document.getElementById('<%=hdnIsPopulation.ClientID%>').value == 'False')
                                        $('#managePopulationTabLink').parent().addClass('linkDisabled');
                                    if (document.getElementById('<%=hdnIsShedule.ClientID%>').value == 'False')
                                        $('#manageScheduleTabLink').parent().addClass('linkDisabled');
                                });
                                break;

                            case ContentTypeConstants.MyFavoriteSlots:
                                $('.hello').hide();
                                $('#dvMyFavoriteSlots').fadeIn(1000, function () {
                                    $('#manageScheduleTabLink, #managePopulationTabLink').parent().removeClass('linkDisabled');
                                    if (document.getElementById('<%=hdnIsPopulation.ClientID%>').value == 'False')
                                        $('#managePopulationTabLink').parent().addClass('linkDisabled');
                                    if (document.getElementById('<%=hdnIsShedule.ClientID%>').value == 'False')
                                        $('#manageScheduleTabLink').parent().addClass('linkDisabled');
                                });
                                break;
                            case ContentTypeConstants.ClientBranding:
                                $('.hello').hide();
                                $('#dvClientBranding').fadeIn(1000, function () {
                                    $('#manageScheduleTabLink, #managePopulationTabLink').parent().removeClass('linkDisabled');
                                    if (document.getElementById('<%=hdnIsPopulation.ClientID%>').value == 'False')
                                        $('#managePopulationTabLink').parent().addClass('linkDisabled');
                                    if (document.getElementById('<%=hdnIsShedule.ClientID%>').value == 'False')
                                        $('#manageScheduleTabLink').parent().addClass('linkDisabled');
                                });
                                break;
                            case ContentTypeConstants.TierProgress:
                                $('.hello').hide();
                                $('#dvTierProgress').fadeIn(1000, function () {
                                    $('#manageScheduleTabLink, #managePopulationTabLink').parent().removeClass('linkDisabled');
                                    if (document.getElementById('<%=hdnIsPopulation.ClientID%>').value == 'False')
                                        $('#managePopulationTabLink').parent().addClass('linkDisabled');
                                    if (document.getElementById('<%=hdnIsShedule.ClientID%>').value == 'False')
                                        $('#manageScheduleTabLink').parent().addClass('linkDisabled');
                                });
                                break;
                            case ContentTypeConstants.MyFavoriteSlotContent:
                                $('.hello').hide();
                                $('#dvMyFavoriteSlotContent').fadeIn(1000, function () {
                                    $('#manageScheduleTabLink, #managePopulationTabLink').parent().removeClass('linkDisabled');
                                    if (document.getElementById('<%=hdnIsPopulation.ClientID%>').value == 'False')
                                        $('#managePopulationTabLink').parent().addClass('linkDisabled');
                                    if (document.getElementById('<%=hdnIsShedule.ClientID%>').value == 'False')
                                        $('#manageScheduleTabLink').parent().addClass('linkDisabled');
                                });
                                break;
                            case ContentTypeConstants.MyRewardImage:
                                $('.hello').hide();
                                $('#dvMyRewardImage').fadeIn(1000, function () {
                                    $('#manageScheduleTabLink, #managePopulationTabLink').parent().removeClass('linkDisabled');
                                    if (document.getElementById('<%=hdnIsPopulation.ClientID%>').value == 'False')
                                        $('#managePopulationTabLink').parent().addClass('linkDisabled');
                                    if (document.getElementById('<%=hdnIsShedule.ClientID%>').value == 'False')
                                        $('#manageScheduleTabLink').parent().addClass('linkDisabled');
                                });

                                break;
                            case ContentTypeConstants.MyFavoriteSlotsUpdateAward:
                                $('.hello').hide();
                                $('#dvMyFavoriteSlotsUpdateAward').fadeIn(1000, function () {
                                    $('#manageScheduleTabLink, #managePopulationTabLink').parent().removeClass('linkDisabled');
                                    if (document.getElementById('<%=hdnIsPopulation.ClientID%>').value == 'False')
                                        $('#managePopulationTabLink').parent().addClass('linkDisabled');
                                    if (document.getElementById('<%=hdnIsShedule.ClientID%>').value == 'False')
                                        $('#manageScheduleTabLink').parent().addClass('linkDisabled');
                                });

                                break;
                            case ContentTypeConstants.AchievementColorCode:
                                $('.hello').hide();
                                $('#dvAchievementColorCode').fadeIn(1000, function () {
                                    $('#manageScheduleTabLink, #managePopulationTabLink').parent().removeClass('linkDisabled');
                                    if (document.getElementById('<%=hdnIsPopulation.ClientID%>').value == 'False')
                                        $('#managePopulationTabLink').parent().addClass('linkDisabled');
                                    if (document.getElementById('<%=hdnIsShedule.ClientID%>').value == 'False')
                                        $('#manageScheduleTabLink').parent().addClass('linkDisabled');
                                });

                                break;

                        }

                        RegisterLeftDivHeight();
                    }
                    function RegisterLeftDivHeight() {
                        $("#dvLeftcontentdetail").height($('#dvRightContent').height());
                    }
                    function SetSelectedContentTypeText() {
                        document.getElementById('<%=hdnContentTypeId.ClientID%>').value = document.getElementById('<%=ddlContentType.ClientID%>').options[document.getElementById('<%=ddlContentType.ClientID%>').selectedIndex].value;
                        document.getElementById('<%=hdnEnvironmentType.ClientID%>').value = document.getElementById('<%=ddlEnvironment.ClientID%>').options[document.getElementById('<%=ddlEnvironment.ClientID%>').selectedIndex].text;
                        document.getElementById('<%=lblAssetName.ClientID%>').innerHTML = document.getElementById('<%=ddlContentType.ClientID%>').options[document.getElementById('<%=ddlContentType.ClientID%>').selectedIndex].text + ' Name';
                    }
                    ///Set Current Tab
                    function SetTabControls() {

                        var readTabValue = $('#<%=hdnSeletedTab.ClientID%>').val();
                        var rowscount = $("#<%=gvContentDetail.ClientID %> tr").length;
                        var isTab = $("#<%=hdnActive.ClientID %>").val();
                        var isPermissionDelete = $("#<%=hdnIsPermissionDelete.ClientID %>").val();
                        var contentType = document.getElementById('MainContent_ddlContentType').options[document.getElementById('MainContent_ddlContentType').selectedIndex].text;
                        switch (readTabValue) {
                            case 'content':
                                if (isTab == "InActive" || isTab == "All") {

                                    <%-- COG-27 nacupido 9-12-16 disable delete button for inactive offers --%>
                                    <%-- COG-57 nacupido 11-21-16 disable delete button for inactive promotions --%>
                                    <%-- COG-58 nacupido 11-21-16 disable delete button for inactive dining specials --%>

                                    //if ($('#<%=ddlContentType.ClientID%> option:selected').val() != "10" && '#<%=ddlContentType.ClientID%> option:selected').val() != "17" && '#<%=ddlContentType.ClientID%> option:selected').val() != "18") {
                                    if ($('#<%=ddlContentType.ClientID%> option:selected').val() == "10") {
                                    }
                                    else if ($('#<%=ddlContentType.ClientID%> option:selected').val() == "17") {
                                    }
                                    else if ($('#<%=ddlContentType.ClientID%> option:selected').val() == "18") {
                                    }
                                    else {
                                        $("#<%=lnkbtnDelete.ClientID %>").addClass('aspNetDisabled');
                                        $("#<%=lnkbtnDelete.ClientID %>").addClass('disabled');
                                    }

                                }
                                else {
                                    if ($('#<%=ddlContentType.ClientID%> option:selected').val() != "38" && rowscount > 0 && isPermissionDelete == 1) {
                                        $("#<%=lnkbtnDelete.ClientID %>").removeClass('aspNetDisabled');
                                        $("#<%=lnkbtnDelete.ClientID %>").removeAttr("disabled");
                                    }
                                }
                                $('.nav-tabs li').removeClass('active');
                                $('.nav-tabs li.nav-tabs-content').addClass('active');
                                $('.tab-content .tab-pane').removeClass('active in');
                                $('#manageContentTab').addClass('active in');
                                break;
                            case 'schedule':
                                $('.nav-tabs li').removeClass('active');
                                $('.nav-tabs li.nav-tabs-schedule').addClass('active');
                                $('.tab-content .tab-pane').removeClass('active in');
                                $('#manageScheduleTab').addClass('active in');
                                $("#<%=lnkbtnDelete.ClientID %>").addClass('aspNetDisabled');
                                $("#<%=lnkbtnDelete.ClientID %>").attr("disabled", $("#<%=lnkbtnDelete.ClientID %>"));
                                break;
                            case 'populationTab':
                                $('.nav-tabs li').removeClass('active');
                                $('.nav-tabs li.nav-tabs-population').addClass('active');
                                $('.tab-content .tab-pane').removeClass('active in');
                                $('#liTiers').removeClass('active');
                                $('#liTiers').addClass('active in');
                                $('div#populationListTab').removeClass('active');
                                $('div#populationTiersTab').addClass('active in');
                                $('div#managePopulationTab').addClass('active in');
                                $("#<%=lnkbtnDelete.ClientID %>").addClass('aspNetDisabled');
                                $("#<%=lnkbtnDelete.ClientID %>").attr("disabled", $("#<%=lnkbtnDelete.ClientID %>"));
                                break;
                            case 'populationTiersTab':
                                $('.nav-tabs li').removeClass('active');
                                $('.nav-tabs li.nav-tabs-population').addClass('active in');
                                $('.tab-content .tab-pane').removeClass('active in');
                                $('div#populationListTab').removeClass('active');
                                $('div#populationTiersTab').addClass('active in');
                                $('div#managePopulationTab').addClass('active in');
                                $('li#liTiers').addClass('active in');
                                $("#<%=lnkbtnDelete.ClientID %>").addClass('aspNetDisabled');
                                $("#<%=lnkbtnDelete.ClientID %>").attr("disabled", $("#<%=lnkbtnDelete.ClientID %>"));

                                break;
                            case 'populationListTab':
                                $('.nav-tabs li').removeClass('active');
                                $('.nav-tabs li.nav-tabs-population').addClass('active');
                                $('.tab-content .tab-pane').removeClass('active in');
                                $('div#populationTiersTab').removeClass('active');
                                $('div#populationListTab').addClass('active in');
                                $('div#managePopulationTab').addClass('active in');
                                $('li#liList').addClass('active');
                                if ($('#<%=ddlContentType.ClientID%> option:selected').val() == '10') {
                                    $('#PopulationListMyOffer').show();
                                    $('#PopulationListOtherContentType').hide();
                                }
                                else {
                                    $('#PopulationListMyOffer').hide();
                                    $('#PopulationListOtherContentType').show();
                                }
                                $("#<%=lnkbtnDelete.ClientID %>").addClass('aspNetDisabled');
                                $("#<%=lnkbtnDelete.ClientID %>").attr("disabled", $("#<%=lnkbtnDelete.ClientID %>"));
                                break;
                        }
                        RegisterLeftDivHeight();
                    }

                    ///Set Default tab on pageload
                    function SetDefaultTab() {
                        $('.nav-tabs li').removeClass('active');
                        $('.nav-tabs li.nav-tabs-content').addClass('active');
                        $('.tab-content .tab-pane').removeClass('active in');
                        $('#manageContentTab').addClass('active in');

                    }

                    function SetSelectedTab(selectedTab) {
                        var selected = selectedTab;
                        $('#<%=hdnSeletedTab.ClientID%>').val(selectedTab);
                        SetTabControls();
                        RegisterDisabledTypeListBox();
                    }

                    ///Page validations
                    function FormValidation() {

                        var readTabValue = $('#<%=hdnSeletedTab.ClientID%>').val();
                        if (document.getElementById('<%=ddlContentType.ClientID%>') != null && document.getElementById('<%=ddlContentType.ClientID%>').selectedIndex != -1) {

                            if (myTrim(document.getElementById('<%=txtAssetName.ClientID%>').value) == '') {
                                document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please enter ' + document.getElementById('<%=lblAssetName.ClientID%>').innerHTML;
                                $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                                document.getElementById('<%=txtAssetName.ClientID%>').focus();
                                return false;
                            }
                            //My Favorite Slots
                            if ($('#<%=ddlContentType.ClientID%> option:selected').val() == 40) {
                                if ($('#<%=txtOrder.ClientID%>').val() == '') {
                                    document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please enter sort order';
                                    $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                                    document.getElementById('<%=txtOrder.ClientID%>').focus();
                                    return false;
                                }
                                if (CheckSortOrder($('#<%=txtOrder.ClientID%>').val(), 3) == 0) {
                                    document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please enter sort order between 1 to 3';
                                    $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                                    document.getElementById('<%=txtOrder.ClientID%>').focus();
                                    return false;
                                }
                            }
                            //Community Favorite Slots
                            if ($('#<%=ddlContentType.ClientID%> option:selected').val() == 39) {
                                if ($('#<%=txtCommunityFavoriteSlotsSortOrder.ClientID%>').val() == '') {
                                    document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please enter sort order';
                                    $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                                    document.getElementById('<%=txtCommunityFavoriteSlotsSortOrder.ClientID%>').focus();
                                    return false;
                                }
                                if (CheckSortOrder($('#<%=txtCommunityFavoriteSlotsSortOrder.ClientID%>').val(), 4) == 0) {
                                    document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please enter sort order between 1 to 4';
                                    $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                                    document.getElementById('<%=txtCommunityFavoriteSlotsSortOrder.ClientID%>').focus();
                                    return false;
                                }
                            }
                            //Dashboard - Most Popular Slot Type
                            if ($('#<%=ddlContentType.ClientID%> option:selected').val() == 29) {
                                if (myTrim($('#<%=txtDashboardMostPopularSlotType.ClientID%>').val()) == '') {
                                    document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please enter slot type';
                                    $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                                    document.getElementById('<%=txtDashboardMostPopularSlotType.ClientID%>').focus();
                                    return false;
                                }

                            }
                            //WebAppLoginScreenBranding
                            if ($('#<%=ddlContentType.ClientID%> option:selected').val() == 24) {
                                if (document.getElementById('MainContent_UploadWebAppLoginScreenBrandingImage1_hdnImageUrl').value == '') {
                                    document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please attach upper left image';
                                    $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                                    return false;
                                }
                                if (document.getElementById('MainContent_UploadWebAppLoginScreenBrandingImage2_hdnImageUrl').value == '') {
                                    document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please attach left image ';
                                    $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                                    return false;
                                }
                                if (document.getElementById('MainContent_UploadWebAppLoginScreenBrandingImage3_hdnImageUrl').value == '') {
                                    document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please attach right image ';
                                    $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                                    return false;
                                }
                            }
                            //Tier Progress
                            if ($('#<%=ddlContentType.ClientID%> option:selected').val() == 42) {
                                if ($('#<%=chkTierProgressActive1.ClientID %>')[0].checked == true && myTrim($('#<%=txtTierProgressTierName1.ClientID %>').val()) == '') {
                                    document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please enter TierName-1';
                                    $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                                    document.getElementById('<%=txtTierProgressTierName1.ClientID%>').focus();
                                    return false;
                                }
                                if ($('#<%=chkTierProgressActive2.ClientID %>')[0].checked == true && myTrim($('#<%=txtTierProgressTierName2.ClientID %>').val()) == '') {
                                    document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please enter TierName-2';
                                    $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                                    document.getElementById('<%=txtTierProgressTierName2.ClientID%>').focus();
                                    return false;
                                }
                                if ($('#<%=chkTierProgressActive3.ClientID %>')[0].checked == true && myTrim($('#<%=txtTierProgressTierName3.ClientID %>').val()) == '') {
                                    document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please enter TierName-3';
                                    $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                                    document.getElementById('<%=txtTierProgressTierName3.ClientID%>').focus();
                                    return false;
                                }
                                if ($('#<%=chkTierProgressActive4.ClientID %>')[0].checked == true && myTrim($('#<%=txtTierProgressTierName4.ClientID %>').val()) == '') {
                                    document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please enter TierName-4';
                                    $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                                    document.getElementById('<%=txtTierProgressTierName4.ClientID%>').focus();
                                    return false;
                                }
                                if ($('#<%=chkTierProgressActive5.ClientID %>')[0].checked == true && myTrim($('#<%=txtTierProgressTierName5.ClientID %>').val()) == '') {
                                    document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please enter TierName-5';
                                    $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                                    document.getElementById('<%=txtTierProgressTierName5.ClientID%>').focus();
                                    return false;
                                }
                                if ($('#<%=chkTierProgressActive6.ClientID %>')[0].checked == true && myTrim($('#<%=txtTierProgressTierName6.ClientID %>').val()) == '') {
                                    document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please enter TierName-6';
                                    $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                                    document.getElementById('<%=txtTierProgressTierName6.ClientID%>').focus();
                                    return false;
                                }
                                if ($('#<%=chkTierProgressActive7.ClientID %>')[0].checked == true && myTrim($('#<%=txtTierProgressTierName7.ClientID %>').val()) == '') {
                                    document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please enter TierName-7';
                                    $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                                    document.getElementById('<%=txtTierProgressTierName7.ClientID%>').focus();
                                    return false;
                                }
                                if ($('#<%=chkTierProgressActive8.ClientID %>')[0].checked == true && myTrim($('#<%=txtTierProgressTierName8.ClientID %>').val()) == '') {
                                    document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please enter TierName-8';
                                    $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                                    document.getElementById('<%=txtTierProgressTierName8.ClientID%>').focus();
                                    return false;
                                }
                                if ($('#<%=chkTierProgressActive9.ClientID %>')[0].checked == true && myTrim($('#<%=txtTierProgressTierName9.ClientID %>').val()) == '') {
                                    document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please enter TierName-9';
                                    $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                                    document.getElementById('<%=txtTierProgressTierName9.ClientID%>').focus();
                                    return false;
                                }
                                if ($('#<%=chkTierProgressActive10.ClientID %>')[0].checked == true && myTrim($('#<%=txtTierProgressTierName10.ClientID %>').val()) == '') {
                                    document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please enter TierName-10';
                                    $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                                    document.getElementById('<%=txtTierProgressTierName10.ClientID%>').focus();
                                    return false;
                                }
                                if ($('#<%=chkTierProgressActive11.ClientID %>')[0].checked == true && myTrim($('#<%=txtTierProgressTierName11.ClientID %>').val()) == '') {
                                    document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please enter TierName-11';
                                    $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                                    document.getElementById('<%=txtTierProgressTierName11.ClientID%>').focus();
                                    return false;
                                }
                                if ($('#<%=chkTierProgressActive12.ClientID %>')[0].checked == true && myTrim($('#<%=txtTierProgressTierName12.ClientID %>').val()) == '') {
                                    document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please enter TierName-12';
                                    $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                                    document.getElementById('<%=txtTierProgressTierName12.ClientID%>').focus();
                                    return false;
                                }
                            }
                            //Schedule
                            if (myTrim(document.getElementById('<%=txtScheduleName.ClientID%>').value) != '' || readTabValue == 'schedule') {
                                if (myTrim(document.getElementById('<%=txtScheduleName.ClientID%>').value) == '') {

                                    document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please enter schedule name';
                                    $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                                    document.getElementById('<%=txtScheduleName.ClientID%>').focus();
                                    return false;
                                }
                                if (document.getElementById('<%=txtScheduleFrom.ClientID%>').value == '') {

                                    document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please enter schedule from date';
                                    $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                                    document.getElementById('<%=txtScheduleFrom.ClientID%>').focus();
                                    return false;
                                }
                                if (document.getElementById('<%=txtScheduleFromAt.ClientID%>').value == '') {

                                    document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please enter schedule from time';
                                    $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                                    document.getElementById('<%=txtScheduleFromAt.ClientID%>').focus();
                                    return false;
                                }
                                if (document.getElementById('<%=txtScheduleTo.ClientID%>').value == '') {

                                    document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please enter schedule to date';
                                    $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                                    document.getElementById('<%=txtScheduleTo.ClientID%>').focus();
                                    return false;
                                }
                                if (document.getElementById('<%=txtscheduleToAt.ClientID%>').value == '') {
                                    document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please enter schedule to time';
                                    $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                                    document.getElementById('<%=txtscheduleToAt.ClientID%>').focus();
                                    return false;
                                }
                                if (Date.parse(document.getElementById('<%=txtScheduleTo.ClientID%>').value) < Date.parse(document.getElementById('<%=txtScheduleFrom.ClientID%>').value)) {
                                    document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Invalid Date Range!\nStart Date cannot be after End Date!';
                                    $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                                    document.getElementById('<%=txtScheduleTo.ClientID%>').focus();
                                    return false;
                                }
                                if ($('#<%=chkMonday.ClientID%>')[0].checked == true) {
                                    if (document.getElementById('<%=txtScheduleMondayFrom.ClientID%>').value == '') {
                                        document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please enter monday from time';
                                        $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                                        document.getElementById('<%=txtScheduleMondayFrom.ClientID%>').focus();
                                        return false;
                                    }
                                    if (document.getElementById('<%=txtScheduleMondayTo.ClientID%>').value == '') {

                                        document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please enter monday to time';
                                        $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                                        document.getElementById('<%=txtScheduleMondayTo.ClientID%>').focus();
                                        return false;
                                    }
                                }
                                else if (document.getElementById('<%=txtScheduleMondayFrom.ClientID%>').value != '' || document.getElementById('<%=txtScheduleMondayTo.ClientID%>').value != '') {
                                    document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please select monday';
                                    $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                                    document.getElementById('<%=chkMonday.ClientID%>').focus();
                                    return false;
                                }
                            if ($('#<%=chkTuesday.ClientID%>')[0].checked == true) {
                                    if (document.getElementById('<%=txtScheduleTueFrom.ClientID%>').value == '') {
                                        document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please enter tuesday from time';
                                        $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                                        document.getElementById('<%=txtScheduleTueFrom.ClientID%>').focus();
                                        return false;
                                    }
                                    if (document.getElementById('<%=txtScheduleTueTo.ClientID%>').value == '') {
                                        document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please enter tuesday to time';
                                        $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                                        document.getElementById('<%=txtScheduleTueTo.ClientID%>').focus();
                                        return false;
                                    }
                                }
                                else if (document.getElementById('<%=txtScheduleTueFrom.ClientID%>').value != '' || document.getElementById('<%=txtScheduleTueTo.ClientID%>').value != '') {

                                    document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please select tuesday';
                                    $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                                    document.getElementById('<%=chkTuesday.ClientID%>').focus();
                                    return false;
                                }
                            if ($('#<%=chkWednesday.ClientID%>')[0].checked == true) {
                                    if (document.getElementById('<%=txtScheduleWedFrom.ClientID%>').value == '') {
                                        document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please enter wednesday from time';
                                        $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                                        document.getElementById('<%=txtScheduleWedFrom.ClientID%>').focus();
                                        return false;
                                    }
                                    if (document.getElementById('<%=txtScheduleWedTo.ClientID%>').value == '') {

                                        document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please enter wednesday to time';
                                        $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                                        document.getElementById('<%=txtScheduleWedTo.ClientID%>').focus();
                                        return false;
                                    }
                                }
                                else if (document.getElementById('<%=txtScheduleWedFrom.ClientID%>').value != '' || document.getElementById('<%=txtScheduleWedTo.ClientID%>').value != '') {

                                    document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please select wednesday';
                                    $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                                    document.getElementById('<%=chkWednesday.ClientID%>').focus();
                                    return false;
                                }


                            if ($('#<%=chkThursday.ClientID%>')[0].checked == true) {
                                    if (document.getElementById('<%=txtScheduleThuFrom.ClientID%>').value == '') {

                                        document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please enter thursday from time';
                                        $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                                        document.getElementById('<%=txtScheduleThuFrom.ClientID%>').focus();
                                        return false;
                                    }
                                    if (document.getElementById('<%=txtScheduleThuTo.ClientID%>').value == '') {
                                        document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please enter thursday to time';
                                        $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                                        document.getElementById('<%=txtScheduleThuTo.ClientID%>').focus();
                                        return false;
                                    }
                                }
                                else if (document.getElementById('<%=txtScheduleThuFrom.ClientID%>').value != '' || document.getElementById('<%=txtScheduleThuTo.ClientID%>').value != '') {
                                    document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please select thursday';
                                    $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                                    document.getElementById('<%=chkThursday.ClientID%>').focus();
                                    return false;
                                }
                            if ($('#<%=chkFriday.ClientID%>')[0].checked == true) {
                                    if (document.getElementById('<%=txtScheduleFriFrom.ClientID%>').value == '') {
                                        document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please enter friday from time';
                                        $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                                        document.getElementById('<%=txtScheduleFriFrom.ClientID%>').focus();
                                        return false;
                                    }
                                    if (document.getElementById('<%=txtScheduleFriTo.ClientID%>').value == '') {
                                        document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please enter friday to time';
                                        $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                                        document.getElementById('<%=txtScheduleFriTo.ClientID%>').focus();
                                        return false;
                                    }
                                }
                                else if (document.getElementById('<%=txtScheduleFriFrom.ClientID%>').value != '' || document.getElementById('<%=txtScheduleFriTo.ClientID%>').value != '') {
                                    document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please select friday';
                                    $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                                    document.getElementById('<%=chkFriday.ClientID%>').focus();
                                    return false;
                                }
                            if ($('#<%=chkSaturday.ClientID%>')[0].checked == true) {
                                    if (document.getElementById('<%=txtScheduleSatFrom.ClientID%>').value == '') {
                                        document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please enter saturday from time';
                                        $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                                        document.getElementById('<%=txtScheduleSatFrom.ClientID%>').focus();
                                        return false;
                                    }
                                    if (document.getElementById('<%=txtScheduleSatTo.ClientID%>').value == '') {
                                        document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please enter saturday to time';
                                        $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                                        document.getElementById('<%=txtScheduleSatTo.ClientID%>').focus();
                                        return false;
                                    }
                                }
                                else if (document.getElementById('<%=txtScheduleSatFrom.ClientID%>').value != '' || document.getElementById('<%=txtScheduleSatTo.ClientID%>').value != '') {

                                    document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please select saturday';
                                    $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                                    document.getElementById('<%=chkSaturday.ClientID%>').focus();
                                    return false;
                                }

                            if ($('#<%=chkSunday.ClientID%>')[0].checked == true) {
                                    if (document.getElementById('<%=txtScheduleSunFrom.ClientID%>').value == '') {
                                        document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please enter sunday from time';
                                        $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                                        document.getElementById('<%=txtScheduleSunFrom.ClientID%>').focus();
                                        return false;
                                    }
                                    if (document.getElementById('<%=txtScheduleSunTo.ClientID%>').value == '') {
                                        document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please enter sunday to time';
                                        $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                                        document.getElementById('<%=txtScheduleSunTo.ClientID%>').focus();
                                        return false;
                                    }
                                }
                                else if (document.getElementById('<%=txtScheduleSunFrom.ClientID%>').value != '' || document.getElementById('<%=txtScheduleSunTo.ClientID%>').value != '') {

                                    document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please select sunday';
                                    $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                                    document.getElementById('<%=chkSunday.ClientID%>').focus();
                                    return false;
                                }
                        }


                        var validation = ConfirmMessage(1);
                        if (validation == false) {
                            return false;
                        }
                        else {

                            return true;
                        }

                    }
                }

                ///Alert Message
                function ConfirmMessage(flag) {



                    var savemsg = 'Are you sure to save this content?';
                    var cancelmsg = 'Are you sure to discard current changes?';
                    var deletemsg = 'Are you sure to delete this content?';
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
function MobileNoValidation() {
    $('.numericMobile').keydown(function (event) {
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
    $(".numericMobile").bind("paste", function (e) {
        return false;
    });
    $(".numericMobile").bind("drop", function (e) {
        return false;
    });
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
function isNumberWithDecimal() {
    $('.numericwithdecimal').keydown(function (event) {
        // Allow special chars + arrows                             

        if (event.keyCode == 46 || event.keyCode == 110 || event.keyCode == 8 || event.keyCode == 9
            || event.keyCode == 27 || event.keyCode == 13
            || (event.keyCode == 65 && event.ctrlKey === true)
            || (event.keyCode >= 35 && event.keyCode <= 39) || (event.keyCode == 0)) {
            return;
        }
        else {
            // If it's not a number stop the keypress
            if (event.shiftKey || (event.keyCode < 48 || event.keyCode > 57) && (event.keyCode < 96 || event.keyCode > 105)
                && event.keyCode == 109 && event.keyCode == 107 && event.keyCode == 110) {
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

//HTML Editor
function isValidColor(x) {
    var str = x.value;
    var returnVal = str.match(/^#(([0-9a-fA-F]{2}){3}|([0-9a-fA-F]){3})$/) !== null;
    if (!returnVal && x.value != '') {
        x.value = '';
        document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Invalid color codes.';
                        $('#AlertBox').modal({ backdrop: 'static', keyboard: false });

                    }
                }

                function maskClose() {
                    $('.contentMask').on('click', 'button', function () {
                        $('.contentMask').fadeOut(1000);
                    });
                }


                function RegisterDetectedFormChanges() {
                    $.each($("input:text"), function (index, element) {
                        element.defaultValue = $(element).val();
                    });
                }
                function RegisterFieldSets() {

                    if ($('.fieldset legend input[type="checkbox"]').is(':checked')) {
                        $('.fieldSwitch input[type="checkbox"]').prop('disabled', false);
                    }
                    else {
                        $('.fieldSwitch input[type="checkbox"]').prop('disabled', true);
                    }
                    //Onpageload
                    if ($('.trmonday input[type="checkbox"]').is(':checked')) {
                        $('.trmonday').find('input[type="text"]').prop('disabled', false);
                        $('.trmonday').find('input[type="checkbox"]').prop('disabled', false);
                    }
                    else
                        $('.trmonday').find('input[type="text"], select').prop('disabled', true);

                    if ($('.trtuesday input[type="checkbox"]').is(':checked')) {
                        $('.trtuesday').find('input[type="text"]').prop('disabled', false);
                        $('.trtuesday').find('input[type="checkbox"]').prop('disabled', false);
                    }
                    else
                        $('.trtuesday').find('input[type="text"]').prop('disabled', true);
                    if ($('.trwednesday input[type="checkbox"]').is(':checked')) {
                        $('.trwednesday').find('input[type="text"]').prop('disabled', false);
                        $('.trwednesday').find('input[type="checkbox"]').prop('disabled', false);
                    }
                    else
                        $('.trwednesday').find('input[type="text"]').prop('disabled', true);
                    if ($('.trthursday input[type="checkbox"]').is(':checked')) {
                        $('.trthursday').find('input[type="text"]').prop('disabled', false);
                        $('.trthursday').find('input[type="checkbox"]').prop('disabled', false);
                    }
                    else
                        $('.trthursday').find('input[type="text"]').prop('disabled', true);
                    if ($('.trfriday input[type="checkbox"]').is(':checked')) {
                        $('.trfriday').find('input[type="text"]').prop('disabled', false);
                        $('.trfriday').find('input[type="checkbox"]').prop('disabled', false);
                    }
                    else
                        $('.trfriday').find('input[type="text"]').prop('disabled', true);

                    if ($('.trsaturday input[type="checkbox"]').is(':checked')) {
                        $('.trsaturday').find('input[type="text"]').prop('disabled', false);
                        $('.trsaturday').find('input[type="checkbox"]').prop('disabled', false);
                    }
                    else
                        $('.trsaturday').find('input[type="text"]').prop('disabled', true);

                    if ($('.trsunday input[type="checkbox"]').is(':checked')) {
                        $('.trsunday').find('input[type="text"]').prop('disabled', false);
                        $('.trsunday').find('input[type="checkbox"]').prop('disabled', false);
                    }
                    else
                        $('.trsunday').find('input[type="text"]').prop('disabled', true);

                    /// End Pageload

                    //Onchange
                    $(' .fieldset legend input[type="checkbox"]').change(function () {
                        if ($('.fieldset legend input[type="checkbox"]').is(':checked')) {
                            $('.fieldSwitch input[type="checkbox"]').prop('disabled', false);
                        }
                        else {
                            $(".scheduleTable input:checkbox").attr("checked", false);
                            $(".scheduleTable input:checkbox").attr("disabled", true);
                            $(".scheduleTable input[type='text']").val("");
                            $('.fieldSwitch input[type="text"]').prop('disabled', true);
                        }
                    });

                    $(' .trmonday input[type="checkbox"]').change(function () {
                        if ($('.trmonday input[type="checkbox"]').is(':checked')) {
                            $('.trmonday').find('input[type="text"]').prop('disabled', false);
                        }
                        else {
                            $('.trmonday').find('input[type="text"]').prop('disabled', true);
                            $('.trmonday input[type="text"]').val("");
                        }
                    });
                    $(' .trtuesday input[type="checkbox"]').change(function () {
                        if ($('.trtuesday input[type="checkbox"]').is(':checked')) {
                            $('.trtuesday').find('input[type="text"]').prop('disabled', false);
                        }
                        else {
                            $('.trtuesday').find('input[type="text"]').prop('disabled', true);
                            $('.trtuesday input[type="text"]').val("");
                        }
                    });
                    $(' .trwednesday input[type="checkbox"]').change(function () {
                        if ($('.trwednesday input[type="checkbox"]').is(':checked')) {
                            $('.trwednesday').find('input[type="text"]').prop('disabled', false);
                        }
                        else {
                            $('.trwednesday').find('input[type="text"]').prop('disabled', true);
                            $('.trwednesday input[type="text"]').val("");
                        }
                    });
                    $(' .trthursday input[type="checkbox"]').change(function () {
                        if ($('.trthursday input[type="checkbox"]').is(':checked')) {
                            $('.trthursday').find('input[type="text"]').prop('disabled', false);
                        }
                        else {
                            $('.trthursday').find('input[type="text"]').prop('disabled', true);
                            $('.trthursday input[type="text"]').val("");
                        }
                    });
                    $(' .trfriday input[type="checkbox"]').change(function () {
                        if ($('.trfriday input[type="checkbox"]').is(':checked')) {
                            $('.trfriday').find('input[type="text"]').prop('disabled', false);
                        }
                        else {
                            $('.trfriday').find('input[type="text"]').prop('disabled', true);
                            $('.trfriday input[type="text"]').val("");
                        }
                    });
                    $(' .trsaturday input[type="checkbox"]').change(function () {
                        if ($('.trsaturday input[type="checkbox"]').is(':checked')) {
                            $('.trsaturday').find('input[type="text"]').prop('disabled', false);
                        }
                        else {
                            $('.trsaturday').find('input[type="text"]').prop('disabled', true);
                            $('.trsaturday input[type="text"]').val("");
                        }
                    });
                    $(' .trsunday input[type="checkbox"]').change(function () {
                        if ($('.trsunday input[type="checkbox"]').is(':checked')) {
                            $('.trsunday').find('input[type="text"]').prop('disabled', false);
                        }
                        else {
                            $('.trsunday').find('input[type="text"]').prop('disabled', true);
                            $('.trsunday input[type="text"]').val("");
                        }
                    });
                }

                function myTrim(x) {
                    return x.replace(/\s/g, '').replace('-', '');
                }
                function RegisterCheckboxClick() {
                    $('input:checkbox').on('change', function () {
                        ToggleEnablingDivOnCheckedChange($(this).prop('id'));
                    });
                }
                function DisabledEnabledCheckbox() {
                    ResetControls('#dvTier1', $('#<%=chkTierProgressActive1.ClientID%>')[0].checked);
                        ResetControls('#dvTier2', $('#<%=chkTierProgressActive2.ClientID%>')[0].checked);
                        ResetControls('#dvTier3', $('#<%=chkTierProgressActive3.ClientID%>')[0].checked);
                        ResetControls('#dvTier4', $('#<%=chkTierProgressActive4.ClientID%>')[0].checked);
                        ResetControls('#dvTier5', $('#<%=chkTierProgressActive5.ClientID%>')[0].checked);
                        ResetControls('#dvTier6', $('#<%=chkTierProgressActive6.ClientID%>')[0].checked);
                        ResetControls('#dvTier7', $('#<%=chkTierProgressActive7.ClientID%>')[0].checked);
                        ResetControls('#dvTier8', $('#<%=chkTierProgressActive8.ClientID%>')[0].checked);
                        ResetControls('#dvTier9', $('#<%=chkTierProgressActive9.ClientID%>')[0].checked);
                        ResetControls('#dvTier10', $('#<%=chkTierProgressActive10.ClientID%>')[0].checked);
                        ResetControls('#dvTier11', $('#<%=chkTierProgressActive11.ClientID%>')[0].checked);
                    ResetControls('#dvTier12', $('#<%=chkTierProgressActive12.ClientID%>')[0].checked);
                }
                function ToggleEnablingDivOnCheckedChange(controlId) {
                    var status = $('input:checkbox[id*="' + controlId + '"]').is(':checked');
                    switch (controlId) {
                        case '<%=chkTierProgressActive1.ClientID %>':
                                ResetControls('#dvTier1', status);
                                break;
                            case '<%=chkTierProgressActive2.ClientID %>':
                                ResetControls('#dvTier2', status);
                                break;
                            case '<%=chkTierProgressActive3.ClientID %>':
                                ResetControls('#dvTier3', status);
                                break;
                            case '<%=chkTierProgressActive4.ClientID %>':
                                ResetControls('#dvTier4', status);
                                break;
                            case '<%=chkTierProgressActive5.ClientID %>':
                                ResetControls('#dvTier5', status);
                                break;
                            case '<%=chkTierProgressActive6.ClientID %>':
                                ResetControls('#dvTier6', status);
                                break;
                            case '<%=chkTierProgressActive7.ClientID %>':
                                ResetControls('#dvTier7', status);
                                break;
                            case '<%=chkTierProgressActive8.ClientID %>':
                                ResetControls('#dvTier8', status);
                                break;
                            case '<%=chkTierProgressActive9.ClientID %>':
                                ResetControls('#dvTier9', status);
                                break;
                            case '<%=chkTierProgressActive10.ClientID %>':
                                ResetControls('#dvTier10', status);
                                break;
                            case '<%=chkTierProgressActive11.ClientID %>':
                                ResetControls('#dvTier11', status);
                                break;
                        case '<%=chkTierProgressActive12.ClientID %>':
                            ResetControls('#dvTier12', status);
                            break;
                    }
                }
                function ResetControls(divId, status) {

                    $(divId).find('input:text').prop('disabled', !status);
                    $(divId).find('input:checkbox').prop('disabled', !status);

                }

                function RegisterMyFevouriteSlotCheckbox() {

                    //Onpageload
                    if ($('#<%=chkAwardCreatingSlotFev.ClientID%>')[0].checked == false) {
                            $('#dvAwardCreatingSlotFev').find('input, select').prop('disabled', true);
                            $('#dvAwardCreatingSlotFev').prop('disabled', true);
                        }
                        else {
                            $('#dvAwardCreatingSlotFev').find('input, select').prop('disabled', false);
                            $('#dvAwardCreatingSlotFev').prop('disabled', false);
                        }

                        if ($('#<%=chkmyFavNotifyOutOfApp.ClientID%>')[0].checked == false) {
                            $('#dvmyFavNotifyOutOfApp').find('input, select').prop('disabled', true);
                            $('#dvmyFavNotifyOutOfApp').prop('disabled', true);
                        }
                        else {
                            $('#dvmyFavNotifyOutOfApp').find('input, select').prop('disabled', false);
                            $('#dvmyFavNotifyOutOfApp').prop('disabled', false);
                        }

                        if ($('#<%=chkmyFavUpdateSlotFav.ClientID%>')[0].checked == false) {
                            $('#dvmyFavUpdateSlotFav').find('input, select').prop('disabled', true);
                            $('#dvmyFavUpdateSlotFav').prop('disabled', true);
                        }
                        else {
                            $('#dvmyFavUpdateSlotFav').find('input, select').prop('disabled', false);
                            $('#dvmyFavUpdateSlotFav').prop('disabled', false);
                        }
                        if ($('#<%=chkmyFavAwardNotification.ClientID%>')[0].checked == false) {
                            $('#dvmyFavAwardNotification').find('input, select').prop('disabled', true);
                            $('#dvmyFavAwardNotification').prop('disabled', true);
                        }
                        else {
                            $('#dvmyFavAwardNotification').find('input, select').prop('disabled', false);
                            $('#dvmyFavAwardNotification').prop('disabled', false);
                        }

                        /// End Pageload
                        //Onchange
                        $('#<%=chkAwardCreatingSlotFev.ClientID%>').on('change', function () {
                            if ($('#<%=chkAwardCreatingSlotFev.ClientID%>')[0].checked == false) {
                                $('#dvAwardCreatingSlotFev').find('input, select').prop('disabled', true);
                                $('#dvAwardCreatingSlotFev').prop('disabled', true);
                            }
                            else {
                                $('#dvAwardCreatingSlotFev').find('input, select').prop('disabled', false);
                                $('#dvAwardCreatingSlotFev').prop('disabled', false);
                            }
                        });
                        $('#<%=chkmyFavNotifyOutOfApp.ClientID%>').on('change', function () {
                            if ($('#<%=chkmyFavNotifyOutOfApp.ClientID%>')[0].checked == false) {
                                $('#dvmyFavNotifyOutOfApp').find('input, select').prop('disabled', true);
                                $('#dvmyFavNotifyOutOfApp').prop('disabled', true);
                            }
                            else {
                                $('#dvmyFavNotifyOutOfApp').find('input, select').prop('disabled', false);
                                $('#dvmyFavNotifyOutOfApp').prop('disabled', false);
                            }
                        });
                        $('#<%=chkmyFavUpdateSlotFav.ClientID%>').on('change', function () {
                            if ($('#<%=chkmyFavUpdateSlotFav.ClientID%>')[0].checked == false) {
                                $('#dvmyFavUpdateSlotFav').find('input, select').prop('disabled', true);
                                $('#dvmyFavUpdateSlotFav').prop('disabled', true);
                            }
                            else {
                                $('#dvmyFavUpdateSlotFav').find('input, select').prop('disabled', false);
                                $('#dvmyFavUpdateSlotFav').prop('disabled', false);
                            }
                        });
                    $('#<%=chkmyFavAwardNotification.ClientID%>').on('change', function () {
                        if ($('#<%=chkmyFavAwardNotification.ClientID%>')[0].checked == false) {
                                $('#dvmyFavAwardNotification').find('input, select').prop('disabled', true);
                                $('#dvmyFavAwardNotification').prop('disabled', true);
                            }
                            else {
                                $('#dvmyFavAwardNotification').find('input, select').prop('disabled', false);
                                $('#dvmyFavAwardNotification').prop('disabled', false);
                            }
                        });

                    }
                    function CheckSortOrder(val, maxorder) {
                        var status = 0;
                        if (val == '1' && maxorder >= 1)
                            status = 1;
                        if (val == '2' && maxorder >= 2)
                            status = 1;
                        if (val == '3' && maxorder >= 3)
                            status = 1;
                        if (val == '4' && maxorder >= 4)
                            status = 1;
                        return status;
                    }

                    //////****************************End Common Function Part *************************************************************
            </script>



            <!-- Dialog show event handler -->
            <div style="text-align: center;">
                <asp:UpdateProgress ID="updateProgress" runat="server">
                    <ProgressTemplate>
                        <div style="position: fixed; text-align: center; height: 100%; width: 100%; top: 0; right: 0; left: 0; z-index: 9999999; background-color: #000000; opacity: 0.7;">
                            <asp:Image ID="imgUpdateProgress" runat="server" ImageUrl="Content/img/loader.gif" AlternateText="Loading ..." ToolTip="Loading ..." Style="padding: 10px; position: fixed; top: 45%; left: 50%;" />
                        </div>
                    </ProgressTemplate>
                </asp:UpdateProgress>
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
                            <asp:Button ID="btnConfirmedActive" CssClass="btn btn-danger" runat="server" Text="OK" UseSubmitBehavior="false" data-dismiss="modal" OnClick="lnkbtnActive_Click" Style="display: none;"></asp:Button>
                            <asp:Button ID="btnConfirmedInActive" CssClass="btn btn-danger" runat="server" Text="OK" UseSubmitBehavior="false" data-dismiss="modal" OnClick="lnkbtnInActive_Click" Style="display: none;"></asp:Button>
                            <asp:Button ID="btnConfirmedAll" CssClass="btn btn-danger" runat="server" Text="OK" UseSubmitBehavior="false" data-dismiss="modal" OnClick="lnkbtnAll_Click" Style="display: none;"></asp:Button>

                            <button type="button" class="btn" id="confirm" data-dismiss="modal">Cancel</button>
                        </div>
                    </div>
                </div>
            </div>
            </label>
            </label>
        </ContentTemplate>
    </asp:UpdatePanel>

</asp:Content>
