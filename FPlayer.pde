class FPlayer extends FGameObject {
  int n;
  int live;
  int returnx;
  int returny;
  float x;
  float y;

  FPlayer(color c, int playerNum) {
    super();
    setPosition(300, 0);
    setName("player");
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
    
    if(isTouching("spike")){
      setPosition(100, 100);
    }
  }

  void show() {
  }
}
