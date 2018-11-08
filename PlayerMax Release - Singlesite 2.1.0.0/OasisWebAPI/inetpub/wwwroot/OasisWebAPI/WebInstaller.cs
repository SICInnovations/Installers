using System.Collections;
using System.ComponentModel;
using System.Configuration;
using System.Configuration.Install;
using System.DirectoryServices;
using System.Web.Configuration;

namespace HA.OasisWebAPI.ATIGateway
{
    [RunInstaller(true)]
    public partial class WebInstaller : System.Configuration.Install.Installer
    {
        const string PROVIDE_NMAE = "System.Data.SqlClient";
        public const string DATABASE_CONNECTION_KEY = "OasisWebAPIDBConnectionString";

        public WebInstaller()
        {
            InitializeComponent();
        }

        public override void Install(IDictionary stateSaver)
        {
            base.Install(stateSaver);

            string targetSite = Context.Parameters["targetsite"];
            string targetVDir = Context.Parameters["targetvdir"];
            string targetDirectory = Context.Parameters["targetdir"];
            string connectionString = Context.Parameters["OASISWEBAPICONNSTRING"];

            if (targetSite == null)
                throw new InstallException("IIS Site Name Not Specified!");

            if (targetSite.StartsWith("/LM/"))
                targetSite = targetSite.Substring(4);

            ConfigureDatabase(targetSite, targetVDir, connectionString, null, null);
        }

        void ConfigureDatabase(string targetSite, string targetVDir, string connectionString, string connectionstringBallys, string connectionstringHollywoodBR)
        {
            // Retrieve "Friendly Site Name" from IIS for TargetSite
            DirectoryEntry entry = new DirectoryEntry("IIS://LocalHost/" + targetSite);
            string friendlySiteName = entry.Properties["ServerComment"].Value.ToString();

            // Open Application's Web.Config
            Configuration config = WebConfigurationManager.OpenWebConfiguration("/" + targetVDir, friendlySiteName);

            // Create and add new connection string setting for KIOSK web.config
            ConnectionStringSettings appDatabase = new ConnectionStringSettings();
            appDatabase.Name = DATABASE_CONNECTION_KEY;
            appDatabase.ProviderName = PROVIDE_NMAE;
            appDatabase.ConnectionString = connectionString;

            config.ConnectionStrings.ConnectionStrings.Clear();
            config.ConnectionStrings.ConnectionStrings.Add(appDatabase); ;

            config.ConnectionStrings.ConnectionStrings[DATABASE_CONNECTION_KEY].ConnectionString = connectionString;

            config.Save();
        }

    }
}
