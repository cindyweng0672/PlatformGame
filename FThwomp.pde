class FThwomp extends FGameObject {

  float x, y;
  PImage[] imgs;
  boolean drop;

  FThwomp(float x, float y, PImage[] imgs) {
    super(gridSize*2);
    this.imgs=imgs;
    setPosition(x+gridSize/2, y+gridSize/2);
    setName("thwomp");
    setRotatable(false);
    attachImage(imgs[0]);
    setStatic(true);
  }

  void act() {
    if (checkPlayer(player)||checkPlayer(player2)) {
      setStatic(false);
      attachImage(imgs[1]);
    }
  }

  void show() {
  }

  boolean checkPlayer(FPlayer p) {
    float selfx=getX();
    float selfy=getY();
    float px=p.getX();
    float py=p.getY();
    float xLimit=selfx+gridSize*2+gridSize/2;
    float yLimit=selfy+gridSize*4+gridSize/2;
    if (px>selfx&&px<xLimit&&py>selfy&&py<yLimit) {
      return true;
    }
    return false;
  }
}
