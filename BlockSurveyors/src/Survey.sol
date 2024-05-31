// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

contract Survey {
    //FUNCTIONS TO INCLUDE:
    // endNow()
    
    // getResults()
    
    
    address private owner;
    uint256 public id;
    mapping (address => bool) public hasVoted; //mapping of addresses to whether or not they have voted (true or false
    string surveyName; // name of the survey
    string question; // the question the user asks
    string[] solutions; // Written multiple choice options
    uint256[] answers; // collect answers
    uint256 numAllowedResponces; // how many people have answered
    uint256 startTime; // when the survey opens
    uint256 endTime; // when the survey closes
    uint256 ethReward; // amount of reward given to users

    modifier onlyOwner {
        require(msg.sender == owner, 'call exclusive to owner');
    }

    constructor(string memory _surveyName, 
                string memory _question, 
                string[] memory _solutions, 
                uint256 _duration, 
                uint256 _numAllowedResponces) {
        owner = msg.sender;         //initialize all members of the survey
        surveyName = _surveyName;
        question = _question;
        solutions = _solutions;
        numAllowedResponces = _numAllowedResponces;
        startTime = block.timestamp;
        endTime = startTime + _duration;
        ethReward = msg.value;

        for (uint256 i = 0; i < _solutions.length; i++) { //initialize all answers to 0
            answers.push(0);
        }
    
    }


     
    function endNow() public onlyOwner {
        endTime = block.timestamp;
    }

    function vote(uint256 option) public {
        hasVoted[msg.sender] = true; //mark the user as having voted
        answers[option] += 1; //increment the number of votes for the option
        numAllowedResponces -= 1; //decrement the number of allowed responses remaining
        if (numAllowedResponces == 0) { //if the number of allowed responses is 0, close the survey
            endNow();
        }
    }

    // Function to get the results of the survey
    function getResults() public view returns (uint256[] memory) {
        require(block.timestamp > endTime, "Survey is still active");

        //print the question followed by its number of votes in answers

    }
}
