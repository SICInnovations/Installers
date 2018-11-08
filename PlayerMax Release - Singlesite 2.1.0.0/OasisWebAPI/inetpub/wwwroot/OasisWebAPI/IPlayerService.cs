using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.ServiceModel.Web;
using System.Text;
using HA.OasisWebAPI.Entities;
using HA.OasisWebAPI.ATIGateway;
using HA.OasisWebAPI.ATIGateway.DTO;
namespace HA.OasisWebAPI.ATIGateway
{

    // NOTE: You can use the "Rename" command on the "Refactor" menu to change the interface name "IService1" in both code and config file together.
    [ServiceContract]
    public interface IPlayerService
    {
        #region Get For Single Player Profile

        [OperationContract]
        List<PlayerAddress> GetPlayerAddress(Int32? LinkedPlayerID);

        [OperationContract]
        List<PlayerPhone> GetPlayerPhone(Int32? LinkedPlayerID);

        [OperationContract]
        List<PlayerEmail> GetPlayerEmail(Int32 LinkedPlayerID);

        [OperationContract]
        List<PlayerIdent> GetPlayerPersonalID(Int32 LinkedPlayerID);

        [OperationContract]
        List<PlayerImage> GetPlayerImage(Int32 LinkedPlayerID);

        [OperationContract]
        List<PlayerComment> GetPlayerMemo(Int32 LinkedPlayerID);

        [OperationContract]
        List<PlayerStop> GetPlayerStop(Int32 LinkedPlayerID);

        [OperationContract]
        List<PlayerLink> GetPlayerLink(Int32 LinkedPlayerID);

        [OperationContract]
        List<PlayerCard> GetPlayerCard(Int32 LinkedPlayerID);

        [OperationContract]
        List<PlayerKeyPair> GetPlayerKeyPair(Int32 LinkedPlayerID);

        [OperationContract]
        PlayerAccountBalance GetPlayerAccountBalance(int LinkedPlayerID);

        [OperationContract]
        List<PlayerExternalID> GetPlayerExternalId(Int32 LinkedPlayerID);

        [OperationContract]
        PlayerInfo GetPlayerById(int iPlayerID, bool? iReturnCard = null, bool? iReturnAddress = null, bool? iReturnPhone = null, bool? iReturnEmail = null, bool? iReturnPersonalID = null, bool? iReturnMemo = null, bool? iReturnAcctBalances = null, bool? iReturnGroups = null, bool? iReturnLinkedIDs = null, bool? iReturnOffers = null, bool? iReturnExternalIDs = null);

        [OperationContract]
        List<PlayerInfo> GetPlayerList(Int32? RecordCount, Int32? RecordSeed);

        [OperationContract]
        PlayerProfile SearchPlayers(int? iRecordCount = null, int? iRecordSeed = null);

        [OperationContract]
        List<PlayerOffers> GetPlayerOffers(Int32 LinkedPlayerID);

        #endregion


        #region Add/Update PlayerAddress

        /// <summary>
        /// Adds the player address.
        /// </summary>
        /// <param name="playerAddressList">The player address list.</param>
        /// <param name="LinkedPlayerID">The player id.</param>
        //[OperationContract]
        //int AddPlayerAddress(List<PlayerAddress> playerAddressList, int LinkedPlayerID);


        /// <summary>
        /// Updates the player address.
        /// </summary>
        /// <param name="playerAddressList">The player address list.</param>
        /// <param name="LinkedPlayerID">The player id.</param>
        [OperationContract]
        int UpdatePlayerAddress(List<PlayerAddress> playerAddressList, int LinkedPlayerID);

        #endregion

        #region Add PlayerExternalId

        /// <summary>
        /// Add ExternalId of Player.
        /// </summary>
        /// <param name="LinkedPlayerID">The player id.</param>
        /// <param name="externalId">The external id.</param>
        /// <param name="externalSystemName">Name of the external system.</param>
        /// <exception cref="System.NotImplementedException"></exception>
        [OperationContract]
        int AddPlayerExternalId(Int32 LinkedPlayerID, PlayerExternalID PlayerExternalId);

