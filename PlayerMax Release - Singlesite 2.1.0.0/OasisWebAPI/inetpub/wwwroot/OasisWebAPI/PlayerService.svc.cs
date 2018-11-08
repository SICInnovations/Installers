using System;
using System.Collections.Generic;
using HA.OasisWebAPI.Entities;
using HA.OasisWebAPI.ATIGateway.DTO;
using HA.Logging;

namespace HA.OasisWebAPI.ATIGateway
{
    // NOTE: You can use the "Rename" command on the "Refactor" menu to change the class name "Service1" in code, svc and config file together.
    // NOTE: In order to launch WCF Test Client for testing this service, please select Service1.svc or Service1.svc.cs at the Solution Explorer and start debugging.
    public class PlayerService : IPlayerService
    {
        private static readonly HALogger _logger = new HALogger(typeof(PlayerService));

        #region Get For Single Player Profile

        public List<PlayerAddress> GetPlayerAddress(int? LinkedPlayerID)
        {
            List<PlayerAddress> playerAddressList = null;
            try
            {
                PlayerInfoContext objPlayerInfoContext = new PlayerInfoContext();
                playerAddressList = objPlayerInfoContext.GetPlayerAddress(LinkedPlayerID);
                if (playerAddressList.Count > 0)
                    _logger.InfoFormat(playerAddressList, playerAddressList.Count.ToString() + " PlayerAddress has found for LinkedPlayerID : " + LinkedPlayerID.ToString(), "GetPlayerAddress");
                else
                    _logger.InfoFormat(playerAddressList, "No PlayerAddress has found for LinkedPlayerID : " + LinkedPlayerID.ToString(), "GetPlayerAddress");
            }
            catch (Exception ex)
            {
                _logger.ErrorFormat(ex.TargetSite, ex.Message, ex.Source, "GetPlayerAddress");
            }
            return playerAddressList;
        }

        public List<PlayerPhone> GetPlayerPhone(int? LinkedPlayerID)
        {
            List<PlayerPhone> playerPhoneList = null;
            try
            {
                PlayerInfoContext objPlayerInfoContext = new PlayerInfoContext();
                playerPhoneList = objPlayerInfoContext.GetPlayerPhone(LinkedPlayerID);
                if (playerPhoneList.Count > 0)
                    _logger.InfoFormat(playerPhoneList, playerPhoneList.Count.ToString() + " PlayerPhone has found for LinkedPlayerID : " + LinkedPlayerID.ToString(), "GetPlayerPhone");
                else
                    _logger.InfoFormat(playerPhoneList, "No PlayerPhone has found for LinkedPlayerID : " + LinkedPlayerID.ToString(), "GetPlayerPhone");
            }
            catch (Exception ex)
            {
                _logger.ErrorFormat(ex.TargetSite, ex.Message, ex.Source, "GetPlayerPhone");
            }
            return playerPhoneList;
        }

        public List<PlayerEmail> GetPlayerEmail(int LinkedPlayerID)
        {
            List<PlayerEmail> playerEmailList = null;
            try
            {
                PlayerInfoContext objPlayerInfoContext = new PlayerInfoContext();
                playerEmailList = objPlayerInfoContext.GetPlayerEmail(LinkedPlayerID);
                if (playerEmailList.Count > 0)
                    _logger.InfoFormat(playerEmailList, playerEmailList.Count.ToString() + " PlayerEmail has found for LinkedPlayerID : " + LinkedPlayerID.ToString(), "GetPlayerEmail");
                else
                    _logger.InfoFormat(playerEmailList, "No PlayerEmail has found for LinkedPlayerID : " + LinkedPlayerID.ToString(), "GetPlayerEmail");
            }
            catch (Exception ex)
            {
                _logger.ErrorFormat(ex.TargetSite, ex.Message, ex.Source, "GetPlayerEmail");
            }
            return playerEmailList;
        }

