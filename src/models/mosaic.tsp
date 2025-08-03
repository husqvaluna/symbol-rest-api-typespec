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
@example(1)
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
  @example(6)
  divisibility: integer;

  duration: BlockDuration;
}

model MosaicInfoDTO {
  id: ID;

  mosaic: MosaicDTO;
}

model MosaicNetworkPropertiesDTO {
  /**
   * Maximum number of mosaics that an account can own.
   */
  @example("10000")
  maxMosaicsPerAccount?: string;

  /**
   * Maximum mosaic duration.
   */
  @example("365d")
  maxMosaicDuration?: string;

  /**
   * Maximum mosaic divisibility.
   */
  @example("6")
  maxMosaicDivisibility?: string;

  /**
   * Address of the mosaic rental fee sink account.
   */
  @example("TAMESPACEWH4MKFMBCVFERDPOOP4FK7MTDJEYP35")
  mosaicRentalFeeSinkAddress?: Address;

  /**
   * Mosaic rental fee.
   */
  @example("500'000'000")
  mosaicRentalFee?: string;
}

model MosaicPage is Page<MosaicInfoDTO>;