        [OperationContract]
        int UpdatePlayerExternalId(Int32 playerId, PlayerExternalID PlayerExternalId);

        #endregion

        #region Add/Update PlayerPhone

        /// <summary>
        /// Adds the player phone.
        /// </summary>
        /// <param name="phone">The phone.</param>
        /// <param name="LinkedPlayerID">The player id.</param>
        //[OperationContract]
        //int AddPlayerPhone(List<PlayerPhone> phones, int LinkedPlayerID);


        /// <summary>
        /// Updates the player phone.
        /// </summary>
        /// <param name="phone">The phone.</param>
        /// <param name="LinkedPlayerID">The player id.</param>
        [OperationContract]
        int UpdatePlayerPhone(List<PlayerPhone> phones, int LinkedPlayerID);


        #endregion

        #region Add/Update PlayerEmail

        /// <summary>
        /// Adds the player email.
        /// </summary>
        /// <param name="emails">The email.</param>
        /// <param name="LinkedPlayerID">The player id.</param>
        //[OperationContract]
        //int AddPlayerEmail(List<PlayerEmail> emails, int LinkedPlayerID);

        /// <summary>
        /// Updates the player email.
        /// </summary>
        /// <param name="emails">The email.</param>
        /// <param name="LinkedPlayerID">The player id.</param>
        [OperationContract]
        int UpdatePlayerEmail(List<PlayerEmail> emails, int LinkedPlayerID);

        #endregion

        /// <summary>
        /// Gets the player id by card number.
        /// </summary>
        /// <param name="cardNumber">The card number.</param>
        /// <returns>
        /// LinkedPlayerID associated with card number
        /// </returns>        
        [OperationContract]
        int? GetPlayerIdByCardNumber(string cardNumber);

        /// <summary>
        /// Validates the PIN.
        /// </summary>
        /// <param name="LinkedPlayerID">The player id.</param>
        /// <param name="pinByte">The pin byte.</param>
        /// <returns>
        /// True if PIN is valid
        /// </returns>
        [OperationContract]
        string ValidatePIN(int LinkedPlayerID, string pinString);

        /// <summary>
        /// Adds the player.
        /// </summary>
        /// <param name="playerprofile">The player info.</param>
        /// <returns>
        /// LinkedPlayerID
        /// </returns>
        /// <exception cref="System.ArgumentNullException"></exception>
        [OperationContract]
        int AddPlayer(PlayerInfo playerInfo);


        #region Add/Update PlayerProfile
        //[OperationContract]
        //int AddPlayerProflie(PlayerInfo playerObject);

        [OperationContract]
        int UpdatePlayerProflie(PlayerInfo playerObject);
        #endregion

        #region Add/Update PlayerImage

        [OperationContract]
        int AddPlayerImage(List<PlayerImage> playerImageList, Int32 LinkedPlayerID);

        [OperationContract]
        int UpdatePlayerImage(List<PlayerImage> playerImageList, Int32 LinkedPlayerID);

        #endregion


        [OperationContract]
        int? GetPlayerIdByExternalID(string ExternalId, string ExternalIDTypeID);


        #region Add/Update player Identification

        [OperationContract]
        int AddPlayerIdentification(List<PlayerIdent> playerIdentList, Int32 LinkedPlayerID);

        [OperationContract]
        int UpdatePlayerIdentification(List<PlayerIdent> playerIdentList, Int32 LinkedPlayerID);

        #endregion


        #region Add/Update PlayerMemo

        [OperationContract]
        int AddPlayerMemo(List<PlayerComment> playercommentList, int playerId);

        [OperationContract]
        int UpdatePlayerMemo(List<PlayerComment> playercommentList, int playerId);

        #endregion

        [OperationContract]
        Boolean DapPlayer(string clubNumber);
    }
}
