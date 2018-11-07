pragma solidity ^0.4.18;

contract Hackathon {
  struct Project {
    string title;
    uint[] ratings;
  }
  Project[] projects;
  
  // TODO: add the findWinner function
  
  function newProject(string _title) public {
    // creates a new project with a title and an empty ratings array
    projects.push(Project(_title, new uint[](0)));
  }

  function rate(uint _idx, uint _rating) public {
    // rates a project by its index
    projects[_idx].ratings.push(_rating);
  }

  function findWinner() public view returns(string){
    uint index;
    uint highestScore = 0;
    if(projects.length == 1){
      return projects[0].title;
    }
    for(uint i =0; i < projects.length; i++){
      uint tempScore = 0;
      for(uint k=0; k < projects[i].ratings.length; k++){
        tempScore += projects[i].ratings[k]; 
      }
      uint value = tempScore / projects[i].ratings.length;
      if(value > highestScore){
        index = i;
        highestScore = value;
      }
    }
    return projects[index].title;
  }
}
