import "@typespec/http";

import "../types/core.tsp";
import "../models";
import "../parameters.tsp";

using Http;

@tag("Receipt routes")
@route("/statements")
namespace Catapult.Statement {
  @get
  @route("/transaction")
  @summary("Search transaction statements")
  @doc("""
Gets an array of transaction statements.
""")
  op searchReceipts(
    ...Parameters.heightQuery,
    ...Parameters.fromHeightQuery,
    ...Parameters.toHeightQuery,
    ...Parameters.receiptTypeQuery,
    ...Parameters.recipientAddressQuery,
    ...Parameters.senderAddressQuery,
    ...Parameters.targetAddressQuery,
    ...Parameters.artifactIdQuery,
    ...Parameters.paginationParameters,
  ): TransactionStatementPage | ResourceNotFoundError | ConflictError;

  @tag("Receipt routes")
  @route("/resolutions")
  namespace Resolution {
    @get
    @route("/address")
    @summary("Get receipts address resolution statements")
    @doc("""
Gets an array of address resolution statements.
""")
    op searchAddressResolutionStatements(
      ...Parameters.heightQuery,
      ...Parameters.paginationParameters,
    ): ResolutionStatementPage | ResourceNotFoundError | ConflictError;

    @get
    @route("/mosaic")
    @summary("Get receipts mosaic resolution statements")
    @doc("""
Gets an array of mosaic resolution statements.
""")
    op searchMosaicResolutionStatements(
      ...Parameters.heightQuery,
      ...Parameters.paginationParameters,
    ): ResolutionStatementPage | ResourceNotFoundError | ConflictError;
  }
}
