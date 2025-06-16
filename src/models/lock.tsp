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
  id: string;
  lock: HashLockEntryDTO;
}

model HashLockPage is Page<HashLockInfoDTO>;

model HashLockNetworkPropertiesDTO {
  /**
   * Amount that has to be locked per aggregate in partial cache.
   */
  lockedFundsPerAggregate?: string;

  /**
   * Maximum number of blocks for which a hash lock can exist.
   */
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
  id: string;
  lock: SecretLockEntryDTO;
}

model SecretLockPage is Page<SecretLockInfoDTO>;

model SecretLockNetworkPropertiesDTO {
  /**
   * Maximum number of blocks for which a secret lock can exist.
   */
  maxSecretLockDuration?: string;

  /**
   * Minimum size of a proof in bytes.
   */
  minProofSize?: string;

  /**
   * Maximum size of a proof in bytes.
   */
  maxProofSize?: string;
}
