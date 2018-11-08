<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="UC_PopulationTypeTab.ascx.cs" Inherits="HAMobileWebAdmin.UserControl.UC_PopulationTypeTab" %>

<div class=" clearfix tab-container">
    <div class="col-md-12">
        <div class="col-md-6 ">
            <label>Players by Type</label>
            <asp:DropDownList ID="ddlTierType" runat="server" AutoPostBack="true"  
                OnSelectedIndexChanged="ddlTierType_SelectedIndexChanged" 
                CssClass="form-control jq-selectbox" onchange="RegisterDisabledTypeListBox()">              
            </asp:DropDownList>
        </div>
        <div class="row" id="dvlstTier">
            <div class="col-md-12">
                <div class="col-md-12">
                    <label>Players by Tier</label>
                </div>
                <div class="col-md-12">
                    <label>Tiers</label>
                </div>
            </div>
            <asp:ListBox runat="server" ID="lstPopulationTiers" SelectionMode="Multiple" CssClass="tiersListBox col-md-12"></asp:ListBox>
            <asp:HiddenField runat="server" ID="hdnSelectedPopulationTiers" Value="0" />
        </div>
    </div>
</div>
<script type="text/javascript">
    RegisterDisabledTypeListBox();   
    function RegisterDisabledTypeListBox() {       
        $('#dvlstTier').find('select, button, input:text').prop('disabled', true);                
        if ($("#<%=ddlTierType.ClientID%> option:selected").val() == "4" || $("#<%=ddlTierType.ClientID%> option:selected").val() == "2")
        {$('#dvlstTier').find('select, button, input:text').prop('disabled', false);}
    }    
</script>

