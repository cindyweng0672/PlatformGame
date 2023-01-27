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
    touchingPlayer(player, goombas);
    touchingPlayer(player2, goombas);
    if (isTouching("wall")) {
      direction*=-1;
      setPosition(getX()+direction, getY());
    }
    float vy=getVelocityY();
    setVelocity(speed*direction, vy);
  }

  void touchingPlayer(FPlayer p, ArrayList<FGoomba> list) {
    if (isTouching("player")) {
      if (p.getY()<getY()-gridSize/2) {
        list.remove(this);
        world.remove(this);
      } else {
        list.remove(this);
        world.remove(this);
        p.live--;
      }
    }
  }
}
