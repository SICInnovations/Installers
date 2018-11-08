using HA.Logging;
using HA.OasisWebAPI.ATIGateway.DTO;
using HA.OasisWebAPI.Entities;
using System;

namespace HA.OasisWebAPI.ATIGateway
{
    // NOTE: You can use the "Rename" command on the "Refactor" menu to change the class name "IPropertyService" in code, svc and config file together.
    // NOTE: In order to launch WCF Test Client for testing this service, please select IPropertyService.svc or IPropertyService.svc.cs at the Solution Explorer and start debugging.
    public class PropertyService : IPropertyService
    {
        private static readonly HALogger _logger = new HALogger(typeof(PropertyService));

        public PropertyProfile GetProperyInfo(bool iGetPropertyProfile, bool? iGetInternals = null, bool? iGetPropertyAddress = null, bool? iGetDepartments = null, bool? iGetAccountTypes = null, bool? iGetClub = null, bool? iGetGroup = null, bool? iGetArea = null, bool? iGetZone = null, bool? iGetSection = null, bool? iGetGame = null, bool? iGetTheme = null, bool? iGetPaytable = null, bool? iGetMultiGroup = null, bool? iGetChipSet = null, bool? iGetShift = null, bool? iGetCEQ = null, bool? iGetCalculation = null, bool? iGetIdentificationTypes = null, bool? iGetExternalIDType = null, bool? iGetLocations = null, bool? iGetEmployee = null, bool? iGetJobCodes = null)
        {
            PropertyProfile propertyProfile = null;
            try
            {
                PropertyInfoContext propertyInfoContext = new PropertyInfoContext();
                propertyProfile = propertyInfoContext.GetProperyInfo(iGetPropertyProfile, iGetInternals, 
                    iGetPropertyAddress, iGetDepartments, iGetAccountTypes, iGetClub, iGetGroup, iGetArea, iGetZone, iGetSection, 
                    iGetGame, iGetTheme, iGetPaytable, iGetMultiGroup, iGetChipSet, iGetShift, iGetCEQ, iGetCalculation, 
                    iGetIdentificationTypes, iGetExternalIDType, iGetLocations, iGetEmployee, iGetJobCodes);

                if (propertyProfile == null)
                    _logger.InfoFormat(propertyProfile, "No ProperyInfo has found.", "GetProperyInfo");
                else
                    _logger.InfoFormat(propertyProfile, "ProperyInfo has found.", "GetProperyInfo");                                                                        
            }
            catch (Exception ex)
            {
                _logger.ErrorFormat(ex.TargetSite, ex.Message, ex.Source, "GetProperyInfo");
            }
            return propertyProfile;
        }
    }
}
