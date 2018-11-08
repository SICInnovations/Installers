using HA.OasisWebAPI.ATIGateway.DTO;
using System.Collections.Generic;
using System.ServiceModel;

namespace HA.OasisWebAPI.ATIGateway
{
    // NOTE: You can use the "Rename" command on the "Refactor" menu to change the interface name "IHostService" in both code and config file together.
    [ServiceContract]
    public interface IHostService
    {
        [OperationContract]
        HostInfo GetHostInformation(string PlayerID);
    }
}
