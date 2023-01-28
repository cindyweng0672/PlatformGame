class Coin extends FGameObject{
  
  FWorld w;
  
  Coin(float x, float y, PImage img, FWorld w){
        super(gridSize);
        setPosition(x*gridSize, y*gridSize);
        setStatic(true);
        setSensor(true);
        attachImage(img);
        setName("coin");
        this.w=w;
  }
  
  void act(){
    if(isTouching("player")){
      w.remove(this);
    }
  }
}