        public List<PlayerIdent> GetPlayerPersonalID(int LinkedPlayerID)
        {
            List<PlayerIdent> playerIdentList = null;
            try
            {
                PlayerInfoContext objPlayerInfoContext = new PlayerInfoContext();
                playerIdentList = objPlayerInfoContext.GetPlayerPersonalID(LinkedPlayerID);
                if (playerIdentList.Count > 0)
                    _logger.InfoFormat(playerIdentList, playerIdentList.Count.ToString() + " PlayerPersonalID has found for LinkedPlayerID : " + LinkedPlayerID.ToString(), "GetPlayerPersonalID");
                else
                    _logger.InfoFormat(playerIdentList, "No PlayerPersonalID has found for LinkedPlayerID : " + LinkedPlayerID.ToString(), "GetPlayerPersonalID");
            }
            catch (Exception ex)
            {
                _logger.ErrorFormat(ex.TargetSite, ex.Message, ex.Source, "GetPlayerPersonalID");
            }
            return playerIdentList;
        }

        public List<PlayerImage> GetPlayerImage(int LinkedPlayerID)
        {
            List<PlayerImage> playerImageList = null;
            try
            {
                PlayerInfoContext objPlayerInfoContext = new PlayerInfoContext();
                playerImageList = objPlayerInfoContext.GetPlayerImage(LinkedPlayerID);
                if (playerImageList.Count > 0)
                    _logger.InfoFormat(playerImageList, playerImageList.Count.ToString() + " PlayerImage has found for LinkedPlayerID : " + LinkedPlayerID.ToString(), "GetPlayerImage");
                else
                    _logger.InfoFormat(playerImageList, "No PlayerImage has found for LinkedPlayerID : " + LinkedPlayerID.ToString(), "GetPlayerImage");
            }
            catch (Exception ex)
            {
                _logger.ErrorFormat(ex.TargetSite, ex.Message, ex.Source, "GetPlayerImage");
            }
            return playerImageList;
        }

        public List<PlayerComment> GetPlayerMemo(int LinkedPlayerID)
        {
            List<PlayerComment> PlayerCommentList = null;
            try
            {
                PlayerInfoContext objPlayerInfoContext = new PlayerInfoContext();
                PlayerCommentList = objPlayerInfoContext.GetPlayerMemo(LinkedPlayerID);
                if (PlayerCommentList.Count > 0)
                    _logger.InfoFormat(PlayerCommentList, PlayerCommentList.Count.ToString() + " PlayerComment has found for LinkedPlayerID : " + LinkedPlayerID.ToString(), "GetPlayerMemo");
                else
                    _logger.InfoFormat(PlayerCommentList, "No PlayerComment has found for LinkedPlayerID : " + LinkedPlayerID.ToString(), "GetPlayerMemo");
            }
            catch (Exception ex)
            {
                _logger.ErrorFormat(ex.TargetSite, ex.Message, ex.Source, "GetPlayerMemo");
            }
            return PlayerCommentList;
        }

        public List<PlayerStop> GetPlayerStop(int LinkedPlayerID)
        {
            List<PlayerStop> PlayerStopList = null;
            try
            {
                PlayerInfoContext objPlayerInfoContext = new PlayerInfoContext();
                PlayerStopList = objPlayerInfoContext.GetPlayerStop(LinkedPlayerID);
                if (PlayerStopList.Count > 0)
                    _logger.InfoFormat(PlayerStopList, PlayerStopList.Count.ToString() + " PlayerStop has found for LinkedPlayerID : " + LinkedPlayerID.ToString(), "GetPlayerStop");
                else
                    _logger.InfoFormat(PlayerStopList, "No PlayerStop has found for LinkedPlayerID : " + LinkedPlayerID.ToString(), "GetPlayerStop");
            }
            catch (Exception ex)
            {
                _logger.ErrorFormat(ex.TargetSite, ex.Message, ex.Source, "GetPlayerStop");
            }
            return PlayerStopList;
        }

