var TTT;

TTT = function() {
  var currentPiece,
      setCurrentPiece,
      mouseOverSquare,
      mouseOutSquare;

  currentPiece = "";

  return {
    setCurrentPiece : function(player) {
      currentPiece = player;
    },
    mouseOverSquare : function(element) {
      if (element.src.match(/empty_square/)) {
        element.src = "/images/pieces/" + currentPiece + "_dim.png";
      }
    },
    mouseOutSquare : function(element) {
      if (element.src.match(/_dim/)) {
        element.src = "/images/pieces/empty_square.png";
      }
    }
  };
}();
