import "@typespec/http";
import "../types/core.tsp";

using Http;

model ModelError {
  code: string;
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
  pageNumber: integer;
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
  type: MerkleTreeNodeTypeEnum;

  /**
   * Branch link path.
   */
  path: string;

  /**
   * Encoded branch link path.
   */
  encodedPath: string;

  /**
   * Nibble count.
   */
  nibbleCount: integer;

  /**
   * Branch link bitmask.
   */
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
  type: MerkleTreeNodeTypeEnum;

  /**
   * Leaf path.
   */
  path: string;

  /**
   * Encoded leaf path.
   */
  encodedPath: string;

  /**
   * Nibble count.
   */
  nibbleCount: integer;

  /**
   * Leaf value (sha256 hash).
   */
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
  maxTransactionsPerAggregate?: string;

  /**
   * Maximum number of cosignatures per aggregate.
   */
  maxCosignaturesPerAggregate?: string;

  /**
   * Set to true if cosignatures must exactly match component signers. Set to false if cosignatures should be validated externally.
   */
  enableStrictCosignatureCheck?: boolean;

  /**
   * Set to true if bonded aggregates should be allowed. Set to false if bonded aggregates should be rejected.
   */
  enableBondedAggregateSupport?: boolean;

  /**
   * Maximum lifetime a bonded transaction can have before it expires.
   */
  maxBondedTransactionLifetime?: string;
}

model TransferNetworkPropertiesDTO {
  /**
   * Maximum transaction message size.
   */
  maxMessageSize?: string;
}

model AccountKeyLinkNetworkPropertiesDTO {
  /**
   * to trigger plugin load
   */
  dummy?: string;
}
