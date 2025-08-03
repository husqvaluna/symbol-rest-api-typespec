import "../types/core.tsp";
import "../models";
import "../parameters.tsp";

using Http;

@tag("Account routes")
@route("/accounts")
namespace Catapult.Account {
  @get
  @summary("Search accounts")
  @doc("Gets an array of accounts.")
  op searchAccounts(
    ...Parameters.paginationParameters,
    ...Parameters.orderByAccountQuery,
    ...Parameters.mosaicIdQuery,
  ): AccountPage | ConflictError;

  @post
  @summary("Get accounts information")
  @doc("Returns the account information for an array of accounts.")
  op getAccountsInfo(@body body: accountIds): Body<AccountInfoDTO[]> | BadRequestError | ConflictError;

  @get
  @route("/{accountId}")
  @summary("Get account information")
  @doc("Returns the account information.")
  op getAccountInfo(...Parameters.accountIdPath): AccountInfoDTO | ResourceNotFoundError | ConflictError;

  @get
  @route("/{accountId}/merkle")
  @summary("Get account merkle information")
  @doc("Returns the account merkle information.")
  op getAccountInfoMerkle(...Parameters.accountIdPath): MerkleStateInfoDTO | ResourceNotFoundError | ConflictError;
}
