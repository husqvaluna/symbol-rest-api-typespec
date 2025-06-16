import "@typespec/http";
import "@typespec/openapi";
import "@typespec/openapi3";

import "./models";
import "./routes";

using Http;
using OpenAPI;

@info(#{
  version: "1.0.4",
  license: #{ name: "Apache 2.0", url: "http://www.apache.org/licenses/LICENSE-2.0.html" },
})
@service(#{ title: "Catapult REST Endpoints" })
@doc("OpenAPI Specification of catapult-rest")
@server("http://localhost:3000", "Local development")
@server("https://sym-main-01.opening-line.jp:3001", "MAINNET sym-main-01.opening-line.jp")
@server("https://sym-main-02.opening-line.jp:3001", "MAINNET sym-main-02.opening-line.jp")
@server("https://sym-main-03.opening-line.jp:3001", "MAINNET sym-main-03.opening-line.jp")
@server("https://sym-test-01.opening-line.jp:3001", "TESTNET sym-test-01.opening-line.jp")
@server("https://sym-test-03.opening-line.jp:3001", "TESTNET sym-test-03.opening-line.jp")
namespace Catapult;
