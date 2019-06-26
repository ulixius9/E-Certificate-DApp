pragma solidity >=0.4.0 <0.6.0;

contract Owners{
    address owner;
    
    constructor () public{
        owner=msg.sender;
    }
    
    modifier checkOwner(){
        require(
            msg.sender==owner,
            'You must be the owner to set certificate'
        );
        _;
    }
}

contract Certificate is Owners{
    
    struct Holder{
        uint level;
        bytes16 name;
    }
    
    mapping (address => Holder) holders;
    address[] public holderAdd;
    
    
    event HolderInfo(
        bytes16 name,
        uint level
    );
    
    
    modifier checkLevel(uint _level){
        require(
        _level<=3,
        "You must enter correct level"
        );
        _;
    }
    
    function setHolderInfo (address _address, bytes16 _name, uint _level) public checkLevel(_level) checkOwner{
        holders[_address].name=_name;
        holders[_address].level=_level;
        holderAdd.push(_address);
        emit HolderInfo(_name,_level);
    }
    
    function getHolders() view public returns (address[] memory){
        return(holderAdd);
    }
    
    function getHolder(address _address) view public returns(bytes16, uint){
        return(holders[_address].name,holders[_address].level);
    }
    
    function holderCount() view public returns(uint){
        return (holderAdd.length);
    }
}
