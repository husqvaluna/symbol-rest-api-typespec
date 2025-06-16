import "@typespec/http";
import "./types/core.tsp";
import "./models";

using Http;

namespace Parameters {
  model address {
    /**
     * Account address.
     */
    @path address: Address;
  }

  model accountIdPath {
    /**
     * Account public key or address encoded using a 32-character set.
     */
    @path accountId: string;
  }

  model hashPath {
    /**
     * Filter by hash.
     */
    @path hash: Hash256;
  }

  model compositeHashPath {
    /**
     * Filter by composite hash.
     */
    @path compositeHash: Hash256;
  }

  model heightPath {
    /**
     * Block height.
     */
    @path height: Height;
  }

  model limitPath {
    /**
     * Number of elements to be returned.
     * The limit should be greater than or equal to "db.pageSizeMin" and not higher than "db.pageSizeMax".
     * The settings are adjustable via the configuration file (rest/resources/rest.json) per REST instance.
     *
     */
    @path limit: integer;
  }

  model mosaicIdPath {
    /**
     * Mosaic identifier.
     */
    @path mosaicId: MosaicId;
  }

  model namespaceIdPath {
    /**
     * Namespace identifier.
     */
    @path namespaceId: NamespaceId;
  }

  model publicKeyPath {
    /**
     * Account public key.
     */
    @path publicKey: PublicKey;
  }

  model receiptHashPath {
    /**
     * Receipt hash.
     */
    @path hash: Hash256;
  }

  model sourceAddressPath {
    /**
     * Account address.
     */
    @path sourceAddress: Address;
  }

  model transactionHashPath {
    /**
     * Transaction hash.
     */
    @path hash: Hash256;
  }

  model transactionIdPath {
    /**
     * Transaction id or hash.
     */
    @path transactionId: string;
  }

