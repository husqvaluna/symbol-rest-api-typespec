import "../types/core.tsp";
import "./common.tsp";

model EntityDTO {
  signerPublicKey: PublicKey;

  /**
   * Entity version.
   */
  @example(1)
  version: integer;

  network: NetworkTypeEnum;

  @example(32835)
  type: integer;
}

model SizePrefixedEntityDTO {
  /**
   * Entity size in bytes.
   */
  size: UInt32;
}

model VerifiableEntityDTO {
  signature: Signature;
}

model BlockDTO {
  ...SizePrefixedEntityDTO;
  ...VerifiableEntityDTO;
  ...EntityDTO;
  height: Height;
  timestamp: Timestamp;
  difficulty: Difficulty;
  proofGamma: ProofGamma;
  proofVerificationHash: ProofVerificationHash;
  proofScalar: ProofScalar;
  previousBlockHash: Hash256;
  transactionsHash: Hash256;
  receiptsHash: Hash256;
  stateHash: Hash256;
  beneficiaryAddress: Address;
  feeMultiplier: BlockFeeMultiplier;
}

model BlockInfoDTO {
  /**
   * Internal resource identifier.
   */
  @example("67CA9E5B1F221298E20D97CB")
  id: string;

  meta: BlockMetaDTO;
  block: BlockDTO | ImportanceBlockDTO;
}

model BlockMetaDTO {
  hash: Hash256;

  totalFee: Amount;

  generationHash: Hash256;

  stateHashSubCacheMerkleRoots: Hash256[];

  /**
   * Total number of [transactions](https://docs.symbolplatform.com/concepts/transaction.html) confirmed in this block,
   * including *embedded* transactions (i.e. transactions contained within aggregate transactions).
   */
  totalTransactionsCount: integer;

  /**
   * Number of [transactions](https://docs.symbolplatform.com/concepts/transaction.html) confirmed in this block.
   * This does not count *embedded* transactions (i.e. transactions contained within aggregate transactions).
   */
  transactionsCount: integer;

  /**
   * Number of statements (of any kind) present in this block.
   * Bear in mind that some of them (like
   * [resolution statements](https://docs.symbolplatform.com/concepts/receipt.html#resolution-statement)) are
   * triggered by transactions present in the block, but in general,
   * [transaction statements](https://docs.symbolplatform.com/concepts/receipt.html#transaction-statement) are not.
   */
  statementsCount: integer;
}

model BlockPage is Page<BlockInfoDTO>;

model ImportanceBlockDTO {
  ...BlockDTO;

  /**
   * Number of voting eligible accounts.
   */
  votingEligibleAccountsCount: UInt32;

  /**
   * Number of harvesting eligible accounts.
   */
  harvestingEligibleAccountsCount: UInt64;

  /**
   * Total balance eligible for voting.
   */
  totalVotingBalance: Amount;

  /**
   * Previous importance block hash.
   */
  previousImportanceBlockHash: Hash256;
}

/**
 * Each merkle path item is composed of a hash, and a position relative to the proofHash being evaluated.
 */
model MerklePathItemDTO {
  position?: PositionEnum;
  hash?: Hash256;
}

model MerkleProofInfoDTO {
  /**
   * List of complementary merkle path items needed to recalculate the merkle root.
   */
  merklePath?: MerklePathItemDTO[];
}

model FinalizedBlockDTO {
  finalizationEpoch: FinalizationEpoch;
  finalizationPoint: FinalizationPoint;
  height: Height;
  hash: Hash256;
}

model BmTreeSignature {
  root: ParentPublicKeySignaturePair;
  bottom: ParentPublicKeySignaturePair;
}

model FinalizationProofDTO {
  version: integer;
  finalizationEpoch: FinalizationEpoch;
  finalizationPoint: FinalizationPoint;
  height: Height;
  hash: Hash256;
  messageGroups: MessageGroup[];
}

model MessageGroup {
  /**
   * Message stage
   */
  stage: StageEnum;

  /**
   * Block height corresponding to the first hash.
   */
  height: Height;

  hashes: Hash256[];
  signatures: BmTreeSignature[];
}

model ParentPublicKeySignaturePair {
  parentPublicKey: PublicKey;
  signature: Signature;
}