        public List<PlayerLink> GetPlayerLink(int LinkedPlayerID)
        {
            List<PlayerLink> playerLinkList = null;
            try
            {
                PlayerInfoContext objPlayerInfoContext = new PlayerInfoContext();
                playerLinkList = objPlayerInfoContext.GetPlayerLink(LinkedPlayerID);
                if (playerLinkList.Count > 0)
                    _logger.InfoFormat(playerLinkList, playerLinkList.Count.ToString() + " PlayerLink has found for LinkedPlayerID : " + LinkedPlayerID.ToString(), "GetPlayerLink");
                else
                    _logger.InfoFormat(playerLinkList, "No PlayerLink has found for LinkedPlayerID : " + LinkedPlayerID.ToString(), "GetPlayerLink");
            }
            catch (Exception ex)
            {
                _logger.ErrorFormat(ex.TargetSite, ex.Message, ex.Source, "GetPlayerLink");
            }
            return playerLinkList;
        }

        public List<PlayerCard> GetPlayerCard(int LinkedPlayerID)
        {
            List<PlayerCard> playerCardList = null;
            try
            {
                PlayerInfoContext objPlayerInfoContext = new PlayerInfoContext();
                playerCardList = objPlayerInfoContext.GetPlayerCard(LinkedPlayerID);
                if (playerCardList.Count > 0)
                    _logger.InfoFormat(playerCardList, playerCardList.Count.ToString() + " PlayerCard has found for LinkedPlayerID : " + LinkedPlayerID.ToString(), "GetPlayerCard");
                else
                    _logger.InfoFormat(playerCardList, "No PlayerCard has found for LinkedPlayerID : " + LinkedPlayerID.ToString(), "GetPlayerCard");
            }
            catch (Exception ex)
            {
                _logger.ErrorFormat(ex.TargetSite, ex.Message, ex.Source, "GetPlayerCard");
            }
            return playerCardList;
        }

        public List<PlayerKeyPair> GetPlayerKeyPair(int LinkedPlayerID)
        {
            List<PlayerKeyPair> playerKeyPairList = null;
            try
            {
                PlayerInfoContext objPlayerInfoContext = new PlayerInfoContext();
                playerKeyPairList = objPlayerInfoContext.GetPlayerKeyPair(LinkedPlayerID);
                if (playerKeyPairList.Count > 0)
                    _logger.InfoFormat(playerKeyPairList, playerKeyPairList.Count.ToString() +" PlayerKeyPair has found for LinkedPlayerID : " + LinkedPlayerID.ToString(), "GetPlayerKeyPair");
                else
                    _logger.InfoFormat(playerKeyPairList, "No PlayerKeyPair has found for LinkedPlayerID : " + LinkedPlayerID.ToString(), "GetPlayerKeyPair");
            }
            catch (Exception ex)
            {
                _logger.ErrorFormat(ex.TargetSite, ex.Message, ex.Source, "GetPlayerKeyPair");
            }
            return playerKeyPairList;
        }

        public PlayerAccountBalance GetPlayerAccountBalance(int LinkedPlayerID)
        {
            PlayerAccountBalance playerAccountList = null;
            try
            {
                PlayerInfoContext objPlayerInfoContext = new PlayerInfoContext();
                playerAccountList = objPlayerInfoContext.GetPlayerAccountBalance(LinkedPlayerID);
                if (playerAccountList != null)
                    _logger.InfoFormat(playerAccountList, "PlayerAccountBalance has found for LinkedPlayerID : " + LinkedPlayerID.ToString(), "GetPlayerAccountBalance");
                else
                    _logger.InfoFormat(playerAccountList, "No PlayerAccountBalance has found for LinkedPlayerID : " + LinkedPlayerID.ToString(), "GetPlayerAccountBalance");
            }
            catch (Exception ex)
            {
                _logger.ErrorFormat(ex.TargetSite, ex.Message, ex.Source, "GetPlayerAccountBalance");
            }
            return playerAccountList;
        }

