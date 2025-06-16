import "../types/core.tsp";
import "./common.tsp";

model MultisigAccountGraphInfoDTO {
  /**
   * Level of the multisig account.
   */
  level: integer;

  /**
   * Array of multisig accounts for this level.
   */
  multisigEntries: MultisigAccountInfoDTO[];
}

model MultisigAccountInfoDTO {
  multisig: MultisigDTO;
}

model MultisigDTO {
  version: StateVersion;
  accountAddress: Address;

  /**
   * Number of signatures needed to approve a transaction.
   */
  minApproval: UInt32;

  /**
   * Number of signatures needed to remove a cosignatory.
   */
  minRemoval: UInt32;

  /**
   * Addresses of the cosignatory accounts.
   */
  cosignatoryAddresses: Address[];

  /**
   * Multisig accounts where the account is cosignatory.
   */
  multisigAddresses: Address[];
}

model MultisigNetworkPropertiesDTO {
  /**
   * Maximum number of multisig levels.
   */
  maxMultisigDepth?: string;

  /**
   * Maximum number of cosignatories per account.
   */
  maxCosignatoriesPerAccount?: string;

  /**
   * Maximum number of accounts a single account can cosign.
   */
  maxCosignedAccountsPerAccount?: string;
}

