//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

contract VotingContract {
    struct Candidate {
        string name;
        bool verified;
        address _address;
        uint256 totalVotes;
        bool exists;
    }

    struct Voter {
        string name;
        bool verified;
        address _address;
        bool exists;
    }

    event Logger(string msg);
    mapping(string => Candidate) public Candidates;
    mapping(address => Voter) public Voters;
    string[] public candidateNames;
    string[] public voterNames;
    uint256 private openingTime;
    uint256 private totalCandidates;
    address private owner;
    uint256 totalVotes;

    constructor() {
        owner = msg.sender;
    }

    modifier isOwner() {
        require(owner == msg.sender, "Only owner can perform this Operation");
        _;
    }

    modifier isVerified(address _address) {
        require(Voters[_address].verified, "The voter is not verified");
        _;
    }

    modifier votingOn() {
        require(block.timestamp <= openingTime, "Voting in progress");
        _;
    }

    modifier votingOff() {
        require(openingTime == 0, "Voting already begun");
        _;
    }

    function getOpeningTime() public view returns (uint256) {
        return openingTime;
    }

    function setVotingTime(uint256 _min) public {
        openingTime = block.timestamp + (_min * 60 * 1000);
    }

    function registerCandidate(
        string memory _candidateName,
        address _candidateAddress
    ) public votingOff isOwner {
        require(
            Candidates[_candidateName].exists == false,
            "Candidate Already Registered"
        );
        Candidates[_candidateName] = Candidate(
            _candidateName,
            true,
            _candidateAddress,
            0,
            true
        );
        candidateNames.push(_candidateName);
        totalCandidates += 1;
    }

    function deleteCandidate(string memory _candidateName)
        public
        returns (bool)
    {
        delete Candidates[_candidateName];
        return true;
    }

    function registerAsVoter(string memory _name) public {
        Voters[msg.sender] = Voter(_name, false, msg.sender, true);
        voterNames.push(_name);
    }

    function verifyVoter(address _address) public votingOff isOwner {
        require(Voters[_address].exists == true, "Voter does not exists");
        Voters[_address].verified = true;
    }

    function Vote(string memory _candidate)
        public
        votingOn
        isVerified(msg.sender)
    {
        Candidates[_candidate].totalVotes += 1;
        Voters[msg.sender].verified = false;
        totalVotes += 1;
        emit Logger("Vote logged");
    }

    function winner() public view returns (string memory) {
        string memory winnerCandidate = "No Winner";
        for (uint8 i = 0; i < totalCandidates; i++) {
            uint256 voteNumber = Candidates[candidateNames[i]].totalVotes;
            if ((voteNumber / totalCandidates) * 100 > 60) {
                winnerCandidate = candidateNames[i];
                break;
            }
        }
        return winnerCandidate;
    }

    fallback() external payable {
        emit Logger(
            "Dont send Funds with your transaction. This is a Voting Contract"
        );
        address payable to = payable(msg.sender);
        to.transfer(msg.value);
        emit Logger("Funds Reverted");
    }
}
