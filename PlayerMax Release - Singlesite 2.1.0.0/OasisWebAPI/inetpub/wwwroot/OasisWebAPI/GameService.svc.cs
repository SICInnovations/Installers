using System;
using System.Collections.Generic;
using HA.OasisWebAPI.ATIGateway.DTO;
using HA.OasisWebAPI.Entities;
using HA.Logging;

namespace HA.OasisWebAPI.ATIGateway
{
    // NOTE: You can use the "Rename" command on the "Refactor" menu to change the class name "GameService" in code, svc and config file together.
    // NOTE: In order to launch WCF Test Client for testing this service, please select GameService.svc or GameService.svc.cs at the Solution Explorer and start debugging.
    public class GameService : IGameService
    {
        private static readonly HALogger _logger = new HALogger(typeof(GameService));

        public List<SlotGameInfo> GetSlotGames(int? FirstRow, int? LastRow, int? TotalRows)
        {
            List<SlotGameInfo> slotGameList = null;
            try
            {
                GameInfoContext gameInfoContext = new GameInfoContext();
                slotGameList = gameInfoContext.GetSlotGames(FirstRow, LastRow, TotalRows);
                if (slotGameList.Count > 0)
                    _logger.InfoFormat(slotGameList, slotGameList.Count.ToString() + " slotGame has found.", "GetSlotGames");
                else
                    _logger.InfoFormat(slotGameList, "No slotGame has found.", "GetSlotGames");
            }
            catch (Exception ex)
            {
                _logger.ErrorFormat(ex.TargetSite, ex.Message, ex.Source, "GetSlotGames");
            }
            return slotGameList;
        }

        public List<TableGameInfo> GetTableGames(int? FirstRow, int? LastRow, int? TotalRows)
        {
            List<TableGameInfo> tableGameList = null;
            try
            {
                GameInfoContext gameInfoContext = new GameInfoContext();
                tableGameList = gameInfoContext.GetTableGames(FirstRow, LastRow, TotalRows);
                if (tableGameList.Count > 0)
                    _logger.InfoFormat(tableGameList, tableGameList.Count.ToString() + " tableGame has found.", "GetTableGames");
                else
                    _logger.InfoFormat(tableGameList, "No tableGame has found.", "GetTableGames");
            }
            catch (Exception ex)
            {
                _logger.ErrorFormat(ex.TargetSite, ex.Message, ex.Source, "GetTableGames");
            }
            return tableGameList;
        }

        public List<PokerGameInfo> GetPokerGames(int? FirstRow, int? LastRow, int? TotalRows)
        {
            List<PokerGameInfo> pokerGameList = null;
            try
            {
                GameInfoContext gameInfoContext = new GameInfoContext();
                pokerGameList = gameInfoContext.GetPokerGames(FirstRow, LastRow, TotalRows);
                if (pokerGameList.Count > 0)
                    _logger.InfoFormat(pokerGameList, pokerGameList.Count.ToString() + " pokerGame has found.", "GetPokerGames");
                else
                    _logger.InfoFormat(pokerGameList, "No pokerGame has found.", "GetPokerGames");
            }
            catch (Exception ex)
            {
                _logger.ErrorFormat(ex.TargetSite, ex.Message, ex.Source, "GetPokerGames");
            }
            return pokerGameList;
        }

        public PlayerTierInfo GetPlayerTier(int? PlayerID)
        {
            PlayerTierInfo playerTier = null;
            try
            {
                GameInfoContext gameInfoContext = new GameInfoContext();
                playerTier = gameInfoContext.GetPlayerTier(PlayerID);
                if (playerTier == null)
                    _logger.InfoFormat(playerTier, "No PlayerTier has found.", "GetPlayerTier");
                else
                    _logger.InfoFormat(playerTier, "PlayerTier has found.", "GetPlayerTier"); 
            }
            catch (Exception ex)
            {
                _logger.ErrorFormat(ex.TargetSite, ex.Message, ex.Source, "GetPlayerTier");
            }
            return playerTier;
        }

        public PlayerPointBalance GetPlayerPointBalance(int? PlayerID)
        {
            PlayerPointBalance playerPointBalance = null;
            try
            {
                GameInfoContext gameInfoContext = new GameInfoContext();
                playerPointBalance = gameInfoContext.GetPlayerPointBalance(PlayerID);
                if (playerPointBalance == null)
                    _logger.InfoFormat(playerPointBalance, "No PlayerPointBalance has found.", "GetPlayerPointBalance");
                else
                    _logger.InfoFormat(playerPointBalance, "PlayerPointBalance has found.", "GetPlayerPointBalance"); 
            }
            catch (Exception ex)
            {
                _logger.ErrorFormat(ex.TargetSite, ex.Message, ex.Source, "GetPlayerPointBalance");
            }
            return playerPointBalance;
        }