        public List<PlayerExternalID> GetPlayerExternalId(int LinkedPlayerID)
        {
            List<PlayerExternalID> playerExternalIdList = null;
            try
            {
                PlayerInfoContext objplayerInfoContext = new PlayerInfoContext();
                playerExternalIdList = objplayerInfoContext.GetPlayerExternalId(LinkedPlayerID);
                if (playerExternalIdList.Count > 0)
                    _logger.InfoFormat(playerExternalIdList, playerExternalIdList.Count +" ExternalId has found for LinkedPlayerID : " + LinkedPlayerID.ToString(), "GetPlayerExternalId");
                else
                    _logger.InfoFormat(playerExternalIdList, "No ExternalId has found for LinkedPlayerID : " + LinkedPlayerID.ToString(), "GetPlayerExternalId");
            }
            catch (Exception ex)
            {
                _logger.ErrorFormat(ex.TargetSite, ex.Message, ex.Source, "GetPlayerExternalId");
            }
            return playerExternalIdList;
        }

        public PlayerInfo GetPlayerById(int iPlayerID, bool? iReturnCard = null, bool? iReturnAddress = null, bool? iReturnPhone = null, bool? iReturnEmail = null, bool? iReturnPersonalID = null, bool? iReturnMemo = null, bool? iReturnAcctBalances = null, bool? iReturnGroups = null, bool? iReturnLinkedIDs = null, bool? iReturnOffers = null, bool? iReturnExternalIDs = null)
        {
            PlayerInfo playerInfo = null;
            try
            {
                PlayerInfoContext playerInfoContext = new PlayerInfoContext();
                playerInfo = playerInfoContext.GetPlayerById(iPlayerID, iReturnCard, iReturnAddress, iReturnPhone, iReturnEmail, iReturnPersonalID, iReturnMemo, iReturnAcctBalances, iReturnGroups, iReturnLinkedIDs, iReturnOffers, iReturnExternalIDs);
                if (playerInfo != null)
                    _logger.InfoFormat(playerInfo, "Player has found for PlayerID : " + iPlayerID.ToString(), "GetPlayerById");
                else
                    _logger.InfoFormat(playerInfo, "No Player has found for PlayerID : " + iPlayerID.ToString(), "GetPlayerById");
            }
            catch (Exception ex)
            {
                _logger.ErrorFormat(ex.TargetSite, ex.Message, ex.Source, "GetPlayerById");
            }
            return playerInfo;
        }

        public List<PlayerInfo> GetPlayerList(int? RecordCount, int? RecordSeed)
        {
            List<PlayerInfo> PlayerInfoList = null;
            try
            {
                PlayerInfoContext playerInfoContext = new PlayerInfoContext();
                PlayerInfoList = playerInfoContext.GetPlayerList(RecordCount, RecordSeed);
                if (PlayerInfoList.Count > 0)
                    _logger.InfoFormat(PlayerInfoList, PlayerInfoList.Count + " PlayerInfo has found.", "GetPlayerList");
                else
                    _logger.InfoFormat(PlayerInfoList, "No PlayerInfo has found.", "GetPlayerList");
            }
            catch (Exception ex)
            {
                _logger.ErrorFormat(ex.TargetSite, ex.Message, ex.Source, "GetPlayerList");
            }
            return PlayerInfoList;
        }

        public PlayerProfile SearchPlayers(int? iRecordCount = null, int? iRecordSeed = null)
        {
            PlayerProfile PlayerProfileList = null;
            try
            {
                PlayerInfoContext playerInfoContext = new PlayerInfoContext();
                PlayerProfileList = playerInfoContext.SearchPlayers(null, null, null,
                null, null, null, null, null, null, null, null, null,
                null, iRecordCount, iRecordSeed, null, null, null, null, null,
                null, null, null, null, null);
                if (PlayerProfileList == null)
                    _logger.InfoFormat(PlayerProfileList, "No PlayerProfile has found.", "SearchPlayers");
                else
                    _logger.InfoFormat(PlayerProfileList, "PlayerProfileList has found.", "SearchPlayers");

            }
            catch (Exception ex)
            {
                _logger.ErrorFormat(ex.TargetSite, ex.Message, ex.Source, "SearchPlayers");
            }
            return PlayerProfileList;
        }

