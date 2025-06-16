import "../types/core.tsp";
import "./common.tsp";

model AccountPage is Page<AccountInfoDTO>;

model AccountDTO {
  version: StateVersion;
  address: Address;
  addressHeight: Height;
  publicKey: PublicKey;
  publicKeyHeight: Height;
  accountType: AccountTypeEnum;
  supplementalPublicKeys: SupplementalPublicKeysDTO;
  activityBuckets: ActivityBucketDTO[];

  /**
   * Mosaic units owned.
   */
  mosaics: Mosaic[];

  importance: Importance;
  importanceHeight: Height;
}

model AccountInfoDTO {
  /**
   * Internal resource identifier.
   */
  id: string;

  account: AccountDTO;
}

/**
 * Supplementary data stored for importance recalculation.
 * At each importance recalculation, existing buckets are shifted, the working bucket is finalized and a new working bucket is created.
 * Each bucket influences at most five importance recalculations.
 */
model ActivityBucketDTO {
  startHeight: Height;

  /**
   * Fees paid by the account for this bucket.
   */
  totalFeesPaid: Amount;

  /**
   * Number of times the account has been a beneficiary for this bucket.
   */
  beneficiaryCount: UInt32;

  /**
   * Importance score for this bucket. This is taken into account to calculate the latest account importance.
   */
  rawScore: Importance;
}

model AccountLinkPublicKeyDTO {
  publicKey: string;
}

model AccountLinkVotingKeysDTO {
  publicKeys: AccountLinkVotingKeyDTO[];
}

model AccountLinkVotingKeyDTO {
  publicKey: string;
  startEpoch: FinalizationEpoch;
  endEpoch: FinalizationEpoch;
}

model SupplementalPublicKeysDTO {
  linked?: AccountLinkPublicKeyDTO;
  node?: AccountLinkPublicKeyDTO;
  vrf?: AccountLinkPublicKeyDTO;
  voting?: AccountLinkVotingKeysDTO;
}

/**
 * Chain related configuration properties.
 */
model ChainPropertiesDTO {
  /**
   * Set to true if block chain should calculate state hashes so that state is fully verifiable at each block.
   */
  enableVerifiableState?: boolean;

  /**
   * Set to true if block chain should calculate receipts so that state changes are fully verifiable at each block.
   */
  enableVerifiableReceipts?: boolean;

  /**
   * Mosaic id used as primary chain currency.
   */
  currencyMosaicId?: string;

  /**
   * Mosaic id used to provide harvesting ability.
   */
  harvestingMosaicId?: string;

  /**
   * Targeted time between blocks.
   */
  blockGenerationTargetTime?: string;

  /**
   * A higher value makes the network more biased.
   */
  blockTimeSmoothingFactor?: string;

  /**
   * Number of blocks between successive finalization attempts.
   */
  blockFinalizationInterval?: string;

  /**
   * Number of blocks that should be treated as a group for importance purposes.
   */
  importanceGrouping?: string;

  /**
   * Percentage of importance resulting from fee generation and beneficiary usage.
   */
  importanceActivityPercentage?: string;

  /**
   * Maximum number of blocks that can be rolled back.
   */
  maxRollbackBlocks?: string;

  /**
   * Maximum number of blocks to use in a difficulty calculation.
   */
  maxDifficultyBlocks?: string;

  /**
   * Default multiplier to use for dynamic fees.
   */
  defaultDynamicFeeMultiplier?: string;

  /**
   * Maximum lifetime a transaction can have before it expires.
   */
  maxTransactionLifetime?: string;

  /**
   * Maximum future time of a block that can be accepted.
   */
  maxBlockFutureTime?: string;

  /**
   * Initial currency atomic units available in the network.
   */
  initialCurrencyAtomicUnits?: string;

  /**
   * Maximum atomic units (total-supply * 10 ^ divisibility) of a mosaic allowed in the network.
   */
  maxMosaicAtomicUnits?: string;

  /**
   * Total whole importance units available in the network.
   */
  totalChainImportance?: string;

  /**
   * Minimum number of harvesting mosaic atomic units needed for an account to be eligible for harvesting.
   */
  minHarvesterBalance?: string;

  /**
   * Maximum number of harvesting mosaic atomic units needed for an account to be eligible for harvesting.
   */
  maxHarvesterBalance?: string;

  /**
   * Minimum number of harvesting mosaic atomic units needed for an account to be eligible for voting.
   */
  minVoterBalance?: string;

  /**
   * Maximum number of voting keys that can be registered at once per account.
   */
  maxVotingKeysPerAccount?: string;

  /**
   * Minimum number of finalization rounds for which voting key can be registered.
   */
  minVotingKeyLifetime?: string;

  /**
   * Maximum number of finalization rounds for which voting key can be registered.
   */
  maxVotingKeyLifetime?: string;

  /**
   * Percentage of the harvested fee that is collected by the beneficiary account.
   */
  harvestBeneficiaryPercentage?: string;

  /**
   * Percentage of the harvested fee that is collected by the network.
   */
  harvestNetworkPercentage?: string;

  /**
   * Address of the harvest network fee sink account.
   */
  harvestNetworkFeeSinkAddress?: Address;

  /**
   * Number of blocks between cache pruning.
   */
  blockPruneInterval?: string;

  /**
   * Maximum number of transactions per block.
   */
  maxTransactionsPerBlock?: string;
}

/**
 * Network related configuration properties.
 */
model NetworkPropertiesDTO {
  /**
   * Network identifier.
   */
  identifier?: string;

  nodeEqualityStrategy?: NodeIdentityEqualityStrategy;

  /**
   * Nemesis public key.
   */
  nemesisSignerPublicKey?: PublicKey;

  /**
   * Seed for generating Nemesis generation hash.
   */
  generationHashSeed?: Hash256;

  /**
   * Nemesis epoch time adjustment.
   */
  epochAdjustment?: string;
}

model NetworkConfigurationDTO {
  network: NetworkPropertiesDTO;
  chain: ChainPropertiesDTO;
  plugins: PluginsPropertiesDTO;
}
