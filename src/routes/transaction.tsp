import "../types/core.tsp";
import "../models";
import "../parameters.tsp";

using Http;

@tag("Transaction routes")
@route("/transactions")
namespace Catapult.Transaction {
  @put
  @summary("Announce a new transaction")
  @doc("""
Announces a transaction to the network.
The [catbuffer library](https://github.com/nemtech/catbuffer) defines the protocol to serialize and deserialize Symbol entities.
Catbuffers are integrated into [Symbol SDKs](https://nemtech.github.io/sdk.html).
It's recommended to use SDKs instead of calling the API endpoint directly to announce transactions.
""")
  op announceTransaction(@body body: transactionPayload): (AcceptedResponse &
    AnnounceTransactionInfoDTO) | BadRequestError | ConflictError;

  @get
  @route("/confirmed")
  @summary("Search confirmed transactions")
  @doc("""
Returns an array of confirmed transactions.
If a transaction was announced with an alias rather than an address,
the address that will be considered when querying is the one that
was resolved from the alias at confirmation time.
""")
  op searchConfirmedTransactions(
    ...Parameters.addressQuery,
    ...Parameters.recipientAddressQuery,
    ...Parameters.signerPublicKeyQuery,
    ...Parameters.heightQuery,
    ...Parameters.fromHeightQuery,
    ...Parameters.toHeightQuery,
    ...Parameters.fromTransferAmountQuery,
    ...Parameters.toTransferAmountQuery,
    ...Parameters.transactionTypeQuery,
    ...Parameters.embedded,
    ...Parameters.transferMosaicIdQuery,
    ...Parameters.paginationParameters,
  ): TransactionPage | ConflictError;

  @post
  @route("/confirmed")
  @summary("Get confirmed trasactions information")
  @doc("Returns confirmed transactions information for a given array of transactionIds.")
  op getConfirmedTransactions(
    @body body: transactionIds,
  ): Body<TransactionInfoDTO[]> | BadRequestError | ConflictError;

  /**
   * Returns confirmed transaction information given a transactionId or hash.
   */
  @get
  @route("/confirmed/{transactionId}")
  @summary("Get confirmed transaction information")
  @doc("Returns confirmed transaction information given a transactionId or hash.")
  op getConfirmedTransaction(
    ...Parameters.transactionIdPath,
  ): TransactionInfoDTO | ResourceNotFoundError | ConflictError;

  @get
  @route("/unconfirmed")
  @summary("Search unconfirmed transactions")
  @doc("Returns an array of unconfirmed transactions.")
  op searchUnconfirmedTransactions(
    ...Parameters.addressQuery,
    ...Parameters.recipientAddressQuery,
    ...Parameters.signerPublicKeyQuery,
    ...Parameters.heightQuery,
    ...Parameters.fromHeightQuery,
    ...Parameters.toHeightQuery,
    ...Parameters.fromTransferAmountQuery,
    ...Parameters.toTransferAmountQuery,
    ...Parameters.transactionTypeQuery,
    ...Parameters.embedded,
    ...Parameters.transferMosaicIdQuery,
    ...Parameters.paginationParameters,
  ): TransactionPage | ConflictError;

  @post
  @route("/unconfirmed")
  @summary("Get unconfirmed trasactions information")
  @doc("Returns unconfirmed transactions information for a given array of transactionIds.")
  op getUnconfirmedTransactions(
    @body body: transactionIds,
  ): Body<TransactionInfoDTO[]> | BadRequestError | ConflictError;

  @get
  @route("/unconfirmed/{transactionId}")
  @summary("Get unconfirmed transaction information")
  @doc("Returns unconfirmed transaction information given a transactionId or hash.")
  op getUnconfirmedTransaction(
    ...Parameters.transactionIdPath,
  ): TransactionInfoDTO | ResourceNotFoundError | ConflictError;

  @get
  @route("/partial")
  @summary("Search partial transactions")
  @doc("Returns an array of partial transactions.")
  op searchPartialTransactions(
    ...Parameters.addressQuery,
    ...Parameters.recipientAddressQuery,
    ...Parameters.signerPublicKeyQuery,
    ...Parameters.heightQuery,
    ...Parameters.fromHeightQuery,
    ...Parameters.toHeightQuery,
    ...Parameters.fromTransferAmountQuery,
    ...Parameters.toTransferAmountQuery,
    ...Parameters.transactionTypeQuery,
    ...Parameters.embedded,
    ...Parameters.transferMosaicIdQuery,
    ...Parameters.paginationParameters,
  ): TransactionPage | ConflictError;

  @post
  @route("/partial")
  @summary("Get partial trasactions information")
  @doc("Returns partial transactions information for a given array of transactionIds.")
  op getPartialTransactions(
    @body body: transactionIds,
  ): Body<TransactionInfoDTO[]> | BadRequestError | ConflictError;

  @put
  @route("/partial")
  @summary("Announce an aggregate bonded transaction")
  @doc("Announces an aggregate bonded transaction to the network.")
  op announcePartialTransaction(@body body: transactionPayload): (AcceptedResponse &
    AnnounceTransactionInfoDTO) | BadRequestError | ConflictError;

  @get
  @route("/partial/{transactionId}")
  @summary("Get partial transaction information")
  @doc("Returns partial transaction information given a transactionId or hash.")
  op getPartialTransaction(...Parameters.transactionIdPath): TransactionInfoDTO | ResourceNotFoundError | ConflictError;

  @put
  @route("/cosignature")
  @summary("Announce a cosignature transaction")
  @doc("Announces a cosignature transaction to the network.")
  op announceCosignatureTransaction(@body body: cosignature): (AcceptedResponse &
    AnnounceTransactionInfoDTO) | BadRequestError | ConflictError;
}
