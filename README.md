# VoterContract
The Voting Contract can have n candidates
Each candidate need to be registered before starting the Voting process
Each Voter need to be registered to the Contract
Owner of the contract needs to manually verify all the voters
The voting process is kept open (i.e., voting is permitted) during a certain time frame
which is specified by the creator of the contract.
The votes can come only from addresses that are marked as “verified". Thus, the creator
of the contract must mark all permitted addresses as "verified" before the voting can
begin (write a function that would help the creator to mark an address as "verified").
To prevent cheating, each verified address can vote only once - after voting, the address
is marked as "unverified" and thus can't vote again.
winner function returns the winner. The winner should have at least the 60% of
votes. Otherwise, there is no winner.
The contract should not accept any funds sent to it. Any funds sent to the contract (e.g.,
by accident) should be returned to the sender.
