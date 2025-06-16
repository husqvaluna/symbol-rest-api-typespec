import "../types/core.tsp";

model UnlockedAccountDTO {
  unlockedAccount: PublicKey[];
}

model DeploymentDTO {
  /**
   * The tool used to create, maintain and deploy the node. Examples: symbol-bootstrap, manual.
   */
  @example("symbol-bootstrap")
  deploymentTool: string;

  /**
   * The version of the tool used to create, maintain and deploy the node.
   */
  @example("1.1.11")
  deploymentToolVersion: string;

  /**
   * When was the node last upgraded.
   */
  @example("2025-03-11")
  lastUpdatedDate: string;
}

model ServerDTO {
  /**
   * catapult-rest component version.
   */
  @example("2.4.4")
  restVersion: string;

  /**
   * catapult-sdk component version.
   */
  @example("")
  sdkVersion: string;

  deployment: DeploymentDTO;
}

model ServerInfoDTO {
  serverInfo: ServerDTO;
}

model CommunicationTimestampsDTO {
  sendTimestamp?: Timestamp;
  receiveTimestamp?: Timestamp;
}

model NodeTimeDTO {
  communicationTimestamps: CommunicationTimestampsDTO;
}

model DatabaseDTO {
  numIndexes: 76,
  numObjects: 7328577,
  dataSize: 7129099034,
  indexSize: 550572032,
  storageSize: 3327238144
}

model StorageInfoDTO {
  /**
   * Number of blocks stored.
   */
  numBlocks: integer;

  /**
   * Number of transactions stored.
   */
  numTransactions: integer;

  /**
   * Number of accounts created.
   */
  numAccounts: integer;

  database: DatabaseDTO
}

/**
 * A number that defines the different roles the node provides. Possible roles are:
 * * 1 - Peer node.
 * * 2 - Api node.
 * * 4 - Voting node.
 * * 64 - IPv4 compatible node
 * * 128 - IPv6 compatible node.
 *
 * The values are bitwise added together, Examples:
 * 1 = Just Peer.
 * 2 = Just Api.
 * 3 = Peer and Api node.
 * 7 = Peer, Api and Voting node.
 * 65 = IPv4 and Peer node.
 *
 */
@example(3)
scalar RolesTypeEnum extends integer;

model NodeInfoDTO {
  /**
   * Version of the application.
   */
  @example(16777991)
  version: integer;

  publicKey: PublicKey;
  networkGenerationHashSeed: Hash256;
  roles: RolesTypeEnum;

  /**
   * Port used for the communication.
   */
  @example(7900)
  port: integer;

  @example(152)
  networkIdentifier: integer;

  /**
   * Node friendly name.
   */
  @example("mock-server")
  friendlyName: string;

  /**
   * Node IP address.
   */
  @example("192.0.2.1")
  host: string;

  nodePublicKey?: PublicKey;
}

model NodeHealthDTO {
  /**
   * API node service status.
   */
  apiNode: NodeStatusEnum;

  /**
   * MongoDB service status.
   */
  db: NodeStatusEnum;
}

model NodeHealthInfoDTO {
  status: NodeHealthDTO;
}

enum NodeStatusEnum {
  up,
  down,
}

/**
 * Node equality strategy. Defines if the identifier for the node must be its public key or host.
 */
enum NodeIdentityEqualityStrategy {
  host,
  `public-key`,
}
