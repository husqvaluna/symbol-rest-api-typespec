import "../types/core.tsp";
import "../models";
import "../parameters.tsp";

using Http;

@tag("Finalization routes")
@route("/finalization")
namespace Catapult.Finalization {
  @route("/proof")
  namespace Proof {
    @get
    @route("/epoch/{epoch}")
    @summary("Get finalization proof")
    @doc("Gets finalization proof for the greatest height associated with the given epoch.")
    op getFinalizationProofAtEpoch(
      @doc("Finalization epoch.")
      @path epoch: FinalizationEpoch,
    ): FinalizationProofDTO | (NotFoundResponse & ModelError) | (ConflictResponse & ModelError);

    @get
    @route("/height/{height}")
    @summary("Get finalization proof")
    @doc("Gets finalization proof at the given height.")
    op getFinalizationProofAtHeight(
      ...Parameters.heightPath,
    ): FinalizationProofDTO | (NotFoundResponse & ModelError) | (ConflictResponse & ModelError);
  }
}
