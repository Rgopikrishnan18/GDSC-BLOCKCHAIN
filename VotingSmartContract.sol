// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract votingSystem {
    
    //Variables required,later make them private
    address public contractOwner;
    uint256 public winnerCount;
    address public  winner;

    //Assigning conntract deployer address and voting status 
    constructor(){
        contractOwner=msg.sender;   
        status=votingStatus.notYetStarted;

    }

    //modifiers for onlyOwner acess and onlyOnce access
    modifier onlyOwner(){
        require(contractOwner==msg.sender,"Access limited to contractOwner");
        _;
        

    }
    modifier onlyOnce(){
        require(votersList[msg.sender]!=1 ,"Your vote has been casted already!");
        _;

    }
   

    //Enum type containing those status values
    enum votingStatus {notYetStarted,running,completed}
    votingStatus status ;

   //Two mappings one containing votersList showing number of votes casted by users and number of votes recieved by candidates(one vote per user),and also each to whom one casted his vote
    mapping(address=>uint256) public votersList;
    mapping(address=>uint256) public candidateVoteChart;
    mapping(address=>address)   voteCasted;

    

    //Array containing candidate adresses
    address[] public candidateList;



   
    //register the candidates only to be accessed by owner
    function registerCandidates(address _candidate)  public onlyOwner {
        require(!validateCandidate(_candidate),"Candidate already Listed!");
        candidateList.push(_candidate);
        candidateVoteChart[_candidate]=0;

    }

    //function to addvote,only to be accessed once
    function addVote(address _candidate)  public onlyOnce{
        require(validateCandidate(_candidate),"Invalid candidate address");
        candidateVoteChart[_candidate]+=1;
        votersList[msg.sender]+=1;
        voteCasted[msg.sender]=_candidate;
    }

    //validation of opted candidate by user
    function validateCandidate(address _candidate) public view returns(bool){
        for (uint256 i=0; i<candidateList.length; i++) 
        {if(candidateList[i]==_candidate){
            return true;
        }
            
        }
        return false;

    }

    //getting the cotecount of candidates
    function getVoteCount(address _candidate) public view returns (uint256){
        require(status==votingStatus.running||status==votingStatus.completed,"Voting not yet started please wait!");
        require (validateCandidate(_candidate),"Invalid address!");
        return candidateVoteChart[_candidate];

    }

    //gets the winner Status
    function getWinner( ) public  returns(address,uint256) {
        require(status==votingStatus.completed,"Election in progress!");
        for (uint256 i=0; i<candidateList.length; i++) 
        {if(candidateVoteChart[candidateList[i]]>=winnerCount){
            winner=candidateList[i];
            winnerCount=candidateVoteChart[winner];
        }
            
        }
        return (winner,winnerCount);
        

    }

    function startVoting() public onlyOwner{
        status=votingStatus.running;

    }

    function stopVoting() public onlyOwner{
        status=votingStatus.completed;

    }

    

    }

     

    
    
