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

  @doc("Namespace name.")
  name: string;
}

model NamespaceNetworkPropertiesDTO {
  @doc("Maximum namespace name size.")
  @example("64")
  maxNameSize?: string;

  @doc("Maximum number of children for a root namespace.")
  @example("100")
  maxChildNamespaces?: string;

  @doc("Maximum namespace depth.")
  @example("3")
  maxNamespaceDepth?: string;

  @doc("Minimum namespace duration.")
  @example("30d")
  minNamespaceDuration?: string;

  @doc("Maximum namespace duration.")
  @example("1825d")
  maxNamespaceDuration?: string;

  @doc("Grace period during which time only the previous owner can renew an expired namespace.")
  @example("1d")
  namespaceGracePeriodDuration?: string;

  @doc("Reserved root namespaces that cannot be claimed.")
  @example("symbol, symbl, xym, xem, nem, user, account, org, com, biz, net, edu, mil, gov, info")
  reservedRootNamespaceNames?: string;

  @doc("Address of the namespace rental fee sink account.")
  @example("TDVFW6NZN3YI6O4ZRYZHGY73KADCW4HX6IDIKZI")
  namespaceRentalFeeSinkAddress?: Address;

  @doc("Root namespace rental fee per block.")
  @example("2")
  rootNamespaceRentalFeePerBlock?: string;

  @doc("Child namespace rental fee.")
  @example("100000")
  childNamespaceRentalFee?: string;
}

model NamespacePage is Page<NamespaceInfoDTO>;
