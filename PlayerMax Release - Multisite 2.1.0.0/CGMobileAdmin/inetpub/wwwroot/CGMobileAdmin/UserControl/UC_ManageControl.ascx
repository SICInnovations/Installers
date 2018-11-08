<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="UC_ManageControl.ascx.cs" Inherits="HA.WebApp.UC_ContentManagement" %>


<div id="divgv">

    <asp:GridView ID="gvContentDetail" runat="server" AutoGenerateColumns="false" CssClass="table table-striped table-bordered table-condensed"  DataKeyNames="ContentDetailID" AllowPaging="true" PageSize="10" OnPageIndexChanging="gvContentDetail_PageIndexChanging"  >
        <Columns>

            <asp:TemplateField ShowHeader="True" HeaderText="Content Detail"  >
                <ItemTemplate>
                    <asp:Label ID="lblID" runat="server" Visible="false" Text='<%#Eval("ContentDetailID") %>' />
                    <asp:LinkButton ID="lblName" runat="server" Text='<%#Eval("PlainText1") %>' CommandName="Select" OnClick="lblName_Click" />
<%--                    <a href="#" onclick="GetContentDetailData('<%#Eval("ContentDetailID") %>')"><%#Eval("PlainText1") %></a>
--%>
                </ItemTemplate>

            </asp:TemplateField>
        </Columns>

        <%--<PagerTemplate>
            <div id="page-selection" class="pagination-centered"></div>
        </PagerTemplate>--%>
    </asp:GridView>
    <div id="content"></div>

</div>


