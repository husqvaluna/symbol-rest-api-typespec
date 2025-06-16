import "../types/core.tsp";
import "./common.tsp";

model AccountNamesDTO {
  address: Address;

  /**
   * Account linked namespace names.
   */
  names: string[];
}

model AccountsNamesDTO {
  /**
   * Array of account names.
   */
  accountNames: AccountNamesDTO[];
}

model AliasDTO {
  type: AliasTypeEnum;
  mosaicId?: MosaicId;
  address?: Address;
}

model MosaicNamesDTO {
  mosaicId: MosaicId;

  /**
   * Mosaic linked namespace names.
   */
  names: string[];
}

model MosaicsNamesDTO {
  /**
   * Array of mosaic names.
   */
  mosaicNames: MosaicNamesDTO[];
}

model NamespaceInfoDTO {
  /**
   * Internal resource identifier.
   */
  id: string;

  meta: NamespaceMetaDTO;
  `namespace`: NamespaceDTO;
}

model NamespaceMetaDTO {
  /**
   * If true, the namespace is active.
   */
  active: boolean;

  index: integer;
}

model NamespaceDTO {
  version: StateVersion;
  registrationType: NamespaceRegistrationTypeEnum;

  /**
   * Level of the namespace.
   */
  depth: integer;

  level0: NamespaceId;
  level1?: NamespaceId;
  level2?: NamespaceId;
  `alias`: AliasDTO;
  parentId: NamespaceId;
  ownerAddress: Address;
  startHeight: Height;
  endHeight: Height;
}

model NamespaceNameDTO {
  parentId?: NamespaceId;
  id: NamespaceId;

  /**
   * Namespace name.
   */
  name: string;
}

model NamespaceNetworkPropertiesDTO {
  /**
   * Maximum namespace name size.
   */
  maxNameSize?: string;

  /**
   * Maximum number of children for a root namespace.
   */
  maxChildNamespaces?: string;

  /**
   * Maximum namespace depth.
   */
  maxNamespaceDepth?: string;

  /**
   * Minimum namespace duration.
   */
  minNamespaceDuration?: string;

  /**
   * Maximum namespace duration.
   */
  maxNamespaceDuration?: string;

  /**
   * Grace period during which time only the previous owner can renew an expired namespace.
   */
  namespaceGracePeriodDuration?: string;

  /**
   * Reserved root namespaces that cannot be claimed.
   */
  reservedRootNamespaceNames?: string;

  /**
   * Address of the namespace rental fee sink account.
   */
  namespaceRentalFeeSinkAddress?: Address;

  /**
   * Root namespace rental fee per block.
   */
  rootNamespaceRentalFeePerBlock?: string;

  /**
   * Child namespace rental fee.
   */
  childNamespaceRentalFee?: string;
}

model NamespacePage is Page<NamespaceInfoDTO>;
