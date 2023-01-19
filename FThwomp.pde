class FThwomp extends FGameObject {

  float x, y;
  PImage[] imgs;
  float yLimit;

  FThwomp(float x, float y, float lowerY, PImage[] imgs) {
    super(gridSize*2);
    setPosition(x, y);
    setName("thwopm");
    setRotatable(false);
    attachImage(imgs[0]);
    setStatic(true);

    /*int i=(int) y-5;
    while (map.get(x, i)!=black) {
      i--;
    }*/
    yLimit=lowerY;
  }

  void act() {
    if(checkPlayer(player)||checkPlayer(player2)){
      setStatic(false);
      attachImage(imgs[1]);
    }
  }

  void show() {
  }
  
  boolean checkPlayer(FPlayer p){
    if(p.getX()>x&&p.getX()<x+gridSize*2){
      if(p.getY()<y+gridSize*2&& p.getY()>yLimit){
        return true;
      }
    }
    return false;
  }
}
