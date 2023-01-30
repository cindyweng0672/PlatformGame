class FThwomp extends FGameObject {

  float x, y;
  PImage[] imgs;
  boolean drop;
  boolean hitable=true;
  int count=0;

  FThwomp(float x, float y, PImage[] imgs) {
    super(gridSize*2);
    this.imgs=imgs;
    setPosition(x+gridSize/2, y+gridSize/2);
    setName("thwomp");
    setRotatable(false);
    attachImage(imgs[0]);
    setStatic(true);
    this.x=x;
    this.y=y;
  }

  void act() {
    if (!hitable) {
      count++;
      if (count>=300) {
        count=0;
        hitable=true;
        setPosition(x+gridSize/2, y+gridSize/2);
        setStatic(true);
        attachImage(imgs[0]);
      }
    }
    if (hitable) {
      if (checkPlayer(player)||checkPlayer(player2)) {
        if (checkPlayer(player)&&hitable) {
          player.live--;
        }
        if (checkPlayer(player2)&&hitable) {
          player2.live--;
        }
        setStatic(false);
        attachImage(imgs[1]);
        hitable=false;
      }
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
