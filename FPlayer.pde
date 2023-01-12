class FPlayer extends FBox {
  int n;
  int live;
  int returnx;
  int returny;
  float x;
  float y;

  FPlayer(color c, int playerNum) {
    super(gridSize, gridSize);
    setPosition(300, 0);
    setFillColor(c);
    n=playerNum*5;
    live=3;
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
    checkReturn();
    checkCollision();
  }

  void show() {
  }

  void checkCollision() {
    ArrayList<FContact> contacts=getContacts();
    for (int i=0; i<contacts.size(); i++) {
      FContact fc=contacts.get(i);
      if (fc.contains("spike")) {
        setPosition(x, y);
      }
    }
  }
  void checkReturn() {
    if (map.get((int)x+1, (int)y)==purp||map.get((int)x-1, (int)y)==purp) {
      x=getX();
      y=getY();
    }
  }
}
