import "../types/core.tsp";
import "./common.tsp";

model CosignatureDTO {
  ...VerifiableEntityDTO;
  version: CosignatureVersion;
  signerPublicKey: PublicKey;
}

model AccountKeyLinkTransactionBodyDTO {
  linkedPublicKey: PublicKey;
  linkAction: LinkActionEnum;
}

model NodeKeyLinkTransactionBodyDTO {
  linkedPublicKey: PublicKey;
  linkAction: LinkActionEnum;
}

model VotingKeyLinkTransactionBodyDTO {
  linkedPublicKey: VotingKey;
  startEpoch: FinalizationEpoch;
  endEpoch: FinalizationEpoch;
  linkAction: LinkActionEnum;
}

model AggregateTransactionBodyExtendedDTO {
  ...AggregateTransactionBodyDTO;
  ...EmbeddedTransactionBodyDTO;
}

model AggregateTransactionBodyDTO {
  transactionsHash: Hash256;

  /**
   * Array of transaction cosignatures.
   */
  cosignatures: CosignatureDTO[];
}

model HashLockTransactionBodyDTO {
  mosaicId: UnresolvedMosaicId;
  amount: Amount;
  duration: BlockDuration;
  hash: Hash256;
}

model SecretLockTransactionBodyDTO {
  recipientAddress: UnresolvedAddress;
  secret: Hash256;
  mosaicId: UnresolvedMosaicId;
  amount: Amount;
  duration: BlockDuration;
  hashAlgorithm: LockHashAlgorithmEnum;
}
/**
 * Transaction to sends mosaics to a recipient if the proof used is revealed. If the duration is reached, the locked funds go back to the sender of the transaction.
 */
model SecretLockTransactionDTO {
  ...TransactionDTO;
  ...SecretLockTransactionBodyDTO;
}

model SecretProofTransactionBodyDTO {
  recipientAddress: UnresolvedAddress;
  secret: Hash256;
  hashAlgorithm: LockHashAlgorithmEnum;

  /**
   * Original random set of bytes.
   */
  proof: string;
}

model AccountMetadataTransactionBodyDTO {
  targetAddress: UnresolvedAddress;
  scopedMetadataKey: MetadataKey;

  /**
   * Change in value size in bytes.
   */
  valueSizeDelta: integer;

  /**
   * Value size in bytes.
   */
  valueSize: UInt32;

  value: MetadataValue;
}

model MosaicMetadataTransactionBodyDTO {
  targetAddress: UnresolvedAddress;
  scopedMetadataKey: MetadataKey;
  targetMosaicId: UnresolvedMosaicId;

  /**
   * Change in value size in bytes.
   */
  valueSizeDelta: integer;

  /**
   * Value size in bytes.
   */
  valueSize: UInt32;

  value: MetadataValue;
}

model NamespaceMetadataTransactionBodyDTO {
  targetAddress: UnresolvedAddress;
  scopedMetadataKey: MetadataKey;
  targetNamespaceId?: NamespaceId;

  /**
   * Change in value size in bytes.
   */
  valueSizeDelta: integer;

  /**
   * Value size in bytes.
   */
  valueSize: UInt32;

  value: MetadataValue;
}

model MosaicDefinitionTransactionBodyDTO {
  id: MosaicId;
  duration: BlockDuration;

  /**
   * Random nonce used to generate the mosaic id.
   */
  nonce: UInt32;

  flags: MosaicFlagsEnum;

  /**
   * Determines up to what decimal place the mosaic can be divided.
   * Divisibility of 3 means that a mosaic can be divided into smallest parts of 0.001 mosaics.
   * The divisibility must be in the range of 0 and 6.
   *
   */
  divisibility: integer;
}

model MosaicSupplyChangeTransactionBodyDTO {
  mosaicId: UnresolvedMosaicId;
  delta: Amount;
  action: MosaicSupplyChangeActionEnum;
}

model MosaicSupplyRevocationTransactionBodyDTO {
  sourceAddress: UnresolvedAddress;
  mosaicId: UnresolvedMosaicId;
  amount: Amount;
}

model NamespaceRegistrationTransactionBodyDTO {
  duration?: BlockDuration;
  parentId?: NamespaceId;
  id: NamespaceId;
  registrationType: NamespaceRegistrationTypeEnum;

  /**
   * Namespace name.
   */
  name: string;
}

model AddressAliasTransactionBodyDTO {
  namespaceId: NamespaceId;
  address: Address;
  aliasAction: AliasActionEnum;
}

