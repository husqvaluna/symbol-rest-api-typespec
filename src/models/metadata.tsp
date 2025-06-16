import "../types/core.tsp";
import "./common.tsp";

model MetadataEntryDTO {
  version: StateVersion;
  compositeHash: Hash256;
  sourceAddress: Address;
  targetAddress: Address;
  scopedMetadataKey: MetadataKey;
  targetId?: MosaicId | NamespaceId;
  metadataType: MetadataTypeEnum;

  /**
   * Metadata value.
   */
  @format("hex") value: string;
}

model MetadataInfoDTO {
  id: string;
  metadataEntry: MetadataEntryDTO;
}

model MetadataNetworkPropertiesDTO {
  /**
   * Maximum metadata value size.
   */
  maxValueSize?: string;
}

model MetadataPage is Page<MetadataInfoDTO>;
