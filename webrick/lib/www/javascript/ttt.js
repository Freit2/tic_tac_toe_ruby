var TTT;

TTT = function() {
  var currentPlayer,
      setCurrentPlayer,
      mouseOverSquare,
      mouseOutSquare;

  currentPlayer = "";

  return {
    setCurrentPlayer : function(player) {
      currentPlayer = player;
    },
    mouseOverSquare : function(element) {
      if (element.src.match(/empty_square/)) {
        element.src = "/images/pieces/" + currentPlayer + "_dim.png";
      }
    },
    mouseOutSquare : function(element) {
      if (element.src.match(/_dim/)) {
        element.src = "/images/pieces/empty_square.png";
      }
    }
  };
}();