        #endregion


        #region Add/Update PlayerAddress

        //public int AddPlayerAddress(List<PlayerAddress> playerAddressList, int LinkedPlayerID)
        //{
        //    try
        //    {
        //        PlayerInfoContext playerInfoContext = new PlayerInfoContext();
        //        int result = playerInfoContext.AddPlayerAddress(playerAddressList, LinkedPlayerID);
        //        return result;
        //    }
        //    catch (Exception ex)
        //    {
        //        throw ex;
        //    }
        //}

        public int UpdatePlayerAddress(List<PlayerAddress> playerAddressList, int LinkedPlayerID)
        {
            int result = 1;
            try
            {
                PlayerInfoContext playerInfoContext = new PlayerInfoContext();
                result = playerInfoContext.UpdatePlayerAddress(playerAddressList, LinkedPlayerID);
                if (result == 0)
                    _logger.InfoFormat(result, "Player Address has updated successfully", "UpdatePlayerAddress");
                else
                    _logger.InfoFormat(result, "Player Address can't updated successfully. some error occurred", "UpdatePlayerAddress");
            }
            catch (Exception ex)
            {
                _logger.ErrorFormat(ex.TargetSite, ex.Message, ex.Source, "UpdatePlayerAddress");
            }
            return result;
        }

        #endregion


        #region Add/Update PlayerPhone

        //public int AddPlayerPhone(List<PlayerPhone> phones, int LinkedPlayerID)
        //{
        //    try
        //    {
        //        PlayerInfoContext playerInfoContext = new PlayerInfoContext();
        //        int player = playerInfoContext.AddPlayerPhone(phones, LinkedPlayerID);
        //        return player;
        //    }
        //    catch (Exception ex)
        //    {
        //        throw ex;
        //    }
        //}

        public int UpdatePlayerPhone(List<PlayerPhone> phones, int LinkedPlayerID)
        {
            int result = 1;
            try
            {
                PlayerInfoContext playerInfoContext = new PlayerInfoContext();
                result = playerInfoContext.UpdatePlayerPhone(phones, LinkedPlayerID);
                if (result == 0)
                    _logger.InfoFormat(result, "Player Phone has updated successfully", "UpdatePlayerPhone");
                else
                    _logger.InfoFormat(result, "Player Phone can't updated successfully. some error occurred", "UpdatePlayerPhone");
            }
            catch (Exception ex)
            {
                _logger.ErrorFormat(ex.TargetSite, ex.Message, ex.Source, "UpdatePlayerPhone");
            }
            return result;
        }

        #endregion


        #region Add/Update PlayerEmail

        //public int AddPlayerEmail(List<PlayerEmail> emails, int LinkedPlayerID)
        //{
        //    try
        //    {
        //        PlayerInfoContext playerInfoContext = new PlayerInfoContext();
        //        int result = playerInfoContext.AddPlayerEmail(emails, LinkedPlayerID);
        //        return result;
        //    }
        //    catch (Exception ex)
        //    {
        //        throw ex;
        //    }
        //}

        public int UpdatePlayerEmail(List<PlayerEmail> emails, int LinkedPlayerID)
        {
            int result = 1;
            try
            {
                PlayerInfoContext playerInfoContext = new PlayerInfoContext();
                result = playerInfoContext.UpdatePlayerEmail(emails, LinkedPlayerID);
                if (result == 0)
                    _logger.InfoFormat(result, "Player Email has updated successfully", "UpdatePlayerEmail");
                else
                    _logger.InfoFormat(result, "Player Email can't updated successfully. some error occurred", "UpdatePlayerEmail");
            }
            catch (Exception ex)
            {
                _logger.ErrorFormat(ex.TargetSite, ex.Message, ex.Source, "UpdatePlayerEmail");
            }
            return result;
        }

        #endregion


        #region Add/Update PlayerExternalID

