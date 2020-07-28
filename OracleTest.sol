// import "github.com/oraclize/ethereum-api/oraclizeAPI.sol";
import "./libs/oraclize25.sol";

contract DieselPrice is usingOraclize {

    string public DieselPriceUSD;

    function updatePrice() public payable {
        if (oraclize_getPrice("URL") > this.balance) {
            //Handle out of funds error
        } else {
            oraclize_query("URL", "xml(https://www.fueleconomy.gov/ws/rest/fuelprices).fuelPrices.diesel");
        }
    }
    
    function __callback(bytes32 myid, string result) public {
        require(msg.sender == oraclize_cbAddress());
        DieselPriceUSD = result;
    }
}

// https://stackoverflow.com/questions/49481308/get-live-data-from-database-in-solidity
// contract DieselPrice is usingOraclize {

//     string public DieselPriceUSD;
//     event LogConstructorInitiated(string nextStep);
//     event LogPriceUpdated(string price);
//     event LogNewProvableQuery(string description);

//     function DieselPrice() payable {
//         LogConstructorInitiated("Constructor was initiated. Call 'updatePrice()' to send the Provable Query.");
//     }

//     function __callback(bytes32 myid, string result) {
//         if (msg.sender != oraclize_cbAddress()) throw;
//         newDieselPrice(result);
//         DieselPriceUSD = parseInt(result, 2); // let's save it as $ cents
//         // do something with the USD Diesel price
//     }

//     function update() payable {
//         newOraclizeQuery("Oraclize query was sent, standing by for the answer..");
//         oraclize_query("URL", "xml(https://www.fueleconomy.gov/ws/rest/fuelprices).fuelPrices.diesel");
//     }
// }