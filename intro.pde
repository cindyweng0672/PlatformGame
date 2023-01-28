void intro(){
  gif.get(0).act(); 
  gif.get(0).show();
  
  myButton.get(0).act();
  myButton.get(0).show();
  
  textFont(pixelFont);
  textSize(50);
  textAlign(CENTER);
  text("Platformer", width/2, height/2-100);
  
  if(myButton.get(0).clicked){
    mode=PLAY;
  }
}
