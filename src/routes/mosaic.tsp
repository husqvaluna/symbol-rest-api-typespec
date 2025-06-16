import "@typespec/http";

import "../types/core.tsp";
import "../models";
import "../parameters.tsp";

using Http;

@tag("Mosaic routes")
@route("/mosaics")
namespace Catapult.Mosaic {
  @get
  @route("/{mosaicId}")
  @summary("Get mosaic information")
  @doc("Gets the mosaic definition for a given mosaic identifier.")
  op getMosaic(...Parameters.mosaicIdPath): MosaicInfoDTO | ResourceNotFoundError | ConflictError;

  @get
  @route("/{mosaicId}/merkle")
  @summary("Get mosaic merkle information")
  @doc("Gets the mosaic definition merkle for a given mosaic identifier.")
  op getMosaicMerkle(...Parameters.mosaicIdPath): MerkleStateInfoDTO | ResourceNotFoundError | ConflictError;

  @get
  @summary("Search mosaics")
  @doc("Gets an array of mosaics.")
  op searchMosaics(
    ...Parameters.ownerAddressQuery,
    ...Parameters.paginationParameters,
  ): MosaicPage | ConflictError;

  @post
  @summary("Get mosaics information for an array of mosaics")
  @doc("Gets an array of mosaic definition.")
  op getMosaics(@body body: mosaicIds): Body<MosaicInfoDTO[]> | BadRequestError | ConflictError;
}
