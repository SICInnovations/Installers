<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="WebHtmlEditor.ascx.cs" Inherits="HAMobileWebAdmin.UserControl.WebHtmlEditor" %>
<%@ Register Assembly="Infragistics4.WebUI.WebHtmlEditor.v14.1, Version=14.1.20141.2150, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" Namespace="Infragistics.WebUI.WebHtmlEditor" TagPrefix="ighedit" %>
<%@ Register Assembly="Infragistics4.Web.v14.1, Version=14.1.20141.2150, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" Namespace="Infragistics.Web.UI.LayoutControls" TagPrefix="ig" %>
<%@ Register Assembly="Infragistics4.WebUI.WebSpellChecker.v14.1, Version=14.1.20141.2150, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" Namespace="Infragistics.WebUI.WebSpellChecker" TagPrefix="ig_spell" %>
<%@ Register Assembly="Infragistics4.Web.v14.1, Version=14.1.20141.2150, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" Namespace="Infragistics.Web.UI.EditorControls" TagPrefix="ig" %>

<ighedit:WebHtmlEditor UploadedFilesDirectory="~/Temp/Uploads" ImageDirectory="~/Content/WebHtmlEditorImages/" ID="WebHtmlEditor1" runat="server" Height="250px" Width="100%" FontSizeList="1,2,3,4,5,6,7"
    FontStyleList="Blue Underline=color:blue;text-decoration:underline;&amp;Red Bold=color:red;font-weight:bold;&amp;ALL CAPS=text-transform:uppercase;&amp;all lowercase=text-transform:lowercase;&amp;Reset="
    FontNameList="Arial,Verdana,Tahoma,Courier New,Georgia" SpecialCharacterList="O,S,?,F,G,?,?,T,?,?,?,ｵ,?,f,?,e,?,d,?,?,ﾟ,p,s,ﾟ,,ﾞ,・?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,ﾆ,ﾅ,ﾇ,ﾐ,ﾑ,ﾖ,・・・・・・・・・｢,｣,､,･,?,・ｩ,ｮ,・@,・｡,&#14;,&#18;,&#24;,&#26;,&#27;,ｦ,ｧ,ｨ,ｪ,ｬ,ｯ,ｶ,ｰ,ｱ,ｫ,ｻ,ｷ,ｸ,ｺ,ｹ,ｲ,ｳ,ｼ,ｽ,ｾ,ｿ,ﾗ,・"
    FontFormattingList="Heading 1=<h1>&amp;Heading 2=<h2>&amp;Heading 3=<h3>&amp;Heading 4=<h4>&amp;Heading 5=<h5>&amp;Normal=<p>" CssClass="htmleditormb">
    <TextWindow BackColor="#BF313E"/>
    <ClientSideEvents Blur="WebHtmlEditor1_Blur" Initialize="WebHtmlEditor1_Initialize" AfterAction="WebHtmlEditor1_AfterAction" KeyPress="WebHtmlEditor1_KeyPress" KeyDown="WebHtmlEditor1_KeyDown" Focus="WebHtmlEditor1_Focus" BeforeAction="WebHtmlEditor1_BeforeAction"></ClientSideEvents>
    <DialogStyle Font-Size="8pt" Font-Names="sans-serif" BorderWidth="1px" ForeColor="Black" BorderStyle="Solid" BorderColor="Black" BackColor="#ECE9D8"></DialogStyle>
    <Toolbar>
        <ighedit:ToolbarImage Type="DoubleSeparator"></ighedit:ToolbarImage>
        <ighedit:ToolbarButton Type="Bold"></ighedit:ToolbarButton>
        <ighedit:ToolbarButton Type="Italic"></ighedit:ToolbarButton>
        <ighedit:ToolbarButton Type="Underline"></ighedit:ToolbarButton>
        <ighedit:ToolbarButton Type="Strikethrough"></ighedit:ToolbarButton>
        <ighedit:ToolbarImage Type="Separator"></ighedit:ToolbarImage>
        <ighedit:ToolbarButton Type="Subscript"></ighedit:ToolbarButton>
        <ighedit:ToolbarButton Type="Superscript"></ighedit:ToolbarButton>
        <ighedit:ToolbarImage Type="Separator"></ighedit:ToolbarImage>
        <ighedit:ToolbarButton Type="Undo"></ighedit:ToolbarButton>
        <ighedit:ToolbarButton Type="Redo"></ighedit:ToolbarButton>
        <ighedit:ToolbarImage Type="Separator"></ighedit:ToolbarImage>
        <ighedit:ToolbarButton Type="JustifyLeft"></ighedit:ToolbarButton>
        <ighedit:ToolbarButton Type="JustifyCenter"></ighedit:ToolbarButton>
        <ighedit:ToolbarButton Type="JustifyRight"></ighedit:ToolbarButton>
        <ighedit:ToolbarButton Type="JustifyFull"></ighedit:ToolbarButton>
        <ighedit:ToolbarImage Type="Separator"></ighedit:ToolbarImage>
        <ighedit:ToolbarButton Type="Indent"></ighedit:ToolbarButton>
        <ighedit:ToolbarButton Type="Outdent"></ighedit:ToolbarButton>
        <ighedit:ToolbarImage Type="Separator"></ighedit:ToolbarImage>
        <ighedit:ToolbarButton Type="UnorderedList"></ighedit:ToolbarButton>
        <ighedit:ToolbarButton Type="OrderedList"></ighedit:ToolbarButton>
        <ighedit:ToolbarImage Type="Separator"></ighedit:ToolbarImage>
        <ighedit:ToolbarDialogButton Type="InsertRule">
            <Dialog Strings="" InternalDialogType="InsertRule"></Dialog>
        </ighedit:ToolbarDialogButton>
        <ighedit:ToolbarImage Type="Separator"></ighedit:ToolbarImage>
        <ighedit:ToolbarButton Type="Preview"></ighedit:ToolbarButton>
        <ighedit:ToolbarImage Type="Separator"></ighedit:ToolbarImage>
        <ighedit:ToolbarDialogButton Type="FindReplace">
            <Dialog Strings="" InternalDialogType="FindReplace"></Dialog>
        </ighedit:ToolbarDialogButton>
        <ighedit:ToolbarButton Type="CleanWord"></ighedit:ToolbarButton>
        <ighedit:ToolbarButton Type="WordCount"></ighedit:ToolbarButton>
        <ighedit:ToolbarButton Type="PasteHtml"></ighedit:ToolbarButton>
        <ighedit:ToolbarMenuButton Type="Zoom">
            <Menu Width="180px">
                <ighedit:HtmlBoxMenuItem Act="Zoom25">
                </ighedit:HtmlBoxMenuItem>
                <ighedit:HtmlBoxMenuItem Act="Zoom50">
                </ighedit:HtmlBoxMenuItem>
                <ighedit:HtmlBoxMenuItem Act="Zoom75">
                </ighedit:HtmlBoxMenuItem>
                <ighedit:HtmlBoxMenuItem Act="Zoom100">
                </ighedit:HtmlBoxMenuItem>
                <ighedit:HtmlBoxMenuItem Act="Zoom200">
                </ighedit:HtmlBoxMenuItem>
                <ighedit:HtmlBoxMenuItem Act="Zoom300">
                </ighedit:HtmlBoxMenuItem>
                <ighedit:HtmlBoxMenuItem Act="Zoom400">
                </ighedit:HtmlBoxMenuItem>
                <ighedit:HtmlBoxMenuItem Act="Zoom500">
                </ighedit:HtmlBoxMenuItem>
                <ighedit:HtmlBoxMenuItem Act="Zoom600">
                </ighedit:HtmlBoxMenuItem>
            </Menu>
        </ighedit:ToolbarMenuButton>
        <ighedit:ToolbarImage Type="Separator"></ighedit:ToolbarImage>
        <ighedit:ToolbarImage Type="RowSeparator"></ighedit:ToolbarImage>
        <ighedit:ToolbarImage Type="DoubleSeparator"></ighedit:ToolbarImage>
        <ighedit:ToolbarDialogButton Type="FontColor">
            <Dialog BorderStyle="Solid" BackColor="#ECE9D8" ForeColor="Black" Strings="" BorderWidth="1px"
                BorderColor="Black" Font-Size="8pt" Font-Names="sans-serif"></Dialog>
        </ighedit:ToolbarDialogButton>
        <ighedit:ToolbarDialogButton Type="FontHighlight">
            <Dialog BorderStyle="Solid" BackColor="#ECE9D8" ForeColor="Black" Strings="" BorderWidth="1px"
                BorderColor="Black" Font-Size="8pt" Font-Names="sans-serif"></Dialog>
        </ighedit:ToolbarDialogButton>
        <ighedit:ToolbarDialogButton Type="SpecialCharacter">
            <Dialog Strings="" InternalDialogType="SpecialCharacterPicker" Type="InternalWindow"></Dialog>
        </ighedit:ToolbarDialogButton>
        <ighedit:ToolbarMenuButton Type="InsertTable">
            <Menu Width="80px">
                <ighedit:HtmlBoxMenuItem Act="TableProperties">
                    <Dialog Strings="" InternalDialogType="InsertTable"></Dialog>
                </ighedit:HtmlBoxMenuItem>
                <ighedit:HtmlBoxMenuItem Act="InsertColumnRight">
                </ighedit:HtmlBoxMenuItem>
                <ighedit:HtmlBoxMenuItem Act="InsertColumnLeft">
                </ighedit:HtmlBoxMenuItem>
                <ighedit:HtmlBoxMenuItem Act="InsertRowAbove">
                </ighedit:HtmlBoxMenuItem>
                <ighedit:HtmlBoxMenuItem Act="InsertRowBelow">
                </ighedit:HtmlBoxMenuItem>
                <ighedit:HtmlBoxMenuItem Act="DeleteRow">
                </ighedit:HtmlBoxMenuItem>
                <ighedit:HtmlBoxMenuItem Act="DeleteColumn">
                </ighedit:HtmlBoxMenuItem>
                <ighedit:HtmlBoxMenuItem Act="IncreaseColspan">
                </ighedit:HtmlBoxMenuItem>
                <ighedit:HtmlBoxMenuItem Act="DecreaseColspan">
                </ighedit:HtmlBoxMenuItem>
                <ighedit:HtmlBoxMenuItem Act="IncreaseRowspan">
                </ighedit:HtmlBoxMenuItem>
                <ighedit:HtmlBoxMenuItem Act="DecreaseRowspan">
                </ighedit:HtmlBoxMenuItem>
                <ighedit:HtmlBoxMenuItem Act="CellProperties">
                    <Dialog Strings="" InternalDialogType="CellProperties"></Dialog>
                </ighedit:HtmlBoxMenuItem>
                <ighedit:HtmlBoxMenuItem Act="TableProperties">
                    <Dialog Strings="" InternalDialogType="ModifyTable"></Dialog>
                </ighedit:HtmlBoxMenuItem>
            </Menu>
        </ighedit:ToolbarMenuButton>
        <ighedit:ToolbarButton Type="ToggleBorders"></ighedit:ToolbarButton>
        <ighedit:ToolbarImage Type="Separator"></ighedit:ToolbarImage>
        <ighedit:ToolbarButton Type="InsertLink"></ighedit:ToolbarButton>
        <ighedit:ToolbarButton Type="RemoveLink"></ighedit:ToolbarButton>

        <ighedit:ToolbarImage Type="Separator"></ighedit:ToolbarImage>
        <ighedit:ToolbarDropDown Type="FontName">
        </ighedit:ToolbarDropDown>
        <ighedit:ToolbarDropDown Type="FontSize">
        </ighedit:ToolbarDropDown>
        <ighedit:ToolbarDropDown Type="FontFormatting">
        </ighedit:ToolbarDropDown>
        <ighedit:ToolbarDropDown Type="FontStyle">
        </ighedit:ToolbarDropDown>
    </Toolbar>
    <RightClickMenu>
        <ighedit:HtmlBoxMenuItem Act="Cut">
        </ighedit:HtmlBoxMenuItem>
        <ighedit:HtmlBoxMenuItem Act="Copy">
        </ighedit:HtmlBoxMenuItem>
        <ighedit:HtmlBoxMenuItem Act="Paste">
        </ighedit:HtmlBoxMenuItem>
        <ighedit:HtmlBoxMenuItem Act="PasteHtml">
        </ighedit:HtmlBoxMenuItem>
    </RightClickMenu>
</ighedit:WebHtmlEditor>
