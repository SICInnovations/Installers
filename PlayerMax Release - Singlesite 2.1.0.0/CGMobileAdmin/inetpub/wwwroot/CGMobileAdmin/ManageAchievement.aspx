<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="ManageAchievement.aspx.cs" Inherits="HAMobileWebAdmin.ManageAchievement" ValidateRequest="false" %>

<%@ Register Src="~/UserControl/UC_CsvUpload_PopulationListTab_WithOutBarCodeID.ascx" TagPrefix="csv" TagName="UC_CsvUpload_PopulationListTab_WithOutBarCodeID" %>
<%@ Register Src="~/UserControl/UC_PopulationTypeTab.ascx" TagPrefix="listbox" TagName="UC_PopulationTypeTab" %>

<asp:Content runat="server" ID="Content1" ContentPlaceHolderID="HeadContent">
    <title>COG Mobile | Manage Achievement</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <link rel="stylesheet" href="Content/css/pick-a-color-1.2.3.min.css" />
    <script src="Scripts/CommonJS/tinycolor-0.9.15.min.js"></script>
    <script src="Scripts/CommonJS/pick-a-color-1.2.3.min.js"></script>
    <link rel="stylesheet" href="Content/css/perfect-scrollbar-0.4.10.min.css" />
    <script src="Scripts/CommonJS/perfect-scrollbar.js"></script>
    <script src="Scripts/CommonJS/datatables.min.js"></script>

    <asp:UpdatePanel ID="updpnlContentDetail" runat="server" UpdateMode="Conditional">
        <ContentTemplate>
            <div class="row">
                <div class="col-sm-3">
                    <h5>Achievements</h5>
                    <div class="filterWrapper relative" id="dvLeftcontentdetail">
                        <div class=" clearfix whiteBg">
                            <div class="pull-left">
                            </div>
                            <div class="pull-right">
                                <span class="addBtn">Add
                                    <asp:Button ID="lnkbtnAdd" runat="server" OnClick="lnkbtnAdd_Click" CssClass="btn btn-add pull-right"></asp:Button></span>

                            </div>
                        </div>
                        <div class="input-group clearfix col-sm-12">
                            <asp:TextBox CssClass="form-control height26" ID="txtSearch" runat="server"></asp:TextBox>
                            <span class="input-group-btn">
                                <asp:Button ID="btnSearch" runat="server" OnClick="btnSearch_Click" CssClass="btn btn-black glyphicons filter btn-icon white input-group-btnbtnmargin"></asp:Button>
                                <i></i>
                            </span>
                        </div>
                        <div class="new-select">
                            <asp:DropDownList runat="server" OnSelectedIndexChanged="ddlAchievementType_SelectedIndexChanged" ID="ddlAchievementType" AutoPostBack="true" CssClass="form-control jq-selectbox" onchange="RegisterAchievementTypeTab()">
                            </asp:DropDownList>
                        </div>
                        <div id="divgv">
                            <asp:GridView CssClass="gridview" ID="gvAchievements" runat="server" ShowHeader="False" AutoGenerateColumns="false" DataKeyNames="AchievementDetailID" AllowPaging="true" PageSize="15" OnPageIndexChanging="gvAchievements_PageIndexChanging">
                                <Columns>
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <asp:Label ID="lblID" runat="server" Visible="false" Text='<%#Eval("AchievementDetailID") %>' />
                                            <asp:LinkButton ID="lnkBtnShowContentDetail" runat="server" Text='<%#Eval("Name") %>' CommandName="Select" OnClick="lnkBtnShowAchievementDetail_Click" />

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
                    <h5>Achievement Detail</h5>
                    <asp:HiddenField runat="server" ID="hdnAchivementTypeID" Value="" />
                    <asp:HiddenField runat="server" ID="hdnAchievementDetailID" Value="" />
                    <asp:HiddenField runat="server" ID="hdnIsActive" Value="true" />
                    <asp:HiddenField runat="server" ID="hdnButtonSatus" Value="Active" />
                    <asp:HiddenField runat="server" ID="hdnGvAchievementsSelectedIndex" Value="0" />
                    <asp:HiddenField runat="server" ID="hdnIsPopulation" Value="True" />
                    <asp:HiddenField runat="server" ID="hdnIsShedule" Value="True" />
                    <asp:HiddenField runat="server" ID="hdnSelectedTab" Value="contentTab" />
                    <asp:HiddenField runat="server" ID="hdnFileID" Value="" />
                    <asp:HiddenField runat="server" ID="hdnGvScheduleSelectedIndex" Value="0" />
                    <asp:HiddenField runat="server" ID="hdnIsPermissionDelete" Value="1" />
                    <div class="row clearfix relative btnGroup btnGroup3 manage-content-right " id="dvRightContent">
                        <div class="col-md-12 clearfix">
                            <div class="tabControls">
                                <ul class="nav nav-tabs">
                                    <li class="active col-xsm-32 nav-tabs-content"><span class="linkDisabledsp">&nbsp;</span><a data-toggle="tab" href="#manageContentTabLink" id="manageContentTab" onclick="SetSelectedTab('contentTab')">Details</a></li>
                                    <li class="col-xsm-32  nav-tabs-schedule"><span class="linkDisabledsp">&nbsp;</span><a data-toggle="tab" href="#ScheduleTabLink" id="manageScheduleTab" onclick="SetSelectedTab('scheduleTab')">Schedule</a></li>
                                    <li class="col-xsm-32  nav-tabs-population"><span class="linkDisabledsp">&nbsp;</span><a data-toggle="tab" href="#PopulationTabLink" id="managePopulationTab" onclick="SetSelectedTab('populationTab')">Population</a></li>
                                </ul>
                                <div class="tab-pane">
                                    <div class="tab-content ">

                                        <!--Manage Content Tab Starts-->
                                        <div class="tab-pane active fade in tab-container" id="manageContentTabLink">
                                            <div id="dvHeader" style="display: none">
                                                <div class="col-md-12">
                                                    <div class="row">
                                                        <div class="col-md-12">
                                                            <asp:Label ID="lblAssetName" runat="server" CssClass="label">Achievement Name</asp:Label>
                                                            <asp:TextBox ID="txtAchievementName" CssClass="form-control" runat="server" MaxLength="250" />
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col-md-12">
                                                            <label for="contentItem">Achievement Description</label>
                                                            <asp:TextBox TextMode="MultiLine" CssClass="form-control" runat="server" ID="txtAchievementDescription" Height="150px" MaxLength="1000" Width="100%"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div id="dvLinkYourClubAccount" class="box" style="display: none">
                                                    <div class="tab-container-one  clearfix">
                                                        <div class="col-md-12">

                                                            <div class="row">
                                                                <div class="col-md-12">
                                                                </div>
                                                            </div>

                                                        </div>
                                                    </div>
                                                </div>

                                                <!--second option content starts here -->
                                                <div id="dvRaFReferNFriends" class="box" style="display: none">
                                                    <div class="tab-container-one  clearfix">
                                                        <div class="col-md-12">
                                                            <div class="row">
                                                                <div class="col-md-12">
                                                                    <label for="contentItem">Refer N Friends</label>
                                                                    <asp:TextBox ID="txtReferNFriends" CssClass="form-control numeric" runat="server" MaxLength="8" />
                                                                </div>
                                                            </div>

                                                        </div>
                                                    </div>
                                                </div>

                                                <!--second option content ends here -->

                                                <!--third option content starts here -->

                                                <div id="dvadPressionWatchNinAppVideos" class="box" style="display: none">
                                                    <div class="tab-container-one  clearfix">
                                                        <div class="col-md-12">

                                                            <div class="row">
                                                                <div class="col-md-12">
                                                                    <label for="contentItem">Watch N adPressions</label>
                                                                    <asp:TextBox ID="txtadPressionWatchNadPressions" CssClass="form-control numeric" runat="server" MaxLength="8" />
                                                                </div>
                                                            </div>

                                                        </div>
                                                    </div>

                                                </div>

                                                <!--third option content ends here -->

                                                <!--fourth option content starts here -->

                                                <div id="dvAppPointsEarnNPointsfromApp" class="box" style="display: none">
                                                    <div class="tab-container-one  clearfix">
                                                        <div class="col-md-12">

                                                            <div class="row">
                                                                <div class="col-md-12">
                                                                    <label for="contentItem">Earn N Points from App</label>
                                                                    <asp:TextBox ID="txtAppPointsEarnNPointsfromApp" MaxLength="8" CssClass="form-control numeric" runat="server" />
                                                                </div>
                                                            </div>

                                                        </div>
                                                    </div>

                                                </div>

                                                <!--fourth option content ends here -->

                                                <!--fifth option content starts here -->

                                                <div id="dvMostAppPointsEarnedinDefinedTimeframe" class="box" style="display: none">

                                                    <div class="tab-container-one  clearfix">
                                                        <div class="row">
                                                            <div class="clearfix col-md-4">
                                                                <div class="col-xs-3">
                                                                    <label for="adscheduleFrom" class="text-left">From</label>
                                                                </div>
                                                                <div class="col-xs-9 row">
                                                                    <div class="input-group date datePickers" data-date-format="mm/dd/yyyy">
                                                                        <asp:TextBox ID="txtMostAppPointsEarnedinDefinedTimeframefromdate" runat="server" class="form-control datePickers"></asp:TextBox>
                                                                        <span class="input-group-addon" id="Span1"><i class="icon-th"></i></span>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="clearfix col-md-4 row">
                                                                <div class="col-xs-2">
                                                                    <label for="adscheduleTo">To</label>
                                                                </div>
                                                                <div class="col-xs-9 row">
                                                                    <div class="input-group date datePickers" data-date-format="mm/dd/yyyy">
                                                                        <asp:TextBox ID="txtMostAppPointsEarnedinDefinedTimefrmetodate" runat="server" class="form-control datePickers"></asp:TextBox>
                                                                        <span class="input-group-addon" id="adscheduleFrom"><i class="icon-th"></i></span>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                        </div>
                                                    </div>

                                                </div>

                                                <!--fifth option content ends here -->
                                                <!--sixth option content starts here -->
                                                <div id="dvCasinoPlayandEarnatleastNTotalPointsinNDays" class="box" style="display: none">
                                                    <div class="tab-container-one  clearfix">
                                                        <div class="col-md-12">

                                                            <div class="row">
                                                                <div class="col-md-12">

                                                                    <label for="contentItem">Earn at least N Total Points</label>
                                                                    <asp:TextBox ID="txtCasinoEarnatleastNBasePoints" CssClass="form-control numericwithdecimal" runat="server" MaxLength="8" />
                                                                </div>
                                                            </div>
                                                            <div class="row">
                                                                <div class="col-md-12">
                                                                    <label for="contentItem">Within the Scheduled "From" and "To" Dates</label>
                                                                    <!-- nacupido 8-19-16 hide no of days   -->
                                                                    <asp:TextBox ID="txtCasinoWithinNofDays" CssClass="form-control numericwithdecimal" Visible="false" runat="server" MaxLength="8" />

                                                                </div>
                                                            </div>

                                                        </div>
                                                    </div>

                                                </div>
                                                <!--sixth option content ends here -->
                                                <!--seveth option content starts here -->
                                                <div id="dvCasinoHaveaTableorPokerratingofatleastNhours" class="box" style="display: none">
                                                    <div class="tab-container-one  clearfix">
                                                        <div class="col-md-12">

                                                            <div class="row">
                                                                <div class="col-md-12">
                                                                    <label for="contentItem">Have a Table or Poker rating of at least N hours</label>
                                                                    <asp:TextBox ID="txtCasinoHaveaTableorPokerratingofatleastNhours" CssClass="form-control numeric" runat="server" MaxLength="8" />
                                                                </div>
                                                            </div>

                                                        </div>
                                                    </div>

                                                </div>
                                                <!--seventh option content ends here -->
                                                <!--eigth option content starts here -->
                                                <div id="dvCasinoPlayBingoTableGamesorPokerNTimes" class="box" style="display: none">
                                                    <div class="tab-container-one  clearfix">
                                                        <div class="col-md-12">

                                                            <div class="row">
                                                                <div class="col-md-12">
                                                                    <label for="contentItem">Times Bingo Played</label>
                                                                    <asp:TextBox ID="txtCasinoTimesBingoPlayed" CssClass="form-control numeric" runat="server" MaxLength="8" />
                                                                </div>
                                                            </div>
                                                            <div class="row">

                                                                <div class="col-md-12">
                                                                    <label for="contentItem">Times Poker Played</label>
                                                                    <asp:TextBox ID="txtCasinoTimesPokerPlayed" CssClass="form-control numeric" runat="server" MaxLength="8" />
                                                                </div>
                                                            </div>
                                                            <div class="row">
                                                                <div class="col-md-12">
                                                                    <label for="contentItem">Times Table Games Played</label>
                                                                    <asp:TextBox ID="txtCasinoTimesTableGamesPlayed" CssClass="form-control numeric" runat="server" MaxLength="8" />
                                                                </div>
                                                            </div>


                                                        </div>

                                                    </div>
                                                </div>
                                                <!--eigth option content ends here -->
                                                <!--ninth option content starts here -->
                                                <div id="dvCasinoPlayACombinationOfUpToAny4DefinableStatTypesInASingleDay" class="box" style="display: none">
                                                    <div class="tab-container-one  clearfix">
                                                        <div class="col-md-12">

                                                            <%-- <div class="row">
                                                            <div class="col-md-12">
                                                                <label>Bingo - Buy In Value in Dollars</label>
                                                                <asp:TextBox ID="txtCasinoBingoBuyInValueinDollars1" runat="server" CssClass="form-control" runat="server" onkeypress="return isNumberWithDecimal(event)" MaxLength="15" />
                                                                <label for="<%=txtCasinoBingoBuyInValueinDollars1.ClientID %>" class="ache-des"></label>
                                                            </div>
                                                        </div>--%>

                                                            <div>
                                                                <label><b>Select at least two criteria below</b></label>
                                                            </div>
                                                            <div class="row">
                                                                <div class="col-md-8">
                                                                    <div class="col-md-6">
                                                                        <div class="row">
                                                                            <label>Bingo - Buy In Value in Dollars</label>
                                                                            <div class="pull-left">
                                                                                <asp:CheckBox ID="chckCasinoBingoBuyInValueinDollars" runat="server" />
                                                                                <label for="<%=chckCasinoBingoBuyInValueinDollars.ClientID %>" class="ache-des"></label>
                                                                            </div>
                                                                            <div class="pull-left" id="divCasinoBingoBuyInValueinDollars">
                                                                                <asp:TextBox ID="txtCasinoBingoBuyInValueinDollars" runat="server" CssClass="form-control numericwithdecimal" MaxLength="8" />
                                                                                <label for="<%=txtCasinoBingoBuyInValueinDollars.ClientID %>" class="ache-des"></label>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <div class="col-md-6">
                                                                        <label>Table Games - Minutes Played</label>
                                                                        <div class="pull-left">
                                                                            <asp:CheckBox ID="chckCasinoTableGamesMinutesPlayed" runat="server" />
                                                                            <label for="<%=chckCasinoTableGamesMinutesPlayed.ClientID %>" class="ache-des"></label>
                                                                        </div>
                                                                        <div class="pull-left" id="divCasinoTableGamesMinutesPlayed">
                                                                            <asp:TextBox ID="txtCasinoTableGamesMinutesPlayed" CssClass="form-control numeric" runat="server" MaxLength="8" />
                                                                            <label for="<%=txtCasinoTableGamesMinutesPlayed.ClientID %>" class="ache-des"></label>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="row">
                                                                <div class="col-md-8">
                                                                    <div class="col-md-6">
                                                                        <div class="row">
                                                                            <label>Poker - Minutes Played</label>
                                                                            <div class="pull-left">
                                                                                <asp:CheckBox ID="chckCasinoPokerMinutesPlayed" runat="server" />
                                                                                <label for="<%=chckCasinoPokerMinutesPlayed.ClientID %>" class="ache-des"></label>
                                                                            </div>
                                                                            <div class="pull-left" id="divCasinoPokerMinutesPlayed">
                                                                                <asp:TextBox ID="txtchckCasinoPokerMinutesPlayed" CssClass="form-control numeric" runat="server" MaxLength="8" />
                                                                                <label for="<%=txtchckCasinoPokerMinutesPlayed.ClientID %>" class="ache-des"></label>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <div class="col-md-6">
                                                                        <label>Slots - Base Points Earned</label>
                                                                        <div class="pull-left">
                                                                            <asp:CheckBox ID="checkCasinoSlotsBasePointsEarned" runat="server" />
                                                                            <label for="<%=checkCasinoSlotsBasePointsEarned.ClientID %>" class="ache-des"></label>
                                                                        </div>
                                                                        <div class="pull-left" id="divCasinoSlotsBasePointsEarned">
                                                                            <asp:TextBox ID="txtCasinoSlotsBasePointsEarned" CssClass="form-control numericwithdecimal" runat="server" MaxLength="8" />
                                                                            <label for="<%=txtCasinoSlotsBasePointsEarned.ClientID %>" class="ache-des"></label>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                        </div>
                                                    </div>

                                                </div>
                                                <!--ninth option content ends here -->
                                                <!--10th option content starts here -->
                                                <div id="dvAppEarnNAchievements" class="box" style="display: none">
                                                    <div class="tab-container-one  clearfix">
                                                        <div class="col-md-12">

                                                            <div class="row">
                                                                <div class="col-md-12">
                                                                    <label for="contentItem">Earn N Achievements</label>

                                                                    <asp:TextBox ID="txtEarnNAchievements" CssClass="form-control numeric" runat="server" MaxLength="8" />

                                                                </div>
                                                            </div>

                                                        </div>
                                                    </div>

                                                </div>
                                                <!--10th option content ends here -->
                                                <!--11th option content start here    App - Sign in and launch the App N Times-->
                                                <div id="dvAppSigninandLaunchtheAppNTimes" class="box" style="display: none">

                                                    <div class="tab-container-one  clearfix">
                                                        <div class="col-md-12">

                                                            <div class="row">
                                                                <div class="col-md-12">

                                                                    <label for="contentItem">Count of App Launches</label>
                                                                    <asp:TextBox ID="txtCountAppLauches" CssClass="form-control numericwithdecimal" runat="server" MaxLength="8" />
                                                                </div>
                                                            </div>

                                                        </div>
                                                    </div>

                                                </div>
                                                <!--11th option content ends here-->
                                                <!--12th option content start here   Casino- Play and Earn at least N Base points in a definable single session stat type-->
                                                <div id="dvCasinoPlayandEarnatleastNTotalPointsinaDefinableStatType" class="box" style="display: none">
                                                    <div class="tab-container-one  clearfix">
                                                        <div class="col-md-12">

                                                            <div class="row">
                                                                <div class="col-md-12">

                                                                    <label for="contentItem">Earn at least N Total Points</label>
                                                                    <asp:TextBox ID="txtEarnAtLeastNBasePoints" CssClass="form-control numericwithdecimal" runat="server" MaxLength="8" />
                                                                </div>
                                                            </div>
                                                            <div class="row">
                                                                <div class="col-md-12">
                                                                    <label for="contentItem">Stat Type</label>
                                                                    <asp:DropDownList runat="server" ID="ddlStatType" CssClass="form-control jq-selectbox">
                                                                        <asp:ListItem Value="1">Slot</asp:ListItem>
                                                                        <asp:ListItem Value="2">Bingo</asp:ListItem>
                                                                        <asp:ListItem Value="3">Table Games</asp:ListItem>
                                                                        <asp:ListItem Value="4">Poker</asp:ListItem>
                                                                        <%--<asp:ListItem Value="5">Online</asp:ListItem>--%>
                                                                    </asp:DropDownList>
                                                                </div>
                                                            </div>

                                                        </div>
                                                    </div>

                                                </div>
                                                <!--12th option content ends here-->

                                                <!--Footer Common Section -->

                                                <div id="dvFooterTab" class="badge-sec clearfix" style="display: none">

                                                    <div class="pull-left badge-segment col-sm-4  three-column">
                                                        <label>Achievement Badge Image<br />
                                                            (Upload Image 160*160 Pixels)</label>
                                                        <div class="badge-plce_holder">
                                                            <asp:Image ID="ImageShowImage" runat="server" ImageUrl="content/img/badge.png" />
                                                            <asp:HiddenField ID="hdnShowImage" runat="server" Value="content/img/badge.png" />
                                                            <input type="button" class="select-badge new-sec" value="Select Badge" />
                                                        </div>
                                                    </div>
                                                    <div class="pull-right badge-data col-sm-8  col-xs-12 clearfix">
                                                        <div class="row clearfix cleardiv">
                                                            <div class="pull-left" style="display: none">
                                                                <div><b>Award?</b></div>
                                                                <asp:CheckBox ID="chckAward" runat="server" Checked="true" />
                                                                <label for="<%=chckAward.ClientID%>" class="award"></label>
                                                            </div>
                                                            <div id="divAwardsAccountLink">
                                                                <div class="pull-right col-sm-10">
                                                                    <div class="row">
                                                                        <div class="col-md-12">
                                                                            <label for="contentItem">Award</label>
                                                                            <asp:DropDownList runat="server" ID="ddlAward" CssClass="form-control jq-selectbox">
                                                                            </asp:DropDownList>

                                                                        </div>
                                                                    </div>
                                                                    <div class="row">
                                                                        <div class="col-md-12">
                                                                            <label for="contentItem">Maximum Number of Awards</label>
                                                                            <asp:TextBox ID="txtMaximumNumberofAwards" MaxLength="5" CssClass="form-control numeric" runat="server" />
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="row">
                                                            <div class="pull-left">
                                                                <div><b>Notify?</b></div>
                                                                <asp:CheckBox ID="chkNotify" runat="server" Checked="true" />
                                                                <label for="<%=chkNotify.ClientID%>" class="award"></label>
                                                            </div>
                                                            <div class="pull-right col-sm-10" id="divNotifyAccountLink">
                                                                <div class="row">
                                                                    <div class="col-md-12">
                                                                        <label for="<%=txtAwardNotification.ClientID%>">Award Notification</label>
                                                                        <asp:TextBox ID="txtAwardNotification" CssClass="form-control" runat="server" MaxLength="250" />
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <%--   <div class="row progress-seg">
                                                        <div class="col-sm-3"><b class="progress-rate">Progress Bar Colors</b></div>
                                                        <div class="col-sm-3 color-defalut">
                                                            <label class="progress-tap">Background</label>
                                                            <asp:TextBox ID="txtBackground" runat="server" CssClass="pick-a-color form-control" />
                                                        </div>
                                                        <div class="col-sm-3 color-progress">
                                                            <label class="progress-tap">In Progress</label>
                                                            <asp:TextBox ID="txtInProgress" runat="server" CssClass="pick-a-color form-control" />
                                                        </div>
                                                        <div class="col-sm-3 color-complete">
                                                            <label class="progress-tap">Complete</label>
                                                            <asp:TextBox ID="txtComplete" runat="server" CssClass="pick-a-color form-control" />
                                                        </div>
                                                    </div>--%>
                                                    </div>
                                                </div>

                                                <!--Footer Common Section -->
                                            </div>

                                            <div id="dvImageDetail" class="tab-container-two  clearfix" style="display: none">
                                                <div class="col-md-12">
                                                    <div class="badge-sec  inner-badge-sec  clearfix">
                                                        <div class="pull-left badge-segment col-sm-3">
                                                            <label>Achievement Badge Image
                                                                <br />
                                                                (Upload Image 160x160 Pixels)</label>
                                                            <div class="badge-plce_holder ">
                                                                <asp:Image ID="ImageShowImageOk" runat="server" ImageUrl="content/img/badge.png" />
                                                                <input type="button" class="select-badge ok_button" value="OK" />
                                                            </div>
                                                        </div>
                                                        <div class="pull-right badge-data col-sm-9">
                                                            <div><b>Achievement Badge Inventory</b></div>
                                                            <div class="warning">
                                                                <p>
                                                                    Click an image below to preview the full size Badge at left.<br />
                                                                    Badges with a Check symbol have already been assigned to an Achievement.
                                                                </p>
                                                            </div>
                                                            <div class="img-plc-holder">
                                                                <ul class="clearfix col-md-12">

                                                                    <asp:DataList ID="dlAchievementBadgeImage" runat="server" RepeatColumns="3" RepeatLayout="Table" CssClass="BadgeImageHeight img_plc_tbale">
                                                                        <ItemTemplate>
                                                                            <%#(Convert.ToInt64(DataBinder.Eval(Container, "DataItem.fileIdInAchievement")) > 0 ? "<li class=\"selected-img\">" : "<li>")%>
                                                                            <div class="singleIcon">
                                                                                <%#(DataBinder.Eval(Container, "DataItem.FileContent") !=null?"<a href=javascript:void(0);>":"")%>
                                                                                <asp:HiddenField runat="server" ID="hdnFileID" Value='<%#Eval("FileID") %>' />
                                                                                <asp:Image ID="Image1" ImageUrl='<%#(DataBinder.Eval(Container, "DataItem.FileContent") !=null? string.Format("data:image/jpeg;base64,{0}", Convert.ToBase64String((byte[])Eval( ("FileContent") ))):null) %>' alt="icon" runat="server" />

                                                                                <%#(DataBinder.Eval(Container, "DataItem.FileContent") !=null?"</a>":"")%>
                                                                            </div>

                                                                            </li>

                                                                        </ItemTemplate>
                                                                    </asp:DataList>

                                                                </ul>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <!--Content Tab Ends-->

                                        <!--Schedule Tab Starts-->
                                        <div class="tab-pane fade" id="manageScheduleTabLink">
                                            <asp:Panel runat="server" ID="pnlSchedule">
                                                <div class=" clearfix tab-container">
                                                    <div class="col-md-4">
                                                        <div class="clearfix whiteBg">
                                                            <div class="pull-left">
                                                                <label>Schedule</label>
                                                            </div>
                                                            <div class="pull-right">
                                                                <span class="addBtn">Add
                                    <asp:Button ID="lnkbtnAddSchedule" runat="server" OnClick="btnAddSchedule_Click" CssClass="btn btn-add pull-right input-group-shedulebtnbtnmargin"></asp:Button>
                                                                </span>
                                                            </div>
                                                        </div>
                                                        <div class="input-group">
                                                            <asp:TextBox runat="server" ID="txtScheduleSearch" CssClass="form-control height26" />
                                                            <span class="input-group-btn">
                                                                <asp:Button ID="btnSearchSchedule" OnClick="btnContentScheduleSearch_OnClick" CssClass="btn btn-black glyphicons filter btn-icon white filtericonwidth" runat="server" /><i></i>
                                                            </span>
                                                        </div>
                                                        <div class="filterWrapper filterWrapper2 relative schedulegridheight">
                                                            <div>
                                                                <div id="div57">
                                                                    <asp:GridView CssClass="gridview" ID="gvSchedules" OnPageIndexChanging="gvSchedule_PageIndexChanging" DataKeyNames="AchievementScheduleID" runat="server" ShowHeader="False" AutoGenerateColumns="false"
                                                                        AllowPaging="true" PageSize="12">
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
                                                                    <div id="Div58"></div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-8">
                                                        <label for="adscheduleName">Schedule Name</label>
                                                        <asp:TextBox ID="txtScheduleName" runat="server" CssClass="form-control" MaxLength="250"></asp:TextBox>
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
                                                                                <span class="input-group-addon" id="Span1"><i class="icon-th"></i></span>
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
                                                                                <span class="input-group-addon" id="adscheduleFrom"><i class="icon-th"></i></span>
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
                                                                            <div class="bootstrap-timepicker input-group">
                                                                                <asp:TextBox ID="txtScheduleFromAt" runat="server" class="form-control timePickers"></asp:TextBox>
                                                                                <i class="icon-time"></i>
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
                                                                <div class="col-xs-12 clearfix">
                                                                    <div class="col-xs-12">
                                                                        <asp:RadioButton runat="server" Text="Active Across Event Window" ID="rdbAccessAcrossEventWindow" Visible="false" Checked="True" GroupName="adactiveWindow" />
                                                                    </div>
                                                                </div>
                                                                <div class="col-xs-12 clearfix">
                                                                    <div class="col-xs-12">
                                                                        <asp:RadioButton runat="server" Text="Active Within Event Window" ID="rdbAccessWithinEventWindow" Visible="false" GroupName="adactiveWindow" />
                                                                    </div>
                                                                </div>
                                                            </fieldset>
                                                        </div>
                                                        <div class="fieldset nomargin">
                                                            <div>
                                                                <div>
                                                                    <asp:CheckBox Text="Schedule by Day of Week" ID="chkScheduleByDayOfWeek" Visible="false" runat="server" />
                                                                    <%--<input type="checkbox" class="control" id="adscheduleByDay"><label class="controlLabel" for="adscheduleByDay">Schedule by Day of Week</label>--%>
                                                                </div>
                                                                <table hidden="hidden" class="table scheduleTable fieldSwitch">
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
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <asp:HiddenField runat="server" ID="hdnScheduleId" Value="0" />
                                            </asp:Panel>
                                        </div>
                                        <!--Schedule Tab Ends-->

                                        <!--Population Tab Starts-->
                                        <div class="tab-pane fade" id="managePopulationTabLink">
                                            <div class="tabbable tabs-left">
                                                <ul class="nav nav-tabs">
                                                    <li class="col-xsm-2 active nav-tabs-population" id="liTiers"><a data-toggle="tab" href="#PopulationTiersTab" onclick="SetSelectedTab('populationTiersTab')">Tiers</a></li>
                                                    <li class="col-xsm-2 list" id="liList"><a data-toggle="tab" href="#PopulationListTab" onclick="SetSelectedTab('populationListTab')">List</a></li>
                                                </ul>
                                                <div class="tab-content">

                                                    <!-- Population Tiers Tab Starts-->
                                                    <div class="tab-pane fade in active nav-tabs-population" id="PopulationTiersTab">
                                                        <listbox:UC_PopulationTypeTab runat="server" ID="UC_PopulationTypeTab" />
                                                    </div>
                                                    <!--adPression Population Tiers Tab Ends-->

                                                    <!--adPression Population List Tab Starts-->
                                                    <div class="tab-pane fade" id="PopulationListTab">
                                                        <csv:UC_CsvUpload_PopulationListTab_WithOutBarCodeID runat="server" ID="UC_CsvUpload_PopulationListTab_WithOutBarCodeID" />
                                                    </div>
                                                    <!-- Population List Tab Ends-->
                                                </div>
                                            </div>
                                        </div>
                                        <!-- Population Tab Ends-->

                                    </div>
                                </div>
                            </div>
                            <div class="col-md-12 btnGroup2">
                                <div class="btn-groupSpecial clearfix">
                                    <asp:Button ID="lnkbtnSave" OnClientClick=" return FormValidation();" runat="server" Text="Save" OnClick="lnkbtnSave_Click" CssClass="results-control col-xsm-32"></asp:Button>
                                    <asp:Button ID="lnkbtnCancel" runat="server" OnClientClick="return ConfirmMessage(2);" Text="Cancel" OnClick="lnkbtnCancel_Click" CssClass="results-control col-xsm-32"></asp:Button>
                                    <asp:Button ID="lnkbtnDelete" data-toggle="modal" data-target="#Achivement_alert" runat="server" Text="Delete" OnClick="lnkbtnDelete_Click" CssClass="results-control col-xsm-32"></asp:Button>

                                </div>
                            </div>
                        </div>

                    </div>
                </div>
            </div>
            <script type="text/javascript">

                //***************************************Start On UpdatePanel Refresh Register ImageUpload/Common Functions ********************************************************8

                var prm = Sys.WebForms.PageRequestManager.getInstance();
                if (prm != null) {
                    prm.add_endRequest(function (sender, e) {
                        if (sender._postBackSettings.panelsToUpdate != null) {

                            RegisterAchievementTypeTab();
                            RegisterTab();
                            RegisterGetImage();
                            DisabledEnabledCheckbox();
                            RegisterLeftDivheight();
                            RegisterCheckboxClick();
                            isNumber();
                            isNumberWithDecimal();
                            RegisterAchievementImageScrollDiv();
                            RegisterDateAndTimePickers();
                            RegisterDisabledTypeListBox();
                            SetDefaultTab();
                            SetActiveTab();
                            RegisterFieldSets();
                            RegisterDetectedFormChanges();

                        }
                    });
                };

                ///**************************************End On UpdatePanel Refresh Register ImageUpload/Common Functions******************************************
                ////*************************************************Start Page load functionality.***********************************

                $(document).ready(function () {
                    RegisterAhievementTypeDropDownZeroIndex();
                    RegisterAchievementTypeTab();
                    RegisterTab();
                    RegisterGetImage();
                    DisabledEnabledCheckbox();
                    RegisterLeftDivheight();
                    RegisterCheckboxClick();
                    isNumber();
                    isNumberWithDecimal();
                    RegisterAchievementImageScrollDiv();
                    RegisterDateAndTimePickers();
                    RegisterDisabledTypeListBox();
                    SetDefaultTab();
                    SetActiveTab();
                    RegisterFieldSets();
                    RegisterDetectedFormChanges();

                });
                //Page refresh set AchievementType index.
                function RegisterAhievementTypeDropDownZeroIndex() {
                    if (document.getElementById('<%=ddlAchievementType.ClientID%>') != null) {
                        document.getElementById('<%=ddlAchievementType.ClientID%>').selectedIndex = 0;
                    }
                }

                function SetDefaultTab() {
                    $('.nav-tabs li').removeClass('active');
                    $('.nav-tabs li.nav-tabs-content').addClass('active');
                    $('.tab-content .tab-pane').removeClass('active in');
                    $('#manageContentTabLink').addClass('active in');

                }
                function RegisterAchievementTypeTab() {

                    var achievementTypeId = $('#<%=ddlAchievementType.ClientID%>').val();
                    $('.box').hide();
                    $('#dvImageDetail').hide();
                    $('#dvFooterTab').hide();
                    $('#dvHeader').hide();
                    switch (achievementTypeId) {

                        case AchievementTypeConstants.LinkYourClubAccount:
                            $('#dvHeader').show();
                            $('#dvImageDetail').show();
                            $('#dvFooterTab').show();
                            $('#dvLinkYourClubAccount').fadeIn(800, function () {
                                $('#manageScheduleTabLink, #managePopulationTabLink').parent().removeClass('linkDisabled');
                                if (document.getElementById('<%=hdnIsPopulation.ClientID%>').value == 'False')
                                    $('#managePopulationTabLink').parent().addClass('linkDisabled');
                                if (document.getElementById('<%=hdnIsShedule.ClientID%>').value == 'False')
                                    $('#manageScheduleTabLink').parent().addClass('linkDisabled');
                            });

                            break;
                        case AchievementTypeConstants.RaFReferNFriends:
                            $('#dvHeader').show();
                            $('#dvImageDetail').show();
                            $('#dvFooterTab').show();
                            $('#dvRaFReferNFriends').fadeIn(800, function () {
                                $('#manageScheduleTabLink, #managePopulationTabLink').parent().removeClass('linkDisabled');
                                if (document.getElementById('<%=hdnIsPopulation.ClientID%>').value == 'False')
                                    $('#managePopulationTabLink').parent().addClass('linkDisabled');
                                if (document.getElementById('<%=hdnIsShedule.ClientID%>').value == 'False')
                                    $('#manageScheduleTabLink').parent().addClass('linkDisabled');
                            });
                            break;
                        case AchievementTypeConstants.adPressionWatchNinAppVideos:
                            $('#dvHeader').show();
                            $('#dvImageDetail').show();
                            $('#dvFooterTab').show();
                            $('#dvadPressionWatchNinAppVideos').fadeIn(800, function () {
                                $('#manageScheduleTabLink, #managePopulationTabLink').parent().removeClass('linkDisabled');
                                if (document.getElementById('<%=hdnIsPopulation.ClientID%>').value == 'False')
                                    $('#managePopulationTabLink').parent().addClass('linkDisabled');
                                if (document.getElementById('<%=hdnIsShedule.ClientID%>').value == 'False')
                                    $('#manageScheduleTabLink').parent().addClass('linkDisabled');

                            });
                            break;
                        case AchievementTypeConstants.AppPointsEarnNPointsfromApp:
                            $('#dvHeader').show();
                            $('#dvImageDetail').show();
                            $('#dvFooterTab').show();
                            $('#dvAppPointsEarnNPointsfromApp').fadeIn(800, function () {
                                $('#manageScheduleTabLink, #managePopulationTabLink').parent().removeClass('linkDisabled');
                                if (document.getElementById('<%=hdnIsPopulation.ClientID%>').value == 'False')
                                    $('#managePopulationTabLink').parent().addClass('linkDisabled');
                                if (document.getElementById('<%=hdnIsShedule.ClientID%>').value == 'False')
                                    $('#manageScheduleTabLink').parent().addClass('linkDisabled');
                            });
                            break;
                        case AchievementTypeConstants.MostAppPointsEarnedinDefinedTimeframe:
                            $('#dvHeader').show();
                            $('#dvImageDetail').show();
                            $('#dvFooterTab').show();
                            $('#dvMostAppPointsEarnedinDefinedTimeframe').fadeIn(800, function () {
                                $('#manageScheduleTabLink, #managePopulationTabLink').parent().removeClass('linkDisabled');
                                if (document.getElementById('<%=hdnIsPopulation.ClientID%>').value == 'False')
                                    $('#managePopulationTabLink').parent().addClass('linkDisabled');
                                if (document.getElementById('<%=hdnIsShedule.ClientID%>').value == 'False')
                                    $('#manageScheduleTabLink').parent().addClass('linkDisabled');

                            });
                            break;
                        case AchievementTypeConstants.CasinoPlayandEarnatleastNTotalPointsinNDays:
                            $('#dvHeader').show();
                            $('#dvImageDetail').show();
                            $('#dvFooterTab').show();
                            $('#dvCasinoPlayandEarnatleastNTotalPointsinNDays').fadeIn(800, function () {
                                $('#manageScheduleTabLink, #managePopulationTabLink').parent().removeClass('linkDisabled');
                                if (document.getElementById('<%=hdnIsPopulation.ClientID%>').value == 'False')
                                    $('#managePopulationTabLink').parent().addClass('linkDisabled');
                                if (document.getElementById('<%=hdnIsShedule.ClientID%>').value == 'False')
                                    $('#manageScheduleTabLink').parent().addClass('linkDisabled');

                            });
                            break;

                        case AchievementTypeConstants.CasinoPlayandEarnatleastNTotalPointsinaDefinableStatType:
                            $('#dvHeader').show();
                            $('#dvImageDetail').show();
                            $('#dvFooterTab').show();
                            $('#dvCasinoPlayandEarnatleastNTotalPointsinaDefinableStatType').fadeIn(800, function () {
                                $('#manageScheduleTabLink, #managePopulationTabLink').parent().removeClass('linkDisabled');
                                if (document.getElementById('<%=hdnIsPopulation.ClientID%>').value == 'False')
                                    $('#managePopulationTabLink').parent().addClass('linkDisabled');
                                if (document.getElementById('<%=hdnIsShedule.ClientID%>').value == 'False')
                                    $('#manageScheduleTabLink').parent().addClass('linkDisabled');

                            });
                            break;

                        case AchievementTypeConstants.CasinoHaveaTableorPokerratingofatleastNhours:
                            $('#dvHeader').show();
                            $('#dvImageDetail').show();
                            $('#dvFooterTab').show();
                            $('#dvCasinoHaveaTableorPokerratingofatleastNhours').fadeIn(800, function () {
                                $('#manageScheduleTabLink, #managePopulationTabLink').parent().removeClass('linkDisabled');
                                if (document.getElementById('<%=hdnIsPopulation.ClientID%>').value == 'False')
                                    $('#managePopulationTabLink').parent().addClass('linkDisabled');
                                if (document.getElementById('<%=hdnIsShedule.ClientID%>').value == 'False')
                                    $('#manageScheduleTabLink').parent().addClass('linkDisabled');

                            });
                            break;
                        case AchievementTypeConstants.CasinoPlayBingoTableGamesorPokerNTimes:
                            $('#dvHeader').show();
                            $('#dvImageDetail').show();
                            $('#dvFooterTab').show();
                            $('#dvCasinoPlayBingoTableGamesorPokerNTimes').fadeIn(800, function () {
                                $('#manageScheduleTabLink, #managePopulationTabLink').parent().removeClass('linkDisabled');
                                if (document.getElementById('<%=hdnIsPopulation.ClientID%>').value == 'False')
                                    $('#managePopulationTabLink').parent().addClass('linkDisabled');
                                if (document.getElementById('<%=hdnIsShedule.ClientID%>').value == 'False')
                                    $('#manageScheduleTabLink').parent().addClass('linkDisabled');
                            });
                            break;
                        case AchievementTypeConstants.AppEarnNAchievements:
                            $('#dvHeader').show();
                            $('#dvImageDetail').show();
                            $('#dvFooterTab').show();
                            $('#dvAppEarnNAchievements').fadeIn(800, function () {
                                $('#manageScheduleTabLink, #managePopulationTabLink').parent().removeClass('linkDisabled');
                                if (document.getElementById('<%=hdnIsPopulation.ClientID%>').value == 'False')
                                    $('#managePopulationTabLink').parent().addClass('linkDisabled');
                                if (document.getElementById('<%=hdnIsShedule.ClientID%>').value == 'False')
                                    $('#manageScheduleTabLink').parent().addClass('linkDisabled');

                            });
                            break;

                        case AchievementTypeConstants.AppSigninandLaunchtheAppNTimes:
                            $('#dvHeader').show();
                            $('#dvImageDetail').show();
                            $('#dvFooterTab').show();
                            $('#dvAppSigninandLaunchtheAppNTimes').fadeIn(800, function () {
                                $('#manageScheduleTabLink, #managePopulationTabLink').parent().removeClass('linkDisabled');
                                if (document.getElementById('<%=hdnIsPopulation.ClientID%>').value == 'False')
                                    $('#managePopulationTabLink').parent().addClass('linkDisabled');
                                if (document.getElementById('<%=hdnIsShedule.ClientID%>').value == 'False')
                                    $('#manageScheduleTabLink').parent().addClass('linkDisabled');

                            });
                            break;

                        case AchievementTypeConstants.CasinoPlayaCombinationofuptoany4DefinableStatTypesinaSingleDay:
                            $('#dvHeader').show();
                            $('#dvImageDetail').show();
                            $('#dvFooterTab').show();
                            $('#dvCasinoPlayACombinationOfUpToAny4DefinableStatTypesInASingleDay').fadeIn(800, function () {
                                $('#manageScheduleTabLink, #managePopulationTabLink').parent().removeClass('linkDisabled');
                                if (document.getElementById('<%=hdnIsPopulation.ClientID%>').value == 'False')
                                    $('#managePopulationTabLink').parent().addClass('linkDisabled');
                                if (document.getElementById('<%=hdnIsShedule.ClientID%>').value == 'False')
                                    $('#manageScheduleTabLink').parent().addClass('linkDisabled');

                            });
                            break;
                    }
                    RegisterLeftDivheight();
                }
                function DisabledEnabledCheckbox() {
                    var isAward = $('#<%=chckAward.ClientID%>')[0].checked;
                    var isNotify = $('#<%=chkNotify.ClientID%>')[0].checked;
                    var isCasinoBingoBuyInValueinDollars = $('#<%=chckCasinoBingoBuyInValueinDollars.ClientID%>')[0].checked;
                    var isCasinoTableGamesMinutesPlayed = $('#<%=chckCasinoTableGamesMinutesPlayed.ClientID%>')[0].checked;
                    var isCasinoPokerMinutesPlayed = $('#<%=chckCasinoPokerMinutesPlayed.ClientID%>')[0].checked;
                    var isCasinoSlotsBasePointsEarned = $('#<%=checkCasinoSlotsBasePointsEarned.ClientID%>')[0].checked;
                    ResetControls('#divAwardsAccountLink', isAward);
                    ResetControls('#divNotifyAccountLink', isNotify);
                    ResetControls('#divCasinoBingoBuyInValueinDollars', isCasinoBingoBuyInValueinDollars);
                    ResetControls('#divCasinoTableGamesMinutesPlayed', isCasinoTableGamesMinutesPlayed);
                    ResetControls('#divCasinoPokerMinutesPlayed', isCasinoPokerMinutesPlayed);
                    ResetControls('#divCasinoSlotsBasePointsEarned', isCasinoSlotsBasePointsEarned);
                }

                function ToggleEnablingDivOnCheckedChange(controlId) {
                    var status = $('input:checkbox[id*="' + controlId + '"]').is(':checked');
                    switch (controlId) {

                        case '<%=chckAward.ClientID %>':
                            ResetControls('#divAwardsAccountLink', status);
                            break;
                        case '<%=chkNotify.ClientID %>':
                            ResetControls('#divNotifyAccountLink', status);
                            break;
                        case '<%=chckCasinoBingoBuyInValueinDollars.ClientID %>':
                            ResetControls('#divCasinoBingoBuyInValueinDollars', status);
                            break;
                        case '<%=chckCasinoTableGamesMinutesPlayed.ClientID %>':
                            ResetControls('#divCasinoTableGamesMinutesPlayed', status);
                            break;
                        case '<%=chckCasinoPokerMinutesPlayed.ClientID %>':
                            ResetControls('#divCasinoPokerMinutesPlayed', status);
                            break;
                        case '<%=checkCasinoSlotsBasePointsEarned.ClientID %>':
                            ResetControls('#divCasinoSlotsBasePointsEarned', status);
                            break;

                    }
                }
                function RegisterCheckboxClick() {
                    $('input:checkbox').on('change', function () {
                        ToggleEnablingDivOnCheckedChange($(this).prop('id'));

                    });
                }
                function ResetControls(divId, status) {
                    //if ($('input:hidden[id*="hdnAchievementDetailID"]').val() == '') {
                    //    $(divId).find('input:text').val("");
                    $(divId).find('input:checkbox').removeAttr('checked');
                    //}

                    $(divId).find('input:text,select').prop('disabled', !status);
                    $(divId).find('input:checkbox').prop('disabled', !status);

                }
                //Set Left content height.
                function RegisterLeftDivheight() {
                    $("#dvLeftcontentdetail").height($('#dvRightContent').height());

                }
                function RegisterTab() {

                    $(".tab-container-two").hide();
                    $(".new-sec").click(function () {
                        $(".tab-container-one").hide();
                        $(".tab-container-two").show();
                        $(".badge-sec").hide();
                        $(".inner-badge-sec").show();
                        $("#dvHeader").hide();
                        RegisterLeftDivheight();

                    });
                    $(".ok_button").click(function () {
                        $(".tab-container-two").hide();
                        $(".tab-container-one").show();
                        $(".badge-sec").show();
                        $(".inner-badge-sec").hide();
                        $("#dvHeader").show();
                        RegisterLeftDivheight();

                    });

                }

                function FormValidation() {
                    var activeTab = $('input:hidden[id*="hdnSelectedTab"]').val();
                    var achievementTypeID = $('#<%=ddlAchievementType.ClientID%> option:selected').val();
                    if (myTrim(document.getElementById('<%=txtAchievementName.ClientID%>').value) == '') {
                        document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please enter achievement name';
                        $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                        document.getElementById('<%=txtAchievementName.ClientID%>').focus();
                        return false;
                    }
                    if (document.getElementById('<%=txtMostAppPointsEarnedinDefinedTimefrmetodate.ClientID%>').value != '' && document.getElementById('<%=txtMostAppPointsEarnedinDefinedTimeframefromdate.ClientID%>').value != '' && achievementTypeID == 5) {
                        if (Date.parse(document.getElementById('<%=txtMostAppPointsEarnedinDefinedTimefrmetodate.ClientID%>').value) < Date.parse(document.getElementById('<%=txtMostAppPointsEarnedinDefinedTimeframefromdate.ClientID%>').value)) {
                            document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Invalid Date Range!\nFrom Date cannot be after To Date!';
                            $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                            document.getElementById('<%=txtScheduleTo.ClientID%>').focus();
                            return false;
                        }
                    }
                    if ($('#<%=chckCasinoBingoBuyInValueinDollars.ClientID%>')[0].checked == true) {
                        if ($('#<%=txtCasinoBingoBuyInValueinDollars.ClientID%>').val() == '') {
                            document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please enter bingo - buy in value in dollars';
                            $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                            document.getElementById('<%=txtCasinoBingoBuyInValueinDollars.ClientID%>').focus();
                            return false;
                        }
                    }
                    if ($('#<%=chckCasinoTableGamesMinutesPlayed.ClientID%>')[0].checked == true) {
                        if ($('#<%=txtCasinoTableGamesMinutesPlayed.ClientID%>').val() == '') {
                            document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please enter table games - minutes played';
                            $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                            document.getElementById('<%=txtCasinoTableGamesMinutesPlayed.ClientID%>').focus();
                            return false;
                        }
                    }
                    if ($('#<%=chckCasinoPokerMinutesPlayed.ClientID%>')[0].checked == true) {
                        if ($('#<%=txtchckCasinoPokerMinutesPlayed.ClientID%>').val() == '') {
                            document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please enter poker - minutes played';
                            $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                            document.getElementById('<%=txtchckCasinoPokerMinutesPlayed.ClientID%>').focus();
                            return false;
                        }
                    }
                    if ($('#<%=checkCasinoSlotsBasePointsEarned.ClientID%>')[0].checked == true) {
                        if ($('#<%=txtCasinoSlotsBasePointsEarned.ClientID%>').val() == '') {
                            document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please enter slots - base points earned';
                            $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                            document.getElementById('<%=txtCasinoSlotsBasePointsEarned.ClientID%>').focus();
                            return false;
                        }
                    }
                    if ($('#<%=chckAward.ClientID%>')[0].checked == true) {
                        if ($('#<%=ddlAward.ClientID%> option:selected').val() == '-1') {
                            document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please select award';
                            $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                            document.getElementById('<%=ddlAward.ClientID%>').focus();
                            return false;
                        }
                        if ($('#<%=txtMaximumNumberofAwards.ClientID%>').val() == '') {
                            document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please enter maximum number of awards';
                            $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                            document.getElementById('<%=txtMaximumNumberofAwards.ClientID%>').focus();
                              return false;
                          }                        
                    }
                    if ($('#<%=chkNotify.ClientID%>')[0].checked == true) {
                        if (myTrim($('#<%=txtAwardNotification.ClientID%>').val()) == '') {
                            document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please enter award notification';
                            $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                            document.getElementById('<%=txtAwardNotification.ClientID%>').focus();
                            return false;
                        }
                    }
                    //Schedule
                    if (myTrim(document.getElementById('<%=txtScheduleName.ClientID%>').value) != '' || activeTab == 'scheduleTab') {
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
            function SetSelectedTab(selectedTab) {
                var selected = selectedTab;
                $('#<%=hdnSelectedTab.ClientID%>').val(selectedTab);
                    SetActiveTab();
                }
                function SetActiveTab() {
                    var activeTab = $('input:hidden[id*="hdnSelectedTab"]').val();
                    var isTab = $("#<%=hdnButtonSatus.ClientID %>").val();
                    var rowscount = $("#<%=gvAchievements.ClientID %> tr").length;
                    var isPermissionDelete = $("#<%=hdnIsPermissionDelete.ClientID %>").val();
                    switch (activeTab) {
                        case 'contentTab':
                            $('.nav-tabs li').removeClass('active');
                            $('.nav-tabs li.nav-tabs-content').addClass('active');
                            $('.tab-content .tab-pane').removeClass('active in');
                            $('#manageContentTabLink').addClass('active in');

                            if (isTab == "InActive" || isTab == "All") {
                                $("#<%=lnkbtnDelete.ClientID %>").addClass('aspNetDisabled');
                                $("#<%=lnkbtnDelete.ClientID %>").addClass('disabled');
                            }
                            else {
                                if (rowscount > 0 && isPermissionDelete == 1) {
                                    $("#<%=lnkbtnDelete.ClientID %>").removeClass('aspNetDisabled');
                                    $("#<%=lnkbtnDelete.ClientID %>").removeAttr("disabled");
                                }
                            }
                            break;
                        case 'scheduleTab':

                            $('.nav-tabs li').removeClass('active');
                            $('.nav-tabs li.nav-tabs-schedule').addClass('active');
                            $('.tab-content .tab-pane').removeClass('active in');
                            $('#manageScheduleTabLink').addClass('active in');
                            $("#<%=lnkbtnDelete.ClientID %>").addClass('aspNetDisabled');
                            $("#<%=lnkbtnDelete.ClientID %>").attr("disabled", $("#<%=lnkbtnDelete.ClientID %>"));
                            break;
                        case 'populationTab':
                            $('.nav-tabs li').removeClass('active');
                            $('.nav-tabs li.nav-tabs-population').addClass('active');
                            $('.tab-content .tab-pane').removeClass('active in');
                            $('div#PopulationListTab').removeClass('active');
                            $('div#PopulationTiersTab').addClass('active in');
                            $('div#managePopulationTabLink').addClass('active in');
                            $("#<%=lnkbtnDelete.ClientID %>").addClass('aspNetDisabled');
                            $("#<%=lnkbtnDelete.ClientID %>").attr("disabled", $("#<%=lnkbtnDelete.ClientID %>"));

                            break;
                        case 'populationTiersTab':
                            $('.nav-tabs li').removeClass('active');
                            $('.nav-tabs li.nav-tabs-population').addClass('active in');
                            $('.tab-content .tab-pane').removeClass('active in');
                            $('div#PopulationListTab').removeClass('active');
                            $('div#PopulationTiersTab').addClass('active in');
                            $('div#managePopulationTabLink').addClass('active in');
                            $('li#liTiers').addClass('active in');
                            $('li#liList').removeClass('active in');
                            $("#<%=lnkbtnDelete.ClientID %>").addClass('aspNetDisabled');
                            $("#<%=lnkbtnDelete.ClientID %>").attr("disabled", $("#<%=lnkbtnDelete.ClientID %>"));
                            break;
                        case 'populationListTab':
                            $('.nav-tabs li').removeClass('active');
                            $('.nav-tabs li.nav-tabs-population').addClass('active');
                            $('.tab-content .tab-pane').removeClass('active in');
                            $('div#PopulationTiersTab').removeClass('active');
                            $('div#PopulationListTab').addClass('active in');
                            $('div#managePopulationTabLink').addClass('active in');
                            $('li#liTiers').removeClass('active in');
                            $('li#liList').addClass('active in');
                            $("#<%=lnkbtnDelete.ClientID %>").addClass('aspNetDisabled');
                            $("#<%=lnkbtnDelete.ClientID %>").attr("disabled", $("#<%=lnkbtnDelete.ClientID %>"));
                            break;
                    }
                    RegisterLeftDivheight();
                }
                function RegisterGetImage() {
                    //  Icons
                    $('.singleIcon').on('click', function () {
                        $('.singleIcon').removeClass('selected');
                        $(this).addClass('selected');
                    });
                    //  Set Icons
                    $('.singleIcon').click(function () {

                        var selectedIcon = $('.singleIcon.selected img').attr('src');
                        var selectedIconid = $('.singleIcon.selected input').attr('value');
                        document.getElementById('<%=hdnFileID.ClientID%>').value = selectedIconid;
                        $('.badge-plce_holder img').attr({ src: selectedIcon });
                        $('#<%=hdnShowImage.ClientID%>').val(selectedIcon);
                    });
                }

                function rgb2hex(rgb) {
                    rgb = rgb.match(/^rgba?[\s+]?\([\s+]?(\d+)[\s+]?,[\s+]?(\d+)[\s+]?,[\s+]?(\d+)[\s+]?/i);
                    return (rgb && rgb.length === 4) ? "#" +
                     ("0" + parseInt(rgb[1], 10).toString(16)).slice(-2) +
                     ("0" + parseInt(rgb[2], 10).toString(16)).slice(-2) +
                     ("0" + parseInt(rgb[3], 10).toString(16)).slice(-2) : '';
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
                ///Alert Message

                function ConfirmMessage(flag) {

                    var savemsg = 'Are you sure to save this achievement?';
                    var cancelmsg = 'Are you sure to discard current changes?';
                    var deletemsg = 'Are you sure to delete this achievement?';
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
            function myTrim(x) {
                return x.replace(/\s/g, '').replace('-', '');
            }
            function RegisterAchievementImageScrollDiv() {
                $(".img-plc-holder").perfectScrollbar({ suppressScrollX: true });
            }
            function RegisterModel() {
                $('#ConfirmBox').on('show.bs.modal', function (e) {
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


            <div style="text-align: center;">
                <asp:UpdateProgress ID="updateProgress" runat="server">
                    <ProgressTemplate>
                        <div style="position: fixed; text-align: center; height: 100%; width: 100%; top: 0; right: 0; left: 0; z-index: 9999999; background-color: #000000; opacity: 0.7;">
                            <asp:Image ID="imgUpdateProgress" runat="server" ImageUrl="Content/img/loader.gif" AlternateText="Loading ..." ToolTip="Loading ..." Style="padding: 10px; position: fixed; top: 45%; left: 50%;" />
                        </div>

                    </ProgressTemplate>
                </asp:UpdateProgress>
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

                            <asp:Button ID="btnConfirmedActive" CssClass="btn btn-danger" runat="server" Text="OK" UseSubmitBehavior="false" data-dismiss="modal" OnClick="lnkbtnActive_Click" Style="display: none;"></asp:Button>
                            <asp:Button ID="btnConfirmedInActive" CssClass="btn btn-danger" runat="server" Text="OK" UseSubmitBehavior="false" data-dismiss="modal" OnClick="lnkbtnInActive_Click" Style="display: none;"></asp:Button>
                            <asp:Button ID="btnConfirmedAll" CssClass="btn btn-danger" runat="server" Text="OK" UseSubmitBehavior="false" data-dismiss="modal" OnClick="lnkbtnAll_Click" Style="display: none;"></asp:Button>
                            <button type="button" class="btn" id="confirm" data-dismiss="modal">Cancel</button>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Dialog show event handler -->
            <div class="modal fade" id="Achivement_alert" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal"><span class="glyphicon glyphicon-remove"></span></button>
                            <h4 class="modal-title" id="myModalLabel">Alert</h4>
                        </div>
                        <div class="modal-body">
                            <div class="warning">
                                <p><em>Note: this is triggered if the achievement is</em></p>
                                <ol class="list-group">
                                    <li>Deleted / Made Inactive, or</li>
                                    <li>The Achievement passes it's "to" schedule date, or</li>
                                    <li>The user changes the schedule so that the event is expired (in the past)</li>
                                </ol>

                            </div>
                            <h4>Deactivating this Achievement will have the following effects:</h4>
                            <ol class="list-group text-bold">
                                <li>Clear all progress towards this achievement for all users, and</li>
                                <li>Remove the in progress Achievement from all users view.</li>
                                <li>Reactivating the Achievement at a later date will not recover any previous progress for users, and</li>
                                <li>All app users will start with zero progress towards completing the achievement.</li>
                                <li>If a user has completed the Achievement prior to its deactivation, the user will continue to see that achievement in the app.</li>
                            </ol>

                        </div>
                        <div class="modal-footer clearfix">
                            <ul>
                                <li>
                                    <asp:Button type="button" ID="btnConfirmedDelete" CssClass="btn" runat="server" Text="Deactivate Achievement" UseSubmitBehavior="false" data-dismiss="modal" OnClick="lnkbtnDelete_Click"></asp:Button>

                                <li>
                                    <button type="button" class="btn" id="confirm" data-dismiss="modal">Leave Achievement Active</button></li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
