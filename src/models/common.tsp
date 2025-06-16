import "@typespec/http";
import "../types/core.tsp";

using Http;

model ModelError {
  @example("InvalidArgument")
  code: string;
  @example("The argument is invalid.")
  message: string;
}

model Mosaic {
  id: MosaicId;
  amount: Amount;
}

model UnresolvedMosaic {
  id: UnresolvedMosaicId;
  amount: Amount;
}

model Pagination {
  @example(1)
  pageNumber: integer;
  @example(10)
  pageSize: integer;
}

model Page<T> {
  data: T[];
  pagination: Pagination;
}

/**
 * The merkle path information clients can use to proof the state of the given entity.
 */
model MerkleStateInfoDTO {
  raw: MerkleTreeRaw;

  /**
   * Merkle tree parsed from merkle tree raw.
   */
  tree: (MerkleTreeBranchDTO | MerkleTreeLeafDTO)[];
}

/**
 * Merkle tree branch node.
 */
model MerkleTreeBranchDTO {
  /**
   * Merkle tree node type.
   */
  @example(0)
  type: MerkleTreeNodeTypeEnum;

  /**
   * Branch link path.
   */
  @example("484196B44369B764")
  path: string;

  /**
   * Encoded branch link path.
   */
  @example("484196B44369B764")
  encodedPath: string;

  /**
   * Nibble count.
   */
  @example(1)
  nibbleCount: integer;

  /**
   * Branch link bitmask.
   */
  @example("0000000000000000")
  linkMask: string;

  /**
   * Branch links (max 16).
   */
  links: MerkleTreeBranchLinkDTO[];

  /**
   * Hash of the branch node.
   */
  branchHash: Hash256;
}

/**
 * Merkle tree leaf node.
 */
model MerkleTreeLeafDTO {
  /**
   * Merkle tree node type.
   */
  @example(255)
  type: MerkleTreeNodeTypeEnum;

  /**
   * Leaf path.
   */
  @example("484196B44369B764")
  path: string;

  /**
   * Encoded leaf path.
   */
  @example("484196B44369B764")
  encodedPath: string;

  /**
   * Nibble count.
   */
  @example(1)
  nibbleCount: integer;

  /**
   * Leaf value (sha256 hash).
   */
  @example("484196B44369B764")
  value: string;

  /**
   * Hash of the leaf node.
   */
  leafHash: Hash256;
}

/**
 * Merkle tree branch link.
 */
model MerkleTreeBranchLinkDTO {
  /**
   * Branch link nibble bit index (hexadecimal).
   */
  @example("F")
  bit: string;

  /**
   * Branch link hash.
   */
  link: Hash256;
}

model accountIds {
  /**
   * Array of public keys.
   */
  publicKeys?: PublicKey[];

  /**
   * Array of addresses.
   */
  addresses?: Address[];
}

model addresses {
  /**
   * Array of addresses.
   */
  addresses?: Address[];
}

model cosignature {
  parentHash?: Hash256;
  signature?: Signature;
  signerPublicKey?: PublicKey;
  version?: CosignatureVersion;
}

model mosaicIds {
  /**
   * Array of mosaic identifiers.
   */
  mosaicIds?: MosaicId[];
}

model namespaceIds {
  /**
   * Array of namespace identifiers.
   */
  namespaceIds?: NamespaceId[];
}

model transactionHashes {
  /**
   * Array of transaction hashes.
   */
  hashes?: Hash256[];
}

model transactionIds {
  /**
   * Array of transaction identifiers.
   */
  transactionIds?: string[];
}

model transactionPayload {
  /**
   * Transaction payload in hexadecimal format.
   */
  @example("0123456789ABCDEF")
  payload?: string;
}

/*
 * Plugin related configuration properties.
 */
model PluginsPropertiesDTO {
  accountlink?: AccountKeyLinkNetworkPropertiesDTO;
  aggregate?: AggregateNetworkPropertiesDTO;
  lockhash?: HashLockNetworkPropertiesDTO;
  locksecret?: SecretLockNetworkPropertiesDTO;
  metadata?: MetadataNetworkPropertiesDTO;
  mosaic?: MosaicNetworkPropertiesDTO;
  multisig?: MultisigNetworkPropertiesDTO;
  `namespace`?: NamespaceNetworkPropertiesDTO;
  restrictionaccount?: AccountRestrictionNetworkPropertiesDTO;
  restrictionmosaic?: MosaicRestrictionNetworkPropertiesDTO;
  transfer?: TransferNetworkPropertiesDTO;
}

model AggregateNetworkPropertiesDTO {
  /**
   * Maximum number of transactions per aggregate.
   */
  @example("100")
  maxTransactionsPerAggregate?: string;

  /**
   * Maximum number of cosignatures per aggregate.
   */
  @example("25")
  maxCosignaturesPerAggregate?: string;

  /**
   * Set to true if cosignatures must exactly match component signers. Set to false if cosignatures should be validated externally.
   */
  @example(true)
  enableStrictCosignatureCheck?: boolean;

  /**
   * Set to true if bonded aggregates should be allowed. Set to false if bonded aggregates should be rejected.
   */
  @example(true)
  enableBondedAggregateSupport?: boolean;

  /**
   * Maximum lifetime a bonded transaction can have before it expires.
   */
  @example("48h")
  maxBondedTransactionLifetime?: string;
}

model TransferNetworkPropertiesDTO {
  /**
   * Maximum transaction message size.
   */
  @example("1024")
  maxMessageSize?: string;
}

model AccountKeyLinkNetworkPropertiesDTO {
  /**
   * to trigger plugin load
   */
  @example("true")
  dummy?: string;
}