model MosaicAliasTransactionBodyDTO {
  namespaceId: NamespaceId;
  mosaicId: MosaicId;
  aliasAction: AliasActionEnum;
}


model MultisigAccountModificationTransactionBodyDTO {
  /**
   * Number of signatures needed to remove a cosignatory.
   * If we are modifying an existing multisig account, this indicates the relative change of the minimum cosignatories.
   *
   */
  minRemovalDelta: integer;

  /**
   * Number of signatures needed to approve a transaction.
   * If we are modifying an existing multisig account, this indicates the relative change of the minimum cosignatories.
   *
   */
  minApprovalDelta: integer;

  /**
   * Array of cosignatory accounts to add.
   */
  addressAdditions: UnresolvedAddress[];

  /**
   * Array of cosignatory accounts to delete.
   */
  addressDeletions: UnresolvedAddress[];
}


model AccountAddressRestrictionTransactionBodyDTO {
  restrictionFlags: AccountRestrictionFlagsEnum;

  /**
   * Account restriction additions.
   */
  restrictionAdditions: UnresolvedAddress[];

  /**
   * Account restriction deletions.
   */
  restrictionDeletions: UnresolvedAddress[];
}


model AccountMosaicRestrictionTransactionBodyDTO {
  restrictionFlags: AccountRestrictionFlagsEnum;

  /**
   * Account restriction additions.
   */
  restrictionAdditions: UnresolvedMosaicId[];

  /**
   * Account restriction deletions.
   */
  restrictionDeletions: UnresolvedMosaicId[];
}
model AccountOperationRestrictionTransactionBodyDTO {
  restrictionFlags: AccountRestrictionFlagsEnum;

  /**
   * Account restriction additions.
   */
  restrictionAdditions: TransactionTypeEnum[];

  /**
   * Account restriction deletions.
   */
  restrictionDeletions: TransactionTypeEnum[];
}

model MosaicAddressRestrictionTransactionBodyDTO {
  mosaicId: UnresolvedMosaicId;
  restrictionKey: RestrictionKey;
  previousRestrictionValue: RestrictionValue;
  newRestrictionValue: RestrictionValue;
  targetAddress: UnresolvedAddress;
}

model MosaicGlobalRestrictionTransactionBodyDTO {
  mosaicId: UnresolvedMosaicId;
  referenceMosaicId: UnresolvedMosaicId;
  restrictionKey: RestrictionKey;
  previousRestrictionValue: RestrictionValue;
  newRestrictionValue: RestrictionValue;
  previousRestrictionType: MosaicRestrictionTypeEnum;
  newRestrictionType: MosaicRestrictionTypeEnum;
}


model TransferTransactionBodyDTO {
  recipientAddress: UnresolvedAddress;

  /**
   * Array of mosaics sent to the recipient.
   *
   */
  mosaics: UnresolvedMosaic[];

  /**
   * Transfer transaction message
   */
  message?: string;
}


/**
 * Transaction to delegate the account importance score to a proxy account.
 * Required for all accounts willing to activate delegated harvesting.
 *
 */
model AccountKeyLinkTransactionDTO {
  ...TransactionDTO;
  ...AccountKeyLinkTransactionBodyDTO;
}

model EmbeddedAccountKeyLinkTransactionDTO {
  ...EmbeddedTransactionDTO;
  ...AccountKeyLinkTransactionBodyDTO;
}

/**
 * Transaction to link a public key to an account.
 * TLS uses the linked public key to create sessions.
 * Required for node operators.
 *
 */
model NodeKeyLinkTransactionDTO {
  ...TransactionDTO;
  ...NodeKeyLinkTransactionBodyDTO;
}

model EmbeddedNodeKeyLinkTransactionDTO {
  ...EmbeddedTransactionDTO;
  ...NodeKeyLinkTransactionBodyDTO;
}

/**
 * Transaction to link an account with a VRF public key.
 * The key is used to randomize block production and leader/participant selection.
 * Required for all harvesting eligible accounts.
 *
 */
model VrfKeyLinkTransactionDTO {
  ...TransactionDTO;
  ...VrfKeyLinkTransactionBodyDTO;
}

model EmbeddedVrfKeyLinkTransactionDTO {
  ...EmbeddedTransactionDTO;
  ...VrfKeyLinkTransactionBodyDTO;
}

/**
 * Transaction to associate a BLS public key with an account.
 * Required for node operators willing to vote finalized blocks.
 *
 */
model VotingKeyLinkTransactionDTO {
  ...TransactionDTO;
  ...VotingKeyLinkTransactionBodyDTO;
}

