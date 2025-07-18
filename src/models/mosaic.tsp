import "../types/core.tsp";
import "./common.tsp";

/**
 * - 0x00 (none) - No flags present.
 * - 0x01 (supplyMutable) - Mosaic supports supply changes even when mosaic owner owns partial supply.
 * - 0x02 (transferable) - Mosaic supports transfers between arbitrary accounts. When not set, mosaic can only be transferred to
 *     and from mosaic owner.
 * - 0x04 (restrictable) - Mosaic supports custom restrictions configured by mosaic owner.
 * - 0x08 (revokable) - Mosaic allows creator to revoke balances from another user.
 *
 */
scalar MosaicFlagsEnum extends integer;

model MosaicDTO {
  version: StateVersion;
  id: MosaicId;
  supply: Amount;
  startHeight: Height;
  ownerAddress: Address;

  /**
   * Number of definitions for the same mosaic.
   */
  revision: UInt32;

  flags: MosaicFlagsEnum;

  /**
   * Determines up to what decimal place the mosaic can be divided.
   * Divisibility of 3 means that a mosaic can be divided into smallest parts of 0.001 mosaics.
   * The divisibility must be in the range of 0 and 6.
   *
   */
  divisibility: integer;

  duration: BlockDuration;
}

model MosaicInfoDTO {
  /**
   * Internal resource identifier.
   */
  id: string;

  mosaic: MosaicDTO;
}

model MosaicNetworkPropertiesDTO {
  /**
   * Maximum number of mosaics that an account can own.
   */
  maxMosaicsPerAccount?: string;

  /**
   * Maximum mosaic duration.
   */
  maxMosaicDuration?: string;

  /**
   * Maximum mosaic divisibility.
   */
  maxMosaicDivisibility?: string;

  /**
   * Address of the mosaic rental fee sink account.
   */
  mosaicRentalFeeSinkAddress?: Address;

  /**
   * Mosaic rental fee.
   */
  mosaicRentalFee?: string;
}

model MosaicPage is Page<MosaicInfoDTO>;
