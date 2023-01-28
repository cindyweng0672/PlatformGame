class FPlayer extends FGameObject {
  int n;
  int live;
  int returnx;
  int returny;
  float x;
  float y;
  int frame;
  int direction;
  boolean hitable=true;
  int count=0;
  boolean onSwirl=false;
  int coinCount=0;

  FPlayer(color c, int playerNum, int life, String name) {
    super(gridSize);
    direction=R;
    setPosition(300, 0);
    setName(name);
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
    if (isTouching("hammer")) {
      if (hitable) {
        live--;
        hitable=false;
      }
    }
    
    if(isTouching("coin")){
      coinCount++;
    }
    if(coinCount==2){
      live++;
      coinCount=0;
    }

    if (hitable) {
      count++;
      if (count==200) {
        hitable=true;
      }
    }
    animate();

    if (isTouching("swirl")) {
      onSwirl=true;
    }
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

    if (abs(vy)<0.5&&abs(vx)==0) {
      action=idle;
    } else if (abs(vy)>0.5) {
      action=jump;
    } else {
      action=run;
    }
  }

  float[] getPos() {
    float[] arr={x, y};
    return arr;
  }

  void animate() {
    if (frame>=action.length) {
      frame=0;
    }

    if (frameCount%5==0) {
      if (direction==R) {
        PImage temp=reverseImage(action[frame]);
        attachImage(temp);
      } else {
        attachImage((action[frame]));
      }
      frame++;
    }
  }
}
