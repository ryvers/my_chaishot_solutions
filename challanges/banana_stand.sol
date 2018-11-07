pragma solidity ^0.4.19;

contract BananaStand {
  uint8 public bananas;

  function addBananas(uint8 x) public {
      require(bananas < x);
      bananas +=x;
  }

  function removeBananas(uint8 x) public {
      require(bananas >= x);
      bananas -= x;
  }
}
