using HA.Logging;
using HA.OasisWebAPI.ATIGateway.DTO;
using HA.OasisWebAPI.Entities;
using System;

namespace HA.OasisWebAPI.ATIGateway
{
    // NOTE: You can use the "Rename" command on the "Refactor" menu to change the class name "HostService" in code, svc and config file together.
    // NOTE: In order to launch WCF Test Client for testing this service, please select HostService.svc or HostService.svc.cs at the Solution Explorer and start debugging.
    public class HostService : IHostService
    {
        private static readonly HALogger _logger = new HALogger(typeof(HostService));

        public HostInfo GetHostInformation(string PlayerID)
        {
            HostInfo hostList = null;
            try
            {
                HostInfoContext objGameInfoContext = new HostInfoContext();
                hostList = objGameInfoContext.GetHostInformation(PlayerID);
                if (hostList == null)
                    _logger.InfoFormat(hostList, "No HostInformation has found for this PlayerID : " + PlayerID, "GetHostInformation");
                else
                    _logger.InfoFormat(hostList, "HostInformation has found.", "GetHostInformation");
            }
            catch (Exception ex)
            {
                _logger.ErrorFormat(ex.TargetSite, ex.Message, ex.Source, "GetHostInformation");
            }
            return hostList;
        }

    }
}
