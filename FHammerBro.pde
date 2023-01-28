class FHammerBro extends FGameObject {
  int direction=R;
  int speed=50;
  int frame=0;
  PImage img;
  FWorld currentW;

  FHammerBro(int x, int y, PImage img, FWorld w) {
    super(gridSize);
    setPosition(x-gridSize, y);
    this.img=img;
    setName("hammerBro");
    currentW=w;
  }

  void act() {
    setVelocity(100, 0);
    setAngularVelocity(0);

    animate();
    
    touchingPlayer(player, hammerbros);
    touchingPlayer(player2, hammerbros);

    if (isTouching("wall")) {
      direction*=-1;
      setPosition(getX()+direction, getY());
    }

    float vy=getVelocityY();
    setVelocity(speed*direction, vy);

    throwHammers(img);
  }

  void throwHammers(PImage img) {
    count++;
    if (count==120) {
      FBody b=new FBox(gridSize, gridSize);
      b.setPosition(getX(), getY());
      b.attachImage(img);
      int vx=150;
      if (direction==L) {
        vx=-vx;
      }
      b.setVelocity(vx, -400);
      b.setAngularVelocity(10);
      b.setSensor(true);
      b.setName("hammer");
      currentW.add(b);
      count=0;
    }
  }

  void animate() {
    if (frame>=hammerbro.length) {
      frame=0;
    }

    if (frameCount%5==0) {
      if (direction==L) {
        PImage temp=reverseImage(hammerbro[frame]);
        attachImage(temp);
      } else {
        attachImage((hammerbro[frame]));
      }
      frame++;
    }
  }
}
