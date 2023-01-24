class FHammerBro extends FGoomba {
  PImage[] imgs;
  int direction=L;
  int speed=50;
  int frame=0;
  PImage img;

  FHammerBro(int x, int y, PImage[] imgs, PImage img) {
    super(x, y);
    this.imgs=imgs;
    this.img=img;
    setName("hammerBro");
  }

  void act() {
    animate(frame, 2, direction, imgs);
    touchingPlayer(player);
    touchingPlayer(player2);
    if (isTouching("wall")) {
      direction*=-1;
      setPosition(getX()+direction, getY());
    }
    float vy=getVelocityY();
    setVelocity(speed*direction, vy);
    
    throwHammers(img);
    
  }

  void touchingPlayer(FPlayer p) {
    if (isTouching("player")) {
      hammerbros.remove(this);
      p.live--;
      world.remove(this);
    }
  }

  void throwHammers(PImage img) {
    count++;
    if (count==120) {
      FBody b=new FBox(gridSize, gridSize);
      b.setPosition(getX(), getY());
      b.attachImage(img);
      int vx=150;
      if(direction==L){
        vx=-vx;
      }
      b.setVelocity(vx, -400);
      b.setAngularVelocity(10);
      b.setSensor(true);
      b.setName("hammer");
      world.add(b);
      count=0;
    }
  }
}
