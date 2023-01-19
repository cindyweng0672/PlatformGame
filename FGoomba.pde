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
    animate(frame, 2, direction, goomba);
    touchingPlayer(player);
    touchingPlayer(player2);
    if (isTouching("wall")) {
      direction*=-1;
      setPosition(getX()+direction, getY());
    }
    float vy=getVelocityY();
    setVelocity(speed*direction, vy);
  }

  void touchingPlayer(FPlayer p) {
    if (isTouching("player")) {
      if (p.getY()<getY()-gridSize/2) {
        enemies.remove(this);
        world.remove(this);
      } else {
        enemies.remove(this);
        world.remove(this);
        p.live--;
      }
    }
  }
}