  model addressQuery {
    /**
     * Filter by address involved in the transaction.
     * An account's address is considered to be involved in the transaction when
     * the account is the sender, recipient, or it is required to cosign the transaction.
     * This filter cannot be combined with ``recipientAddress`` and ``signerPublicKey`` query params.
     *
     */
    @query(#{ explode: true }) address?: Address;
  }

  model artifactIdQuery {
    /**
     * Mosaic or namespace identifier
     */
    @query(#{ explode: true }) artifactId?: string;
  }

  model mosaicIdQuery {
    /**
     * Filter by mosaic identifier.
     */
    @query(#{ explode: true }) mosaicId?: MosaicId;
  }

  model aliasTypeQuery {
    /**
     * Filter by alias type.
     */
    @query(#{ explode: true }) aliasType?: AliasTypeEnum;
  }

  model beneficiaryAddressQuery {
    /**
     * Filter by beneficiary address.
     */
    @query(#{ explode: true }) beneficiaryAddress?: Address;
  }

  model embedded {
    /**
     * When true, the endpoint also returns all the embedded aggregate transactions.
     * Otherwise, only top-level transactions used to calculate the block transactionsHash are returned.
     * **Note:** This field does not work when combined with the ``address`` parameter. This is,
     * embedded transactions containing the address specified through the ``address`` parameter
     * will not be returned even when used with ``embedded=true``. There is no problem when using
     * other parameters like ``recipientAddress`` instead.
     *
     */
    @query(#{ explode: true }) embedded?: boolean;
  }

  model entryType {
    /**
     * Filter by entry type.
     */
    @query(#{ explode: true }) entryType?: MosaicRestrictionEntryTypeEnum;
  }

  model fromHeightQuery {
    /**
     * Only blocks with height greater or equal than this one are returned.
     */
    @query(#{ explode: true }) fromHeight?: Height;
  }

  model fromTransferAmountQuery {
    /**
     * Requires providing the `transferMosaicId` filter.
     * Only transfer transactions with a transfer amount of the provided mosaic id, greater or equal than this amount are returned.
     *
     */
    @query(#{ explode: true }) fromTransferAmount?: Amount;
  }

  model heightQuery {
    /**
     * Filter by block height.
     */
    @query(#{ explode: true }) height?: Height;
  }

  model idQuery {
    /**
     * Entry id at which to start pagination.
     * If the ordering parameter is set to -id, the elements returned precede the identifier.
     * Otherwise, newer elements with respect to the id are returned.
     *
     */
    @query(#{ explode: true }) id?: string;
  }

  model metadataType {
    /**
     * Filter by metadata type.
     */
    @query(#{ explode: true }) metadataType?: MetadataTypeEnum;
  }

  model level0Query {
    /**
     * Filter by root namespace.
     */
    @query(#{ explode: true }) level0?: NamespaceId;
  }

  model offsetQuery {
    /**
     * Entry id at which to start pagination.
     * If the ordering parameter is set to -id, the elements returned precede the identifier.
     * Otherwise, newer elements with respect to the id are returned.
     *
     */
    @query(#{ explode: true }) offset?: string;
  }

  model orderQuery {
    /**
     * Sort responses in ascending or descending order based on the collection property set on the param ``orderBy``.
     * If the request does not specify ``orderBy``, REST returns the collection ordered by id.
     *
     */
    @query(#{ explode: true }) order?: Order;
  }

  model orderByAccountQuery {
    /**
     * Sort responses by the property set.
     * If ``balance`` option is selected, the request must define the ``mosaicId`` filter.
     *
     */
    @query(#{ explode: true }) orderBy?: AccountOrderByEnum;
  }

  model ownerAddressQuery {
    /**
     * Filter by owner address.
     */
    @query(#{ explode: true }) ownerAddress?: Address;
  }

  model orderByBlockQuery {
    /**
     * Sort responses by the property set.
     *
     */
    @query(#{ explode: true }) orderBy?: BlockOrderByEnum;
  }

  model pageNumberQuery {
    /**
     * Filter by page number.
     */
    @minValue(1)
    @query(#{ explode: true }) pageNumber?: integer = 1;
  }

  model pageSizeQuery {
    /**
     * Select the number of entries to return.
     */
    @minValue(10)
    @maxValue(100)
    @query(#{ explode: true })
    pageSize?: integer = 10;
  }

  model receiptTypeQuery {
    /**
     * Filter by receipt type.
     * To filter by multiple receipt types, add more filter query params like: ``receiptType=8515&receiptType=20803``.
     *
     */
    @query(#{ explode: true }) receiptType?: ReceiptTypeEnum[];
  }

  model recipientAddressQuery {
    /**
     * Filter by address of the account receiving the transaction.
     */
    @query(#{ explode: true }) recipientAddress?: Address;
  }

  model secretQuery {
    /**
     * Filter by secret.
     */
    @query(#{ explode: true }) secret?: Secret;
  }

  model senderAddressQuery {
    /**
     * Filter by address sending mosaics.
     */
    @query(#{ explode: true }) senderAddress?: Address;
  }

  model scopedMetadataKeyQuery {
    /**
     * Filter by metadata key.
     */
    @query(#{ explode: true }) scopedMetadataKey?: MetadataKey;
  }

  model sourceAddressQuery {
    /**
     * Filter by address sending the metadata entry.
     */
    @query(#{ explode: true }) sourceAddress?: Address;
  }

  model registrationTypeQuery {
    /**
     * Filter by registration type.
     */
    @query(#{ explode: true })
    registrationType?: NamespaceRegistrationTypeEnum;
  }

  model signerPublicKeyQuery {
    /**
     * Filter by public key of the account signing the entity.
     */
    @query(#{ explode: true }) signerPublicKey?: PublicKey;
  }

  model targetIdQuery {
    /**
     * Filter by namespace or mosaic id.
     */
    @format("hex")
    @query(#{ explode: true }) targetId?: string;
  }

  model targetAddressQuery {
    /**
     * Filter by target address.
     */
    @query(#{ explode: true }) targetAddress?: Address;
  }

  model toHeightQuery {
    /**
     * Only blocks with height smaller or equal than this one are returned.
     */
    @query(#{ explode: true }) toHeight?: Height;
  }

  model toTransferAmountQuery {
    /**
     * Requires providing the `transferMosaicId` filter.
     * Only transfer transactions with a transfer amount of the provided mosaic id, lesser or equal than this amount are returned.
     *
     */
    @query(#{ explode: true }) toTransferAmount?: Amount;
  }

  model transactionTypeQuery {
    /**
     * Filter by transaction type.
     * To filter by multiple transaction types, add more filter query params like: ``type=16974&type=16718``.
     *
     */
    @query(#{ explode: true }) type?: TransactionTypeEnum[];
  }

  model transferMosaicIdQuery {
    /**
     * Filters transactions involving a specific ``mosaicId``.
     */
    @query(#{ explode: true }) transferMosaicId?: MosaicId;
  }

  model paginationParameters {
    ...pageSizeQuery,
    ...pageNumberQuery,
    ...offsetQuery,
    ...orderQuery,
  }
}
