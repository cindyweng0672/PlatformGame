class FGoomba extends FGameObject {
  int direction=L;
  int speed=50;
  int frame=0;

  FGoomba(float x, float y) {
    super(gridSize);
    setPosition(x, y);
    setName("goomba");
    setRotatable(false);
  }

  void act() {
    if (frame>=goomba.length) {
      frame=0;
    }

    if (frameCount%5==0) {
      if (direction==L) {
        PImage temp=reverseImage(goomba[frame]);
        attachImage(temp);
      } else {
        attachImage((goomba[frame]));
      }
      frame++;
    }
    
    touchingPlayer(player, goombas);
    touchingPlayer(player2, goombas);

    if (isTouching("wall")) {
      direction*=-1;
      setPosition(getX()+direction, getY());
    }

    float vy=getVelocityY();
    setVelocity(speed*direction, vy);
  }
}