model EmbeddedVotingKeyLinkTransactionDTO {
  ...EmbeddedTransactionDTO;
  ...VotingKeyLinkTransactionBodyDTO;
}

/**
 * Transaction to combine multiple transactions together.
 */
model AggregateTransactionDTO {
  ...TransactionDTO;
  ...AggregateTransactionBodyDTO;
}

/**
 * Transaction to combine multiple transactions together.
 */
model AggregateTransactionExtendedDTO {
  ...TransactionDTO;
  ...AggregateTransactionBodyExtendedDTO;
}

/**
 * Transaction to lock funds before sending an aggregate bonded transaction.
 */
model HashLockTransactionDTO {
  ...TransactionDTO;
  ...HashLockTransactionBodyDTO;
}

model EmbeddedHashLockTransactionDTO {
  ...EmbeddedTransactionDTO;
  ...HashLockTransactionBodyDTO;
}

/**
 * Transaction to reveal a proof.
 */
model SecretProofTransactionDTO {
  ...TransactionDTO;
  ...SecretProofTransactionBodyDTO;
}

model EmbeddedSecretLockTransactionDTO {
  ...EmbeddedTransactionDTO;
  ...SecretLockTransactionBodyDTO;
}

model EmbeddedSecretProofTransactionDTO {
  ...EmbeddedTransactionDTO;
  ...SecretProofTransactionBodyDTO;
}


/**
 * Transaction to create or modify a multisig account.
 */
model AccountMetadataTransactionDTO {
  ...TransactionDTO;
  ...AccountMetadataTransactionBodyDTO;
}

model EmbeddedAccountMetadataTransactionDTO {
  ...EmbeddedTransactionDTO;
  ...AccountMetadataTransactionBodyDTO;
}

/**
 * Transaction to create or modify a multisig account.
 */
model MosaicMetadataTransactionDTO {
  ...TransactionDTO;
  ...MosaicMetadataTransactionBodyDTO;
}

model EmbeddedMosaicMetadataTransactionDTO {
  ...EmbeddedTransactionDTO;
  ...MosaicMetadataTransactionBodyDTO;
}

/**
 * Transaction to create or modify a multisig account.
 */
model NamespaceMetadataTransactionDTO {
  ...TransactionDTO;
  ...NamespaceMetadataTransactionBodyDTO;
}

model EmbeddedNamespaceMetadataTransactionDTO {
  ...EmbeddedTransactionDTO;
  ...NamespaceMetadataTransactionBodyDTO;
}

/**
 * Transaction to create a new mosaic.
 */
model MosaicDefinitionTransactionDTO {
  ...TransactionDTO;
  ...MosaicDefinitionTransactionBodyDTO;
}

model EmbeddedMosaicDefinitionTransactionDTO {
  ...EmbeddedTransactionDTO;
  ...MosaicDefinitionTransactionBodyDTO;
}

/**
 * Transaction to increase or decrease the supply of a mosaic.
 */
model MosaicSupplyChangeTransactionDTO {
  ...TransactionDTO;
  ...MosaicSupplyChangeTransactionBodyDTO;
}

model EmbeddedMosaicSupplyChangeTransactionDTO {
  ...EmbeddedTransactionDTO;
  ...MosaicSupplyChangeTransactionBodyDTO;
}

/**
 * Transaction that allows the mosaic creator to revoke some balance from a user.
 */
model MosaicSupplyRevocationTransactionDTO {
  ...TransactionDTO;
  ...MosaicSupplyRevocationTransactionBodyDTO;
}

model EmbeddedMosaicSupplyRevocationTransactionDTO {
  ...EmbeddedTransactionDTO;
  ...MosaicSupplyRevocationTransactionBodyDTO;
}

/**
 * Transaction to create or renew a namespace.
 */
model NamespaceRegistrationTransactionDTO {
  ...TransactionDTO;
  ...NamespaceRegistrationTransactionBodyDTO;
}

model EmbeddedNamespaceRegistrationTransactionDTO {
  ...EmbeddedTransactionDTO;
  ...NamespaceRegistrationTransactionBodyDTO;
}

/**
 * Transaction to link a namespace to an account.
 */
model AddressAliasTransactionDTO {
  ...TransactionDTO;
  ...AddressAliasTransactionBodyDTO;
}

model EmbeddedAddressAliasTransactionDTO {
  ...EmbeddedTransactionDTO;
  ...AddressAliasTransactionBodyDTO;
}

