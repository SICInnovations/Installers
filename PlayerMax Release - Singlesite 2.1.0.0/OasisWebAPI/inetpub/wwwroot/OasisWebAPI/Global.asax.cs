using HA.Logging;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.SessionState;

namespace HA.OasisWebAPI.ATIGateway
{
    public class Global : System.Web.HttpApplication
    {


        private static readonly HALogger _logger = new HALogger(typeof(Global));

        void Application_Start(object sender, EventArgs e)
        {

            log4net.Config.XmlConfigurator.Configure(new FileInfo(Server.MapPath("~/Web.config")));
        }

        void Application_End(object sender, EventArgs e)
        {
            //  Code that runs on application shutdown
        }

        void Application_Error(object sender, EventArgs e)
        {
            Exception ex = Server.GetLastError();
            _logger.FatalFormat(ex.TargetSite, ex.Message);
        }
    }
}