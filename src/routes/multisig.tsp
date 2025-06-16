import "@typespec/http";

import "../types/core.tsp";
import "../models";
import "../parameters.tsp";

using Http;

@tag("Multisig routes")
@route("/account")
namespace Catapult.Multisig {
  @get
  @route("/{address}/multisig")
  @summary("Get multisig account information")
  @doc("Returns the multisig account information.")
  op getAccountMultisig(...Parameters.address): MultisigAccountInfoDTO | (NotFoundResponse &
    ModelError) | (ConflictResponse & ModelError);

  @get
  @route("/{address}/multisig/merkle")
  @summary("Get multisig account merkle information")
  @doc("Returns the multisig account merkle information.")
  op getAccountMultisigMerkle(...Parameters.address): MerkleStateInfoDTO | (NotFoundResponse &
    ModelError) | (ConflictResponse & ModelError);

  @get
  @route("/{address}/multisig/graph")
  @summary("Get multisig account graph information")
  @doc("Returns the multisig account graph.")
  op getAccountMultisigGraph(
    ...Parameters.address,
  ): Body<MultisigAccountGraphInfoDTO[]> | (NotFoundResponse & ModelError) | (ConflictResponse &
    ModelError);
}