        public int AddPlayerExternalId(int playerId, PlayerExternalID PlayerExternalId)
        {
            int result = 1;
            try
            {
                PlayerInfoContext playerInfoContext = new PlayerInfoContext();
                result = playerInfoContext.AddPlayerExternalId(playerId, PlayerExternalId);
                if (result == 0)
                    _logger.InfoFormat(result, "Player ExternalID has added successfully", "AddPlayerExternalId");
                else
                    _logger.InfoFormat(result, "Player ExternalID can't added successfully. some error occurred", "AddPlayerExternalId");
            }
            catch (Exception ex)
            {
                _logger.ErrorFormat(ex.TargetSite, ex.Message, ex.Source, "AddPlayerExternalId");
            }
            return result;
        }

        public int UpdatePlayerExternalId(Int32 playerId, PlayerExternalID PlayerExternalId)
        {
            int result = 1;
            try
            {
                PlayerInfoContext playerInfoContext = new PlayerInfoContext();
                result = playerInfoContext.UpdatePlayerExternalId(playerId, PlayerExternalId);
                if (result == 0)
                    _logger.InfoFormat(result, "PlayerExternalId has updated successfully", "UpdatePlayerExternalId");
                else
                    _logger.InfoFormat(result, "PlayerExternalId can't added successfully. some error occurred", "UpdatePlayerExternalId");
            }
            catch (Exception ex)
            {
                _logger.ErrorFormat(ex.TargetSite, ex.Message, ex.Source, "UpdatePlayerExternalId");
            }
            return result;
        }

        #endregion


        public int? GetPlayerIdByCardNumber(string cardNumber)
        {
            int? linkedPlayerID = null;
            try
            {
                PlayerInfoContext objPlayerInfoContext = new PlayerInfoContext();
                linkedPlayerID = objPlayerInfoContext.GetPlayerIdByCardNumber(cardNumber);
                if (linkedPlayerID == null)
                    _logger.InfoFormat(linkedPlayerID, "No PlayerId has found for this CardNumber : " + cardNumber, "GetPlayerIdByCardNumber");
                else
                    _logger.InfoFormat(linkedPlayerID, "PlayerId has found.", "GetPlayerIdByCardNumber");
            }
            catch (Exception ex)
            {
                _logger.ErrorFormat(ex.TargetSite, ex.Message, ex.Source, "GetPlayerIdByCardNumber");
            }
            return linkedPlayerID;
        }


        public int AddPlayer(PlayerInfo playerInfo)
        {
            int result = 1;
            try
            {
                PlayerInfoContext playerInfoContext = new PlayerInfoContext();
                result = playerInfoContext.AddPlayer(playerInfo);
                if (result == 0)
                    _logger.InfoFormat(result, "Player has added successfully", "AddPlayer");
                else
                    _logger.InfoFormat(result, "Player can't added successfully. some error occurred", "AddPlayer");
            }
            catch (Exception ex)
            {
                _logger.ErrorFormat(ex.TargetSite, ex.Message, ex.Source, "AddPlayer");
            }
            return result;
        }


        public List<PlayerOffers> GetPlayerOffers(int LinkedPlayerID)
        {
            List<PlayerOffers> playerInfoContext = null;
            try
            {
                PlayerInfoContext objPlayerInfoContext = new PlayerInfoContext();
                playerInfoContext = objPlayerInfoContext.GetPlayerOffers(LinkedPlayerID);
                if (playerInfoContext.Count > 0)
                    _logger.InfoFormat(playerInfoContext, playerInfoContext.Count.ToString() + " PlayerOffers has found for LinkedPlayerID : " + LinkedPlayerID.ToString(), "GetPlayerOffers");
                else
                    _logger.InfoFormat(playerInfoContext, "No PlayerOffers has found for LinkedPlayerID : " + LinkedPlayerID.ToString(), "GetPlayerOffers");
            }
            catch (Exception ex)
            {
                _logger.ErrorFormat(ex.TargetSite, ex.Message, ex.Source, "GetPlayerOffers");
            }
            return playerInfoContext;
        }


        #region Add/Update PlayerProfile

