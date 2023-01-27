void gameover(){
  gif.get(0).act(); 
  gif.get(0).show();
  
  myButton.get(1).act(); 
  myButton.get(1).show();
  
  if(myButton.get(1).clicked){
    mode=PLAY;
    player.live=5;
    player2.live=5;
  }
  
  textSize(50);
  textAlign(CENTER);
  if(!player1win){
    text("WINNER Player 1", width/2, height/2-50);
  }else{
    text("WINNER Player 2", width/2, height/2-50);
  }
}
