<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ListBoxUerControl.ascx.cs" Inherits="HAMobile.MobileManagement.UserControl.ListBoxUerControl" %>


<div>
    <asp:HiddenField ID="hdnListBoxUnselectedItems" runat="server" />
    <asp:HiddenField ID="hdnListBoxSelectedItems" runat="server" />
</div>
<div>
    <table>
        <tr>
            <td>Filter:
                        <input type="text" id="box1Filter" />
                <button type="button" id="box1Clear">X</button><br />
                <asp:ListBox ID="box1View" SelectionMode="Multiple" EnableViewState="true" Rows="3" runat="server" Style="height: 250px; width: 250px;"></asp:ListBox>
                <br />
                <span id="box1Counter" class="countLabel"></span>
                <select id="box1Storage">
                </select>
            </td>
            <td>
                <button id="to2" type="button">&nbsp;>&nbsp;</button>
                <button id="allTo2" type="button">&nbsp;>>&nbsp;</button>
                <button id="allTo1" type="button">&nbsp;<<&nbsp;</button>
                <button id="to1" type="button">&nbsp;<&nbsp;</button>
            </td>
            <td>Filter:
                        <input type="text" id="box2Filter" />
                <button type="button" id="box2Clear">X</button><br />
                <asp:ListBox EnableViewState="true" ID="box2View" SelectionMode="Multiple" Rows="3" runat="server" Style="height: 250px; width: 250px"></asp:ListBox><br />
                <span id="box2Counter" class="countLabel"></span>
                <select id="box2Storage">
                </select>
            </td>
        </tr>
    </table>
</div>