        //public int AddPlayerProflie(PlayerInfo playerObject)
        //{
        //    try
        //    {
        //        PlayerInfoContext playerInfoContext = new PlayerInfoContext();
        //        int result = playerInfoContext.AddPlayerProflie(playerObject);

        //        if (result != 0)
        //        {
        //            throw new ApplicationException("Player profile was not added");
        //        }
        //        return result;
        //    }
        //    catch (Exception ex)
        //    {
        //        throw ex;
        //    }
        //}

        public int UpdatePlayerProflie(PlayerInfo playerObject)
        {
            int result = 1;
            try
            {
                PlayerInfoContext playerInfoContext = new PlayerInfoContext();
                result = playerInfoContext.UpdatePlayerProflie(playerObject);
                if (result == 0)
                    _logger.InfoFormat(result, "PlayerProflie has Update successfully", "UpdatePlayerProflie");
                else
                    _logger.InfoFormat(result, "PlayerProflie can't added successfully. some error occurred", "UpdatePlayerProflie");
            }
            catch (Exception ex)
            {
                _logger.ErrorFormat(ex.TargetSite, ex.Message, ex.Source, "UpdatePlayerProflie");
            }
            return result;
        }

        #endregion


        public string ValidatePIN(int LinkedPlayerID, string pinString)
        {
             string rMessage = "";
            try
            {
                PlayerInfoContext playerInfoContext = new PlayerInfoContext();
                rMessage = playerInfoContext.ValidatePIN(LinkedPlayerID, pinString);
                _logger.InfoFormat(true, rMessage, "ValidatePIN");
            }
            catch (Exception ex)
            {
                rMessage = "ERROR ENCOUNTERED 3: " + ex.Message.ToString();
                _logger.ErrorFormat(ex.TargetSite, ex.Message, ex.Source, "ValidatePIN");
            }
            return rMessage;
        }


        #region Add/Update PlayerImage

        public int AddPlayerImage(List<PlayerImage> playerImageList, Int32 LinkedPlayerID)
        {
            int result = 1;
            try
            {
                PlayerInfoContext playerInfoContext = new PlayerInfoContext();
                result = playerInfoContext.AddPlayerImage(playerImageList, LinkedPlayerID);
                if (result == 0)
                    _logger.InfoFormat(result, "PlayerImage has added successfully", "AddPlayerImage");
                else
                    _logger.InfoFormat(result, "PlayerImage can't added successfully. some error occurred", "AddPlayerImage");
            }
            catch (Exception ex)
            {
                _logger.ErrorFormat(ex.TargetSite, ex.Message, ex.Source, "AddPlayerImage");
            }
            return result;
        }

        public int UpdatePlayerImage(List<PlayerImage> playerImageList, Int32 LinkedPlayerID)
        {
            int result = 1;
            try
            {
                PlayerInfoContext playerInfoContext = new PlayerInfoContext();
                result = playerInfoContext.UpdatePlayerImage(playerImageList, LinkedPlayerID);
                if (result == 0)
                    _logger.InfoFormat(result, "PlayerImage has updated successfully", "UpdatePlayerImage");
                else
                    _logger.InfoFormat(result, "PlayerImage can't updated successfully. some error occurred", "UpdatePlayerImage");
            }
            catch (Exception ex)
            {
                _logger.ErrorFormat(ex.TargetSite, ex.Message, ex.Source, "UpdatePlayerImage");
            }
            return result;
        }

        #endregion


        public int? GetPlayerIdByExternalID(string ExternalId, string ExternalIDTypeID)
        {
            int? Playerid = null;
            try
            {
                PlayerInfoContext objPlayerInfoContext = new PlayerInfoContext();
                Playerid = objPlayerInfoContext.GetPlayerIdByExternalID(ExternalId, ExternalIDTypeID);
                if (Playerid == null || Playerid == 0)
                    _logger.InfoFormat(Playerid, "No PlayerId has found for the externalID : " + ExternalId, "GetPlayerIdByExternalID");
                else
                    _logger.InfoFormat(Playerid, "PlayerId has found.", "GetPlayerIdByExternalID");
            }
            catch (Exception ex)
            {
                _logger.ErrorFormat(ex.TargetSite, ex.Message, ex.Source, "GetPlayerIdByExternalID");
            }
            return Playerid;
        }


