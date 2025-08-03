import "../types/core.tsp";
import "../models";
import "../parameters.tsp";

using Http;

@tag("Network routes")
@route("/network")
namespace Catapult.Network {
  @get
  @summary("Get the current network type of the chain")
  @doc("Returns the current network type.")
  op getNetworkType(): NetworkTypeDTO;

  @route("/fees")
  namespace Fee {
    @get
    @route("/rental")
    @summary("Get rental fees information")
    @doc("""
Returns the estimated effective rental fees for namespaces and mosaics.
This endpoint is only available if the REST instance has access to catapult-server ``resources/config-network.properties`` file.
To activate this feature, add the setting "network.propertiesFilePath" in the configuration file (rest/resources/rest.json).
""")
    op getRentalFees(): RentalFeesDTO | (ConflictResponse & ModelError);

    @get
    @route("/transaction")
    @summary("Get transaction fees information")
    @doc("""
Returns the average, median, highest and lower fee multiplier over the last "numBlocksTransactionFeeStats".
The setting "numBlocksTransactionFeeStats" is adjustable via the configuration file (rest/resources/rest.json) per REST instance.
""")
    op getTransactionFees(): TransactionFeesDTO;
  }

  @get
  @route("/properties")
  @summary("Get the network properties")
  @doc("""
Returns the content from a catapult-server network configuration file (resources/config-network.properties).
To enable this feature, the REST setting "network.propertiesFilePath" must define where the file is located.
This is adjustable via the configuration file (rest/resources/rest.json) per REST instance.
""")
  op getNetworkProperties(): NetworkConfigurationDTO | (ConflictResponse & ModelError);
}
