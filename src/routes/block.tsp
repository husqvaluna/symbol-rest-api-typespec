import "@typespec/http";

import "../types/core.tsp";
import "../models";
import "../parameters.tsp";

using Http;

@tag("Block routes")
@route("/blocks")
namespace Catapult.Block {
  @get
  @summary("Search blocks")
  @doc("Gets an array of blocks.")
  op searchBlocks(
    ...Parameters.signerPublicKeyQuery,
    ...Parameters.beneficiaryAddressQuery,
    ...Parameters.paginationParameters,
    ...Parameters.orderByBlockQuery,
  ): BlockPage | ConflictError;

  @get
  @route("/{height}")
  @summary("Get block information")
  @doc("Gets a block from the chain that has the given height.")
  op getBlockByHeight(...Parameters.heightPath): BlockInfoDTO | ResourceNotFoundError | ConflictError;

  @get
  @route("/{height}/transactions/{hash}/merkle")
  @summary("Get the merkle path for a given a transaction and block")
  @doc("""
Returns the merkle path for a transaction included in a block.
The merkle path is the minimum number of nodes needed to calculate the merkle root.

Steps to calculate the merkle root:
1. proofHash = hash (leaf).
2. Concatenate proofHash with the first unprocessed item from the merklePath list as follows:
* a) If item.position == left -> proofHash = sha_256(item.hash + proofHash).
* b) If item.position == right -> proofHash = sha_256(proofHash+ item.hash).
3. Repeat 2. for every item in the merklePath list.
4. Compare if the calculated proofHash equals the one recorded in the
block header (block.transactionsHash) to verify if the transaction was included in the block.
""")
  op getMerkleTransaction(
    ...Parameters.heightPath,
    ...Parameters.transactionHashPath,
  ): MerkleProofInfoDTO | ResourceNotFoundError | ConflictError;

  @get
  @route("/{height}/statements/{hash}/merkle")
  @summary("Get the merkle path for a given a receipt statement hash and block")
  @doc("""
Returns the merkle path for a receipt statement or resolution linked to a block.
The merkle path is the minimum number of nodes needed to calculate the merkle root.

Steps to calculate the merkle root:
1. proofHash = hash (leaf).
2. Concatenate proofHash with the first unprocessed item from the merklePath list as follows:
* a) If item.position == left -> proofHash = sha_256(item.hash + proofHash).
* b) If item.position == right -> proofHash = sha_256(proofHash+ item.hash).
3. Repeat 2. for every item in the merklePath list.
4. Compare if the calculated proofHash equals the one recorded in the
block header (block.receiptsHash) to verify if the statement was linked with the block.
""")
  op getMerkleReceipts(
    ...Parameters.heightPath,
    ...Parameters.receiptHashPath,
  ): MerkleProofInfoDTO | ResourceNotFoundError | ConflictError;
}
