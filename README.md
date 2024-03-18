(Read this file for better understanding of the programme)
 Deployment:

When deploying the `votingSystem` smart contract, you need to ensure that the deployment is done from an account that you trust with ownership privileges. This account will become the `contractOwner` and will have special permissions to manage the voting process.

 Registration

1. Registering Candidates: 
   - Use the `registerCandidates` function to add candidates to the `candidateList`. 
   - Only the `contractOwner` can register candidates, ensuring that the process is controlled and managed by the owner.

 Voting

1.Casting Votes: 
   - Voters can cast their votes using the `addVote` function.
   - The `onlyOnce` modifier ensures that each voter can cast only one vote.
   - The function checks if the candidate is valid and if the voter has not already cast a vote.

   Management

1.    Starting the Voting Process   :
   - The `contractOwner` can start the voting process using the `startVoting` function.
   - This action changes the `status` of the voting process to `running`, allowing voters to cast their votes.

2.    Stopping the Voting Process   :
   - The `contractOwner` can stop the voting process using the `stopVoting` function.
   - This action changes the `status` of the voting process to `completed`, indicating that the voting process has ended.

   Result

1.    Determining the Winner   :
   - After the voting process is completed, the `contractOwner` can determine the winner using the `getWinner` function.
   - The function calculates the candidate with the highest number of votes and returns their address along with the total number of votes they received.

   Best Practices

-    Security   : Ensure that the `contractOwner` account is secure and not vulnerable to unauthorized access.

