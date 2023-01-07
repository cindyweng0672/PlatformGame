class FPlayer extends FBox {
  int n;

  FPlayer(color c, int playerNum) {
    super(gridSize, gridSize);
    setPosition(300, 0);
    setFillColor(c);
    n=playerNum*5;
  }

  void act() {
    int speed=200;
    float vy=getVelocityY();
    float vx=getVelocityX();
    if (keys[n]) {
      setVelocity(-speed, vy);
      System.out.println(n);
    }
    if (keys[n+1]) {
      setVelocity(speed, vy);
    }
    if (keys[n+2]) {
      setVelocity(vx, -speed);
    }
    if (keys[n+3]) {
      setVelocity(vx, speed);
    }
  }

  void show() {
  }
}
