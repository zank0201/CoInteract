pragma solidity ^0.5.0;

// need contract interface with CoToken
import "./CoToken.sol";

contract CoShoe {
    
    
    struct Shoe {
        address payable owner;
        bool sold;
        string name;//url to image
        string image;
    }
    // state variable of 0.5 ether and convert to wei
    //uint public price = 0.5 * 1e18 wei ;
    //  state variable shoessold which keeps number of shoes already sold
    // initialise as zero
    uint public shoesSold = 0;

    // public array holding instance of shoes
    Shoe[] public shoes;
    CoToken public cotoken;

    //  map containing balances
    //mapping (address => uint) public balances;

    address payable public minter;

    // constructor to mint 100 coshoe tokens
    constructor () public {
        // set address of deployer to be owner
        //  instance within shoe array
        Shoe memory shoeArray;
        minter  = msg.sender;
        shoeArray.owner = minter;
        shoeArray.name = "";
        shoeArray.image = "";
        shoeArray.sold = false;  

        // use mint function to mint 100  tokens to mintere
        
        
        // push instances to Shoe array
       // balances[minter] = 100;
        shoes.push(shoeArray);
    
    }

    
    // function called buyhsoe
    function buyShoe(string memory _name, string memory _image, address addr) public {
    cotoken = CoToken(addr);
    // find pair of shoes that have not been sold yet
    
    require(shoesSold >0  || shoesSold <=100, "The are no shoes available.");

    // checks value of attahced function is same as price
    
    // need to call balanceOf function from mint function to check if address has money
    require(cotoken.balances(msg.sender) > 0, "No tokens are owned by buyer");
    cotoken.transferFrom(msg.sender, minter, 1);
    
    bool newSold = true;
    // push to shoes array
    shoes.push(Shoe(msg.sender, newSold, _name ,_image));
    
    // upgrade value of shoes sold
    shoesSold++;
    

    }
    
    // function to check purchases
    function checkPurchases() public view returns(bool[] memory) {
        //set empty boolean array of length of number of shoes sold which will check
        // will put true in index of array 
        bool[] memory _soldarray = new bool[](100);

        for (uint i = 0; i <= shoesSold; i++) {
            Shoe storage shoe = shoes[i];
            if( shoe.owner == msg.sender ) {
                _soldarray[i]= true ;
            }
            else {
                _soldarray[i] = false;
            }
        }
        return _soldarray;
        
    }

    


}
