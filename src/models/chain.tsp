import "../types/core.tsp";
import "./common.tsp";

model ChainInfoDTO {
  height: Height;
  scoreHigh: Score;
  scoreLow: Score;
  latestFinalizedBlock: FinalizedBlockDTO;
}