/**
 * Transaction to link a namespace to a mosaic.
 */
model MosaicAliasTransactionDTO {
  ...TransactionDTO;
  ...MosaicAliasTransactionBodyDTO;
}

model EmbeddedMosaicAliasTransactionDTO {
  ...EmbeddedTransactionDTO;
  ...MosaicAliasTransactionBodyDTO;
}

/**
 * Transaction to create or modify a multisig account.
 */
model MultisigAccountModificationTransactionDTO {
  ...TransactionDTO;
  ...MultisigAccountModificationTransactionBodyDTO;
}


model EmbeddedMultisigAccountModificationTransactionDTO {
  ...EmbeddedTransactionDTO;
  ...MultisigAccountModificationTransactionBodyDTO;
}

/**
 * Transaction to prevent incoming and outgoing transactions for a given a set of addresses.
 */
model AccountAddressRestrictionTransactionDTO {
  ...TransactionDTO;
  ...AccountAddressRestrictionTransactionBodyDTO;
}

model EmbeddedAccountAddressRestrictionTransactionDTO {
  ...EmbeddedTransactionDTO;
  ...AccountAddressRestrictionTransactionBodyDTO;
}

/**
 * Transaction to prevent incoming transactions containing a given set of mosaics.
 */
model AccountMosaicRestrictionTransactionDTO {
  ...TransactionDTO;
  ...AccountMosaicRestrictionTransactionBodyDTO;
}

model EmbeddedAccountMosaicRestrictionTransactionDTO {
  ...EmbeddedTransactionDTO;
  ...AccountMosaicRestrictionTransactionBodyDTO;
}

/**
 * Transaction to prevent outgoing transactions by transaction type.
 */
model AccountOperationRestrictionTransactionDTO {
  ...TransactionDTO;
  ...AccountOperationRestrictionTransactionBodyDTO;
}

model EmbeddedAccountOperationRestrictionTransactionDTO {
  ...EmbeddedTransactionDTO;
  ...AccountOperationRestrictionTransactionBodyDTO;
}

/**
 * Transaction to set a network-wide restriction rule to a mosaic.
 */
model MosaicGlobalRestrictionTransactionDTO {
  ...TransactionDTO;
  ...MosaicGlobalRestrictionTransactionBodyDTO;
}
/**
 * Transaction to set a restriction rule to an address.
 */
model MosaicAddressRestrictionTransactionDTO {
  ...TransactionDTO;
  ...MosaicAddressRestrictionTransactionBodyDTO;
}


model EmbeddedMosaicAddressRestrictionTransactionDTO {
  ...EmbeddedTransactionDTO;
  ...MosaicAddressRestrictionTransactionBodyDTO;
}

model EmbeddedMosaicGlobalRestrictionTransactionDTO {
  ...EmbeddedTransactionDTO;
  ...MosaicGlobalRestrictionTransactionBodyDTO;
}

/**
 * Transaction to transfer mosaics and a message to another account.
 */
model TransferTransactionDTO {
  ...TransactionDTO;
  ...TransferTransactionBodyDTO;
}

model EmbeddedTransferTransactionDTO {
  ...EmbeddedTransactionDTO;
  ...TransferTransactionBodyDTO;
}

model AnnounceTransactionInfoDTO {
  message: string;
}

model EmbeddedTransactionBodyDTO {
  /**
   * Array of transactions initiated by different accounts.
   */
  transactions: EmbeddedTransactionInfoDTO[];
}

model EmbeddedTransactionDTO {
  ...EntityDTO;
}

model EmbeddedTransactionInfoDTO {
  id: ID;

  meta: EmbeddedTransactionMetaDTO;
  transaction:
    | EmbeddedAccountKeyLinkTransactionDTO
    | EmbeddedNodeKeyLinkTransactionDTO
    | EmbeddedVrfKeyLinkTransactionDTO
    | EmbeddedVotingKeyLinkTransactionDTO
    | EmbeddedHashLockTransactionDTO
    | EmbeddedSecretLockTransactionDTO
    | EmbeddedSecretProofTransactionDTO
    | EmbeddedAccountMetadataTransactionDTO
    | EmbeddedMosaicMetadataTransactionDTO
    | EmbeddedNamespaceMetadataTransactionDTO
    | EmbeddedMosaicDefinitionTransactionDTO
    | EmbeddedMosaicSupplyChangeTransactionDTO
    | EmbeddedMosaicSupplyRevocationTransactionDTO
    | EmbeddedNamespaceRegistrationTransactionDTO
    | EmbeddedAddressAliasTransactionDTO
    | EmbeddedMosaicAliasTransactionDTO
    | EmbeddedMultisigAccountModificationTransactionDTO
    | EmbeddedAccountAddressRestrictionTransactionDTO
    | EmbeddedAccountMosaicRestrictionTransactionDTO
    | EmbeddedAccountOperationRestrictionTransactionDTO
    | EmbeddedMosaicGlobalRestrictionTransactionDTO
    | EmbeddedMosaicAddressRestrictionTransactionDTO
    | EmbeddedTransferTransactionDTO;
}