        public PlayerPromoBalance GetPlayerPromoBalance(int? PlayerID)
        {
            PlayerPromoBalance playerPromoBalance = null;
            try
            {
                GameInfoContext gameInfoContext = new GameInfoContext();
                playerPromoBalance = gameInfoContext.GetPlayerPromoBalance(PlayerID);
                if (playerPromoBalance == null)
                    _logger.InfoFormat(playerPromoBalance, "No PlayerPromoBalance has found.", "GetPlayerPromoBalance");
                else
                    _logger.InfoFormat(playerPromoBalance, "PlayerPromoBalance has found.", "GetPlayerPromoBalance"); 
            }
            catch (Exception ex)
            {
                _logger.ErrorFormat(ex.TargetSite, ex.Message, ex.Source, "GetPlayerPromoBalance");
            }
            return playerPromoBalance;
        }

        public PlayerCashBalance GetPlayerCashBalance(int? PlayerID)
        {
            PlayerCashBalance playerCashBalance = null;
            try
            {
                GameInfoContext gameInfoContext = new GameInfoContext();
                playerCashBalance = gameInfoContext.GetPlayerCashBalance(PlayerID);
                if (playerCashBalance == null)
                    _logger.InfoFormat(playerCashBalance, "No PlayerCashBalance has found.", "GetPlayerCashBalance");
                else
                    _logger.InfoFormat(playerCashBalance, "PlayerCashBalance has found.", "GetPlayerCashBalance");
            }
            catch (Exception ex)
            {
                _logger.ErrorFormat(ex.TargetSite, ex.Message, ex.Source, "GetPlayerCashBalance");
            }
            return playerCashBalance;
        }

        public PlayerCompBalance GetPlayerCompBalance(int? PlayerID)
        {
            PlayerCompBalance playerCompBalance = null;
            try
            {
                GameInfoContext gameInfoContext = new GameInfoContext();
                playerCompBalance = gameInfoContext.GetPlayerCompBalance(PlayerID);
                if (playerCompBalance == null)
                    _logger.InfoFormat(playerCompBalance, "No PlayerCompBalance has found.", "GetPlayerCompBalance");
                else
                    _logger.InfoFormat(playerCompBalance, "PlayerCompBalance has found.", "GetPlayerCompBalance");
            }
            catch (Exception ex)
            {
                _logger.ErrorFormat(ex.TargetSite, ex.Message, ex.Source, "GetPlayerCompBalance");
            }
            return playerCompBalance;
        }

        public PlayerBaseBalance GetPlayerBasePoint(int? PlayerID)
        {
            PlayerBaseBalance playerBaseBalance = null;
            try
            {
                GameInfoContext gameInfoContext = new GameInfoContext();
                playerBaseBalance = gameInfoContext.GetPlayerBasePoint(PlayerID);
                if (playerBaseBalance == null)
                    _logger.InfoFormat(playerBaseBalance, "No PlayerBaseBalance has found.", "GetPlayerBaseBalance");
                else
                    _logger.InfoFormat(playerBaseBalance, "PlayerBaseBalance has found.", "GetPlayerBaseBalance");
            }
            catch (Exception ex)
            {
                _logger.ErrorFormat(ex.TargetSite, ex.Message, ex.Source, "GetPlayerBaseBalance");
            }
            return playerBaseBalance;
        }

        public List<PlayerAllBalances> GetPlayerAllBalances(int? PlayerID)
        {
            List<PlayerAllBalances> playerAllBalances = null;
            try
            {
                GameInfoContext gameInfoContext = new GameInfoContext();
                playerAllBalances = gameInfoContext.GetPlayerAllBalances(PlayerID);
                if (playerAllBalances.Count > 0)
                    _logger.InfoFormat(playerAllBalances, playerAllBalances.Count.ToString() + " playerAllBalance has found for PlayerID : " + PlayerID.ToString(), "GetPlayerAllBalances");
                else
                    _logger.InfoFormat(playerAllBalances, "No playerAllBalance has found for PlayerID : " + PlayerID.ToString(), "GetPlayerAllBalances");
            }
            catch (Exception ex)
            {
                _logger.ErrorFormat(ex.TargetSite, ex.Message, ex.Source, "GetPlayerAllBalances");
            }
            return playerAllBalances;
        }

        public List<PlayerSessionRatings> GetPlayerSessionRatings(int? PlayerID)
        {
            List<PlayerSessionRatings> playerSessionRatings = null;
            try
            {
                GameInfoContext gameInfoContext = new GameInfoContext();
                playerSessionRatings = gameInfoContext.GetPlayerSessionRatings(PlayerID);
                if (playerSessionRatings.Count > 0)
                    _logger.InfoFormat(playerSessionRatings, playerSessionRatings.Count.ToString() + " playerSessionRating has found for PlayerID : " + PlayerID.ToString(), "GetPlayerSessionRatings");
                else
                    _logger.InfoFormat(playerSessionRatings, "No playerSessionRating has found for PlayerID : " + PlayerID.ToString(), "GetPlayerSessionRatings");
            }
            catch (Exception ex)
            {
                _logger.ErrorFormat(ex.TargetSite, ex.Message, ex.Source, "GetPlayerSessionRatings");
            }
            return playerSessionRatings;
        }

    }
}
