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
  @example("65204AB4242726662686A453")
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
  @example("AC1A6E1D8DE5B17D2C6B1293F1E3BE85A6493C8C3971E7A09471384B966E442D")
  publicKey: string;
}

model AccountLinkVotingKeysDTO {
  publicKeys: AccountLinkVotingKeyDTO[];
}

model AccountLinkVotingKeyDTO {
  @example("AC1A6E1D8DE5B17D2C6B1293F1E3BE85A6493C8C3971E7A09471384B966E442D")
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
  @example(true)
  enableVerifiableState?: boolean;

  /**
   * Set to true if block chain should calculate receipts so that state changes are fully verifiable at each block.
   */
  @example(true)
  enableVerifiableReceipts?: boolean;

  /**
   * Mosaic id used as primary chain currency.
   */
  @example("0x243FE287A5239A55")
  currencyMosaicId?: string;

  /**
   * Mosaic id used to provide harvesting ability.
   */
  @example("0x243FE287A5239A55")
  harvestingMosaicId?: string;

  /**
   * Targeted time between blocks.
   */
  @example("30s")
  blockGenerationTargetTime?: string;

  /**
   * A higher value makes the network more biased.
   */
  @example("500")
  blockTimeSmoothingFactor?: string;

  /**
   * Number of blocks between successive finalization attempts.
   */
  @example("20")
  blockFinalizationInterval?: string;

  /**
   * Number of blocks that should be treated as a group for importance purposes.
   */
  @example("39")
  importanceGrouping?: string;

  /**
   * Percentage of importance resulting from fee generation and beneficiary usage.
   */
  @example("5")
  importanceActivityPercentage?: string;

  /**
   * Maximum number of blocks that can be rolled back.
   */
  @example("40")
  maxRollbackBlocks?: string;

  /**
   * Maximum number of blocks to use in a difficulty calculation.
   */
  @example("60")
  maxDifficultyBlocks?: string;

  /**
   * Default multiplier to use for dynamic fees.
   */
  @example("100")
  defaultDynamicFeeMultiplier?: string;

  /**
   * Maximum lifetime a transaction can have before it expires.
   */
  @example("24h")
  maxTransactionLifetime?: string;

  /**
   * Maximum future time of a block that can be accepted.
   */
  @example("500ms")
  maxBlockFutureTime?: string;

  /**
   * Initial currency atomic units available in the network.
   */
  @example("8'998'999'998'000'000")
  initialCurrencyAtomicUnits?: string;

  /**
   * Maximum atomic units (total-supply * 10 ^ divisibility) of a mosaic allowed in the network.
   */
  @example("9'000'000'000'000'000")
  maxMosaicAtomicUnits?: string;

  /**
   * Total whole importance units available in the network.
   */
  @example("15'000'000")
  totalChainImportance?: string;

  /**
   * Minimum number of harvesting mosaic atomic units needed for an account to be eligible for harvesting.
   */
  @example("500")
  minHarvesterBalance?: string;

  /**
   * Maximum number of harvesting mosaic atomic units needed for an account to be eligible for harvesting.
   */
  @example("4'000'000'000")
  maxHarvesterBalance?: string;

  /**
   * Minimum number of harvesting mosaic atomic units needed for an account to be eligible for voting.
   */
  @example("50'000")
  minVoterBalance?: string;

  /**
   * Maximum number of voting keys that can be registered at once per account.
   */
  @example("3")
  maxVotingKeysPerAccount?: string;

  /**
   * Minimum number of finalization rounds for which voting key can be registered.
   */
  @example("20")
  minVotingKeyLifetime?: string;

  /**
   * Maximum number of finalization rounds for which voting key can be registered.
   */
  @example("260")
  maxVotingKeyLifetime?: string;

  /**
   * Percentage of the harvested fee that is collected by the beneficiary account.
   */
  @example("10")
  harvestBeneficiaryPercentage?: string;

  /**
   * Percentage of the harvested fee that is collected by the network.
   */
  @example("5")
  harvestNetworkPercentage?: string;

  /**
   * Address of the harvest network fee sink account.
   */
  @example("TAMESPACEWH4MKFMBCVFERDPOOP4FK7MTDJEYP35")
  harvestNetworkFeeSinkAddress?: Address;

  /**
   * Number of blocks between cache pruning.
   */
  @example("100")
  blockPruneInterval?: string;

  /**
   * Maximum number of transactions per block.
   */
  @example("1000")
  maxTransactionsPerBlock?: string;
}

/**
 * Network related configuration properties.
 */
model NetworkPropertiesDTO {
  /**
   * Network identifier.
   */
  @example("testnet")
  identifier?: string;

  nodeEqualityStrategy?: NodeIdentityEqualityStrategy;

  /**
   * Nemesis public key.
   */
  @example("AC1A6E1D8DE5B17D2C6B1293F1E3BE85A6493C8C3971E7A09471384B966E442D")
  nemesisSignerPublicKey?: PublicKey;

  /**
   * Seed for generating Nemesis generation hash.
   */
  @example("57F7DA205008026C776CB6AED843393F04CD458E0AA2D9F1D5F31A402072B2D6")
  generationHashSeed?: Hash256;

  /**
   * Nemesis epoch time adjustment.
   */
  @example("1573430400s")
  epochAdjustment?: string;
}

model NetworkConfigurationDTO {
  network: NetworkPropertiesDTO;
  chain: ChainPropertiesDTO;
  plugins: PluginsPropertiesDTO;
}
