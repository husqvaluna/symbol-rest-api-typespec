import "@typespec/openapi";
import "@typespec/rest";
import "../types/core.tsp";
import "./common.tsp";

model NetworkTypeDTO {
  @doc("Network name.")
  @example("testnet")
  name: string;

  @doc("A short text describing the network.")
  @example("Symbol Sainet Network")
  description: string;
}

model RentalFeesDTO {
  /**
   * Estimated effective rental fee to register/extend a namespace per block.
   */
  effectiveRootNamespaceRentalFeePerBlock: Amount;

  /**
   * Estimated effective rental fee to create a subnamespace.
   */
  effectiveChildNamespaceRentalFee: Amount;

  /**
   * Estimated effective rental fee to create a mosaic.
   */
  effectiveMosaicRentalFee: Amount;
}

model TransactionFeesDTO {
  /**
   * Average fee multiplier over the last "numBlocksTransactionFeeStats" on the current Network.
   */
  averageFeeMultiplier: BlockFeeMultiplier;

  /**
   * Median fee multiplier over the last "numBlocksTransactionFeeStats" on the current Network.
   */
  medianFeeMultiplier: BlockFeeMultiplier;

  /**
   * Highest fee multiplier over the last "numBlocksTransactionFeeStats" on the current Network.
   */
  highestFeeMultiplier: BlockFeeMultiplier;

  /**
   * Lowest fee multiplier over the last "numBlocksTransactionFeeStats" on the current Network.
   */
  lowestFeeMultiplier: BlockFeeMultiplier;

  /**
   * Minimal fee multiplier on the current connected Node.
   */
  minFeeMultiplier: BlockFeeMultiplier;
}
