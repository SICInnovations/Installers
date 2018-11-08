using HA.OasisWebAPI.ATIGateway.DTO;
using System.Collections.Generic;
using System.ServiceModel;

namespace HA.OasisWebAPI.ATIGateway
{
    // NOTE: You can use the "Rename" command on the "Refactor" menu to change the interface name "IGameService" in both code and config file together.
    [ServiceContract]
    public interface IGameService
    {
        [OperationContract]
        List<SlotGameInfo> GetSlotGames(int? FirstRow, int? LastRow, int? TotalRows);

        [OperationContract]
        List<TableGameInfo> GetTableGames(int? FirstRow, int? LastRow, int? TotalRows);

        [OperationContract]
        List<PokerGameInfo> GetPokerGames(int? FirstRow, int? LastRow, int? TotalRows);

        [OperationContract]
        PlayerTierInfo GetPlayerTier(int? PlayerNumber);

        [OperationContract]
        PlayerPointBalance GetPlayerPointBalance(int? PlayerNumber);

        [OperationContract]
        PlayerPromoBalance GetPlayerPromoBalance(int? PlayerNumber);

        [OperationContract]
        PlayerCashBalance GetPlayerCashBalance(int? PlayerNumber);

        [OperationContract]
        PlayerCompBalance GetPlayerCompBalance(int? PlayerNumber);

        [OperationContract]
        PlayerBaseBalance GetPlayerBasePoint(int? PlayerNumber);

        [OperationContract]
        List<PlayerAllBalances> GetPlayerAllBalances(int? PlayerNumber);

        [OperationContract]
        List<PlayerSessionRatings> GetPlayerSessionRatings(int? PlayerNumber);
                
    }
}