        #region Add/Update player Identification

        public int AddPlayerIdentification(List<PlayerIdent> playerIdentList, Int32 LinkedPlayerID)
        {
            int result = 1;
            try
            {
                PlayerInfoContext playerInfoContext = new PlayerInfoContext();
                result = playerInfoContext.AddPlayerIdent(playerIdentList, LinkedPlayerID);
                if (result == 0)
                    _logger.InfoFormat(result, "PlayerIdentification has added successfully", "AddPlayerIdentification");
                else
                    _logger.InfoFormat(result, "PlayerIdentification can't added successfully. some error occurred", "AddPlayerIdentification");
            }
            catch (Exception ex)
            {
                _logger.ErrorFormat(ex.TargetSite, ex.Message, ex.Source, "AddPlayerIdentification");
            }
            return result;
        }

        public int UpdatePlayerIdentification(List<PlayerIdent> playerIdentList, Int32 LinkedPlayerID)
        {
            int result = 1;
            try
            {
                PlayerInfoContext playerInfoContext = new PlayerInfoContext();
                result = playerInfoContext.UpdatePlayerIdent(playerIdentList, LinkedPlayerID);
                if (result == 0)
                    _logger.InfoFormat(result, "PlayerIdentification has updated successfully", "UpdatePlayerIdentification");
                else
                    _logger.InfoFormat(result, "PlayerIdentification can't updated successfully. some error occurred", "UpdatePlayerIdentification");
            }
            catch (Exception ex)
            {
                _logger.ErrorFormat(ex.TargetSite, ex.Message, ex.Source, "UpdatePlayerIdentification");
            }
            return result;
        }

        #endregion


        #region Add/Update PlayerMemo

        public int AddPlayerMemo(List<PlayerComment> playercommentList, int playerId)
        {
            int result = 1;
            try
            {
                PlayerInfoContext playerInfoContext = new PlayerInfoContext();
                result = playerInfoContext.AddPlayerMemo(playercommentList, playerId);
                if (result == 0)
                    _logger.InfoFormat(result, "PlayerMemo has added successfully", "AddPlayerMemo");
                else
                    _logger.InfoFormat(result, "PlayerMemo can't added successfully. some error occurred", "AddPlayerMemo");
            }
            catch (Exception ex)
            {
                _logger.ErrorFormat(ex.TargetSite, ex.Message, ex.Source, "AddPlayerMemo");
            }
            return result;
        }

        public int UpdatePlayerMemo(List<PlayerComment> playercommentList, int playerId)
        {
            int result = 1;
            try
            {
                PlayerInfoContext playerInfoContext = new PlayerInfoContext();
                result = playerInfoContext.UpdatePlayerMemo(playercommentList, playerId);
                if (result == 0)
                    _logger.InfoFormat(result, "PlayerMemo has updated successfully", "UpdatePlayerMemo");
                else
                    _logger.InfoFormat(result, "PlayerMemo can't updated successfully. some error occurred", "UpdatePlayerMemo");
            }
            catch (Exception ex)
            {
                _logger.ErrorFormat(ex.TargetSite, ex.Message, ex.Source, "UpdatePlayerMemo");
            }
            return result;
        }

        #endregion

        public Boolean DapPlayer(string clubNumber)
        {
            Boolean result = false;
            try
            {
                PlayerInfoContext objPlayerInfoContext = new PlayerInfoContext();
                result = objPlayerInfoContext.GetDapPlayer(clubNumber);
                if (result == false)
                    _logger.InfoFormat(false, "Player has been restricted", "DapPlayer");
                else
                    _logger.InfoFormat(true, "Player is valid.", "DapPlayer");
            }
            catch (Exception ex)
            {
                _logger.ErrorFormat(ex.TargetSite, ex.Message, ex.Source, "DapPlayer");
            }
            return result;
        }
        
    }
}

