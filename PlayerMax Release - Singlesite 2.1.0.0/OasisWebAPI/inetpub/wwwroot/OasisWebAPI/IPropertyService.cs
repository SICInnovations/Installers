using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.Text;
using HA.OasisWebAPI.ATIGateway.DTO;
using HA.OasisWebAPI.DB;


namespace HA.OasisWebAPI.ATIGateway
{
    // NOTE: You can use the "Rename" command on the "Refactor" menu to change the interface name "IIPropertyService" in both code and config file together.
    [ServiceContract]
    public interface IPropertyService
    {
        [OperationContract]
        PropertyProfile GetProperyInfo(bool iGetPropertyProfile, bool? iGetInternals = null, bool? iGetPropertyAddress = null, bool? iGetDepartments = null, bool? iGetAccountTypes = null, bool? iGetClub = null, bool? iGetGroup = null, bool? iGetArea = null, bool? iGetZone = null, bool? iGetSection = null, bool? iGetGame = null, bool? iGetTheme = null, bool? iGetPaytable = null, bool? iGetMultiGroup = null, bool? iGetChipSet = null, bool? iGetShift = null, bool? iGetCEQ = null, bool? iGetCalculation = null, bool? iGetIdentificationTypes = null, bool? iGetExternalIDType = null, bool? iGetLocations = null, bool? iGetEmployee = null, bool? iGetJobCodes = null);
    }
}
