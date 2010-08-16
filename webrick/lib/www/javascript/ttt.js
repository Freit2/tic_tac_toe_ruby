var TTT;

TTT = function() {
  var currentPiece,
      isPlayerAllowed,
      setCurrentPiece,
      setPlayerAllowed,
      mouseOverSquare,
      mouseOutSquare;

  currentPiece = "";
  isPlayerAllowed = false;

  return {
    setCurrentPiece : function(player) {
      currentPiece = player;
    },
    setPlayerAllowed : function(bool) {
      isPlayerAllowed = bool;
    },
    mouseOverSquare : function(element) {
      if (element.src.match(/empty_square/) && isPlayerAllowed) {
        element.src = "/images/pieces/" + currentPiece + "_dim.png";
      }
    },
    mouseOutSquare : function(element) {
      if (element.src.match(/_dim/) && isPlayerAllowed) {
        element.src = "/images/pieces/empty_square.png";
      }
    }
  };
}();
