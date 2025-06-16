import "@typespec/http";

import "../types/core.tsp";
import "../models";
import "../parameters.tsp";

using Http;

@tag("Namespace routes")
@route("/namespaces")
namespace Catapult.Namespace {
  @get
  @summary("Search namespaces")
  @doc("Gets an array of namespaces.")
  op searchNamespaces(
    ...Parameters.ownerAddressQuery,
    ...Parameters.registrationTypeQuery,
    ...Parameters.level0Query,
    ...Parameters.aliasTypeQuery,
    ...Parameters.paginationParameters,
  ): NamespacePage | ConflictError;

  @get
  @route("/{namespaceId}")
  @summary("Get namespace information")
  @doc("Gets the namespace for a given namespace identifier.")
  op getNamespace(...Parameters.namespaceIdPath): NamespaceInfoDTO | ResourceNotFoundError | ConflictError;

  @get
  @route("/{namespaceId}/merkle")
  @summary("Get namespace merkle information")
  @doc("Gets the namespace merkle for a given namespace identifier.")
  op getNamespaceMerkle(...Parameters.namespaceIdPath): MerkleStateInfoDTO | ResourceNotFoundError | ConflictError;

  @post
  @route("/names")
  @summary("Get readable names for a set of namespaces")
  @doc("Returns friendly names for namespaces.")
  op getNamespacesNames(@body body: namespaceIds): Body<NamespaceNameDTO[]> | BadRequestError | ConflictError;

  @route("/account")
  namespace Account {
    @post
    @route("/names")
    @summary("Get readable names for a set of accountIds")
    @doc("Returns friendly names for accounts.")
    op getAccountsNames(@body body: addresses): AccountsNamesDTO | BadRequestError | ConflictError;
  }

  @route("/mosaic")
  namespace Mosaic {
    @post
    @route("/names")
    @summary("Get readable names for a set of mosaics")
    @doc("Returns friendly names for mosaics.")
    op getMosaicsNames(@body body: mosaicIds): MosaicsNamesDTO | BadRequestError | ConflictError;
  }
}