model EmbeddedTransactionMetaDTO {
  height: Height;
  aggregateHash: Hash256;

  /**
   * Identifier of the aggregate transaction.
   */
  aggregateId: string;

  /**
   * Transaction index within the aggregate.
   */
  index: integer;

  timestamp?: Timestamp;
  feeMultiplier?: BlockFeeMultiplier;
}

model TransactionPage is Page<TransactionInfoDTO>;

model TransactionBodyDTO {
  maxFee: Amount;
  deadline: BlockDuration;
}

model TransactionDTO {
  ...SizePrefixedEntityDTO;
  ...VerifiableEntityDTO;
  ...EntityDTO;
  ...TransactionBodyDTO;
}

model TransactionInfoDTO {
  id: ID;

  meta: TransactionMetaDTO | EmbeddedTransactionMetaDTO;
  transaction:
    | AccountKeyLinkTransactionDTO
    | EmbeddedAccountKeyLinkTransactionDTO
    | NodeKeyLinkTransactionDTO
    | EmbeddedNodeKeyLinkTransactionDTO
    | VrfKeyLinkTransactionDTO
    | EmbeddedVrfKeyLinkTransactionDTO
    | VotingKeyLinkTransactionDTO
    | EmbeddedVotingKeyLinkTransactionDTO
    | AggregateTransactionDTO
    | AggregateTransactionExtendedDTO
    | HashLockTransactionDTO
    | EmbeddedHashLockTransactionDTO
    | SecretLockTransactionDTO
    | EmbeddedSecretLockTransactionDTO
    | SecretProofTransactionDTO
    | EmbeddedSecretProofTransactionDTO
    | AccountMetadataTransactionDTO
    | EmbeddedAccountMetadataTransactionDTO
    | MosaicMetadataTransactionDTO
    | EmbeddedMosaicMetadataTransactionDTO
    | NamespaceMetadataTransactionDTO
    | EmbeddedNamespaceMetadataTransactionDTO
    | MosaicDefinitionTransactionDTO
    | EmbeddedMosaicDefinitionTransactionDTO
    | MosaicSupplyChangeTransactionDTO
    | EmbeddedMosaicSupplyChangeTransactionDTO
    | MosaicSupplyRevocationTransactionDTO
    | EmbeddedMosaicSupplyRevocationTransactionDTO
    | NamespaceRegistrationTransactionDTO
    | EmbeddedNamespaceRegistrationTransactionDTO
    | AddressAliasTransactionDTO
    | EmbeddedAddressAliasTransactionDTO
    | MosaicAliasTransactionDTO
    | EmbeddedMosaicAliasTransactionDTO
    | MultisigAccountModificationTransactionDTO
    | EmbeddedMultisigAccountModificationTransactionDTO
    | AccountAddressRestrictionTransactionDTO
    | EmbeddedAccountAddressRestrictionTransactionDTO
    | AccountMosaicRestrictionTransactionDTO
    | EmbeddedAccountMosaicRestrictionTransactionDTO
    | AccountOperationRestrictionTransactionDTO
    | EmbeddedAccountOperationRestrictionTransactionDTO
    | MosaicGlobalRestrictionTransactionDTO
    | EmbeddedMosaicGlobalRestrictionTransactionDTO
    | MosaicAddressRestrictionTransactionDTO
    | EmbeddedMosaicAddressRestrictionTransactionDTO
    | TransferTransactionDTO
    | EmbeddedTransferTransactionDTO;
}

model TransactionMetaDTO {
  height: Height;
  hash: Hash256;
  merkleComponentHash: Hash256;

  /**
   * Transaction index within the block.
   */
  index: integer;

  timestamp?: Timestamp;
  feeMultiplier?: BlockFeeMultiplier;
}

model TransactionStatusDTO {
  group: TransactionGroupEnum;
  code?: TransactionStatusEnum;
  hash: Hash256;
  deadline: BlockDuration;
  height?: Height;
}
