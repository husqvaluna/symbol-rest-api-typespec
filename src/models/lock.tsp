import "../types/core.tsp";
import "./common.tsp";

model HashLockEntryDTO {
  version: StateVersion;
  ownerAddress: Address;
  mosaicId: MosaicId;
  amount: Amount;
  endHeight: Height;
  status: LockStatus;
  hash: Hash256;
}

model HashLockInfoDTO {
  @example("65204AB4242726662686A453")
  id: ID;
  lock: HashLockEntryDTO;
}

model HashLockPage is Page<HashLockInfoDTO>;

model HashLockNetworkPropertiesDTO {
  /**
   * Amount that has to be locked per aggregate in partial cache.
   */
  @example("10'000'000")
  lockedFundsPerAggregate?: string;

  /**
   * Maximum number of blocks for which a hash lock can exist.
   */
  @example("2d")
  maxHashLockDuration?: string;
}

model SecretLockEntryDTO {
  version: StateVersion;
  ownerAddress: Address;
  mosaicId: MosaicId;
  amount: Amount;
  endHeight: Height;
  status: LockStatus;
  hashAlgorithm: LockHashAlgorithmEnum;
  secret: Secret;
  recipientAddress: Address;
  compositeHash: Hash256;
}

model SecretLockInfoDTO {
  @example("65204AB4242726662686A453")
  id: ID;
  lock: SecretLockEntryDTO;
}

model SecretLockPage is Page<SecretLockInfoDTO>;

model SecretLockNetworkPropertiesDTO {
  /**
   * Maximum number of blocks for which a secret lock can exist.
   */
  @example("30d")
  maxSecretLockDuration?: string;

  /**
   * Minimum size of a proof in bytes.
   */
  @example("1")
  minProofSize?: string;

  /**
   * Maximum size of a proof in bytes.
   */
  @example("1024")
  maxProofSize?: string;
}
