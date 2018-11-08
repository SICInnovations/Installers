<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ListViewUserControl.ascx.cs" Inherits="HAMobile.MobileManagement.UserControl.ListView_Pagging" %>

<div>
    <asp:ListView ID="lstUserControl" runat="server" DataSourceID="odslstUserControl" ItemPlaceholderID="itmPlaceholder" 
       OnItemCommand="lstUserControl_ItemCommand" >

        <LayoutTemplate>
            <table id="layoutlstUserControl" runat="server">
                <tr id="itmPlaceholder" runat="server">
                </tr>
            </table>
        </LayoutTemplate>

        <EmptyDataTemplate>
            <table id="emptydatatemplatelstUserControl" runat="server">
                <tr id="itmPlaceholder" runat="server">
                    <td>No Data Found...
                    </td>
                </tr>
            </table>
        </EmptyDataTemplate>

        <ItemTemplate>
            <table id="itemdatatemplatelstUserControl" runat="server">
                <tr>
                    <td>
                        <asp:Label ID="lblID" runat="server" Visible="false" Text='<%#Eval("ID") %>'    />
                        <asp:LinkButton ID="lblName" runat="server" Text='<%#Eval("Name") %>' CommandName="Select"/>
                    </td>
                </tr>
            </table>
        </ItemTemplate>

    </asp:ListView>
</div>

<div class="resultPagination">
    <asp:DataPager ID="dataPagerNumeric" PagedControlID="lstUserControl"
        runat="server" PageSize="10">
        <Fields>
            <asp:NumericPagerField ButtonCount="5" NumericButtonCssClass="numeric_button" CurrentPageLabelCssClass="current_page"
                NextPreviousButtonCssClass="next_button" />
        </Fields>
    </asp:DataPager>
    <asp:DataPager ID="dataPagerDisplayNumberOfPages" runat="server" PageSize="10" PagedControlID="lstUserControl">
        <Fields>
            <asp:TemplatePagerField>
                <PagerTemplate>
                    <span style="color: Black;">Records:
                          <%# Container.StartRowIndex >= 0 ? (Container.StartRowIndex + 1) : 0 %>
                               -
                          <%# (Container.StartRowIndex + Container.PageSize) > Container.TotalRowCount ? Container.TotalRowCount : (Container.StartRowIndex + Container.PageSize)%>
                           of
                           <%# Container.TotalRowCount %>
                    </span>
                </PagerTemplate>
            </asp:TemplatePagerField>
        </Fields>
    </asp:DataPager>
</div>
<asp:ObjectDataSource ID="odslstUserControl" runat="server" EnablePaging="true" MaximumRowsParameterName="pageSize"
    StartRowIndexParameterName="startRowIndex">
    <SelectParameters>
        <asp:Parameter Name="startRowIndex" Type="Int32" />
        <asp:Parameter Name="pageSize" Type="Int32" />
    </SelectParameters>
</asp:ObjectDataSource>
