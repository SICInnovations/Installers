<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="ManagePlayerAccount.aspx.cs" Inherits="HAMobileWebAdmin.ManagePlayerAccount" %>
<asp:Content runat="server" ID="Content1" ContentPlaceHolderID="HeadContent">
    <title>COG Mobile | Manage Player Account</title>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
<input type="text" style="display: none"> 
<input type="password" style="display: none">
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
                <asp:HiddenField runat="server" ID="hdnPlayerID" Value="" />
                <asp:HiddenField runat="server" ID="hdnActive" Value="Active" />               

                <div class="col-sm-6">
					<h4>Player Account Management</h4>

					<div class="row">
						<div class="form-group">
							<div class="col-sm-6">
								<label for="contentItem">Email Address</label>
								<asp:TextBox runat="server" CssClass="form-control" id="txtSearchEmailAddress" ></asp:TextBox>
							</div>

							<div class="col-sm-5 btnMarginTop">							
								<asp:Button ID="btnSearchEmailAddress1"  OnClick="btnSearchEmailAddress_Click" runat="server" Text="Search by Email Address" CssClass="search_by_btn" />
								
							</div>

						</div>

					</div>

					<div class="row">
						<div class="form-group">

							<div class="col-sm-6">
								<label for="contentItem">Player Club ID</label>
								<asp:TextBox  ID="txtSearchPlayerClubID" CssClass="form-control" runat="server" ></asp:TextBox>
							</div>

							<div class="col-sm-5 btnMarginTop">
                                <asp:Button ID="btnSearchbyPlayerClubID1"  OnClick="btnSearchbyPlayerClubID_Click" runat="server" Text="Search by Player Club ID" CssClass="search_by_btn" />								
							</div>

						</div>

						<div class="form-group">

							<div class="col-sm-12">
								<label for="contentItem">Player Account Information</label>

							</div>

						</div>

						<div class="row">
							<div class="col-md-12">
								<div class="form-group">

									<div class="col-sm-6">
										<label for="contentItem">Player Name</label>
                                        <asp:TextBox  ID="txtPlayerName" CssClass="form-control" runat="server" ></asp:TextBox>								
									</div>

								</div>
							</div>
						</div>

						<div class="form-group">

							<div class="col-sm-6">
								<label for="contentItem">Player Club ID</label>
                                 <asp:TextBox  ID="txtPlayerClubID" CssClass="form-control" runat="server" ></asp:TextBox>	
							</div>

							<div class="col-sm-5 btnMarginTop">
                                <asp:Button ID="btnUnlinkPlayerClubAccount1" OnClientClick="return ConfirmMessage(3)" OnClick="btnUnlinkPlayerClubAccount_Click" runat="server" Text="Unlink Player Club Account" CssClass="search_by_btn" />
							</div>
                            	<div class="col-sm-1 btnMarginTop"><asp:CheckBox id="chkIsLinked" runat="server" Text="IsLinked"  Visible="false"/></div>
						</div>

						<div class="row">
							<div class="col-md-12">
								<div class="form-group">

									<div class="col-sm-6">
										<label for="contentItem">Player Club Account Link Date/Time</label>
                                           <asp:TextBox  ID="txtPlayerClubAccountLinkDateTime" CssClass="form-control" runat="server" ></asp:TextBox>											
									</div>

								</div>
							</div>
						</div>

						<div class="row">
							<div class="col-md-12">
								<div class="form-group">

									<div class="col-sm-6">
										<label for="contentItem">Internal COG ID</label>
                                          <asp:TextBox  ID="txtInternalCOGID" CssClass="form-control" runat="server" ></asp:TextBox>										
									</div>

								</div>
							</div>
						</div>

						<div class="row">
							<div class="col-md-12">
								<div class="form-group">

									<div class="col-sm-6">
										<label for="contentItem">Most Recent Device ID</label>
                                         <asp:TextBox  ID="txtMostRecentDeviceID" CssClass="form-control" runat="server" ></asp:TextBox>			
										
									</div>

								</div>
							</div>
						</div>

						<div class="row">
							<div class="col-md-12">
								<div class="form-group">

									<div class="col-sm-6">
										<label for="contentItem">Device Type</label>
                                          <asp:TextBox  ID="txtDeviceType" CssClass="form-control" runat="server" ></asp:TextBox>												
									</div>

								</div>
							</div>
						</div>

						<div class="form-group">

							<div class="col-sm-6">
								<label for="contentItem">Email Address</label>
                                 <asp:TextBox  ID="txtEmailAddress" AutoPostBack="False" AutoCompleteType="Disabled" autocomplete="off" CssClass="form-control" runat="server" ></asp:TextBox>			
								
							</div>

							<div class="col-sm-5 btnMarginTop">
                                <asp:Button ID="btnChangeEmailAddress" OnClientClick="return EmailAddressValidation(); ConfirmMessage(4)" OnClick="btnChangeEmailAddress_Click" runat="server" Text="Change Email Address" CssClass="search_by_btn" />			
								
							</div>

						</div>
						<div class="row">
							<div class="col-md-12">
								<div class="form-group">
									<div class="col-sm-6">
										<label for="contentItem">Change Password</label>
                                         <asp:TextBox  ID="txtChangePassword"  AutoCompleteType="Disabled" autocomplete="off"  TextMode="Password" CssClass="form-control" runat="server" ></asp:TextBox>			
									</div>

								</div>
							</div>
						</div>
						<div class="form-group">

							<div class="col-sm-6">
								<label for="contentItem">Confirm New Password</label>
                                 <asp:TextBox  ID="txtConfirmNewPassword" TextMode="Password" CssClass="form-control" runat="server"  ></asp:TextBox>			
								
							</div>

							<div class="col-sm-5 btnMarginTop">
                                 <asp:Button ID="btnChangePassword" OnClientClick="return PasswordValidation(); ConfirmMessage(5)" OnClick="btnChangePassword_Click" runat="server" Text="Change Password" CssClass="search_by_btn" />			
								
							</div>

						</div>

						<!-- end here content -->

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

            <Script type="text/javascript">
                //***************************************Start On UpdatePanel Refresh Register ImageUpload/Common Functions ********************************************************8

                var prm = Sys.WebForms.PageRequestManager.getInstance();
                if (prm != null) {
                    prm.add_endRequest(function (sender, e) {
                        if (sender._postBackSettings.panelsToUpdate != null) {
                                                      
                            //Register Model
                            RegisterModel();
                          

                        }
                    });
                };

                ///**************************************End On UpdatePanel Refresh Register ImageUpload/Common Functions******************************************
                ////*************************************************Start Page load functionality.***********************************

                $(document).ready(function () {
                   
                    //Register Model
                    RegisterModel();
                  

                });
                function RegisterModel() {
                    $('#ConfirmBox').on('show.bs.modal', function (e) {
                    });
                }
                function EmailAddressValidation()
                {
                    if ($('#<%=txtEmailAddress.ClientID%>').val() == "")
                        {                 
                        document.getElementById('<%=txtEmailAddress.ClientID%>').focus();
                        document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please enter email address!';
                        $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                        return false;
                    }                    
                    if(validateEmail($('#<%=txtEmailAddress.ClientID%>').val())==false)
                    {
                        document.getElementById('<%=txtEmailAddress.ClientID%>').focus();
                        document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please enter valid email address!';
                        $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                        return false;
                    }

                    
                }
                function PasswordValidation() {

                    var pwd = $('#<%=txtChangePassword.ClientID%>').val();
                    var vPwd = $('#<%=txtConfirmNewPassword.ClientID%>').val();
                    
                    if ($('#<%=txtChangePassword.ClientID%>').val() == "") {
                        document.getElementById('<%=txtChangePassword.ClientID%>').focus();
                        document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please enter change password!';
                        $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                        return false;
                    }
                    if ($('#<%=txtConfirmNewPassword.ClientID%>').val() == "") {
                        document.getElementById('<%=txtConfirmNewPassword.ClientID%>').focus();
                        document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Please enter confirm password!';
                        $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                        return false;
                    }
                    if (pwd != vPwd) {

                        $('#<%=txtConfirmNewPassword.ClientID%>').val('');                     
                        document.getElementById('<%=alertMessage.ClientID%>').innerHTML = 'Change passowrd and confirm password do not match!';
                        $('#AlertBox').modal({ backdrop: 'static', keyboard: false });
                        return false;
                    }
                }
                  
                   
                    
                ///Alert Message
                function ConfirmMessage(flag) {
                    var unlinkmsg = 'Are you sure to unlink player account?';
                    var cancelmsg = 'Are you sure to discard current changes?';
                    var changeemailemsg = 'Are you sure to change email address?';
                    var changepwdemsg = 'Are you sure to change password?';

                    var isChange = FormChanges('from1');

                    if (isChange != "") {
                        var message = '';
                        if (flag == 1) {
                            $('#<%=btnConfirmedSearchByEmail.ClientID%>').show();
                            $('#<%=btnConfirmedSearchByPlayerClubNo.ClientID%>').hide();
                            $('#<%=btnConfirmedUnlinkPlayerAccount.ClientID%>').hide();
                            $('#<%=btnConfirmedChangeEmail.ClientID%>').hide();
                            $('#<%=btnConfirmedChangePassword.ClientID%>').hide();
                            $('#ConfirmBoxMessage').html(cancelmsg);
                        }
                        else if (flag == 2) {
                            $('#<%=btnConfirmedSearchByEmail.ClientID%>').hide();
                            $('#<%=btnConfirmedSearchByPlayerClubNo.ClientID%>').show();
                            $('#<%=btnConfirmedUnlinkPlayerAccount.ClientID%>').hide();
                            $('#<%=btnConfirmedChangeEmail.ClientID%>').hide();
                            $('#<%=btnConfirmedChangePassword.ClientID%>').hide();
                            $('#ConfirmBoxMessage').html(cancelmsg);
                        }
                        else if (flag == 3) {
                            $('#<%=btnConfirmedSearchByEmail.ClientID%>').hide();
                            $('#<%=btnConfirmedSearchByPlayerClubNo.ClientID%>').hide();
                            $('#<%=btnConfirmedUnlinkPlayerAccount.ClientID%>').show();
                            $('#<%=btnConfirmedChangeEmail.ClientID%>').hide();
                            $('#<%=btnConfirmedChangePassword.ClientID%>').hide();
                            $('#ConfirmBoxMessage').html(unlinkmsg);
                        }
                        else if (flag == 4) {
                            $('#<%=btnConfirmedSearchByEmail.ClientID%>').hide();
                            $('#<%=btnConfirmedSearchByPlayerClubNo.ClientID%>').hide();
                            $('#<%=btnConfirmedUnlinkPlayerAccount.ClientID%>').hide();
                            $('#<%=btnConfirmedChangeEmail.ClientID%>').show();
                            $('#<%=btnConfirmedChangePassword.ClientID%>').hide();
                            $('#ConfirmBoxMessage').html(changeemailemsg);
                        }
                        else if (flag == 5) {
                            $('#<%=btnConfirmedSearchByEmail.ClientID%>').hide();
                            $('#<%=btnConfirmedSearchByPlayerClubNo.ClientID%>').hide();
                            $('#<%=btnConfirmedUnlinkPlayerAccount.ClientID%>').hide();
                            $('#<%=btnConfirmedChangeEmail.ClientID%>').hide();
                            $('#<%=btnConfirmedChangePassword.ClientID%>').show();
                            $('#ConfirmBoxMessage').html(changepwdemsg);
                        }
                        $('#ConfirmBox').modal({ backdrop: 'static', keyboard: false });
                        return false;
                    }


                }
                function validateEmail(email) {
                   
                    var emailReg = new RegExp(/^([^.@]+)(\.[^.@]+)*@([^.@]+\.)+([^.@]+)$/);
                    var valid = emailReg.test(email);

                    if (!valid) {
                        return false;
                    }
                    
                    return true
                }
            </Script>
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
                            <asp:Button ID="btnConfirmedSearchByEmail" OnClick="btnSearchEmailAddress_Click" CssClass="btn btn-danger" runat="server" Text="OK" UseSubmitBehavior="false" data-dismiss="modal"  Style="display: none;"></asp:Button>
                            <asp:Button ID="btnConfirmedSearchByPlayerClubNo" OnClick="btnSearchbyPlayerClubID_Click" CssClass="btn btn-danger" runat="server" Text="OK" UseSubmitBehavior="false" data-dismiss="modal"  Style="display: none;"></asp:Button>
                            <asp:Button ID="btnConfirmedUnlinkPlayerAccount" OnClick="btnUnlinkPlayerClubAccount_Click" CssClass="btn btn-danger" runat="server" Text="OK" UseSubmitBehavior="false" data-dismiss="modal"  Style="display: none;"></asp:Button>
                            <asp:Button ID="btnConfirmedChangeEmail" OnClick="btnChangeEmailAddress_Click" CssClass="btn btn-danger" runat="server" Text="OK" UseSubmitBehavior="false" data-dismiss="modal"  Style="display: none;"></asp:Button>
                            <asp:Button ID="btnConfirmedChangePassword" OnClick="btnChangePassword_Click" CssClass="btn btn-danger" runat="server" Text="OK" UseSubmitBehavior="false" data-dismiss="modal"  Style="display: none;"></asp:Button>
                           
                            <button type="button" class="btn" id="confirm" data-dismiss="modal">Cancel</button>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Dialog show event handler -->

        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>