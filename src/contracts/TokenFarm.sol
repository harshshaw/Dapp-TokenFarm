pragma solidity >0.5.0;
import "./DappToken.sol";
import "./DaiToken.sol";

contract TokenFarm {
    string public name = "Dapp Token Farm";
    // Storing in the state with type as DappToken and variable dappToken etc.
    address public owner;
    DappToken public dappToken;
    DaiToken public daiToken;

    address[] public stakers;
    mapping(address => uint256) public stakingBalance;
    mapping(address => bool) public hasStaked;
    mapping(address => bool) public isStaking;

    constructor(DappToken _dappToken, DaiToken _daiToken) public {
        dappToken = _dappToken;
        daiToken = _daiToken;
        owner = msg.sender;
    }

    //1.Stakes Tokens (Deposit)
    function stakeTokens(uint256 _amount) public {
        require(_amount > 0, "amount cannot be 0");

        daiToken.transferFrom(msg.sender, address(this), _amount);
        stakingBalance[msg.sender] = stakingBalance[msg.sender] + _amount;

        if (!hasStaked[msg.sender]) {
            stakers.push(msg.sender);
        }

        //updateStaking Status
        isStaking[msg.sender] = true;
        hasStaked[msg.sender] = true;
    }

    //Unstaking Tokens(Withdraw)

    function unstakeTokens() public {
        uint256 balance = stakingBalance[msg.sender];

        //Require amount greater than 0
        require(balance >= 0, "Staking balannce cannot be 0");

        //Transfer Mock Dai tokens to this contract for staking
        daiToken.transfer((msg.sender), balance);

        //Reset staking balance
        stakingBalance[msg.sender] = 0;

        isStaking[msg.sender] = false;
    }

    //2. Unstaking Token (withdraw)
    //Issusing Tokens

    function issueTokens() public {
        require(msg.sender == owner, "Caller must be owner");
        for (uint256 i = 0; i < stakers.length; i++) {
            address recipient = stakers[i];
            uint256 balance = stakingBalance[recipient];

            if (balance > 0) {
                dappToken.transfer(recipient, balance);
            }
        }
    }
}
