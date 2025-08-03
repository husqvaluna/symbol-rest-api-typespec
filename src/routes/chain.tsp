import "../types/core.tsp";
import "../models";
import "../parameters.tsp";

using Http;

@tag("Chain routes")
@route("/chain")
namespace Catapult.Chain {
  @get
  @route("/info")
  @summary("Get the current information of the chain")
  @doc("""
Returns the current information of the blockchain.

The higher the score, the better the chain.
During synchronization, nodes try to get the best blockchain in the network.

The score for a block is derived from its difficulty and the time (in seconds) that has elapsed since the last block:

block score = difficulty − time elapsed since last block
""")
  op getChainInfo(): ChainInfoDTO;
}
