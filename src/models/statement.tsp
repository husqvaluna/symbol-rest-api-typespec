import "../types/core.tsp";
import "./common.tsp";

/**
 * Receipt stored when a state change that triggered a mosaic transfer.
 */
model BalanceTransferReceiptDTO {
  ...ReceiptDTO;
  mosaicId: MosaicId;
  amount: Amount;
  senderAddress: Address;
  recipientAddress: Address;
}

/**
 * Receipt stored when a state change modified an account balance.
 */
model BalanceChangeReceiptDTO {
  ...ReceiptDTO;
  mosaicId: MosaicId;
  amount: Amount;
  targetAddress: Address;
}

/**
 * Receipt stored when a namespace expires.
 */
model NamespaceExpiryReceiptDTO {
  ...ReceiptDTO;
  artifactId: NamespaceId;
}

/**
 * Receipt stored when a mosaic expires.
 */
model MosaicExpiryReceiptDTO {
  ...ReceiptDTO;
  artifactId: MosaicId;
}

/**
 * Receipt stored when network currency mosaics were created due to inflation.
 */
model InflationReceiptDTO {
  ...ReceiptDTO;
  mosaicId: MosaicId;
  amount: Amount;
}

model ReceiptDTO {
  /**
   * Version of the receipt.
   */
  version: integer;

  type: ReceiptTypeEnum;
}

model ResolutionEntryDTO {
  source: SourceDTO;
  resolved: Address | MosaicId;
}

model ResolutionStatementDTO {
  height: Height;
  unresolved: UnresolvedMosaicId | UnresolvedAddress;

  /**
   * Array of resolution entries linked to the unresolved namespaceId.
   * It is an array instead of a single resolution entry since
   * within one block the resolution might change for different sources due to alias related transactions.
   *
   */
  resolutionEntries: ResolutionEntryDTO[];
}

/**
 * A resolution statement keeps the relation between a namespace alias used in a transaction
 * and the real address or mosaicId.
 *
 */
model ResolutionStatementInfoDTO {
  id: ID;

  meta: StatementMetaDTO;
  statement: ResolutionStatementDTO;
}

model ResolutionStatementPage is Page<ResolutionStatementInfoDTO>;

/**
 * Transaction that triggered the receipt.
 */
model SourceDTO {
  /**
   * Transaction index within the block.
   */
  primaryId: UInt32;

  /**
   * Transaction index within the aggregate transaction.
   * If the transaction is not an embedded transaction, then the secondary id is set to 0.
   *
   */
  secondaryId: UInt32;
}



/**
 * Metadata related to the statment, including block information.
 */
model StatementMetaDTO {
  timestamp: Timestamp;
}

model TransactionStatementDTO {
  height: Height;
  source: SourceDTO;

  /**
   * Array of receipts.
   */
  receipts: (
    | BalanceTransferReceiptDTO
    | BalanceChangeReceiptDTO
    | NamespaceExpiryReceiptDTO
    | MosaicExpiryReceiptDTO
    | InflationReceiptDTO)[];
}

/**
 * Collection of receipts related to a transaction.
 */
model TransactionStatementInfoDTO {
  id: ID;

  meta: StatementMetaDTO;
  statement: TransactionStatementDTO;
}

model TransactionStatementPage is Page<TransactionStatementInfoDTO>;

