class FPlayer extends FGameObject {
  int n;
  int live;
  int returnx;
  int returny;
  float x;
  float y;
  int frame;
  int direction;
  final int R=1;
  final int L=-1;

  FPlayer(color c, int playerNum, int life) {
    super();
    direction=R;
    setPosition(300, 0);
    setName("player");
    setFillColor(c);
    setRotatable(false);
    n=playerNum*5;
    live=life;
    frame=0;
  }

  void act() {
    input();

    if (isTouching("spike")) {
      setPosition(100, 100);
      live--;
    }
    if (isTouching("lava")) {
      setPosition(100, 100);
      live--;
    }

    //collisions();
    animate();
  }

  void show() {
  }

  void input() {
    int speed=200;
    float vy=getVelocityY();
    float vx=getVelocityX();
    if (keys[n]) {
      setVelocity(-speed, vy);
      direction=R;
    }
    if (keys[n+1]) {
      setVelocity(speed, vy);
      direction=L;
    }
    if (keys[n+2]) {
      setVelocity(vx, -speed);
    }
    if (keys[n+3]) {
      setVelocity(vx, speed);
    }
    if (abs(vy)<0.1) {
      action=idle;
    }
    if (abs(vy)>0.1) {
      action=jump;
    }
  }

  void animate() {
    if (frame>=action.length) {
      frame=0;
    } else {
      if (frameCount%5==0) {
        if (direction==L) {
          attachImage(action[frame]);
        } else {
          attachImage(reverseImage(action[frame]));
        }
        frame++;
      }
    }
  }
}
