<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="UC_ContentSchedule.ascx.cs" Inherits="HAMobileWebAdmin.UserControl.UC_ContentSchedule" %>


<div class="tab-pane fade" id="manageScheduleTab">
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <div class="tab-container clearfix">
                <div class="col-md-4">
                    <div class="filterWrapper filterWrapper2 relative">
                        <div class="row clearfix whiteBg">
                            <div class="col-xs-7">
                                <label>Schedule</label>
                            </div>
                            <div class="col-xs-5">
                                <span class="addBtn">Add
                                    <asp:Button ID="lnkbtnAddSchedule" runat="server" OnClick="btnAddSchedule_Click"
                                        CssClass="btn btn-add pull-right"></asp:Button>
                                </span>
                            </div>
                        </div>
                        <div class="input-group">
                            <asp:TextBox runat="server" ID="txtSearchBox" CssClass="form-control" />
                            <span class="input-group-btn">
                                <asp:Button ID="btnSearch" OnClick="btnSearch_OnClick" CssClass="btn btn-black glyphicons filter btn-icon white" runat="server" /><i></i>
                            </span>
                        </div>
                        <div class="filterResults">
                            <div id="div57">
                                <asp:GridView CssClass="gridview" ID="gvSchedules" runat="server" ShowHeader="False" AutoGenerateColumns="false"
                                    AllowPaging="true">
                                    <Columns>
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <asp:LinkButton ID="lnkBtnScheduleName" runat="server" Text='<%#Eval("ScheduleName") %>' OnClick="lnkBtnScheduleName_Click" />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                    <SelectedRowStyle CssClass="gvSelectedRow" />
                                </asp:GridView>
                                <div id="Div58"></div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-8">
                    <label for="adscheduleName">Schedule Name</label>
                    <asp:TextBox ID="txtScheduleName" runat="server" CssClass="form-control"></asp:TextBox>
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
                                        <div class="input-group date datePickers" data-date-format="mm-dd-yyyy">
                                            <asp:TextBox ID="txtScheduleFrom" ReadOnly="True" runat="server" class="form-control datePickers"></asp:TextBox>
                                            <span class="input-group-addon" id="Span1"><i class="icon-th"></i></span>
                                        </div>
                                    </div>
                                </div>
                                <div class="clearfix calTime">
                                    <div class="col-xs-3">
                                        <label for="adscheduleTo">To</label>
                                    </div>
                                    <div class="col-xs-9">
                                        <div class="input-group date datePickers" data-date-format="mm-dd-yyyy">
                                            <asp:TextBox ID="txtScheduleTo" ReadOnly="True" runat="server" class="form-control datePickers"></asp:TextBox>
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
                                            <asp:TextBox ID="txtScheduleFromAt" ReadOnly="True" runat="server" class="form-control timePickers"></asp:TextBox>
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
                                            <asp:TextBox ID="txtscheduleToAt" ReadOnly="True" runat="server" class="form-control timePickers"></asp:TextBox>
                                            <i class="icon-time"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-xs-12 clearfix">
                                <div class="col-xs-12">
                                    <asp:RadioButton runat="server" Text="Active Across Event Window" ID="rdbAccessAcrossEventWindow" Checked="True" GroupName="adactiveWindow" />
                                </div>
                            </div>
                            <div class="col-xs-12 clearfix">
                                <div class="col-xs-12">
                                    <asp:RadioButton runat="server" Text="Active Within Event Window" ID="rdbAccessWithinEventWindow" GroupName="adactiveWindow" />
                                </div>
                            </div>
                        </fieldset>
                    </div>
                    <div class="fieldset nomargin">
                        <fieldset>
                            <legend>
                                <input type="checkbox" class="control" id="adscheduleByDay"><label class="controlLabel" for="adscheduleByDay">Schedule by Day of Week</label></legend>
                            <table class="table scheduleTable fieldSwitch">
                                <tbody>
                                    <tr>
                                        <td>
                                            <input type="checkbox" id="adscheduleMonday"><label for="adscheduleMonday">Monday</label>
                                        </td>
                                        <td>
                                            <label for="adscheduleMondayFrom" class="pull-left">From</label>
                                            <div class="pull-right">
                                                <div class="bootstrap-timepicker input-group">
                                                    <asp:TextBox ID="txtScheduleMondayFrom" ReadOnly="True" runat="server" class="form-control timePickers"></asp:TextBox>
                                                    <i class="icon-time"></i>
                                                </div>
                                            </div>
                                        </td>
                                        <td>
                                            <label for="adscheduleMondayTo" class="pull-left">To</label>
                                            <div class="pull-right">
                                                <div class="bootstrap-timepicker input-group">
                                                    <asp:TextBox ID="txtScheduleMondayTo" ReadOnly="True" runat="server" class="form-control timePickers"></asp:TextBox>
                                                    <i class="icon-time"></i>
                                                </div>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <input type="checkbox" id="adscheduleTues"><label for="adscheduleTues">Tuesday</label>
                                        </td>
                                        <td>
                                            <label for="adscheduleTuesFrom" class="pull-left">From</label>
                                            <div class="pull-right">
                                                <div class="bootstrap-timepicker input-group">
                                                    <asp:TextBox ID="txtScheduleTueFrom" ReadOnly="True" runat="server" class="form-control timePickers"></asp:TextBox>
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
                                    <tr>
                                        <td>
                                            <input type="checkbox" id="adscheduleWed"><label for="adscheduleWed">Wednesday</label>
                                        </td>
                                        <td>
                                            <label for="adscheduleWedFrom" class="pull-left">From</label>
                                            <div class="pull-right">
                                                <div class="bootstrap-timepicker input-group">
                                                    <asp:TextBox ID="txtScheduleWedFrom" ReadOnly="True" runat="server" class="form-control timePickers"></asp:TextBox>
                                                    <i class="icon-time"></i>
                                                </div>
                                            </div>
                                        </td>
                                        <td>
                                            <label for="adscheduleWedTo" class="pull-left">To</label>
                                            <div class="pull-right">
                                                <div class="bootstrap-timepicker input-group">
                                                    <asp:TextBox ID="txtScheduleWedTo" ReadOnly="True" runat="server" class="form-control timePickers"></asp:TextBox>
                                                    <i class="icon-time"></i>
                                                </div>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <input type="checkbox" id="adscheduleThus"><label for="adscheduleThus">Thursday</label>
                                        </td>
                                        <td>
                                            <label for="adscheduleThusFrom" class="pull-left">From</label>
                                            <div class="pull-right">
                                                <div class="bootstrap-timepicker input-group">
                                                    <asp:TextBox ID="txtScheduleThuFrom" ReadOnly="True" runat="server" class="form-control timePickers"></asp:TextBox>
                                                    <i class="icon-time"></i>
                                                </div>
                                            </div>
                                        </td>
                                        <td>
                                            <label for="adscheduleThusTo" class="pull-left">To</label>
                                            <div class="pull-right">
                                                <div class="bootstrap-timepicker input-group">
                                                    <asp:TextBox ID="txtScheduleThuTo" ReadOnly="True" runat="server" class="form-control timePickers"></asp:TextBox>
                                                    <i class="icon-time"></i>
                                                </div>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <input type="checkbox" id="adscheduleFri"><label for="adscheduleFri">Friday</label>
                                        </td>
                                        <td>
                                            <label for="adschelblWebAppLoginScreenBrandingmage1duleFriFrom" class="pull-left">From</label>
                                            <div class="pull-right">
                                                <div class="bootstrap-timepicker input-group">
                                                    <asp:TextBox ID="txtScheduleFriFrom" ReadOnly="True" runat="server" class="form-control timePickers"></asp:TextBox>
                                                    <i class="icon-time"></i>
                                                </div>
                                            </div>
                                        </td>
                                        <td>
                                            <label for="adscheduleFriTo" class="pull-left">To</label>
                                            <div class="pull-right">
                                                <div class="bootstrap-timepicker input-group">
                                                    <asp:TextBox ID="txtScheduleFriTo" ReadOnly="True" runat="server" class="form-control timePickers"></asp:TextBox>
                                                    <i class="icon-time"></i>
                                                </div>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <input type="checkbox" id="adscheduleSat"><label for="adscheduleSat">Saturday</label>
                                        </td>
                                        <td>
                                            <label for="adscheduleSatFrom" class="pull-left">From</label>
                                            <div class="pull-right">
                                                <div class="bootstrap-timepicker input-group">
                                                    <asp:TextBox ID="txtScheduleSatFrom" ReadOnly="True" runat="server" class="form-control timePickers"></asp:TextBox>
                                                    <i class="icon-time"></i>
                                                </div>
                                            </div>
                                        </td>
                                        <td>
                                            <label for="adscheduleSatTo" class="pull-left">To</label>
                                            <div class="pull-right">
                                                <div class="bootstrap-timepicker input-group">
                                                    <asp:TextBox ID="txtScheduleSatTo" ReadOnly="True" runat="server" class="form-control timePickers"></asp:TextBox>
                                                    <i class="icon-time"></i>
                                                </div>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <input type="checkbox" id="adscheduleSun"><label for="adscheduleSun">Sunday</label>
                                        </td>
                                        <td>
                                            <label for="adscheduleSunFrom" class="pull-left">From</label>
                                            <div class="pull-right">
                                                <div class="bootstrap-timepicker input-group">
                                                    <asp:TextBox ID="txtScheduleSunFrom" ReadOnly="True" runat="server" class="form-control timePickers"></asp:TextBox>
                                                    <i class="icon-time"></i>
                                                </div>
                                            </div>
                                        </td>
                                        <td>
                                            <label for="adscheduleSunTo" class="pull-left">To</label>
                                            <div class="pull-right">
                                                <div class="bootstrap-timepicker input-group">
                                                    <asp:TextBox ID="txtScheduleSunTo" ReadOnly="True" runat="server" class="form-control timePickers"></asp:TextBox>
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
            </div>
            <asp:HiddenField runat="server" ID="hdnScheduleId" Value="0" />
        </ContentTemplate>
    </asp:UpdatePanel>
</div>
<script type="text/javascript">
    function RegisterScript() {
        var fieldSwitch = $('.fieldSwitch');
        var legendSwitch = $('.fieldset legend input');
        fieldSwitch.find('input, select').prop('disabled', true);
        //$('.input-group-addon').parent().removeClass('dis');
        legendSwitch.on('click', function () {
            if ($(this).is(':checked')) {
                $(this).parent().next('.fieldSwitch').find('input, select').prop('disabled', false);
                //$('.input-group-addon').parent().addClass('dis');
            }
            else {
                $(this).parent().next('.fieldSwitch').find('input, select').prop('disabled', true);
                $(this).parent().next('.fieldSwitch').find('input').removeAttr("checked");
                //$('.input-group-addon').parent().removeClass('dis');
            }
        });
    }
</script>

